class CardsController < ApplicationController
  
  before_filter :authenticate
  before_filter :load_deck
  before_filter :authorize
  
  def authorize
    unless current_user == @deck.user
      redirect_to root_url, alert: "You are not authorized to access that"
    end
  end
  
  def load_deck
    @deck = Deck.find( params[:deck_id] )
  end
  
  # GET /cards
  # GET /cards.json
  def index
    @cards = @deck.cards.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cards }
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card = @deck.cards.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @card }
      format.js # show.js.erb
    end
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = @deck.cards.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/1/edit
  def edit
    @card = @deck.cards.find(params[:id])
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = @deck.cards.build(params[:card])

    respond_to do |format|
      if @card.save
        # flash.now.notice = "\"#{@card.content}\" was added to the deck"
        format.html { redirect_to new_deck_card_url(@deck) }
        format.json { render json: @card, status: :created, location: @card }
        format.js
      else
        flash.now.alert = @card.errors.full_messages.join(', ')
        format.html { render action: "new" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end
  
  def move_up
    @card = @deck.cards.find(params[:card_id])
    @card.move_higher
    
    respond_to do |format|
      format.html {redirect_to deck_reorder_url(@deck)}
      format.js
    end
  end
  
  def move_down
    @card = @deck.cards.find(params[:card_id])
    @card.move_lower
    
    respond_to do |format|
      format.html {redirect_to deck_reorder_url(@deck)}
      format.js
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = @deck.cards.find(params[:id])

    respond_to do |format|
      if @card.update_attributes(params[:card])
        format.html { redirect_to [@deck,@card], notice: 'Card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card = @deck.cards.find(params[:id])
    @card.destroy

    respond_to do |format|
      # flash.now.notice = "\"#{@card.content}\" was removed"
      format.html { redirect_to deck_cards_url(@deck) }
      format.json { head :no_content }
      format.js
    end
  end
end
















