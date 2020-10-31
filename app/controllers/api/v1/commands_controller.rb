# frozen_string_literal: true

module Api
  module V1
    class CommandsController < ApplicationController
      def index
        commands = Command.all
        render json: {status: 'SUCCESS', message: 'All Commands', data: commands}, status: :ok
      end

      def create
        params_permit = params.permit(:cmdtype, :step, :xbfr, :ybfr, :xaftr, :yaftr, :robot_id)
        command = Command.new(params_permit)
        if command.save
          render json: {status: 'SUCCESS', message: 'Saved Command', data: command}, status: :created
        else
          render json: {status: 'ERROR', message: 'Command not saved', data: command.errors}, status: :unprocessable_entity
        end
      end

      def self.getnewcommand(cmdtype, step, xbfr, ybfr, robotid)
        command = Command.new
        command.cmdtype = cmdtype
        command.step = step
        command.xbfr = xbfr
        command.ybfr = ybfr
        command.robot_id = robotid
        command
      end

      def self.savecommandlog(command, xaftr, yaftr)
        command.xaftr = xaftr
        command.yaftr = yaftr
        command.save
      end
    end
  end
end
