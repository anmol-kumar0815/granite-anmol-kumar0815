# frozen_string_literal: true

class TaskLoggerJob < ApplicationJob
  sidekiq_options queue: :default, retry: 3
  queue_as :default

  def perform(task)
    msg = "A task was created with the following title: #{task.title}"
    log = Log.create! task_id: task.id, message: msg

    puts log.message
  end

  def setup
    @task = create(:task)
  end

  before_enqueue :print_before_enqueue_message
  after_enqueue :print_after_enqueue_message

  # def perform
  #   puts "TaskLoggerJob is performed"
  # end

  def print_before_enqueue_message
    puts "Printing from inside before_enqueue callback"
  end

  def print_after_enqueue_message
    puts "Printing from inside after_enqueue callback"
  end
end
