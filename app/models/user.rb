class User < ApplicationRecord
    has_many :payments, dependent: :destroy
    has_many :debts, dependent: :destroy
end
