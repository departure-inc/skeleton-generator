#
# @note このファイルは、RSpecのテストで共通して利用するヘルパーメソッドを定義するためのファイルです。
# @example
# module ResponseHelper
#   def json
#     JSON.parse(response.body)
#   end
# end
#
# RSpec.configure do |config|
#   config.include ResponseHelper
# end
#
# @example
# shared_examples_for 'authenticatable' do
#   it 'returns 401 status code' do
#     expect(response.status).to eq 401
#   end
#
#   it 'returns success' do
#     expect(response.status).to eq 200
#   end
# end
#
# RSpec.describe 'GET /api/v1/users', type: :request do
#   it_behaves_line 'authenticatable'
# end
#
# @example
# shared_context 'with jwt authenticated user' do
#   subject(:authenticated_user) { user }
#   let(:user) { create(:user) }
#   let(:token) { JsonWebToken.encode(user_id: user.id) }
#   let(:headers) { { Authorization: "Bearer #{token}" } }
#
#   before do
#     sign_in user
#   end
# end
#
# RSpec.describe PostsController do
#   include_context 'with jwt authenticated user'
# end
#
