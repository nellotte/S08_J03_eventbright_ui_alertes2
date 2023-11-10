class CheckoutController < ApplicationController
  def create
    @total = params[:total].to_d
    @event_id = params[:event_id]
    @user_id = params[:user_id]
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total*100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        },
      ],
      metadata: {
        event_id: @event_id,
        user_id: @user_id
      },
      mode: 'payment',
      customer_email: current_user.email, 
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    redirect_to @session.url, allow_other_host: true
  
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @list_line_items = Stripe::Checkout::Session.list_line_items(params[:session_id])
    @event_id = @session.metadata.event_id 

    # Récupérez l'ID du client Stripe à partir du paiement
    stripe_customer_id = @payment_intent.id

    # Créez une nouvelle instance d'Attendance
    @attendance = Attendance.new(
      user_id: current_user.id,  # Utilisez l'ID de l'utilisateur actuel
      event_id: @event_id,
      stripe_customer_id: stripe_customer_id
    )
     
    if @attendance.save
      @attendance_created = true #pour gérer le bouton revvenir à levent dans le show du check out success
    else
      # Gérez les erreurs en cas d'échec de sauvegarde de l'`Attendance`
      flash[:error] = 'Erreur lors de la création de l\'Attendance.'
      redirect_to event_path(@event_id)
    end
  end


  def cancel
  end

end
