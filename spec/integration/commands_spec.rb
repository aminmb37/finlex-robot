# spec/integration/commands_spec.rb
require 'swagger_helper'

describe 'Commands API' do

  path '/commands' do

    get 'Retrieves all commands' do
      tags 'Commands'
      produces 'application/json'

      response '200', 'commands found' do
        schema type: :array,
               items: {
                 cmdtype: { type: :string },
                 step: { type: :integer },
                 xbfr: { type: :integer },
                 ybfr: { type: :integer },
                 xaftr: { type: :integer },
                 yaftr: { type: :integer },
                 robot_id: { type: :integer }
               },
               required: %w[id cmdtype step xbfr ybfr xaftr yaftr robot_id]
      end

      response '422', 'invalid request' do
        let(:command) { { name: 'inv' } }
        run_test!
      end
    end

    post 'Creates a command' do
      tags 'Commands'
      consumes 'application/json'
      parameter name: :command, in: :body, schema: {
        type: :object,
        properties: {
          cmdtype: { type: :string },
          step: { type: :integer },
          xbfr: { type: :integer },
          ybfr: { type: :integer },
          xaftr: { type: :integer },
          yaftr: { type: :integer },
          robot_id: { type: :integer }
        },
        required: %w[id cmdtype step xbfr ybfr xaftr yaftr robot_id]
      }

      response '201', 'command created' do
        let(:command) { { id: 1, cmdtype: 'moveright', step: 3, xbfr: 0, ybfr: 0, xaftr: 3, yaftr: 0, robot_id: 1 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:command) { { name: 'inv' } }
        run_test!
      end
    end
  end
end
