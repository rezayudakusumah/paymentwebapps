class User < ApplicationRecord
    has_many :payments, dependent: :destroy
end
