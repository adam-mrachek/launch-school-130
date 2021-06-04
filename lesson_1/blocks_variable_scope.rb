level_1 = "outer-most variable"

[1, 2, 3].each do |n|                 # block creates a new scope
  level_2 = "inner variable"

  ['a', 'b', 'c'].each do |n2|
    level_3 = "inner-most variable"   # nested block creates a nested scope

    # all three level_x variables are accessible here
  end

  # level_1 is accessible here
  # level_2 is accessible here
  # level_3 is not accessible here
end

# level_1 is accessible here
# level_2 is not accessible here
# level_3 is not accessible here

# Closure and Binding

# A closure is a chunk of code that you can pass around and execute at a later time.
# In order for a chunk of code to be execute later, it must understand the surrounding
# context from where it was defined.
# In Ruby, a "chunk of code" or closure is reprsented by a Proc object, a lambda, or a block.

name = "Robert"
chunk_of_code = Proc.new { puts "hi #{name}" }

def call_me(some_code)
  some_code.call       # call will execute the chunk of code that gets passed in
end

call_me(chunk_of_code)