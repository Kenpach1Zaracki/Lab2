def task1
  data = gets.strip.split
  n, m = data[0].to_i, data[1].to_i
  s = data[2]

  if n <= 0 || m <= 0
    puts "No"
    return
  end

  if s.match(/[^LRUD]/)
    puts "No"
    return
  end

  min_x = max_x = min_y = max_y = 0
  x = y = 0

  s.each_char do |move|
    case move
    when 'L' then x -= 1
    when 'R' then x += 1
    when 'D' then y += 1
    when 'U' then y -= 1
    end
    min_x = [min_x, x].min
    max_x = [max_x, x].max
    min_y = [min_y, y].min
    max_y = [max_y, y].max
  end

  if max_x - min_x < m && max_y - min_y < n
    puts "(#{1 - min_y},#{1 - min_x})"
  else
    puts "No"
  end
end

def normalize_email(email)
  local, domain = email.split('@')
  local = local.split('+')[0].gsub('.', '')
  "#{local}@#{domain}"
end

def task2
  emails = gets.strip.split
  unique = emails.map { |e| normalize_email(e) }.uniq
  puts "Уникальных адресов: #{unique.size}"
end

def task3
  line = gets.strip

  if line.empty?
    puts "Серий: 0"
    return
  end

  numbers = line.split.map(&:to_i)
  count = 0

  if numbers.any?
    count = 1
    prev = numbers[0]

    numbers[1..].each do |curr|
      if curr < prev
        count += 1
      end
      prev = curr
    end
  end

  puts "Серий: #{count}"
end

def main
  while true
    puts "Выберите задание:"
    puts "1 - Проверка движения по доске"
    puts "2 - Подсчёт уникальных email"
    puts "3 - Подсчёт серий чисел"
    puts "0 - Выход"
    choice = gets.strip

    case choice
    when '1'
      puts "Вы выбрали задание 1: Проверка движения по доске"
      task1
    when '2'
      puts "Вы выбрали задание 2: Подсчёт уникальных email"
      task2
    when '3'
      puts "Вы выбрали задание 3: Подсчёт серий чисел"
      task3
    when '0'
      puts "Выход..."
      break
    else
      puts "Неверный выбор!"
    end
  end
end

main
