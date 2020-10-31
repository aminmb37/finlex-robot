# frozen_string_literal: true

module Api
  module V1
    class RobotsController < ApplicationController
      def index
        robots = Robot.all
        render json: { status: 'SUCCESS', message: 'All Robots', data: robots }, status: :ok
      end

      def show
        robot = Robot.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Robot', data: robot }, status: :ok
      end

      def create
        params_permit = params.permit(:name, :x, :y, :direction)
        robot = Robot.new(params_permit)
        if robot.save
          render json: { status: 'SUCCESS', message: 'Saved Robot', data: robot }, status: :created
        else
          render json: { status: 'ERROR', message: 'Robot not saved', data: robot.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        robot = Robot.find(params[:id])
        robot.destroy
        render json: { status: 'SUCCESS', message: 'Deleted Robot', data: robot }, status: :ok
      end

      def update
        robot = Robot.find(params[:id])
        params_permit = params.permit(:name, :x, :y, :direction)
        updaterobot(robot, params_permit, 'updated')
      end

      def moveright
        robot = Robot.find(params[:robot_id])
        command = CommandsController.getnewcommand('moveright', params[:step], robot.x, robot.y, robot.id)
        case robot.direction
        when 'right'
          robot.y -= params[:step]
        when 'left'
          robot.y += params[:step]
        when 'forward'
          robot.x += params[:step]
        else
          robot.x -= params[:step]
        end
        params_permit = params.permit(:x, :y)
        updaterobot(robot, params_permit, 'moved')
        CommandsController.savecommandlog(command, robot.x, robot.y)
      end

      def moveleft
        robot = Robot.find(params[:robot_id])
        command = CommandsController.getnewcommand('moveleft', params[:step], robot.x, robot.y, robot.id)
        case robot.direction
        when 'right'
          robot.y += params[:step]
        when 'left'
          robot.y -= params[:step]
        when 'forward'
          robot.x -= params[:step]
        else
          robot.x += params[:step]
        end
        params_permit = params.permit(:x)
        updaterobot(robot, params_permit, 'moved')
        CommandsController.savecommandlog(command, robot.x, robot.y)
      end

      def moveforward
        robot = Robot.find(params[:robot_id])
        command = CommandsController.getnewcommand('moveforward', params[:step], robot.x, robot.y, robot.id)
        case robot.direction
        when 'right'
          robot.x += params[:step]
        when 'left'
          robot.x -= params[:step]
        when 'forward'
          robot.y += params[:step]
        else
          robot.y -= params[:step]
        end
        params_permit = params.permit(:x, :y)
        updaterobot(robot, params_permit, 'moved')
        CommandsController.savecommandlog(command, robot.x, robot.y)
      end

      def movebackward
        robot = Robot.find(params[:robot_id])
        command = CommandsController.getnewcommand('movebackward', params[:step], robot.x, robot.y, robot.id)
        case robot.direction
        when 'right'
          robot.x -= params[:step]
        when 'left'
          robot.x += params[:step]
        when 'forward'
          robot.y -= params[:step]
        else
          robot.y += params[:step]
        end
        params_permit = params.permit(:x, :y)
        updaterobot(robot, params_permit, 'moved')
        CommandsController.savecommandlog(command, robot.x, robot.y)
      end

      def turnright
        robot = Robot.find(params[:robot_id])
        command = CommandsController.getnewcommand('turnright', nil, robot.x, robot.y, robot.id)
        robot.direction = case robot.direction
                          when 'right'
                            'backward'
                          when 'left'
                            'forward'
                          when 'forward'
                            'right'
                          else
                            'left'
                          end
        params_permit = params.permit(:direction)
        updaterobot(robot, params_permit, 'turned')
        CommandsController.savecommandlog(command, robot.x, robot.y)
      end

      def turnleft
        robot = Robot.find(params[:robot_id])
        command = CommandsController.getnewcommand('turnleft', nil, robot.x, robot.y, robot.id)
        robot.direction = case robot.direction
                          when 'right'
                            'forward'
                          when 'left'
                            'backward'
                          when 'forward'
                            'left'
                          else
                            'right'
                          end
        params_permit = params.permit(:direction)
        updaterobot(robot, params_permit, 'turned')
        CommandsController.savecommandlog(command, robot.x, robot.y)
      end

      def turnback
        robot = Robot.find(params[:robot_id])
        command = CommandsController.getnewcommand('turnback', nil, robot.x, robot.y, robot.id)
        robot.direction = case robot.direction
                          when 'right'
                            'left'
                          when 'left'
                            'right'
                          when 'forward'
                            'backward'
                          else
                            'forward'
                          end
        params_permit = params.permit(:direction)
        updaterobot(robot, params_permit, 'turned')
        CommandsController.savecommandlog(command, robot.x, robot.y)
      end

      private

      def updaterobot(robot, params_permit, word)
        if robot.update_attributes(params_permit)
          success = format("Robot #{word} successfully!", word)
          render json: { status: 'SUCCESS', message: success, data: robot }, status: :ok
        else
          failure = format("Robot not #{action}!", word)
          render json: { status: 'ERROR', message: failure, data: robot.errors }, status: :unprocessable_entity
        end
      end
    end
  end
end
