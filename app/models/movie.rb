class Movie < ActiveRecord::Base
    def self.all_ratings
        return {"G" => "G", "PG" => "PG","PG-13" => "PG-13","R" => "R","NC-17" => "NC-17"}
    end
end
