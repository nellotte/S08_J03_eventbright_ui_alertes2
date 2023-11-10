class EventMailer < ApplicationMailer
  default from: 'nelly.guerin@yopmail.com'

  def event_validated(event)
    @event = event
    mail(to: @event.admin.email, subject: 'Votre événement a été validé')
  end

  def event_rejected(event)
    @event = event
    mail(to: @event.admin.email, subject: 'Votre événement a été refusé')
  end
end