class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @plan = params[:plan]
  end

  def create
    plan = params[:plan]
    token = params[:stripeToken]

    # Create a customer in Stripe
    customer = Stripe::Customer.create(
      source: token,
      email: current_user.email
    )

    # Charge the customer based on the selected plan
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: plan_amount(plan),
      description: "#{plan.capitalize} Plan",
      currency: 'usd'
    )

    # Handle successful payment
    if charge.paid
      # Update the user's subscription
      current_user.subscriptions.create(
        plan: plan,
        starts_at: Time.current,
        ends_at: Time.current + 1.month, # Adjust this based on your plan duration
        active: true
      )

      session[:plan] = plan
      redirect_to payment_success_path # Redirect to the payment success page
    else
      flash[:alert] = "Payment failed. Please try again."
      render :new
    end

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_payment_path(plan: plan)
  end

  def success
    @plan = session[:plan]
    session.delete(:plan)
  end

  private

  def plan_amount(plan)
    case plan
    when 'basic'
      999  # $9.99
    when 'silver'
      1999 # $19.99
    when 'diamond'
      2999 # $29.99
    else
      0    # Invalid plan
    end
  end
end
