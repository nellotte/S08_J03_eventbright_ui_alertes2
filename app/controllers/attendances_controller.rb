class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: [:show]


  def index 
  end

  def show 
    @attendance = Attendance.find(params[:id])

  end

  def create
    @attendance = Attendance.new
  end

end