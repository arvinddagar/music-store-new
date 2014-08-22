class ChargesController < ApplicationController
def new
  @lesson=Lesson.find(params[:id])
  @lesson_details=Timing.find(params[:timing_id])
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
   @pay.save
   @user=current_student.user
    NotifierMailer.payment_confirmation(@user).deliver
rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path
end
end
