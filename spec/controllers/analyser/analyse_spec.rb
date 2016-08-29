describe AnalyserController, type: :controller do
  describe 'POST analyse' do
    context 'with valid params' do
      let(:user) { create :user }

      let(:dataset) { [5, 6, 7, 13, 43, 45, 46, 55, 56, 60, 61, 62, 65, 66, 66, 67, 90, 100, 104, 132] }

      let(:expected_response) {
        { 'max' => 132.0,
          'min' => 5.0,
          'mean' =>	57.45,
          'median' =>	60.5,
          'lower_quartile' =>	44.0,
          'upper_quartile' =>	66.5,
          'outliers' =>	[5.0, 6.0, 7.0, 104.0, 132.0] }
      }

      before do
        auth_headers = user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'returns result' do
        post :analyse, { dataset: dataset }

        expect(response).to have_http_status 200
        expect(JSON.parse(response.body)).to eq expected_response
      end
    end

    context 'with invalid params' do
      let(:user) { create :user }

      before do
        auth_headers = user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'returns error' do
        post :analyse, { dataset: [1, 2, 'f', 4, 5] }

        expect(response).to have_http_status 422
      end
    end
  end
end
