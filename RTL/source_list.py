import os

path = os.environ.get('RTL_PATH')
rtl_list = open('RTL_LIST', 'w')

for root, directories, files in os.walk(path, topdown=False):
    for name in files:
        if name != 'RTL_LIST':
            part = name.split('.')
            if part[1] == 'v' or part[1] == 'sv':
                rtl_list.write(os.path.join(root, name) + '\n')
