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
    def delete_book(book)
        @books.delete_at(@books.index(book))

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
book2=Book.new("title2","B", "12seew")
book3=Book.new("title3","C", "wdf")

inventory=Inventory.new(book1)
# puts inventory.books
inventory.add_book(book2)
inventory.add_book(book3)
inventory.list_books()
puts "LLLLLLLLLL"
inventory.delete_book(book1)
inventory.list_books()
# puts inventory.books