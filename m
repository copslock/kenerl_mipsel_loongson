Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA06462; Thu, 18 Apr 1996 03:03:45 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id DAA26426; Thu, 18 Apr 1996 03:03:40 -0700
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id DAA26410; Thu, 18 Apr 1996 03:03:37 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA06459 for <lmlinux@neteng.engr.sgi.com>; Thu, 18 Apr 1996 03:03:36 -0700
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id DAA26404; Thu, 18 Apr 1996 03:03:35 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id DAA22557; Thu, 18 Apr 1996 03:03:32 -0700
Received: from caip.rutgers.edu (caip.rutgers.edu [128.6.19.83]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id GAA24871; Thu, 18 Apr 1996 06:03:26 -0400
Received: (davem@localhost) by caip.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id GAA20599; Thu, 18 Apr 1996 06:03:26 -0400
Date: Thu, 18 Apr 1996 06:03:26 -0400
Message-Id: <199604181003.GAA20599@caip.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: sparclinux@vger.rutgers.edu
CC: linux-smp@vger.rutgers.edu, linux-kernel@vger.rutgers.edu,
        lmlinux@neteng.engr.sgi.com, user@host.rutgers.edu
Subject: SMP, yeah it works dude...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


make -j vmlinux in 3 minutes 45 seconds, second time was a little
faster because it was all in the cache... and... of course

? ps -auxwww
USER       PID %CPU %MEM SIZE  RSS  TTY STAT START   TIME COMMAND
davem       41  0.0  0.2  588  436    1 S    08:52   0:01 -bash
davem     1689  0.0  0.0  112  100    1 S    09:08   0:00 sh
/usr/local/X11R5/bin/startx
davem     1690  0.0  0.2 1140  452    1 S    09:08   0:00 xinit
/usr/home/davem/.xinitrc --
davem     1691  1.7  0.8 3760 1476    1 S    09:08   0:56 X :0
davem     1692  0.1  0.4 1292  736    1 S    09:08   0:03 fvwm
davem     1714  0.0  0.2 1092  520    1 S    09:08   0:00
/usr/local/X11R5/lib/X11/fvwm/FvwmPager 7 4 /usr/home/davem/.fvwmrc 0
8 0 3
davem     2061  0.0  0.2  596  464   p3 S    09:11   0:01 -bash
davem     4336  0.0  0.2  600  468   p0 S    09:50   0:00 -bash
davem     4361  0.1  0.0  148   68   p0 S    09:53   0:00 ./crashme
+2000 666 100 1:10:30 2
davem     4383 74.4  0.1  348  268   p0 R    09:53   6:12 ./crashme
+2000 686 100 21 2 subprocess
davem     4430 59.8  0.0  228  148   p0 R    09:56   3:15 ./crashme
+2000 721 100 56 2 subprocess
davem     4468 43.6  0.0  252  172   p0 R    09:58   1:39 ./crashme
+2000 741 100 76 2 subprocess
davem     4478 38.1  0.1  344  264   p0 R    09:59   1:09 ./crashme
+2000 750 100 85 2 subprocess
davem     4488 34.8  0.0  176   96   p0 R    09:59   0:47 ./crashme
+2000 759 100 94 2 subprocess
davem     4507 31.6  0.0  252  172   p0 R    10:01   0:17 ./crashme
+2000 775 100 110 2 subprocess
davem     4515  0.2  0.2  696  392   p3 S    10:01   0:00 telnet caip
davem     4520  2.0  0.2  588  436   p1 S    10:02   0:00 -bash
davem     4526 29.3  0.1  252  176   p0 R    10:02   0:02 ./crashme
+2000 784 100 119 2 subprocess
davem     4537  0.0  0.0  232  156   p1 R    10:02   0:00 ps -auxwww
root         1  0.3  0.0  188  144    ? S    08:51   0:14 init [2]
                                                                             
root         2  0.0  0.0    0    0    ? SW   08:51   0:00 (kflushd)
root         3  0.0  0.0    0    0    ? SW<  08:51   0:00 (kswapd)
root         4  0.0  0.0    0    0    ? SW   08:52   0:00 (nfsiod)
root         5  0.0  0.0    0    0    ? SW   08:52   0:00 (nfsiod)
root         6  0.0  0.0    0    0    ? SW   08:52   0:00 (nfsiod)
root         7  0.0  0.0    0    0    ? SW   08:52   0:00 (nfsiod)
root        11  0.2  0.0  116   44    ? S    08:52   0:09 update
(bdfluHOME=/
root        27  0.0  0.1  628  268    ? S    08:52   0:00
/usr/etc/inetd
root        29  0.0  0.1  636  248    ? S    08:52   0:00
/usr/etc/portmap
root        42  0.0  0.0  152  100    2 S    08:52   0:00 /sbin/getty
9600 tty2
root        43  0.0  0.0  152  100    3 S    08:52   0:00 /sbin/getty
9600 tty3
root        44  0.0  0.0  152  100    4 S    08:52   0:00 /sbin/getty
9600 tty4
root        45  0.0  0.0  152  100    5 S    08:52   0:00 /sbin/getty
9600 tty5
root        46  0.0  0.0  152  100    6 S    08:52   0:00 /sbin/getty
9600 tty6
root      2060  0.0  0.6 1996 1220    1 S    09:11   0:01 xterm
root      4335  0.0  0.6 1980 1180    1 S    09:50   0:00 xterm
root      4519  2.4  0.6 1980 1180    1 S    10:02   0:00 xterm
? uname -a
Linux huahaga 1.3.90 #10 Thu Apr 18 04:44:32 EDT 1996 sparc
? cat /proc/cpuinfo 
cpu             : ROSS HyperSparc RT625
fpu             : ROSS HyperSparc combined IU/FPU
promlib         : Version 3 Revision 2
type            : sun4m
Elf Support     : yes
Cpu0Bogo        : 116.73
Cpu1Bogo        : 116.73
Cpu2Bogo        : 0.00
Cpu3Bogo        : 0.00
MMU type        : ROSS HyperSparc
invall          : 102
invmm           : 10509
invrnge         : 155469
invpg           : 2305064
contexts        : 4096
big_chunks      : 0
little_chunks   : 0

        CPU0            CPU1            CPU2            CPU3
State: online           akp             offline         offline
Lock:  00000002         00000002                00000000
 00000000

klock: ff
block: 0
alock: 0
? uptime
 10:04am  up  1:12,  2 users,  load average: 7.39, 5.20, 3.63
? 

It keeps going and going and going....

Later,
David S. Miller
davem@caip.rutgers.edu
