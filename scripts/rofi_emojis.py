#!/usr/bin/python
import sys
from subprocess import Popen, PIPE
contents = sys.stdin.buffer.readlines()
array = []
for line in contents:
    try:
        desc, code = line.decode().strip().split("|")
    except:
        continue
    desc=desc.replace("&amp;amp;","&")
    desc = desc.strip()
    code=code.strip()
    array.append("{} : {}".format(chr(int(code,16)),desc))
array = '\n'.join(array)
rofi = Popen(
    args=[
        'rofi',
        '-dmenu',
        '-i',
        '-multi-select',
        '-kb-custom-1',
        'Alt+c'
    ],
    stdin=PIPE,
    stdout=PIPE
)
(stdout, stderr) = rofi.communicate(input=array.encode('utf-8'))
if rofi.returncode == 1:
    exit()
else:
    for line in stdout.splitlines():
        print(line.decode())
