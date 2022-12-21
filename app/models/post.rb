class Post < ApplicationRecord
  #ActiveStorageを使って画像を表示する
  #post modelに画像を使う宣言
  has_one_attached :image
  
  
end
