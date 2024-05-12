class Inventory   
    def initialize()
        @items = []
        load_books
    end

    def get_items()
        return @items
    end

    def add_item(title, author, isbn)
        if title.empty?
            puts "Title cannot be empty. Book not added to the inventory."
            return
        end
        
        book = {title: title, author: author, ISBN: isbn}
        if !@items.include?(book)
            @items.push(book)
            save_books
            puts "Book added successfully."
        else
            puts "Book already exists in the inventory."
        end
    end
    

    def remove_item(isbn)
        if @items.delete_if { |book| book[:ISBN] == isbn }
            save_books
            puts "Book removed successfully."
        else
            puts "Book not found in the inventory."
        end
    end
    
    def list_books()
        @items.each do |book|
            puts "Title: #{book[:title]}, Author: #{book[:author]}, ISBN: #{book[:ISBN]}"
        end
    end

    def search_by_name(name)
        found_books = @items.select { |book| book[:title] && book[:title].include?(name) }
        if found_books.empty?
            puts "No books found with the name '#{name}'."
        else
            puts "Books found with the name '#{name}':"
            found_books.each do |book|
                puts "Title: #{book[:title]}, Author: #{book[:author]}, ISBN: #{book[:ISBN]}"
            end
        end
    end

    def search_by_author(name)
        found_books = @items.select { |book| book[:author] && book[:author].include?(name) }
        if found_books.empty?
            puts "No books found with the name '#{name}'."
        else
            puts "Books found with the name '#{name}':"
            found_books.each do |book|
                puts "Title: #{book[:title]}, Author: #{book[:author]}, ISBN: #{book[:ISBN]}"
            end
        end
    end

    def search_by_ISBN(id)
        found_books = @items.select { |book| book[:ISBN] && book[:ISBN].include?(id) }
        if found_books.empty?
            puts "No books found with the name '#{name}'."
        else
            puts "Books found with the name '#{name}':"
            found_books.each do |book|
                puts "Title: #{book[:title]}, Author: #{book[:author]}, ISBN: #{book[:ISBN]}"
            end
        end
    end
    

    private

    def load_books
        if File.exist?("inventory.txt")
            File.open("inventory.txt", "r") do |file|
                file.each_line do |line|
                    title, author, isbn = line.chomp.split(",")
                    @items << {title: title, author: author, ISBN: isbn}
                end
            end
        else
            puts "File 'inventory.txt' does not exist."
        end
    end

    def save_books
        File.open("inventory.txt", "w") do |file|
            @items.each do |book|
                file.puts "#{book[:title]},#{book[:author]},#{book[:ISBN]}"
            end
        end
    end
end

def print_options
    puts "Options:"
    puts "1. List all books"
    puts "2. Add new book"
    puts "3. Remove book"
    puts "4. Search by name"
    puts "5. Search by author"
    puts "6. Search by ISBN"
    puts "7. Exit"
    print "Enter your choice: "
end

inventory = Inventory.new

loop do
    print_options
    choice = gets.chomp.to_i

    case choice
    when 1
        inventory.list_books
    when 2
        print "Enter title: "
        title = gets.chomp
        print "Enter author: "
        author = gets.chomp
        print "Enter ISBN: "
        isbn = gets.chomp
        inventory.add_item(title, author, isbn)
    when 3
        print "Enter ISBN of the book to remove: "
        isbn = gets.chomp
        inventory.remove_item(isbn)
    when 4
        print "Enter name of the book to search: "
        name = gets.chomp
        inventory.search_by_name(name)

    when 5
        print "Enter name of the author to search: "
        name = gets.chomp
        inventory.search_by_author(name)

    when 6
        print "Enter ISBN of the book to search: "
        id = gets.chomp
        inventory.search_by_ISBN(id)
    when 7
        puts "Goodbye!"

    else
        puts "Invalid choice. Please select a valid option."
    end

    print "Do you want to continue? (yes/no): "
    continue = gets.chomp.downcase
    break if continue != "yes"
end




