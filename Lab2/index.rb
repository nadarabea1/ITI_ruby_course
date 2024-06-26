require 'time'

module Logger
    def log_info(message)
        add_message('Info', message)
    end

    def log_warning(message)
        add_message('Warning', message)
    end

    def log_error(message)
        add_message('Error', message)
    end

    def add_message(log_type, message)
        File.open("app.logs", "a") do |f|
        f.write("#{Time.now.iso8601} -- #{log_type} -- #{message} \n")
        end
    end
end

class User
    attr_accessor :name, :balance

    def initialize(name, balance)
        @name = name
        @balance = balance
    end
end

class Transaction
    attr_reader :user, :value

    def initialize(user, value)
        @user = user
        @value = value
    end
end

class Bank
    def process_transaction(transaction, callback)
        raise "Process transaction body"
    end
end
class CBABank < Bank
    include Logger

    def process_transactions(transactions, &callback)
        log_info("Processing Transactions #{transactions.map { |t| "#{t.user.name} transaction with value #{t.value}" }.join(', ')}")

        transactions.each do |transaction|
        begin
            if transaction.user.balance + transaction.value < 0
            raise "There is no Blance"
            end

            if transaction.user.balance + transaction.value == 0
            log_warning("#{transaction.user.name} has 0 balance")
            end

            transaction.user.balance += transaction.value

            log_info("User #{transaction.user.name} transaction with value #{transaction.value} succeeded")
        rescue => e
            log_error("User #{transaction.user.name} transaction with value #{transaction.value} failed with message #{e.message}")
            callback.call(false)
            return
        end
        end

        callback.call(true)
    end
end


users = [
    User.new("Ali", 200),
    User.new("Peter", 500),
    User.new("Manda", 100)
]

out_side_bank_users = [
    User.new("Menna", 400),
]

transactions = [
    Transaction.new(users[0], -20),
    Transaction.new(users[0], -30),
    Transaction.new(users[0], -50),
    Transaction.new(users[0], -100),
    Transaction.new(users[0], -100),
    Transaction.new(out_side_bank_users[0], -100)
]

cba_bank = CBABank.new
cba_bank.process_transactions(transactions) do |success|
    if success
        puts "All transactions processed successfully"
    end
end
