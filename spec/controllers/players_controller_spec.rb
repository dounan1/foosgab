require 'spec_helper'

describe PlayersController do
  let!(:player) { Fabricate(:player) }
  let(:player_attributes) { Fabricate.attributes_for(:player, name: 'Boris') }
  let(:invalid_player_attributes) { Fabricate.attributes_for(:invalid_player) }

  describe 'GET #index' do
    before(:each) do
      get :index
    end

    it 'assigns players to @players' do
      expect(assigns(:players)).to eq [player]
    end

    it 'returns a valid response' do
      expect(response.response_code).to eq 200
    end
  end

  describe 'GET #show' do
    before(:each) do
      get :show, id: player.id
    end

    it 'assigns the given player to @player' do
      get :show, id: player.id
      expect(assigns(:player)).to eq player
    end

    it 'returns a valid response' do
      expect(response.response_code).to eq 200
    end
  end
  
  describe 'GET #new' do
    before(:each) do
      get :new
    end
    
    it 'assigns a new player to @player' do
      get :new
      expect(assigns(:player)).to be_a_new Player
    end

    it 'returns a valid response' do
      expect(response.response_code).to eq 200
    end
  end

  describe 'GET #edit' do
    before(:each) do
      get :edit, id: player.id
    end

    it 'assigns the given player to @player' do
      expect(assigns(:player)).to eq player
    end

    it 'returns a valid response' do
      expect(response.response_code).to eq 200
    end
  end
  
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'persists the new player' do
        expect { post :create, player: player_attributes }.to change(Player, :count).by 1
      end
      
      it 'redirects to players#index' do
        post :create, player: player_attributes
        expect(response).to redirect_to(:players)
      end

      it 'returns a valid response' do
        post :create, player: player_attributes
        expect(response.response_code).to eq 302
      end
    end
    
    context 'with invalid attributes' do
      it 'does not persist the new player' do
        expect { post :create, player: invalid_player_attributes }.to_not change(Player, :count)
      end

      it 'returns a valid response' do
        post :create, player: player_attributes
        expect(response.response_code).to eq 302
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the given player' do
      expect { delete :destroy, id: player.id }.to change(Player, :count).by -1
    end

    it 'returns a valid response' do
      delete :destroy, id: player.id
      expect(response.response_code).to eq 302
    end
  end
end