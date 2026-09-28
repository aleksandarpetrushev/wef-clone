class EventPolicy
  def initialize(user, event)
    @user = user
    @event = event
  end

  def show?
    if @event.public?
      true
    else
      @event.organization_memberships.exists?(member: @user)
    end
  end

  def update?
    @event.organization_memberships.exists?(member: @user, role: "admin")
  end

  def destroy?
    update?
  end
end
