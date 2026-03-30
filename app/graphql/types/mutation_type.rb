# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :create_product, mutation: Mutations::CreateProduct
    
  end
end
