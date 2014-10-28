classes = ObjectSpace.each_object(Class).reject { |k| "#{k}".match /Gem|Thor|Gviz/ }

h = {}
classes.each do |klass|
 tree = klass.ancestors.select { |anc| anc.is_a? Class }.reverse
 next if tree.include?(Exception) && tree[-1] != Exception
 puts "====="
 tree.each_cons(2) do |a, b|
   a_id, b_id = [a, b].map(&:object_id)
   h[b] = a

   # puts "#{a_id} => #{b_id} / #{a} => #{b}"
 end
end

# 親子関係
# h.each_pair do |child,parent|
#   puts "#{child} <= #{parent}"
# end

# sum = 0
h.each_pair do |child,parent|
  puts "@#{child}"

  # クラスメソッド
  # print child.methods

  # インスタンスメソッド
  child.instance_methods(false).each do |m|
    puts m
  end
  # print child.instance_methods.size
  # sum += child.instance_methods.size
  puts
end

# puts h.length
# puts sum

