module Events
  class Register
    def initialize(event:, user:)
      @event = event
      @user = user
    end

    def call
      if event.registrations.count < event.capacity
        ActiveRecord::Base.transaction do

          event.registrations.create!(user: current_user)
          event.with_lock do
            event.capacity -= 1
            event.save!
          end
        end
      end
    end
  end
end
