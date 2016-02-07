import csv, os

##Change current directory to the file which stores Ahmed's raw data
INPUT_PATH = "/Users/lina/Desktop/Ahmed/raw/"
os.chdir(INPUT_PATH)

count=0
NoneMethodNum=0
NoneMethodFileName=[]

for csvFilename in os.listdir('.'):
	if not csvFilename.endswith('.csv'):
		continue
	else:
		print ""
		print "************************************"
		print "Processing File " + INPUT_PATH + csvFilename
		try:
			with open(INPUT_PATH+csvFilename,'rb') as read_file_obj:
				count=count+1
				temp=0
				reader=csv.reader(read_file_obj)
				for row in reader:
					if 'PIN' in row:
						print row
					if 'None' in row:
						if row[0]=='Unsuccessful':
							print row
					if row[2]=='':
						temp=temp | 1

				if temp==1:
					NoneMethodNum=NoneMethodNum+1
					NoneMethodFileName.append(csvFilename)
		except Exception, e:
			raise e

print "count "+str(count)
print "csvFile which does not record method for Screen On and Screen Off."
print "NoneMethodNum "+str(NoneMethodNum)
print NoneMethodFileName