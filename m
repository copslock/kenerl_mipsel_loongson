Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id TAA12772; Tue, 26 Mar 1996 19:00:25 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id SAA28611; Tue, 26 Mar 1996 18:59:52 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id SAA28606; Tue, 26 Mar 1996 18:59:50 -0800
Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <lmlinux@neteng.engr.sgi.com> id SAA12736; Tue, 26 Mar 1996 18:59:49 -0800
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id SAA28599; Tue, 26 Mar 1996 18:59:48 -0800
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id SAA11135; Tue, 26 Mar 1996 18:59:33 -0800
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id VAA10508; Tue, 26 Mar 1996 21:58:47 -0500
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id VAA03837; Tue, 26 Mar 1996 21:58:46 -0500
Date: Tue, 26 Mar 1996 21:58:46 -0500
Message-Id: <199603270258.VAA03837@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: lmlinux@neteng.engr.sgi.com
CC: torvalds@cs.helsinki.fi, user@host.rutgers.edu, adrian@remus.rutgers.edu
Subject: it keeps going and going and...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I should yank this 'davem' guys account, he's such a fucking abusive
user.  Grrr...

? uname -a
Linux trombetas 1.3.77 #2 Tue Mar 26 19:47:52 EST 1996 sparc
? uptime
  2:56am  up  1:55,  3 users,  load average: 28.65, 28.21, 24.86
? ps -auxwww
USER       PID %CPU %MEM SIZE  RSS  TTY STAT START   TIME COMMAND
davem       38  0.0  0.0  584    0   p0 SW   01:01   0:00 (bash)
davem     1067  0.0  0.5  588  116   p1 S    01:39   0:00 -bash
davem     1107  5.5  1.0  312  228   p1 R    01:39   4:01 top
davem     1117  0.0  1.8  592  412   p2 S    01:40   0:01 -bash
davem     1142  0.0  1.0  596  236   p3 S    01:40   0:00 -bash
davem     1147  0.0  0.4  588   96   p4 S    01:40   0:00 -bash
davem     1148  0.0  0.5  588  120   p6 S    01:40   0:00 -bash
davem     1149  0.0  0.3  588   88   p7 S    01:40   0:00 -bash
davem     1150  0.0  0.5  588  132   p5 S    01:40   0:00 -bash
davem     1152  0.0  0.3  588   84   p8 S    01:40   0:00 -bash
davem     1229  5.1  0.7  416  176   p7 R    01:40   3:42 find .
davem     1230  5.1  0.7  416  176   p5 R    01:40   3:42 find .
davem     1231  5.1  0.7  416  176   p8 R    01:40   3:41 find .
davem     1232  5.1  0.7  416  176   p6 S    01:40   3:41 find .
davem     1233  5.0 11.1 4452 2492   p4 R    01:40   3:37 emacs19 -i
davem     1242  0.0  0.2  572   64   p9 S    01:43   0:00 /bin/bash -i
davem     1261  3.4  3.1 1872  704   p9 R    01:44   2:22 xgas
davem     1262  2.6  3.1 1872  708   p9 S    01:44   1:48 xgas
davem     1263  0.3  3.0 1872  692   p9 S    01:44   0:12 xgas
davem     1264  0.5  3.2 1872  716   p9 S    01:44   0:23 xgas
davem     1269  0.0  0.2  148   64   p3 S    01:46   0:00 ./crashme +2000.80 666 100 1:10:30 2
davem     1286  5.0  0.2  152   64   p3 R    01:46   3:19 ./crashme +2000.80 681 100 16 2 subprocess
davem     1422  4.6  0.2  156   64   p3 R    01:54   2:41 ./crashme +2000.80 782 100 117 2 subprocess
davem     1484  4.3  0.2  156   56   p3 R    01:59   2:20 ./crashme +2000.80 839 100 174 2 subprocess
davem     1489  4.3  0.2  156   56   p3 R    01:59   2:19 ./crashme +2000.80 844 100 179 2 subprocess
davem     1505  4.3  0.2  156   52   p3 R    02:01   2:14 ./crashme +2000.80 860 100 195 2 subprocess
davem     1516  4.3  0.2  152   56   p3 R    02:02   2:11 ./crashme +2000.80 871 100 206 2 subprocess
davem     1525  4.2  0.2  156   52   p3 R    02:02   2:08 ./crashme +2000.80 880 100 215 2 subprocess
davem     1652  4.0  0.3  152   68   p3 R    02:12   1:38 ./crashme +2000.80 999 100 334 2 subprocess
davem     1767  3.8  0.3  156   68   p3 R    02:21   1:12 ./crashme +2000.80 1102 100 437 2 subprocess
davem     1769  3.8  0.2  148   56   p3 R    02:21   1:11 ./crashme +2000.80 1104 100 439 2 subprocess
davem     1885  3.5  0.2  152   64   p3 R    02:29   0:49 ./crashme +2000.80 1200 100 535 2 subprocess
davem     1886  3.5  0.3  148   68   p3 R    02:29   0:49 ./crashme +2000.80 1201 100 536 2 subprocess
davem     1901  3.5  0.2  152   52   p3 R    02:30   0:47 ./crashme +2000.80 1212 100 547 2 subprocess
davem     1929  3.4  0.5  160  112   p3 R    02:32   0:41 ./crashme +2000.80 1240 100 575 2 subprocess
davem     1981  3.3  0.5  160  116   p3 R    02:36   0:32 ./crashme +2000.80 1288 100 623 2 subprocess
davem     2007  3.3  0.3  152   72   p3 R    02:38   0:28 ./crashme +2000.80 1310 100 645 2 subprocess
davem     2021  3.3  0.3  148   72   p3 R    02:39   0:26 ./crashme +2000.80 1324 100 659 2 subprocess
davem     2027  3.3  0.3  156   76   p3 R    02:40   0:24 ./crashme +2000.80 1330 100 665 2 subprocess
davem     2076  3.3  0.3  148   72   p3 R    02:44   0:17 ./crashme +2000.80 1376 100 711 2 subprocess
davem     2132  3.3  0.3  156   80   p3 R    02:47   0:09 ./crashme +2000.80 1421 100 756 2 subprocess
davem     2155  3.4  0.3  148   72   p3 R    02:49   0:06 ./crashme +2000.80 1440 100 775 2 subprocess
davem     2200  0.0  0.8  272  196   p2 R    02:52   0:00 ps -auxwww
root         1  0.0  0.0  188    0    ? SW   01:01   0:04 (init)
root         2  0.0  0.0    0    0    ? SW   01:01   0:01 (kflushd)
root         3  0.0  0.0    0    0    ? SW<  01:01   0:01 (kswapd)
root         7  0.0  0.1  116   28    ? S    01:01   0:01 update (bdfluHOME=/
root        23  0.0  0.1  628   24    ? S    01:01   0:00 (inetd)
root        25  0.0  0.0  636   12    ? S    01:01   0:00 (portmap)
root        36  0.1  0.2  668   48    ? S    01:01   0:07 /usr/etc/in.telnetd
root        39  0.0  0.0  152    0    1 SW   01:02   0:00 (getty)
root        40  0.0  0.0  152    0    2 SW   01:02   0:00 (getty)
root        41  0.0  0.0  152    0    3 SW   01:02   0:00 (getty)
root        42  0.0  0.0  152    0    4 SW   01:02   0:00 (getty)
root        43  0.0  0.0  152    0    5 SW   01:02   0:00 (getty)
root        44  0.0  0.0  152    0    6 SW   01:02   0:00 (getty)
root        68  0.0  0.0  900    0   p0 SW   01:02   0:02 (bash)
root       120  0.0  0.0  584    0   p0 SW   01:04   0:00 (bash)
root       134  0.0  0.0  584    0   p0 SW   01:04   0:00 (bash)
root       148  0.0  0.0  584    0   p0 SW   01:04   0:00 (bash)
root       162  0.0  0.0  584    0   p0 SW   01:04   0:00 (bash)
root       176  0.0  0.0  584    0   p0 SW   01:04   0:00 (bash)
root       190  0.0  0.0  584    0   p0 SW   01:04   0:00 (bash)
root       205  0.0  0.0  584    0   p0 SW   01:05   0:00 (bash)
root       219  0.0  0.0  584    0   p0 SW   01:05   0:00 (bash)
root       233  0.0  0.0  584    0   p0 SW   01:05   0:00 (bash)
root       247  0.0  0.0  584    0   p0 SW   01:05   0:00 (bash)
root       261  0.0  0.0  584    0   p0 SW   01:05   0:00 (bash)
root       275  0.0  0.0  584    0   p0 SW   01:05   0:00 (bash)
root       290  0.0  0.0  584    0   p0 SW   01:05   0:00 (bash)
root       304  0.0  0.0  584    0   p0 SW   01:05   0:00 (bash)
root       318  0.0  0.0  584    0   p0 SW   01:05   0:00 (bash)
root       332  0.0  0.0  584    0   p0 SW   01:05   0:00 (bash)
root       346  0.0  0.0  584    0   p0 SW   01:05   0:00 (bash)
root       360  0.0  0.0  584    0   p0 SW   01:05   0:00 (bash)
root       401  0.0  0.0  584    0   p0 SW   01:06   0:00 (bash)
root       415  0.0  0.0  584    0   p0 SW   01:06   0:00 (bash)
root       429  0.0  0.0  584    0   p0 SW   01:06   0:00 (bash)
root       443  0.0  0.0  584    0   p0 SW   01:06   0:00 (bash)
root       457  0.0  0.0  584    0   p0 SW   01:06   0:00 (bash)
root       471  0.0  0.0  584    0   p0 SW   01:06   0:00 (bash)
root       485  0.0  0.0  584    0   p0 SW   01:06   0:00 (bash)
root       501  0.0  0.0  108    0   p0 SW   01:07   0:00 (sh)
root       502  0.0  0.0  108    0   p0 SW   01:07   0:00 (sh)
root       503  0.0  0.0  112    0   p0 SW   01:07   0:00 (sh)
root       504  0.0  0.0  584    0   p0 SW   01:07   0:00 (bash)
root       518  0.0  0.0  584    0   p0 SW   01:07   0:00 (bash)
root       532  0.0  0.0  584    0   p0 SW   01:07   0:00 (bash)
root       546  0.0  0.0  584    0   p0 SW   01:07   0:00 (bash)
root       560  0.0  0.0  584    0   p0 SW   01:07   0:00 (bash)
root       574  0.0  0.0  592    0   p0 SW   01:07   0:00 (bash)
root       721  0.0  0.5  888  116   p0 S    01:12   0:01 (make)
root       757  0.0  0.9  552  204   p0 S    01:15   0:00 /bin/bash -c set -e; for i in kernel drivers mm fs net ipc lib arch/sparc/kernel arch/sparc/lib arch/sparc/mm arch/sparc/prom; do make -C $i; done
root      1064  0.2  3.8 1976  856    ? S    01:39   0:09 xterm -T trombetas
root      1085  0.0  0.5  604  124   p1 T    01:39   0:00 /bin/bash
root      1116  0.0  0.8  668  180    ? S    01:40   0:01 /usr/etc/in.telnetd
root      1138  0.5  3.7 1976  848   p2 S    01:40   0:23 xterm
root      1139  4.0  2.9 1960  668   p2 S    01:40   2:55 xterm
root      1140  4.0  2.9 1960  652   p2 S    01:40   2:54 xterm
root      1141  0.0  2.8 1960  644   p2 S    01:40   0:00 xterm
root      1143  4.0  2.9 1960  656   p2 S    01:40   2:56 xterm
root      1144  4.0  2.9 1960  648   p2 S    01:40   2:55 xterm
root      1293  0.0  1.0  588  228   p3 S    01:46   0:00 /bin/bash
root      1481  0.0  0.6  612  148   p3 S    01:59   0:00 (tail)
root      2102  0.2  2.5  888  560   p0 S    02:46   0:01 make -C fs
root      2112  0.0  0.4  112  100   p0 S    02:46   0:00 /bin/sh -c set -e; for i in ext2 proc nfs; do make -C $i; done
root      2113  0.2  2.4  868  544   p0 S    02:46   0:01 make -C ext2
root      2123  0.3  2.4  876  548   p0 S    02:47   0:01 make all_targets
root      2173  0.1  1.1  660  268   p0 S    02:50   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -g -pipe -c -o balloc.o balloc.c
root      2174  1.1  3.8 1332  856   p0 S    02:51   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      2175  2.9 10.9 3396 2452   p0 R    02:51   0:03 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase balloc.c -g -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      2176  0.2  3.0 1204  680   p0 S    02:51   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o balloc.o
? top
  2:53am  up  1:51,  3 users,  load average: 28.51, 27.67, 23.85
112 processes: 83 sleeping, 28 running, 0 zombie, 1 stopped
CPU states: 43.7% user, 54.4% system, 95.8% nice,  4.2% idle
Mem:  22344K av, 21976K used,   368K free, 12056K shrd,  5308K buf   328K ca
Swap: 65516K av,  6648K used, 58868K free

  PID USER     PRI  NI SIZE  RES SHRD STAT %CPU %MEM  TIME COMMAND
 1767 davem     16  15  156   56   36 R     3.2  0.2  1:13 ./crashme +2000.80 1
 1652 davem     17  15  152   60   40 R     3.1  0.2  1:39 ./crashme +2000.80 9
 1107 davem     15  15  312  228  104 R     3.1  1.0  4:02 top
 1886 davem     13  15  148   64   44 R     3.1  0.2  0:50 ./crashme +2000.80 1
 1286 davem     19  15  152   64   44 R     3.1  0.2  3:20 ./crashme +2000.80 6
 1233 davem     16  15 4452 2456 1308 R     3.0 10.9  3:38 emacs19 -i
 1229 davem     18  15  416  176   80 R     2.9  0.7  3:43 find .
 1422 davem     12  15  156   56   36 R     2.9  0.2  2:42 ./crashme +2000.80 7
 1505 davem     11  15  156   52   32 R     2.9  0.2  2:15 ./crashme +2000.80 8
 1516 davem     11  15  152   52   32 R     2.9  0.2  2:12 ./crashme +2000.80 8
 1981 davem     10  15  160  112   76 R     2.9  0.5  0:33 ./crashme +2000.80 1
 2076 davem     19  15  148   68   44 R     2.9  0.3  0:18 ./crashme +2000.80 1
 1769 davem     20  15  148   56   36 R     2.9  0.2  1:12 ./crashme +2000.80 1
 1929 davem     17  15  160  108   76 R     2.9  0.4  0:42 ./crashme +2000.80 1
 2132 davem     17  15  156   76   44 R     2.9  0.3  0:10 ./crashme +2000.80 1
 2027 davem     15  15  156   68   40 R     2.9  0.3  0:26 ./crashme +2000.80 1
 2155 davem     14  15  148   64   40 R     2.9  0.2  0:08 ./crashme +2000.80 1
