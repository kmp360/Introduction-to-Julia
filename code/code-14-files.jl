# "Code example for Chapter 14 -- Files"
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.8.0\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2022\\lectures-1.8")
#---

fout = open("output.txt", "w")

line = "This here's the wattle,\n"
write(fout, line)

line = "the emblem of our land.\n"
write(fout, line)

close(fout)

#---

fout = open("output.txt", "a")

line = "Add text here.\n"
write(fout, line)

close(fout)

#---

fout = open("output.txt", "a")

write(fout, string(150))

camels = 42

println(fout, "I have spotted $camels camels.")

close(fout)

#---

fout = open("output.txt", "a")

write(fout, string(150)*"\n")

close(fout)

#---

camels = 43

fout = open("output.txt", "a")

println(fout, "I have spotted $camels camels.")

close(fout)

#---

using Printf

fout = open("output.txt", "a")

@printf(fout, "Hello %s\n", "world")

@printf(fout, "Scientific notation: %e\n", 1.234)

@printf(fout, "Scientific notation three digits: %.3e\n", 1.23456)

@printf(fout, "Decimal two digits: %.2f\n", 1.23456)

@printf(fout, "Padded to length 5: %5i\n", 123)

@printf(fout, "Padded with zeros to length 6: %06i\n", 123)

@printf(fout, "Use shorter of decimal or scientific: %g %g\n", 1.23, 12300000.0)

@printf(fout, "Use shorter of decimal or scientific: %g %g\n", 1.23, 12300000.0)

@printf(fout, "%.0f %.1f %f", 0.5, 0.025, -0.0078125)

close(fout)

#---

str = @sprintf("this is a %s %15.1f", "test", 34.567)

fout = open("output.txt", "a")

println(fout, str)

close(fout)

#---

abspath("output.txt")

#---

readdir()

#---

function walk(dirname)
    for name in readdir(dirname)
        path = joinpath(dirname, name)
        if isfile(path)
            println(path)
        else
            walk(path)
        end
    end
end

walk(pwd())

#---

path = "E:\\aaa-Julia-course-2022\\lectures-1.8\\Introduction-to-Julia\\notebooks"

for (root, dirs, files) in walkdir(path)

    println("Root directory: $root")

    if !isempty(dirs)
        println("Directories in $root")
        
        for dir in dirs
            println(joinpath(root, dir)) # path to directories
        end
    else 
        println("No directories in root directory.")
    end

    if !isempty(files)
        println("Files in root directory:")

        for file in files
            println(joinpath(root, file)) # path to files
        end
    end
end

#---

fin = open("bad_file.txt")

#---

try
    fin = open("bad_file.txt")
catch exc
    println("Something went wrong: $exc")
end

#---

f = open("output.txt")

try
    line = readline(f)
    println(line)
    line = readline(f)
    println(line)
finally
    close(f)
end

#---

# Exercise 14-1

include("wc.jl")

using Main.LineCount

linecount("wc.jl")
