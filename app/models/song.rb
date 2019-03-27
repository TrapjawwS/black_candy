# frozen_string_literal: true

class Song < ApplicationRecord
  validates :name, :file_path, :md5_hash, presence: true

  belongs_to :album
  belongs_to :artist

  def format
    MediaFile.format(file_path)
  end

  def favorited?
    Current.user.favorite_playlist.include?(id)
  end

  def self.find_ordered(ids)
    order_clause = ids.map { |id| "id=#{id} desc" }.join(',')
    where(id: ids).order(Arel.sql(order_clause))
  end
end
