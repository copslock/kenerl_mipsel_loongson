Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA06499; Thu, 18 Apr 1996 03:23:32 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id DAA27721; Thu, 18 Apr 1996 03:23:26 -0700
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id DAA27716; Thu, 18 Apr 1996 03:23:25 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA06496 for <lmlinux@neteng.engr.sgi.com>; Thu, 18 Apr 1996 03:23:24 -0700
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id DAA27711; Thu, 18 Apr 1996 03:23:23 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id DAA23687; Thu, 18 Apr 1996 03:23:21 -0700
Received: from caip.rutgers.edu (caip.rutgers.edu [128.6.19.83]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id GAA25790; Thu, 18 Apr 1996 06:23:18 -0400
Received: (davem@localhost) by caip.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id GAA21132; Thu, 18 Apr 1996 06:23:17 -0400
Date: Thu, 18 Apr 1996 06:23:17 -0400
Message-Id: <199604181023.GAA21132@caip.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: sparclinux@vger.rutgers.edu
CC: linux-smp@vger.rutgers.edu, lmlinux@neteng.engr.sgi.com
Subject: this is sooo much fun...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


USER       PID %CPU %MEM SIZE  RSS  TTY STAT START   TIME COMMAND
davem       41  0.0  0.2  588  436    1 S    08:52   0:01 -bash
davem     1689  0.0  0.0  112  100    1 S    09:08   0:00 sh /usr/local/X11R5/bin/startx
davem     1690  0.0  0.2 1140  452    1 S    09:08   0:00 xinit /usr/home/davem/.xinitrc --
davem     1691  1.6  0.8 3796 1516    1 S    09:08   1:19 X :0
davem     1692  0.0  0.4 1296  744    1 S    09:08   0:04 fvwm
davem     1714  0.0  0.2 1092  520    1 S    09:08   0:00 /usr/local/X11R5/lib/X11/fvwm/FvwmPager 7 4 /usr/home/davem/.fvwmrc 0 8 0 3
davem     2061  0.0  0.2  596  464   p3 S    09:11   0:01 -bash
davem     4336  0.0  0.2  600  468   p0 S    09:50   0:00 -bash
davem     4361  0.0  0.0  148   68   p0 S    09:53   0:01 ./crashme +2000 666 100 1:10:30 2
davem     4383 30.6  0.1  348  268   p0 R    09:53  10:36 ./crashme +2000 686 100 21 2 subprocess
davem     4430 24.0  0.0  228  148   p0 R    09:56   7:38 ./crashme +2000 721 100 56 2 subprocess
davem     4468 20.0  0.0  252  172   p0 R    09:58   6:01 ./crashme +2000 741 100 76 2 subprocess
davem     4478 18.9  0.1  344  264   p0 R    09:59   5:32 ./crashme +2000 750 100 85 2 subprocess
davem     4488 18.1  0.0  176   96   p0 R    09:59   5:09 ./crashme +2000 759 100 94 2 subprocess
davem     4507 17.1  0.0  252  172   p0 R    10:01   4:38 ./crashme +2000 775 100 110 2 subprocess
davem     4515  0.1  0.2  696  392   p3 S    10:01   0:02 telnet caip
davem     4520  0.0  0.2  588  464   p1 S    10:02   0:00 -bash
davem     4526 16.6  0.1  252  176   p0 R    10:02   4:23 ./crashme +2000 784 100 119 2 subprocess
davem     4589 14.6  0.0  216  140   p0 R    10:06   3:15 ./crashme +2000 833 100 168 2 subprocess
davem     4628 12.9  0.1  312  236   p0 R    10:09   2:28 ./crashme +2000 871 100 206 2 subprocess
davem     4661 12.3  0.1  256  176   p0 R    10:10   2:11 ./crashme +2000 887 100 222 2 subprocess
davem     4736 11.1  0.1 2260  264   p0 R    10:13   1:40 ./crashme +2000 920 100 255 2 subprocess
davem     4756 11.0  0.0  228  152   p0 R    10:13   1:37 ./crashme +2000 923 100 258 2 subprocess
davem     4815  0.0  0.2  592  444   p2 S    10:14   0:00 -bash
davem     4830  2.1  0.6 1872 1188   p2 R    10:14   0:17 xgas
davem     4845 10.6  0.0  208  128   p0 R    10:15   1:25 ./crashme +2000 939 100 274 2 subprocess
davem     4851 10.5  0.1  348  268   p0 R    10:15   1:22 ./crashme +2000 942 100 277 2 subprocess
davem     4852  1.4  0.2 1064  456   p2 S    10:15   0:11 xswarm
davem     4896  0.1  0.2  588  448   p4 S    10:16   0:00 -bash
davem     4990  9.5  0.0  228  148   p0 R    10:19   0:51 ./crashme +2000 992 100 327 2 subprocess
davem     5024  9.2  0.1  348  268   p0 R    10:20   0:43 ./crashme +2000 1006 100 341 2 subprocess
davem     5058  9.0  0.1  332  256   p0 R    10:21   0:37 ./crashme +2000 1015 100 350 2 subprocess
davem     5143  8.4  0.0  204  124   p0 R    10:23   0:27 ./crashme +2000 1035 100 370 2 subprocess
davem     5150  8.4  0.1  340  264   p0 R    10:23   0:26 ./crashme +2000 1037 100 372 2 subprocess
davem     5207  0.1  0.2  584  444   p5 S    10:24   0:00 -bash
davem     5226  7.2  0.1  320  272   p5 R    10:24   0:16 top
davem     5297  7.1  0.0  192  116   p0 R    10:26   0:09 ./crashme +2000 1072 100 407 2 subprocess
davem     5473  0.0  0.0  248  172   p4 R    10:28   0:00 ps -auxwww
davem     5475 99.9  0.1  264  184   p0 R    10:28   0:00 ./crashme +2000 1100 100 435 2 subprocess
root         1  0.2  0.0  188  144    ? S    08:51   0:14 init [2]                                                                                  
root         2  0.0  0.0    0    0    ? SW   08:51   0:00 (kflushd)
root         3  0.0  0.0    0    0    ? SW<  08:51   0:00 (kswapd)
root         4  0.0  0.0    0    0    ? SW   08:52   0:00 (nfsiod)
root         5  0.0  0.0    0    0    ? SW   08:52   0:00 (nfsiod)
root         6  0.0  0.0    0    0    ? SW   08:52   0:00 (nfsiod)
root         7  0.0  0.0    0    0    ? SW   08:52   0:00 (nfsiod)
root        11  0.1  0.0  116   44    ? S    08:52   0:10 update (bdfluHOME=/
root        27  0.0  0.1  628  268    ? S    08:52   0:00 /usr/etc/inetd
root        29  0.0  0.1  636  248    ? S    08:52   0:00 /usr/etc/portmap
root        42  0.0  0.0  152  100    2 S    08:52   0:00 /sbin/getty 9600 tty2
root        43  0.0  0.0  152  100    3 S    08:52   0:00 /sbin/getty 9600 tty3
root        44  0.0  0.0  152  100    4 S    08:52   0:00 /sbin/getty 9600 tty4
root        45  0.0  0.0  152  100    5 S    08:52   0:00 /sbin/getty 9600 tty5
root        46  0.0  0.0  152  100    6 S    08:52   0:00 /sbin/getty 9600 tty6
root      2060  0.0  0.6 1996 1220    1 S    09:11   0:03 xterm
root      4335  0.0  0.6 1980 1180    1 S    09:50   0:00 xterm
root      4519  0.0  0.6 1980 1204    1 S    10:02   0:01 xterm
root      4644  0.0  0.2  592  460   p1 S    10:10   0:00 /bin/bash
root      4814  0.0  0.6 1960 1164    1 S    10:14   0:00 xterm
root      4894  0.1  0.6 1960 1164    1 S    10:16   0:01 xterm
root      5205  0.3  0.2  668  364    ? S    10:24   0:00 /usr/etc/in.telnetd
root      5272  0.1  0.2  596  444   p4 T    10:25   0:00 /bin/bash
root      5341  1.6  0.3  912  580   p1 S    10:27   0:01 make -j
root      5349  0.0  0.1  556  304   p1 S    10:27   0:00 /bin/bash -c set -e; for i in kernel drivers mm fs net ipc lib arch/sparc/kernel arch/sparc/lib arch/sparc/mm arch/sparc/prom; do make -C $i; done
root      5351  0.4  0.3  864  540   p1 S    10:27   0:00 make -C kernel
root      5365  1.9  0.3  964  636   p1 S    10:27   0:01 make all_targets
root      5376  0.3  0.1  660  268   p1 S    10:27   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o init/main.o init/main.c
root      5381  0.2  0.1  660  268   p1 S    10:27   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -fno-omit-frame-pointer -c sched.c
root      5382  5.1  2.0 4112 3664   p1 R    10:27   0:02 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase main.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5383  0.1  0.3 1132  552   p1 S    10:27   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o init/main.o
root      5392  1.3  0.4 1288  856   p1 S    10:27   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5393  5.2  2.0 4128 3664   p1 R    10:27   0:02 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase sched.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -fno-omit-frame-pointer -o -
root      5394  0.2  0.3 1132  560   p1 S    10:27   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o sched.o
root      5397  0.2  0.1  660  268   p1 S    10:27   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o sys.o sys.c
root      5407  0.2  0.1  660  268   p1 S    10:27   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o exit.o exit.c
root      5417  1.4  0.5 1420  896   p1 S    10:27   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5422  5.2  1.9 3920 3436   p1 R    10:27   0:02 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase sys.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5423  0.3  0.3 1132  552   p1 S    10:27   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o sys.o
root      5429  5.6  1.9 3824 3372   p1 R    10:27   0:02 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase exit.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5430  0.4  0.3 1132  556   p1 S    10:27   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o exit.o
root      5451  0.3  0.1  660  268   p1 S    10:27   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o fork.o fork.c
root      5457  0.3  0.1  660  268   p1 S    10:27   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o sysctl.o sysctl.c
root      5459  5.6  2.0 4168 3668   p1 R    10:27   0:02 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase fork.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5461  0.1  0.3 1132  548   p1 S    10:27   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o fork.o
root      5462  1.6  0.4 1356  876   p1 S    10:27   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5463  5.3  1.9 3912 3432   p1 R    10:27   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase sysctl.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5464  0.3  0.3 1132  548   p1 S    10:27   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o sysctl.o
