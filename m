Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id WAA26736; Fri, 15 Mar 1996 22:29:06 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id WAA24314; Fri, 15 Mar 1996 22:29:01 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id WAA24309; Fri, 15 Mar 1996 22:29:00 -0800
Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <lmlinux@neteng.engr.sgi.com> id WAA26727; Fri, 15 Mar 1996 22:28:58 -0800
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id WAA24300; Fri, 15 Mar 1996 22:28:58 -0800
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id WAA19239; Fri, 15 Mar 1996 22:28:55 -0800
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id BAA15720; Sat, 16 Mar 1996 01:28:35 -0500
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id BAA05973; Sat, 16 Mar 1996 01:28:35 -0500
Date: Sat, 16 Mar 1996 01:28:35 -0500
Message-Id: <199603160628.BAA05973@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: sparclinux@vger.rutgers.edu
CC: tridge@cs.anu.edu.au, lmlinux@neteng.engr.sgi.com, apod@caip.rutgers.edu,
        kish@caip.rutgers.edu, rukshin@caip.rutgers.edu,
        hedrick@remus.rutgers.edu, fil@klinzhai.rutgers.edu,
        john@paul.rutgers.edu
Subject: YEAH!!!
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


This is so cool, I cannot believe it!
I was so elated when I logged into this thing I had to
share it with everyone ;-)
GO ANDY GO!

Linux/AP+  (hibana)


hibana login: davem
Password: 
Linux hibana 1.3.71 #294 Sat Mar 16 10:57:57 EST 1996 sparc
hibana:~$ cat /proc/cpuinfo
cpu             : Texas Instruments, Inc. - SuperSparc 50
fpu             : SuperSparc on-chip FPU
promlib         : Version 0 Revision 0
wp              : yes
type            : sun4m
Elf Support     : no
BogoMips        : 63.89
MMU type        : TI Viking/MXCC
invall          : 4
invmm           : 1156
invrnge         : 7773
invpg           : 9935
contexts        : 65536
hibana:~$ ps -auxwww
USER       PID %CPU %MEM SIZE  RSS  TTY STAT START   TIME COMMAND
davem      251  0.6  3.1  572  436   p2 S    17:21   0:00 -bash
davem      260  0.0  1.0  228  148   p2 R    17:24   0:00 ps -auxwww
root         1  0.0  1.0  188  148    ? S    16:31   0:01 init [2]             
root         2  0.0  0.0    0    0    ? SW   16:31   0:00 (kflushd)
root         3  0.0  0.0    0    0    ? SW<  16:31   0:00 (kswapd)
root        13  0.0  2.0  604  280    ? S    16:31   0:00 /usr/sbin/inetd
root        22  0.4  1.9  592  272    ? S    16:31   0:15 in.telnetd
root        35  0.0  0.7  168  108    1 S    16:31   0:00 /sbin/getty 9600 tty1
root       105  0.0  1.8  608  256    ? S    16:44   0:00 portmap
root       223  0.1  1.9  592  268    ? S    17:18   0:00 in.telnetd
root       227  0.2  3.3  568  452   p1 S    17:18   0:00 -sh
root       235  0.0  3.3  568  452   p1 T    17:18   0:00 -sh
root       250  0.4  1.9  592  272    ? S    17:21   0:00 in.telnetd
tridge      25  0.0  3.3  572  460   p0 S    16:31   0:02 -bash
tridge     224  0.1  3.1  564  428   p1 S    17:18   0:00 -bash
hibana:~$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  13967360  7041024  6926336  2998272     4096  5001216
Swap:        0        0        0
MemTotal:     13640 kB
MemFree:       6764 kB
MemShared:     2928 kB
Buffers:          4 kB
Cached:        4884 kB
SwapTotal:        0 kB
SwapFree:         0 kB
hibana:~$ 

Something to tell your grandkids about man.

Later,
David S. Miller
davem@caip.rutgers.edu
