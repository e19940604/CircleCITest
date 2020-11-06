class UserConfirmEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    ContactMailer.say_hello_to(user).deliver_now
    logger.debug "Here's some info: #{hash.inspect}"
  end
end
