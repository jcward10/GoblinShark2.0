class GamePlaysController < ApplicationController
  include GamePlaysHelper
  before_action :set_game_play, only: [:show, :edit, :update, :destroy]

  # GET /game_plays
  # GET /game_plays.json
  def index
    @game_plays = GamePlay.all
    @gameover = false

  end

  # GET /game_plays/1
  # GET /game_plays/1.json
  def show
  end

  def restart
    Room.destroy_all
    GamePlay.destroy_all

    Rails.application.load_seed
    redirect_to root_url
  end

  # GET /game_plays/new
  def new

    @game_play =GamePlay.create(room_id: params[:room_id])
    # @game_plays = GamePlay.all
    # monster
    redirect_to root_url
  end

  def shoot
    if Room.find(params[:weapon]).goblin_shark
      flash[:shoot] = "You win"
      GamePlay.delete_all
GamePlay.create(room: Room.find_by(goblin_shark: false, lochness_monster:false, whirlpool:false, kracken:false, iceberg:false))
    else
      flash[:miss] =  "Your anchor missed"
    end
  redirect_to root_url
  end

  # GET /game_plays/1/edit
  def edit

  end

  # POST /game_plays
  # POST /game_plays.json
  def create
    @game_play = GamePlay.new(game_play_params)

    respond_to do |format|
      if @game_play.save
        format.html { redirect_to @game_play, notice: 'Game play was successfully created.' }
        format.json { render :show, status: :created, location: @game_play }
      else
        format.html { render :new }
        format.json { render json: @game_play.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_plays/1
  # PATCH/PUT /game_plays/1.json
  def update
    respond_to do |format|
      if @game_play.update(game_play_params)
        format.html { redirect_to @game_play, notice: 'Game play was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_play }
      else
        format.html { render :edit }
        format.json { render json: @game_play.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_plays/1
  # DELETE /game_plays/1.json
  def destroy
    @game_play.destroy
    respond_to do |format|
      format.html { redirect_to game_plays_url, notice: 'Game play was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_play
      @game_play = GamePlay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_play_params
      params.require(:game_play).permit(:player_room, :room_id)
    end
end
