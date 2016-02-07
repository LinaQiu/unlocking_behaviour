import csv

count=0
sub=[]
##line=[]

with open('/Users/lina/Desktop/Ahmed/02b73904-c89c-47a5-8293-ce0a574dd53aauth25_60.csv','rb') as f:
	reader=csv.reader(f)
	for row in reader:
		count=count+1
##		line=[]
		if count<18:
			print row
			temp="user"+str(count)
			row.append(temp)
			print row
##			line.append("user"+str(count))
##			row=line+row
##			print row
			sub.append(row)


with open('/Users/lina/Desktop/Ahmed/test.csv','wb') as fp:
	writer=csv.writer(fp,delimiter=',')
	writer.writerows(sub)