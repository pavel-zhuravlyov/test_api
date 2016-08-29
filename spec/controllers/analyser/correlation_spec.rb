# describe AnalyserController, type: :controller do
#   describe 'POST :correlation' do
#     context 'with valid params' do
#       let(:user) { create :user }
#       let(:expected_response) { { correlation: 1} }
#
#       before do
#         auth_headers = user.create_new_auth_token
#         request.headers.merge!(auth_headers)
#       end
#       it 'generates result' do
#         post :correlation, {first_dataset: [1, 2, 3, 4, 5], second_dataset: [1, 2, 3, 4, 5]}, format: :json
#
#         expect(response.body).to eq expected_response
#       end
#     end
#   end
# end
