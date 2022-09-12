# finding files
1+1 #adding two numbers 
list.files()
?list.files
x <- list.files(recursive = TRUE,include.dirs = TRUE,
          full.names = TRUE, pattern = ".csv", 
          path = "~/Desktop")
list.files(pattern= ".csv", recursive = TRUE, full.names = TRUE)
y <- x[1]

readLines(y)[1:3]

z <- read.csv(y)
z$AIRLINE
z$IATA_CODE[3]
?c()
z$IATA_CODE[c(1,3)]
myvec <- c(1,3,5,7,9)
z$IATA_CODE[myvec]

x
grades <- list.files(recursive = TRUE,pattern = "grade",full.names = TRUE, ignore.case = TRUE)
grades <- read.csv("./Data/Fake_grade_data.csv")
# grades <- read.csv("./Code_Examples/assign_letter_grades.R" "./Data/Fake_grade_data.csv")
grades[2,2]
# row 3, colimn 1,3,5
grades[3,c(1,3,5)]
grades[3,c(3,5,7)]
#list of stuents greater than 15 on ass 1

grades$Assignment_1>15
grades$Student[grades$Assignment_1>15]


grades["Student_1","Student_3","Student_6","Student_7","Student_8","Student_10"]

#listing all .csv files in "Data" for assign 2
getwd()
csv_files<- list.files(path = "Data",recursive = TRUE,full.names = TRUE,pattern = ".csv")
# how many .csv files are there. 
length(csv_files)
#find wingspan data set
wing<- list.files(path = "Data",recursive = TRUE,full.names = TRUE,pattern = "wingspan_vs_mass.csv")

#load wingspan data set
df <- read.csv(file=wing)
#inspect first 5 lines of data set
head(df,n=5)


#find files that start with lowercase b
# ^ means starts with $ means ends with * means inf of anything.
# . means any character.
list.files(path = "Data",full.names = TRUE,recursive = TRUE,pattern = "^b")


#ends with b
list.files(path = "Data",full.names = TRUE,recursive = TRUE,pattern = "^b.*b$")

# display first line of each file that starts with b.

list.files(path = "Data",full.names = TRUE,recursive = TRUE,pattern = "^b")

readLines("Data/data-shell/creatures/basilisk.dat",n=1)

readLines("Data/data-shell/data/pdb/benzaldehyde.pdb",n=1)

readLines("Data/Messy_Take2/b_df.csv",n=1)

# placing a value on b files and making a loop. 
X<- list.files(path = "Data",full.names = TRUE,recursive = TRUE,pattern = "^b")
readLines(X[1],n=1)
readLines(X[2],n=1)
readLines(X[3],n=1)

#for-loop in X

for(eachfile in X){print(readLines(eachfile,n=1))}

#for loop in csv_files

for(eachfile in csv_files) {print(readLines(eachfile,n=1))
}

#math
-17100/1.5*10^-8

