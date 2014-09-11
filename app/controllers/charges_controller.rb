class ChargesController < ApplicationController

def new
  if Reservation.find_by('student_id = ? AND timing_id = ? AND schedule_id = ? ' , current_student.id ,params[:timing_id],params[:schedule_id]).present?
    flash[:info] = 'You Cannot booked this class , as you have already booked this class'
    redirect_to root_path
  else
    @lesson=Lesson.find(params[:id])
    @lesson_details=Timing.find(params[:timing_id])
  end
end

def create
  @amount=500
  customer = Stripe::Customer.create(
    :email => 'example@stripe.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )
  @date=Timing.find(params[:timing_id]).day.date
  @pay =current_student.reservations.new( lesson_id: params[:lesson_id] ,stripe_customer_token: charge['customer'] , card_token: params[:stripeToken] , schedule_id: params[:schedule_id], timing_id: params[:timing_id],class_date: @date)
  if @pay.save
    @reservation_id= current_student.reservations.last.id
    @temp_lesson=Lesson.find(params[:lesson_id])
    @temp_commision=@temp_lesson.price.to_f
    @temp_commision=@temp_commision*15/100
    @earning=Earning.new(:amount => Lesson.find(params[:lesson_id]).price, :reservation_id => @reservation_id, :commission => @temp_commision, :tutor_id  => @temp_lesson.tutor.id)
    @earning.save
    @tutor=@temp_lesson.tutor.user
    @admin="admin@music.com"
    NotifierMailer.admin_confirmation(@admin).deliver
    NotifierMailer.reservation_confirmation(@tutor).deliver
  end
  @user=current_student.user
  NotifierMailer.payment_confirmation(@user).deliver
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end