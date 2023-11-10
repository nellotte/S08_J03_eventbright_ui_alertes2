class WebsiteAdministrator::EventSubmissionsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # Liste tous les événements à valider
    @events_to_validate = Event.where(validated: nil)
    @events_rejected = Event.where(validated: false)
    @events_validated = Event.where(validated: true)
    @events = @events_to_validate + @events_rejected + @events_validated
  end

  def show
    # Affiche un événement à valider précis
    @event = Event.find(params[:id])
  end

  def edit
    # Editer l'événement à valider
    @event = Event.find(params[:id])
  end

  def update 
    @event = Event.find(params[:id])
    # Enregistrez l'état précédent de l'événement
    previous_status = @event.validated_before_last_save
    if @event.update(event_params)
      # Vérifiez si l'état précédent était différent
      if previous_status != @event.validated
        send_status_email(@event)
      end
      redirect_to website_administrator_event_submission_path, notice: 'Événement validé avec succès.'
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:validated)  # Ajoutez tous les autres champs que vous souhaitez mettre à jour
  end

  def send_status_email(event)
    if event.validated
      EventMailer.event_validated(event).deliver_now
    else
      EventMailer.event_rejected(event).deliver_now
    end
  end
end
