require 'spec_helper'

describe StatsController do
  describe 'GET #index' do
    before(:each) do
      get :index
    end

    it 'returns a valid response' do
      expect(response.response_code).to eq 200
    end

    it 'assigns the games chart data' do
      expect(assigns(:games_chart)).to_not be_nil
    end

    it 'assigns the average goals chart data' do
      expect(assigns(:average_goals_chart)).to_not be_nil
    end

    it 'assigns the wins share chart data' do
      expect(assigns(:wins_share_chart)).to_not be_nil
    end
  end
end