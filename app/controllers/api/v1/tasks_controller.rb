module Api
  module V1
    class TasksController < ApplicationController
      def index
        tasks = Task.all
        render json: tasks
      end

      def show
        task = Task.find(params[:id])
        render json: task
      end

      def destroy
        task = Task.find(params[:id])
        task.destroy
        head :no_content
      end
    end
  end
end
