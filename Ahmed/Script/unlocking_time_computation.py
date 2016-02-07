from datetime import datetime
import time
import csv, os

##Change current directory to the file which stores outputs of "unlocking_attempt_separation.py"
INPUT_PATH = "/Users/lina/Desktop/Ahmed/OUTPUT/"
os.chdir(INPUT_PATH)

##Define output path
OUTPUT_PATH ="/Users/lina/Desktop/Ahmed/UNLOCKING_TIME/"

def CalcLengthMilliseconds(dt1,dt2):
	"""
    Calculate unlocking time for each unlocking attempt
	"""
	d1=datetime.strptime(dt1,'%Y-%m-%dT%I:%M:%S.%f %p')
	d2=datetime.strptime(dt2,'%Y-%m-%dT%I:%M:%S.%f %p')
	dt=d2-d1
	return str(dt.seconds*1000+dt.microseconds/1000)

def LogSessionLine(userID,unlocking_time,unlocking_method):
	"""
	Add lines for each unlocking attempt data
	"""
	try:
		unlocking_line=[userID,unlocking_method,unlocking_time]
		return unlocking_line
	except:
		return None

def SaveUnlockingLines(all_unlocking_lines,filename):
	"""
	Save all recorded unlocking lines to a .csv file
	"""
	try:
		with open(filename,'wb') as write_file_obj:
			print "Wrote %s lines to file %s." % (len(all_unlocking_lines),filename)
			writer=csv.writer(write_file_obj,dialect='excel',quoting=csv.QUOTE_ALL)
			writer.writerows(all_unlocking_lines)
	except Exception, e:
		print "Failed to create a .csv file to store unlocking lines."
		raise e
	
##Use os.listdir('.') to list all raw .csv files 
for csvFilename in os.listdir('.'):
	if not csvFilename.endswith('.csv'):
		continue
	else:
		print ""
		print "************************************"
		print "Processing File " + INPUT_PATH + csvFilename
		try:
			with open(INPUT_PATH+csvFilename,'rb') as read_file_obj:
				reader=csv.reader(read_file_obj)

				##Create output file name
				filename=OUTPUT_PATH+"unlocking_time_"+csvFilename

				##Create an empty list to store zero/one/two failure(s) unlockng_time lines
				all_unlocking_lines=[]
				all_unlocking_lines.append(['userID','unlocking_method','unlocking_time(ms)'])

				##Tell whether it is a zero_failure_auth_* file ('Screen On','Successful')
				if 'zero_failure_auth' in csvFilename:
					for row in reader:
						next_row=next(reader)
						userID="user"+row[4]
						dt1=row[1]
						dt2=next_row[1]
						unlocking_time=CalcLengthMilliseconds(dt1,dt2)
						all_unlocking_lines.append(LogSessionLine(userID,unlocking_time,next_row[2]))

				##Tell whether it is a one_failure_auth_* file ('Sreen On','Unsuccessful','Successful')
				if 'one_failure_auth' in csvFilename:
					for row in reader:
						next_row=next(reader)
						next_2_row=next(reader)
						userID="user"+row[4]
						dt1=row[1]
						dt2=next_2_row[1]
						unlocking_time=CalcLengthMilliseconds(dt1,dt2)
						all_unlocking_lines.append(LogSessionLine(userID,unlocking_time,next_2_row[2]))

                ##Tell whether it is a two_failure_auth_* file ('Sreen On','Unsuccessful','Unsuccessful','Successful')
				if 'two_failures_auth' in csvFilename:
					for row in reader:
						next_row=next(reader)
						next_2_row=next(reader)
						next_3_row=next(reader)
						userID="user"+row[4]
						dt1=row[1]
						dt2=next_3_row[1]
						unlocking_time=CalcLengthMilliseconds(dt1,dt2)
						all_unlocking_lines.append(LogSessionLine(userID,unlocking_time,next_3_row[2]))

                ##Save all_unlocking_lines for zero/one/two failure(s) unlockng attempts
				SaveUnlockingLines(all_unlocking_lines,filename)
						
							
		except Exception, e:
			print "Failed to open the file. File does not exist."
			print "Exception= ", str(e)