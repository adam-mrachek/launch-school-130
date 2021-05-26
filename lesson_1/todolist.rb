# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a Todolist object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    if todo.instance_of?(Todo)
      @todos << todo
    else
      raise TypeError.new("Can only add Todo objects")
    end
  end
  alias_method(:<<, :add)

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def size
    @todos.size
  end

  def to_a
    @todos
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def item_at(index)
    if index >= @todos.size
      raise IndexError.new("Todo does not exist.")
    else
      @todos[index]
    end
  end

  def mark_done_at(index)
    if index >= @todos.size
      raise IndexError.new("Todo does not exist.")
    else
      item_at(index).done!
    end
  end

  def mark_undone_at(index)
    if index >= @todos.size
      raise IndexError.new("Todo does not exist.")
    else
      item_at(index).undone!
    end
  end

  def done!
    @todos.each { |todo| todo.done! }
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    if index >= @todos.size
      raise IndexError.new("Todo does not exist.")
    else
      @todos.delete_at(index)
    end
  end

  def to_s
    @todos.each do |todo|
      puts todo
    end
  end

  def each
    counter = 0

    while counter < @todos.size
      yield(@todos[counter])
      counter += 1
    end

    self
  end

  def select
    results = TodoList.new(title)

    each do |todo|
      results << todo if yield(todo)
    end

    results
  end

  def find_by_title(title)
    select{ |todo| todo.title == title }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(str)
    find_by_title(str) && find_by_title(str).done! # right side will only execute if left side evaluates to `true` meaning the todo exists.
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----

# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
list.add(todo3)                 # adds todo3 to end of list, returns list
# list.add(1)                     # raises TypeError with message "Can only add Todo objects"

# p list.size
# p list.first
# p list.last
# p list.to_a
# p list.done?

# ---- Retrieving an item in the list ----

# item_at
# list.item_at                    # raises ArgumentError
# list.item_at(1)                 # returns 2nd item in list (zero based index)
# list.item_at(100)               # raises IndexError

# ---- Marking items in the list -----

# mark_done_at
# list.mark_done_at               # raises ArgumentError
# list.mark_done_at(1)            # marks the 2nd item as done
# list.mark_done_at(100)          # raises IndexError

# mark_undone_at
# list.mark_undone_at             # raises ArgumentError
# list.mark_undone_at(1)          # marks the 2nd item as not done
# list.mark_undone_at(100)        # raises IndexError

# done!
# list.done!                      # marks all items as done

# ---- Deleting from the list -----

# shift
# list.shift                      # removes and returns the first item in list

# pop
# list.pop                        # removes and returns the last item in list

# remove_at
# list.remove_at                  # raises ArgumentError
# list.remove_at(1)               # removes and returns the 2nd item
# list.remove_at(100)             # raises IndexError

# ---- Outputting the list -----
# to_s
# list.to_s                      # returns string representation of the list

# TodoList#each method

# list.each do |todo|
#   puts todo                   # calls Todo#to_s
# end

# TodoList#select method

# todo1.done!
#
# results = list.select { |todo| todo.done? }    # you need to implement this method
#
# puts results.inspect

list.mark_all_done
puts list

list.mark_all_undone
puts list