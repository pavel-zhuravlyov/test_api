describe AnalyserController, type: :controller do
  describe 'POST :correlation' do
    context 'with valid params' do
      let(:user) { create :user }

      before do
        auth_headers = user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'returns result' do
        post :correlation, {first_dataset: [1, 2, 3, 4, 5], second_dataset: [1, 2, 3, 4, 5]}

        expect(response).to have_http_status 200
        expect(JSON.parse(response.body)['correlation']).to eq 1
      end
    end

    context 'with invalid params' do
      context 'with different datasets' do
        let(:user) { create :user }

        before do
          auth_headers = user.create_new_auth_token
          request.headers.merge!(auth_headers)
        end

        it 'returns error' do
          post :correlation, {first_dataset: [1, 2, 3, 4, 5], second_dataset: [1, 2, 3, 4]}
          expect(response).to have_http_status 422
        end
      end

      context 'with invalid dataset' do
        let(:user) { create :user }

        before do
          auth_headers = user.create_new_auth_token
          request.headers.merge!(auth_headers)
        end

        it 'returns error' do
          post :correlation, {first_dataset: [1, '2', 3, 4, 5], second_dataset: [1, 'tu', 3, 4, 5]}
          expect(response).to have_http_status 422
        end
      end
    end
  end
end
