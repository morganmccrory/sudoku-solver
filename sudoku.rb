class Sudoku
  attr_reader  :board_array
  def initialize(board_string)
    @check = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @board_string = board_string
    @board_array = @board_string.split("").each_slice(9).to_a
    @board_array
    @boxes = []
  end

  def row_possibilities(row_index)
    row_poss = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @board_array[row_index].each do |number|
      row_poss.select! do |check_num|
        number != check_num
      end
    end
    row_poss
  end

  def column_possibilities(column_index)
    col_poss = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @board_array.transpose[column_index].each do |number|
      col_poss.select! do |check_num|
        number != check_num
      end
    end
    col_poss
  end

  def box_number(row_index, column_index)
    (row_index/3) + (column_index/3)*3
  end

  def box_possibilities(row_index, column_index)
    box_index = box_number(row_index, column_index)
    box_poss = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    box(box_index).each do |number|
      box_poss.select! do |check_num|
        number != check_num
      end
    end
    box_poss
  end

  def box(index)
    boxes = []
    @board_array.each_slice(3) do |x|
      box_array = []
      box_array << x[0][0] << x[0][1] << x[0][2] << x[1][0] << x[1][1] << x[1][2] << x[2][0] << x[2][1] << x[2][2]
      boxes << box_array
    end
    @board_array.each_slice(3) do |x|
      box_array = []
      box_array << x[0][3] << x[0][4] << x[0][5] << x[1][3] << x[1][4] << x[1][5] << x[2][3] << x[2][4] << x[2][5]
      boxes << box_array
    end
    @board_array.each_slice(3) do |x|
      box_array = []
      box_array << x[0][6] << x[0][7] << x[0][8] << x[1][6] << x[1][7] << x[1][8] << x[2][6] << x[2][7] << x[2][8]
      boxes << box_array
    end
    boxes[index]
  end

  def board
  end

  def row_correct?
    arr = []
    @board_array.each do |row|
      if row.sort == @check
        arr << true
      end
    end
    if arr.length == 9
      return true
    end
  end

  def col_correct?
    arr = []
    @board_array.transpose.each do |col|
      if col.sort == @check
        arr << true
      end
    end
    if arr.length == 9
      return true
    end
  end

  def box_correct?
    arr = []
    box.each do |box|
      if box.sort == @check
        arr << true
      end
    end
    if arr.length == 9
      return true
    end
  end

  def solve
    until @board_array.flatten.all? {|num| num.to_i > 0}
      @board_array.each_index do |row|
        @board_array[row].each_index do |column|
          next if @board_array[row][column].to_i > 0
          if possibility_compiler(row, column).length == 1
            @board_array[row][column] = possibility_compiler(row, column).first
          else
            next
          end
        end
      end
    end
  end



  def possibility_compiler(row_index, column_index)
    row_possibilities(row_index) & column_possibilities(column_index) & box_possibilities(row_index, column_index)
  end


  # Returns a string representing the current state of the board
  def to_s
  end
end


# stuff = [
# ["-", "-", "5", "-", "3", "-", "-", "8", "1"],
# ["9", "-", "2", "8", "5", "-", "-", "6", "-"],
# ["6", "-", "-", "-", "-", "4", "-", "5", "-"],
# ["-", "-", "7", "4", "-", "2", "8", "3", "-"],
# ["3", "4", "9", "7", "6", "-", "-", "-", "5"],
# ["-", "-", "8", "3", "-", "-", "4", "9", "-"],
# ["1", "5", "-", "-", "8", "7", "-", "-", "2"],
# ["-", "9", "-", "-", "-", "-", "6", "-", "-"],
# ["-", "2", "6", "-", "4", "9", "5", "-", "3"]]

# stuff = --5-3--819-285--6-6----4-5---74-283-34976---5--83--49-15--87--2-9----6---26-495-3

# p stuff.join("")

# board = "--5-3--819-285--6-6----4-5---74-283-34976---5--83--49-15--87--2-9----6---26-495-3"
# test = Sudoku.new(board)