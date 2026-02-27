class OrderPolicy < ApplicationPolicy
  def index?
    admin? || dealer_or_customer?
  end

  def show?
    admin? || record.user == user
  end

  def create?
    dealer_or_customer?
  end

  def approve?
    admin?
  end

  def reject?
    admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
