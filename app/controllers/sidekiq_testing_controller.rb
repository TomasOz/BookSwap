class SidekiqTestingController < ApplicationController
	def index;	end

	def perform_sidekiq_task
		TestJob.perform_async

		redirect_to sidekiq_testing_path, notice: 'Job has been enqueued!'
	end

	def perform_sidekiq_task_later
		TestJob.perform_in(5.minutes)

		redirect_to sidekiq_testing_path, notice: 'Job has been enqueued!'
	end
end
