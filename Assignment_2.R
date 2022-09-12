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
