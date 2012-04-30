class DecksController < ApplicationController
  
  before_filter :authenticate
  before_filter :authorize, :only => [:reorder, :shuffle, :update, :destroy]
  
  def authorize
    @deck = Deck.find( params[:id] ) if params[:id]
    @deck = Deck.find( params[:deck_id] ) if params[:deck_id]
    
    unless current_user == @deck.user
      redirect_to root_url, alert: "You are not authorized to access that"
    end
  end
  
  # GET /decks
  # GET /decks.json
  def index
    if current_user
      @decks = current_user.decks.all
      
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @decks }
      end
    else
      respond_to do |format|
        format.html {redirect_to new_session_url, :notice => "You must login to access your decks"}
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def test_flash
    @decks = current_user.decks.all
    flash.now.alert = "This is a test alert thingy of the thing with a really long message thing that spans more than one line."
    render 'index'
  end
  
  def show
    @deck = Deck.find params[:id]
    respond_to do |format|
      format.json {render json: @deck}
    end
  end

  # GET /decks/new
  # GET /decks/new.json
  def new
    @deck = Deck.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deck }
    end
  end

  # GET /decks/1/edit
  def edit
    @deck = Deck.find(params[:id])
  end
  
  def reorder
    @deck = Deck.find( params[:deck_id] )
  end
  
  def shuffle
    @deck = Deck.find( params[:deck_id] )
    @deck.shuffle
    
    respond_to do |format|
      format.html {render 'reorder'}
      format.js #reorder.js.erb
    end
  end

  # POST /decks
  # POST /decks.json
  def create
    @deck = Deck.new(params[:deck])

    respond_to do |format|
      if @deck.save
        @deck.update_attribute( :user_id, current_user.id )
        format.html { redirect_to deck_cards_url(@deck), notice: 'Deck was successfully created.' }
        format.json { render json: @deck, status: :created, location: @deck }
      else
        format.html { render action: "new" }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /decks/1
  # PUT /decks/1.json
  def update
    @deck = Deck.find(params[:id])

    respond_to do |format|
      if @deck.update_attributes(params[:deck])
        format.html { redirect_to deck_cards_url(@deck), notice: 'Deck was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy

    respond_to do |format|
      format.html { redirect_to decks_url }
      format.json { head :no_content }
    end
  end
end
