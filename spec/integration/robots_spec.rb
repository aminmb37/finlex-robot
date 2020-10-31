# spec/integration/robots_spec.rb
require 'swagger_helper'

describe 'Robots API' do

  path '/robots' do

    get 'Retrieves all robots' do
      tags 'Robots'
      produces 'application/json'

      response '200', 'robots found' do
        schema type: :array,
               items: {
                 id: { type: :integer },
                 name: { type: :string },
                 x: { type: :integer },
                 y: { type: :integer },
                 direction: { type: :string }
               },
               required: %w[id name x y direction]
      end

      response '422', 'invalid request' do
        let(:robot) { { name: 'inv' } }
        run_test!
      end
    end

    post 'Creates a robot' do
      tags 'Robots'
      consumes 'application/json'
      parameter name: :robot, in: :body, schema: {
        type: :object,
        properties: {
            name: { type: :string },
            x: { type: :integer },
            y: { type: :integer },
            direction: { type: :string }
          },
        required: %w[name x y direction]
      }

      response '201', 'robot created' do
        let(:robot) { { id: 1, name: 'First Robot', x: 0, y: 0, direction: 'forward' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:robot) { { name: 'inv' } }
        run_test!
      end
    end
  end

  path '/robots/{id}' do

    get 'Retrieves a robot' do
      tags 'Robots'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'robot found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 x: { type: :integer },
                 y: { type: :integer },
                 direction: { type: :string }
               },
               required: %w[id name x y direction]

        let(:id) { Robot.create(id: 1, name: 'First Robot', x: 0, y: 0, direction: 'forward').id }
        run_test!
      end

      response '404', 'robot not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/inv' }
        run_test!
      end
    end

    put 'Updates a robot' do
      tags 'Robots'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :robot, in: :body, schema: {
        type: :object,
        properties: {
            name: { type: :string },
            x: { type: :integer },
            y: { type: :integer },
            direction: { type: :string }
          },
        required: %w[name x y direction]
      }

      response '200', 'robot updated' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 x: { type: :integer },
                 y: { type: :integer },
                 direction: { type: :string }
               },
               required: %w[id name x y direction]

        let(:id) { Robot.create(id: 1, name: 'First Robot', x: 0, y: 0, direction: 'forward').id }
        run_test!
      end

      response '404', 'robot not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/inv' }
        run_test!
      end
    end

    delete 'Deletes a robot' do
      tags 'Robots'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'robot deleted' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 x: { type: :integer },
                 y: { type: :integer },
                 direction: { type: :string }
               },
               required: %w[id name x y direction]

        let(:id) { Robot.create(id: 1, name: 'First Robot', x: 0, y: 0, direction: 'forward').id }
        run_test!
      end

      response '404', 'robot not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/inv' }
        run_test!
      end
    end
  end

  path '/robots/{id}/moveright' do

    put 'Moves a robot to the right' do
      tags 'Robots'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :step, in: :body, schema: {
        type: :object,
        properties: {
          step: { type: :integer }
        },
        required: %w[step]
      }

      response '200', 'robot moved' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 x: { type: :integer },
                 y: { type: :integer },
                 direction: { type: :string }
               },
               required: %w[id name x y direction]

        let(:id) { Robot.create(id: 1, name: 'First Robot', x: 0, y: 0, direction: 'forward').id }
        run_test!
      end

      response '404', 'robot not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/inv' }
        run_test!
      end
    end
  end

  path '/robots/{id}/moveleft' do

    put 'Moves a robot to the left' do
      tags 'Robots'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :step, in: :body, schema: {
        type: :object,
        properties: {
          step: { type: :integer }
        },
        required: %w[step]
      }

      response '200', 'robot moved' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 x: { type: :integer },
                 y: { type: :integer },
                 direction: { type: :string }
               },
               required: %w[id name x y direction]

        let(:id) { Robot.create(id: 1, name: 'First Robot', x: 0, y: 0, direction: 'forward').id }
        run_test!
      end

      response '404', 'robot not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/inv' }
        run_test!
      end
    end
  end

  path '/robots/{id}/moveforward' do

    put 'Moves a robot forward' do
      tags 'Robots'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :step, in: :body, schema: {
        type: :object,
        properties: {
          step: { type: :integer }
        },
        required: %w[step]
      }

      response '200', 'robot moved' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 x: { type: :integer },
                 y: { type: :integer },
                 direction: { type: :string }
               },
               required: %w[id name x y direction]

        let(:id) { Robot.create(id: 1, name: 'First Robot', x: 0, y: 0, direction: 'forward').id }
        run_test!
      end

      response '404', 'robot not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/inv' }
        run_test!
      end
    end
  end

  path '/robots/{id}/movebackward' do

    put 'Moves a robot backward' do
      tags 'Robots'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :step, in: :body, schema: {
        type: :object,
        properties: {
          step: { type: :integer }
        },
        required: %w[step]
      }

      response '200', 'robot moved' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 x: { type: :integer },
                 y: { type: :integer },
                 direction: { type: :string }
               },
               required: %w[id name x y direction]

        let(:id) { Robot.create(id: 1, name: 'First Robot', x: 0, y: 0, direction: 'forward').id }
        run_test!
      end

      response '404', 'robot not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/inv' }
        run_test!
      end
    end
  end

  path '/robots/{id}/turnright' do

    put 'Turns a robot to the right' do
      tags 'Robots'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'robot turned' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 x: { type: :integer },
                 y: { type: :integer },
                 direction: { type: :string }
               },
               required: %w[id name x y direction]

        let(:id) { Robot.create(id: 1, name: 'First Robot', x: 0, y: 0, direction: 'forward').id }
        run_test!
      end

      response '404', 'robot not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/inv' }
        run_test!
      end
    end
  end

  path '/robots/{id}/turnleft' do

    put 'Turns a robot to the left' do
      tags 'Robots'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'robot turned' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 x: { type: :integer },
                 y: { type: :integer },
                 direction: { type: :string }
               },
               required: %w[id name x y direction]

        let(:id) { Robot.create(id: 1, name: 'First Robot', x: 0, y: 0, direction: 'forward').id }
        run_test!
      end

      response '404', 'robot not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/inv' }
        run_test!
      end
    end
  end

  path '/robots/{id}/turnback' do

    put 'Turns a robot back' do
      tags 'Robots'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'robot turned' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 x: { type: :integer },
                 y: { type: :integer },
                 direction: { type: :string }
               },
               required: %w[id name x y direction]

        let(:id) { Robot.create(id: 1, name: 'First Robot', x: 0, y: 0, direction: 'forward').id }
        run_test!
      end

      response '404', 'robot not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/inv' }
        run_test!
      end
    end
  end
end
