# frozen_string_literal: true

require "test_helper"

class PreferenceTest < ActiveSupport::TestCase
  def setup
    user = create(:user)
    @preference = user.preference
  end
end
