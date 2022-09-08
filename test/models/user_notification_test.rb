# frozen_string_literal: true

require "test_helper"

class UserNotification < ApplicationRecord
  belongs_to :user

  validates :last_notification_sent_date, presence: true
  validate :last_notification_sent_date_is_valid_date
  validate :last_notification_sent_date_cannot_be_in_the_past

  def setup
    @user_notification = create(:user_notification)
  end

  private

    def last_notification_sent_date_is_valid_date
      if last_notification_sent_date.present?
        Date.parse(last_notification_sent_date.to_s)
      end
    rescue ArgumentError
      errors.add(:last_notification_sent_date, "must be a valid date")
    end

    def last_notification_sent_date_cannot_be_in_the_past
      if last_notification_sent_date.present? &&
          last_notification_sent_date < Time.zone.today
        errors.add(:last_notification_sent_date, "can't be in the past")
      end
    end

    def test_last_notification_sent_date_must_be_present
      @user_notification.last_notification_sent_date = nil
      assert @user_notification.invalid?
      assert_includes @user_notification.errors.messages[:last_notification_sent_date], t("errors.messages.blank")
    end

    def test_last_notification_sent_date_must_be_parsable
      # The value of date becomes nil if provided with invalid date.
      # https://github.com/rails/rails/issues/29272

      @user_notification.last_notification_sent_date = "12-13-2021"
      assert_nil @user_notification.last_notification_sent_date
    end

    def test_last_notification_sent_date_cannot_be_in_past
      @user_notification.last_notification_sent_date = Time.zone.yesterday
      assert @user_notification.invalid?
      assert_includes @user_notification.errors.messages[:last_notification_sent_date], t("date.cant_be_in_past")
    end
end
