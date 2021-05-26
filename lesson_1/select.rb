def select(array)
  index = 0
  result = []

  while index < array.size
    if yield(array[index])
      result << array[index]
    end

    index += 1
  end

  result
end

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }
p select(array) { |num| puts num }
p select(array) { |num| num + 1 }