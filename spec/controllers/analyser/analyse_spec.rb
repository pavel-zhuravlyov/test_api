describe AnalyserController, type: :controller do
  describe 'POST analyse' do
    context 'with valid params' do
      let(:user) { create :user }

      before do
        auth_headers = user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'generates result' do
        post :analyse, {dataset: [1, 2, 3, 4, 5]}

        expect(response).to have_http_status 200
      end
    end

    context 'with invalid params' do
      let(:user) { create :user }

      before do
        auth_headers = user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'generates result' do
        post :analyse, {dataset: [1, 2, 'f', 4, 5]}
        expect(response).to have_http_status 422
      end
    end
  end
end
