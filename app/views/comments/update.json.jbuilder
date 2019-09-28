if @new_comment.present? 
  json.array! @new_comment # 配列かつjson形式で@new_messageを返す
end