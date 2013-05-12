require 'spec_helper'

describe GamesController, type: :controller do
  let!(:game) { Fabricate(:game) }
  let(:invalid_game_attributes) { Fabricate.attributes_for(:invalid_game) }

  before(:each) do
    Ability.any_instance.stub(:can?).and_return(true)
  end

  describe 'GET #index' do
    before(:each) do
      get :index
    end

    it 'assigns games to @games' do
      expect(assigns(:games)).to eq [game]
    end
    
    it 'returns a valid response' do
      expect(response.response_code).to eq 200
    end
  end

  describe 'GET #show' do
    before(:each) do
      get :show, id: game.id
    end

    it 'assigns the given game to @game' do
      expect(assigns(:game)).to eq game
    end
    
    it 'returns a valid response' do
      expect(response.response_code).to eq 200
    end
  end

  describe 'GET #new' do
    before(:each) do
      get :new
    end

    it 'assigns a new game to @game' do
      expect(assigns(:game)).to be_a_new Game
    end
    
    it 'returns a valid response' do
      expect(response.response_code).to eq 200
    end
  end

  describe 'GET #edit' do
    before(:each) do
      get :edit, id: game.id
    end

    it 'assigns the given game to @game' do
      expect(assigns(:game)).to eq game
    end
    
    it 'returns a valid response' do
      expect(response.response_code).to eq 200
    end
  end

  describe 'POST #create' do
    let!(:game_attributes) do
      { date: Date.today, red: Fabricate.attributes_for(:team), blue: Fabricate.attributes_for(:team) }
    end

    let!(:invalid_game_attributes) do
      { date: nil, red: nil, blue: nil }
    end

    context 'with valid attributes' do
      render_views

      it 'persists the new game' do
        expect { post :create, game: game_attributes }.to change(Game, :count).by 1
      end

      it 'returns a valid response' do
        post :create, game: game_attributes
        expect(response.response_code).to eq 302
      end
    end
    
    context 'with invalid attributes' do
      it 'does not persist the new game' do
        expect { post :create, game: invalid_game_attributes }.to_not change(Game, :count)
      end

      it 'renders the new game form' do
        post :create, game: invalid_game_attributes
        expect(response).to render_template('new')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the given game' do
      expect { delete :destroy, id: game.id }.to change(Game, :count).by -1
    end

    it 'returns a valid response' do
      delete :destroy, id: game.id
      expect(response.response_code).to eq 302
    end
  end
end