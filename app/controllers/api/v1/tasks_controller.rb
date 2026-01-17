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

      def create
        task = Task.new(task_params)

        if task.save
          render json: task, status: :created
        else
          render json: { errors: task.errors }, status: :unprocessable_entity
        end
      end

      private
        def task_params
          params.expect(task: [ :title ])
        end
    end
  end
end
