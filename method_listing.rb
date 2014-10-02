classes = ObjectSpace.each_object(Class).reject { |k| "#{k}".match /Gem|Thor|Gviz/ }


h = {}
classes.each do |klass|
 tree = klass.ancestors.select { |anc| anc.is_a? Class }.reverse
 next if tree.include?(Exception) && tree[-1] != Exception
 puts "====="
 tree.each_cons(2) do |a, b|
   a_id, b_id = [a, b].map(&:object_id)
   # puts "#{a_id} => #{b_id} / #{a} => #{b}"
   h[b] = a

   puts "#{a_id} => #{b_id} / #{a} => #{b}"
 end
end

# 親子関係
h.each_pair do |child,parent|
  puts "#{child} <= #{parent}"
end

h.each_pair do |child,parent|
  puts child

  # クラスメソッド
  # print child.methods

  # インスタンスメソッド
  print child.instance_methods
  puts
end



