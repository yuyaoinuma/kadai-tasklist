class ToppagesController < ApplicationController
  def index
    if logged_in?
      @task = current_user.tasks.build
      @tasks = current_user.task_ids
    end
  end
end
