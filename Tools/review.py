"""
get the file last modify time and save to review.md
edit by hichens
"""

import os
from datetime import datetime
import calendar

def get_last_modify_time(filename='../CS/Assembly/理论知识/1.基础.md'):
    msg = os.popen("git log -1 --pretty=format:\"%ad\" {}".format(filename)).read() #last modify time 
    return msg


def month2num(month):
    return str(list(calendar.month_abbr).index(month))


def get_days(filename='../CS/Assembly/理论知识/1.基础.md'):
    now = datetime.now()
    msg = get_last_modify_time(filename)
    msg = msg.split(" ")
    try:
        year = msg[4]
        month = month2num(msg[1])
        day = msg[2]
        datestr = "-".join([year, month, day])
        date = datetime.strptime(datestr, "%Y-%m-%d")
        days =  (now - date).days
    except:
        days = 0
    return days

def print_date():
    dirs = '.'
    for root, dirs, files in os.walk(dirs):
        files = [f for f in files if not f[0] == '.']
        dirs[:] = [d for d in dirs if not d[0] == '.']
        for file in files:
            if file.split(".")[-1] == 'md':
                file_path = os.path.join(root,file)
                print(file_path)
                print(get_last_modify_time(file_path))
                print()


def Write2md(dirs='../'):
    file_shedule = []
    for root, dirs, files in os.walk(dirs):
        files = [f for f in files if not f[0] == '.']
        dirs[:] = [d for d in dirs if not d[0] == '.']
        for file in files:
            if file.split(".")[-1] == 'md':
                file_path = os.path.join(root,file)
                days = get_days(file_path)
                file_shedule.append([days, file_path])

        
    save_path = "../review.md"
    url = "https://github.com/hehichens/Hichens-NoteBook/blob/master/"
    if os.path.exists(save_path):
        os.remove(save_path)
    day_list = [0, 2, 4, 8, 16, 32]
    for i, day in enumerate(day_list[:-1]):
        f = open(save_path, 'a')
        f.write("## {} - {} 天\n".format(day_list[i], day_list[i+1]))
        for shedule in file_shedule:
            if day_list[i]<= shedule[0] < day_list[i+1]:
                filename = shedule[1].split("/")[-1]
                f.write("- [{}]({})\n".format(filename, shedule[1][3:]))
        f.write("\n")
        f.write("\n")
        f.close()


if __name__ == "__main__":
    # print(get_days())
    # print_date()
    Write2md()