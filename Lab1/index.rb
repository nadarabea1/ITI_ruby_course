class Inventory
    attr_accessor :books

    def initialize(book)
        @books=[]
        @books.push(book)
        file = File.new("inventory.txt", "w")
        File.write("inventory.txt", "Book: {Title: #{book.title}, auther: #{book.auther}, isbn:#{book.isbn}}\n")
    end
    def add_book(book)
        @books.push(book)
        File.open("inventory.txt", "a"){|f| f.write("Book: {Title: #{book.title}, auther: #{book.auther}, isbn:#{book.isbn}}\n")}
    end
    def list_books()
        @books.each do |item|
            puts "Book: {Title: #{item.title}, auther: #{item.auther}, isbn:#{item.isbn}}"
        end
    end
    def delete_book(isbn)
        @books=@books.filter { |book| book.isbn != isbn }
        File.open('inventory.txt', 'w') {|file| file.truncate(0) }
        @books.each do |item|
            File.open("inventory.txt", "a"){|f| f.write("Book: {Title: #{item.title}, auther: #{item.auther}, isbn:#{item.isbn}}\n")}
        end

    end
    def sort_books()

    end
end
class Book
    attr_accessor :title
    attr_accessor :auther
    attr_accessor :isbn
    def initialize(title, auther, isbn)
        @title=title
        @auther=auther
        @isbn=isbn
    end 
end

book1=Book.new("title1","A", "12sw")
book2=Book.new("title2","B", "7yh")
book3=Book.new("title3","C", "000")

inventory=Inventory.new(book1)
inventory.add_book(book2)
inventory.add_book(book3)
# inventory.delete_book("000")

option=0
while option<4 or option>0
puts "1. List Books"
puts "2. Add new book"
puts "3. Remove by ISBN"

option = gets.chomp.to_i

case option
    when 1
        inventory.list_books()
    when 2
        puts "Enter Title:"
        title=gets
        puts "Enter Author:"
        auther=gets
        puts "Enter ISBN:"
        isbn=gets
        book=Book.new(title.strip, auther.strip, isbn.strip)
        inventory.add_book(book)

    when 3
        puts "Enter ISBN:"
        isbn = gets.chomp
        inventory.delete_book(isbn)
    when 0
        break

    else 
        puts "Wrong Option"
    end
end

