# Stripe.api_key = "sk_test_t4wx7tn0vkt6KvjVQttifgfz"
#  STRIPE_PUBLIC_KEY = "pk_test_agoeUm8hre8hMHhR2C6Pccr9"
Rails.configuration.stripe = {
  publishable_key: ENV['PUBLISHABLE_KEY'] || 'pk_test_agoeUm8hre8hMHhR2C6Pccr9',
  secret_key:      ENV['SECRET_KEY'] || 'sk_test_t4wx7tn0vkt6KvjVQttifgfz'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]