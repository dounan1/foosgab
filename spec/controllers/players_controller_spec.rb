require 'spec_helper'

describe PlayersController do
  let!(:player) { Fabricate(:player) }

  describe 'GET #index' do
    it 'assigns players to @players' do
      get :index
      expect(assigns(:players)).to eq [player]
    end
  end

  describe 'GET #show' do
    it 'assigns the given player to @player' do
      get :show, id: player.id
      expect(assigns(:player)).to eq player
    end
  end
  
  describe 'GET #new' do
    it 'assigns a new player to @player' do
      get :new
      expect(assigns(:player)).to be_a_new Player
    end
  end
  
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'persists the new player' do
        expect { post :create, player: Fabricate.attributes_for(:player) }.to change(Player, :count).by(1)
      end
      
      it 'redirects to players#index' do
        post :create, player: Fabricate.attributes_for(:player)
        expect(response).to redirect_to(:players)
      end
    end
    
    context 'with invalid attributes' do
      it 'does not persist the new player' do
        expect { post :create, player: Fabricate.attributes_for(:invalid_player) }.to_not change(Player, :count)
      end
    end
  end

end