import csv
import os

def add_user(uname, psw):
	retval = os.system('useradd {0} -m -s /bin/bash'.format(uname))
	retval = os.system('echo "{0}:{1}" | chpasswd {0}'.format(uname, psw ))
	#retval = os.system('cp -rf /home/fenics/.jupyter /home/{0}/.jupyter'.format(uname))
	retval = os.system('cp -r /home/fenics/cvips_labs /home/{0}/'.format(uname))
	retval = os.system('cp -r /home/fenics/hippylib/tutorial /home/{0}/hippylib_tutorial'.format(uname))
	retval = os.system('chown -R {0} /home/{0}'.format(uname))
	retval = os.system('chmod -R u+rX /home/{0}'.format(uname))

with open('users.csv') as csvfile:
	reader = csv.DictReader(csvfile)
	print(reader.fieldnames)
	for row in reader:
		add_user(row['user'], row['password'])
