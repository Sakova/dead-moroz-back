class ElfAlertJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.where(role: "elf").each do |user|
      UserMailer.job_alert(user).deliver_now
    end
  end
end
