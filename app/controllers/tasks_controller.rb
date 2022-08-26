class TasksController < ApplicationController
    def index
        @tasks = Task.all
        render
    end
end
