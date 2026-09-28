class ProcessRegistrationJob < ApplicationJob
  retry_on PaymentGateway::Timeout, attempts: 3

  discard_on PaymentGateway::PaymentFailedError

  def perform(registration_id)
    registration = Registration.find(registration_id)
    
    return if registration.status == "confirmed"

    PaymentGateway.charge(
      amount: registration.price,
      idempotency_key: "#{registration.id}-#{Time.current.to_i}"
    )

    registration.update!(status: "confirmed")

    # payment declined
    rescue PaymentGateway::PaymentFailedError
      registration.update!(status: "payment_failed")
      raise
    end
  end
end
