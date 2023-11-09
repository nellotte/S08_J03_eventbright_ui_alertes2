class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: [:show]


  def index 
  end

  def show 
    @attendance = Attendance.find(params[:id])

  end

  def create
    # Récupérez l'identifiant Stripe depuis les paramètres ou toute autre source pertinente
    stripe_id = params[:payment_intent_id] 

    # Créez un objet `Attendance` et associez-le à l'utilisateur et à l'événement
    @attendance = Attendance.new(user: current_user, event: @event)

    # Utilisez l'identifiant Stripe comme `stripe_customer_id` dans l'objet `Attendance`
    @attendance.stripe_customer_id = stripe_id

    # Sauvegardez l'objet `Attendance` dans la base de données
    if @attendance.save
      # Redirigez l'utilisateur vers une page de confirmation de la création de l'`Attendance`
      redirect_to confirmation_path, notice: 'Attendance créée avec succès.'
    else
      # Gérez les erreurs en cas d'échec de sauvegarde de l'`Attendance`
      flash[:error] = 'Erreur lors de la création de l\'Attendance.'
      redirect_to event_path(@event)
    end
  end

  
  private

  def correct_user

  end

end