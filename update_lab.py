import csv
import os
import argparse

def push2user(user, folder, target):
	retval = os.system('cp -rf /home/fenics/{2}/{0} /home/{1}/{2}'.format(folder, user, target))
	retval = os.system('chown -R {0} /home/{0}/{2}/{1}'.format(user, folder,target))
	retval = os.system('chmod -R u+rwX /home/{0}/{2}/{1}'.format(user, folder, target))

parser = argparse.ArgumentParser(description='Push user content')
parser.add_argument('folder', nargs=1)
parser.add_argument('target', nargs=1)
args = parser.parse_args()
os.system('cd /home/fenics/{0} && git pull'.format(args.target))
with open('users.csv') as csvfile:
	reader = csv.DictReader(csvfile)
	for row in reader:
		push2user(row['user'], args.folder, args.target)
