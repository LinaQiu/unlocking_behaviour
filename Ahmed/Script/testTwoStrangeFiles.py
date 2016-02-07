import csv
import os
import sys

##Create an empty list to store zero/one/two failure(s) authentication data
##For unlocking mechanism "None"
zero_failure_auth_None=[]
one_failure_auth_None=[]
two_failures_auth_None=[]

##For unlocking mechanism "DAS"
zero_failure_auth_DAS=[]
one_failure_auth_DAS=[]
two_failures_auth_DAS=[]

##For unlocking mechanism "Password"
zero_failure_auth_Password=[]
one_failure_auth_Password=[]
two_failures_auth_Password=[]

UNLOCKING_MECHANISM_NONE='None'
UNLOCKING_MECHANISM_DAS='DAS'
UNLOCKING_MECHANISM_PASSWORD='Password'

##To store the index of the file that we are dealing with
count=0

##Change current directory to the file which stores Ahmed's raw data
INPUT_PATH = "/Users/lina/Desktop/Ahmed/twoStrangeFiles/"
os.chdir(INPUT_PATH)

##Define output path
OUTPUT_PATH ="/Users/lina/Desktop/Ahmed/twoStrangeFilesOUTPUT/"

##Use os.listdir('.') to list all raw .csv files 
for csvFilename in os.listdir('.'):
	if not csvFilename.endswith('.csv'):
		continue
	else:
		print ""
		print "************************************"
		print "Processing File " + INPUT_PATH + csvFilename
		row_count=0
		try:
			with open(INPUT_PATH+csvFilename,'rb') as read_file_obj:
				reader=csv.reader(read_file_obj)
				##To count how many user files we have read so far
				count=count+1

				print "FileNum "+ str(count)

				for row in reader:
					row_count=row_count+1
					if (row[0]=='Screen On'):
						row.append(str(count))
						next_row=next(reader)
						next_row.append(str(count))
						##See if the next row begins with 'Successful', which means it is a zero_failure_auth attempt 
						if next_row[0]=='Successful':
						    ##Store zero_failure_auth attempt
							if next_row[2]==UNLOCKING_MECHANISM_NONE:
								zero_failure_auth_None.append(row)
								zero_failure_auth_None.append(next_row)
							elif next_row[2]==UNLOCKING_MECHANISM_DAS:
								zero_failure_auth_DAS.append(row)
								zero_failure_auth_DAS.append(next_row)
							elif next_row[2]==UNLOCKING_MECHANISM_PASSWORD:
								zero_failure_auth_Password.append(row)
								zero_failure_auth_Password.append(next_row)

						##Otherwise, see if the next row begins with 'Unsuccessful', which means it might be a one/two_failure_auth attempt 
						elif next_row[0]=='Unsuccessful':
							next_2_row=next(reader)
							next_2_row.append(str(count))

							if(next_2_row[0]=='Successful'):
								##Store one_failure_auth attempt
								if next_2_row[2]==UNLOCKING_MECHANISM_NONE:
									one_failure_auth_None.append(row)
									one_failure_auth_None.append(next_row)
									one_failure_auth_None.append(next_2_row)
								elif next_2_row[2]==UNLOCKING_MECHANISM_DAS:
									one_failure_auth_DAS.append(row)
									one_failure_auth_DAS.append(next_row)
									one_failure_auth_DAS.append(next_2_row)
								elif next_2_row[2]==UNLOCKING_MECHANISM_PASSWORD:
									one_failure_auth_Password.append(row)
									one_failure_auth_Password.append(next_row)
									one_failure_auth_Password.append(next_2_row)

							##See if it's two_failure_auth attempt
							elif(next_2_row[0]=='Unsuccessful'):
								next_3_row=next(reader)
								next_3_row.append(str(count))

								if(next_3_row[0]=='Successful'):
									##Store two_failure_auth attempt
									if next_3_row[2]==UNLOCKING_MECHANISM_NONE:
										two_failures_auth_None.append(row)
										two_failures_auth_None.append(next_row)
										two_failures_auth_None.append(next_2_row)
										two_failures_auth_None.append(next_3_row)
									elif next_3_row[2]==UNLOCKING_MECHANISM_DAS:
										two_failures_auth_DAS.append(row)
										two_failures_auth_DAS.append(next_row)
										two_failures_auth_DAS.append(next_2_row)
										two_failures_auth_DAS.append(next_3_row)
									elif next_3_row[2]==UNLOCKING_MECHANISM_PASSWORD:
										two_failures_auth_Password.append(row)
										two_failures_auth_Password.append(next_row)
										two_failures_auth_Password.append(next_2_row)
										two_failures_auth_Password.append(next_3_row)
				print "test"
		except Exception as e:
			print row
			print "Failed to open the file. File does not exists."
			#sys.exit('file %s, line %d: %s' % (csvFilename,reader.line_num,e))
	print "There are "+str(row_count)+" lines in this file."

##Print out how many files we have processed
print "We have processed "+str(count)+" files."

##Store zero/one/two_failure_auth_UNLOCKING_MECHANISM attepmts 
if zero_failure_auth_None:
	print ""	
	print "Output zero_failure_auth_None.csv"
	try:
		with open(OUTPUT_PATH+"zero_failure_auth_None.csv",'wb') as write_file_obj:
			writer=csv.writer(write_file_obj,delimiter=',')
			writer.writerows(zero_failure_auth_None)
	except Exception, e:
		print "Failed to create the file."
		raise e
if zero_failure_auth_DAS:
	print ""	
	print "Output zero_failure_auth_DAS.csv"
	try:
		with open(OUTPUT_PATH+"zero_failure_auth_DAS.csv",'wb') as write_file_obj:
			writer=csv.writer(write_file_obj,delimiter=',')
			writer.writerows(zero_failure_auth_DAS)
	except Exception, e:
		print "Failed to create the file."
		raise e
if zero_failure_auth_Password:
	print ""	
	print "Output zero_failure_auth_Password.csv"
	try:
		with open(OUTPUT_PATH+"zero_failure_auth_Password.csv",'wb') as write_file_obj:
			writer=csv.writer(write_file_obj,delimiter=',')
			writer.writerows(zero_failure_auth_Password)
	except Exception, e:
		print "Failed to create the file."
		raise e


if one_failure_auth_None:
	print ""	
	print "Output one_failure_auth_None.csv"
	try:
		with open(OUTPUT_PATH+"one_failure_auth_None.csv",'wb') as write_file_obj:
			writer=csv.writer(write_file_obj,delimiter=',')
			writer.writerows(one_failure_auth_None)
	except Exception, e:
		print "Failed to create the file."
		raise e
if one_failure_auth_DAS:
	print ""	
	print "Output one_failure_auth_DAS.csv"
	try:
		with open(OUTPUT_PATH+"one_failure_auth_DAS.csv",'wb') as write_file_obj:
			writer=csv.writer(write_file_obj,delimiter=',')
			writer.writerows(one_failure_auth_DAS)
	except Exception, e:
		print "Failed to create the file."
		raise e
if one_failure_auth_Password:
	print ""	
	print "Output one_failure_auth_Password.csv"
	try:
		with open(OUTPUT_PATH+"one_failure_auth_Password.csv",'wb') as write_file_obj:
			writer=csv.writer(write_file_obj,delimiter=',')
			writer.writerows(one_failure_auth_Password)
	except Exception, e:
		print "Failed to create the file."
		raise e


if two_failures_auth_None:
	print ""	
	print "Output two_failures_auth_None.csv"
	try:
		with open(OUTPUT_PATH+"two_failures_auth_None.csv",'wb') as write_file_obj:
			writer=csv.writer(write_file_obj,delimiter=',')
			writer.writerows(two_failures_auth_None)
	except Exception, e:
		print "Failed to create the file."
		raise e
if two_failures_auth_DAS:
	print ""	
	print "Output two_failures_auth_DAS.csv"
	try:
		with open(OUTPUT_PATH+"two_failures_auth_DAS.csv",'wb') as write_file_obj:
			writer=csv.writer(write_file_obj,delimiter=',')
			writer.writerows(two_failures_auth_DAS)
	except Exception, e:
		print "Failed to create the file."
		raise e
if two_failures_auth_Password:
	print ""	
	print "Output two_failures_auth_Password.csv"
	try:
		with open(OUTPUT_PATH+"two_failures_auth_Password.csv",'wb') as write_file_obj:
			writer=csv.writer(write_file_obj,delimiter=',')
			writer.writerows(two_failures_auth_Password)
	except Exception, e:
		print "Failed to create the file."
		raise e