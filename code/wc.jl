module LineCount

    export linecount

    function linecount(filename)
        count = 0
        for line in eachline(filename)
            count += 1
        end
        return count
    end

end