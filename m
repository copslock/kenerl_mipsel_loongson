Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA06508; Thu, 18 Apr 1996 03:26:48 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id DAA27931; Thu, 18 Apr 1996 03:26:43 -0700
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id DAA27926; Thu, 18 Apr 1996 03:26:42 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA06505 for <lmlinux@neteng.engr.sgi.com>; Thu, 18 Apr 1996 03:26:41 -0700
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id DAA27923; Thu, 18 Apr 1996 03:26:41 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id DAA23921; Thu, 18 Apr 1996 03:26:39 -0700
Received: from caip.rutgers.edu (caip.rutgers.edu [128.6.19.83]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id GAA25952; Thu, 18 Apr 1996 06:26:38 -0400
Received: (davem@localhost) by caip.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id GAA21229; Thu, 18 Apr 1996 06:26:37 -0400
Date: Thu, 18 Apr 1996 06:26:37 -0400
Message-Id: <199604181026.GAA21229@caip.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: sparclinux@vger.rutgers.edu
CC: lmlinux@neteng.engr.sgi.com
Subject: you guys really have to try this sometime...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


YOWW!  Am I MULTI-PENGUIN yet!!!???

USER       PID %CPU %MEM SIZE  RSS  TTY STAT START   TIME COMMAND
davem       41  0.0  0.2  588  436    1 S    08:52   0:01 -bash
davem     1689  0.0  0.0  112  100    1 S    09:08   0:00 sh /usr/local/X11R5/bin/startx
davem     1690  0.0  0.2 1140  452    1 S    09:08   0:00 xinit /usr/home/davem/.xinitrc --
davem     1691  1.6  0.8 3796 1516    1 S    09:08   1:23 X :0
davem     1692  0.0  0.4 1296  744    1 S    09:08   0:04 fvwm
davem     1714  0.0  0.2 1092  520    1 S    09:08   0:00 /usr/local/X11R5/lib/X11/fvwm/FvwmPager 7 4 /usr/home/davem/.fvwmrc 0 8 0 3
davem     2061  0.0  0.2  596  464   p3 S    09:11   0:01 -bash
davem     4336  0.0  0.2  600  468   p0 S    09:50   0:00 -bash
davem     4361  0.0  0.0  148   68   p0 S    09:53   0:02 ./crashme +2000 666 100 1:10:30 2
davem     4383 29.0  0.1  348  268   p0 R    09:53  10:49 ./crashme +2000 686 100 21 2 subprocess
davem     4430 22.7  0.0  228  148   p0 R    09:56   7:51 ./crashme +2000 721 100 56 2 subprocess
davem     4468 19.0  0.0  252  172   p0 R    09:58   6:14 ./crashme +2000 741 100 76 2 subprocess
davem     4478 18.0  0.1  344  264   p0 R    09:59   5:45 ./crashme +2000 750 100 85 2 subprocess
davem     4488 17.2  0.0  176   96   p0 R    09:59   5:22 ./crashme +2000 759 100 94 2 subprocess
davem     4507 16.2  0.0  252  172   p0 R    10:01   4:52 ./crashme +2000 775 100 110 2 subprocess
davem     4515  0.1  0.2  696  392   p3 S    10:01   0:02 telnet caip
davem     4520  0.0  0.2  588  464   p1 S    10:02   0:00 -bash
davem     4526 15.7  0.1  252  176   p0 R    10:02   4:36 ./crashme +2000 784 100 119 2 subprocess
davem     4589 13.8  0.0  216  140   p0 R    10:06   3:28 ./crashme +2000 833 100 168 2 subprocess
davem     4628 12.3  0.1  312  236   p0 R    10:09   2:41 ./crashme +2000 871 100 206 2 subprocess
davem     4661 11.7  0.1  256  176   p0 R    10:10   2:24 ./crashme +2000 887 100 222 2 subprocess
davem     4736 10.6  0.1 2260  264   p0 R    10:13   1:52 ./crashme +2000 920 100 255 2 subprocess
davem     4756 10.5  0.0  228  152   p0 R    10:13   1:50 ./crashme +2000 923 100 258 2 subprocess
davem     4815  0.0  0.2  592  444   p2 S    10:14   0:00 -bash
davem     4830  2.2  0.6 1872 1188   p2 S    10:14   0:22 xgas
davem     4845 10.1  0.0  208  128   p0 R    10:15   1:38 ./crashme +2000 939 100 274 2 subprocess
davem     4851 10.0  0.1  348  268   p0 R    10:15   1:35 ./crashme +2000 942 100 277 2 subprocess
davem     4852  1.4  0.2 1064  456   p2 R    10:15   0:13 xswarm
davem     4896  0.1  0.2  592  452   p4 S    10:16   0:00 -bash
davem     4990  9.1  0.0  228  148   p0 R    10:19   1:04 ./crashme +2000 992 100 327 2 subprocess
davem     5024  8.8  0.1  348  268   p0 R    10:20   0:55 ./crashme +2000 1006 100 341 2 subprocess
davem     5058  8.6  0.1  332  256   p0 R    10:21   0:50 ./crashme +2000 1015 100 350 2 subprocess
davem     5143  8.2  0.0  204  124   p0 R    10:23   0:40 ./crashme +2000 1035 100 370 2 subprocess
davem     5150  8.2  0.1  340  264   p0 R    10:23   0:39 ./crashme +2000 1037 100 372 2 subprocess
davem     5207  0.0  0.2  584  444   p5 S    10:24   0:00 -bash
davem     5226  7.4  0.1  320  272   p5 R    10:24   0:28 top
davem     5297  7.6  0.0  192  116   p0 R    10:26   0:22 ./crashme +2000 1072 100 407 2 subprocess
davem     5612  0.0  0.1  252  176   p4 R    10:31   0:01 ps -auxwww
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
root      2060  0.0  0.6 1996 1220    1 S    09:11   0:04 xterm
root      4335  0.0  0.6 1980 1180    1 S    09:50   0:00 xterm
root      4519  0.0  0.6 1980 1204    1 S    10:02   0:01 xterm
root      4644  0.0  0.2  592  460   p1 S    10:10   0:00 /bin/bash
root      4814  0.0  0.6 1960 1164    1 S    10:14   0:00 xterm
root      4894  0.1  0.6 1960 1164    1 S    10:16   0:01 xterm
root      5205  0.3  0.2  668  364    ? S    10:24   0:01 /usr/etc/in.telnetd
root      5272  0.1  0.2  604  448   p4 T    10:25   0:00 /bin/bash
root      5341  0.5  0.3  912  580   p1 S    10:27   0:01 make -j
root      5349  0.0  0.1  556  304   p1 S    10:27   0:00 /bin/bash -c set -e; for i in kernel drivers mm fs net ipc lib arch/sparc/kernel arch/sparc/lib arch/sparc/mm arch/sparc/prom; do make -C $i; done
root      5488  0.2  0.2  844  520   p1 S    10:29   0:00 make -C drivers
root      5491  0.0  0.0  116  104   p1 S    10:29   0:00 /bin/sh -c set -e; for i in block char net  sbus scsi; do make -C $i; done
root      5529  1.0  0.3  900  572   p1 S    10:30   0:00 make -C char
root      5532  4.5  0.3  996  668   p1 S    10:30   0:01 make all_targets
root      5537  0.6  0.1  660  268   p1 S    10:30   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o n_tty.o n_tty.c
root      5538  0.6  0.1  660  268   p1 S    10:30   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o sparc/keyboard.o sparc/keyboard.c
root      5539  0.5  0.1  660  268   p1 S    10:30   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o tty_ioctl.o tty_ioctl.c
root      5540  0.5  0.1  660  268   p1 S    10:30   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o pty.o pty.c
root      5541  2.6  0.4 1184  796   p1 S    10:30   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5542  0.8  0.1  660  268   p1 S    10:30   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o vt.o vt.c
root      5543  3.0  0.4 1260  836   p1 S    10:30   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5544  9.8  2.0 3988 3528   p1 R    10:30   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase keyboard.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5546 10.0  1.8 3780 3272   p1 R    10:30   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase n_tty.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5547  0.5  0.3 1132  548   p1 S    10:30   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o n_tty.o
root      5548  3.2  0.4 1220  800   p1 S    10:30   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5549 10.0  1.9 3788 3340   p1 R    10:30   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase tty_ioctl.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5550  0.5  0.3 1132  552   p1 S    10:30   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o tty_ioctl.o
root      5552  9.7  1.8 3752 3292   p1 R    10:30   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase pty.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5553  0.5  0.3 1132  548   p1 S    10:30   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o pty.o
root      5555  0.6  0.3 1132  548   p1 S    10:30   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o sparc/keyboard.o
root      5556  0.9  0.1  660  268   p1 S    10:30   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o vc_screen.o vc_screen.c
root      5557  0.9  0.1  660  268   p1 S    10:30   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o random.o random.c
root      5559  3.3  0.4 1236  840   p1 S    10:30   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5560 10.6  1.9 3928 3456   p1 R    10:30   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase vt.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5561  0.6  0.3 1132  548   p1 S    10:30   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o vt.o
root      5563 12.8  1.7 3508 3016   p1 R    10:30   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase vc_screen.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5564  0.8  0.3 1132  548   p1 S    10:30   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o vc_screen.o
root      5565  3.7  0.4 1184  780   p1 S    10:30   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5566 11.2  1.8 3800 3296   p1 R    10:30   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase random.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5567  0.8  0.3 1132  548   p1 S    10:30   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o random.o
root      5569  1.2  0.1  660  268   p1 S    10:30   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o consolemap.o consolemap.c
root      5570  1.1  0.1  660  268   p1 S    10:30   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o selection.o selection.c
root      5571  0.8  0.1  660  268   p1 S    10:30   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o sparc/serial.o sparc/serial.c
root      5572  1.4  0.1  660  268   p1 S    10:30   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o sunmouse.o sunmouse.c
root      5574  1.0  0.1  660  268   p1 S    10:31   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o suncons.o suncons.c
root      5579 15.0  1.8 3752 3232   p1 R    10:31   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase selection.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5580  0.9  0.3 1132  548   p1 S    10:31   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o selection.o
root      5581  4.9  0.4 1280  824   p1 S    10:31   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5582 16.0  1.8 3676 3188   p1 R    10:31   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase consolemap.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5583  1.0  0.3 1132  560   p1 S    10:31   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o consolemap.o
root      5584  5.3  0.4 1256  872   p1 S    10:31   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5585 16.0  1.9 3952 3484   p1 R    10:31   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase serial.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5586  0.9  0.3 1132  548   p1 S    10:31   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o sparc/serial.o
root      5588 18.0  1.8 3740 3220   p1 R    10:31   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase sunmouse.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5589  0.9  0.3 1132  548   p1 S    10:31   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o sunmouse.o
root      5590  2.0  0.1  660  268   p1 S    10:31   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o misc.o misc.c
root      5591  1.5  0.1  660  268   p1 S    10:31   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o tty_io.o tty_io.c
root      5592  1.7  0.1  660  268   p1 S    10:31   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o console.o console.c
root      5593  1.1  0.1  660  268   p1 S    10:31   0:00 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe -c -o mem.o mem.c
root      5594  8.4  0.6 1728 1108   p1 S    10:31   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5596 21.3  1.9 4136 3340   p1 R    10:31   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase suncons.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5597  0.7  0.3 1132  548   p1 S    10:31   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o suncons.o
root      5598  6.7  0.4 1308  848   p1 S    10:31   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5599 21.6  1.9 3928 3436   p1 R    10:31   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase mem.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5600  0.8  0.3 1132  548   p1 S    10:31   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o mem.o
root      5602  8.7  0.5 1472  944   p1 S    10:31   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5603 26.1  1.9 3936 3444   p1 R    10:31   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase tty_io.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5604  1.0  0.3 1132  548   p1 S    10:31   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o tty_io.o
root      5605  8.4  0.5 1600 1032   p1 S    10:31   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cpp -lang-c -I/usr/src/linux/include -undef -D__GNUC__=2 -D__GNUC_MINOR__=6 -Dsparc -Dsun -Dunix -D__GCC_NEW_VARARGS__ -D__sparc__ -D__sun__ -D__unix__ -D__GCC_NEW_VARARGS__ -D__sparc -D__sun -D__unix 
root      5606 27.1  2.0 4116 3620   p1 R    10:31   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase console.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o -
root      5607  1.2  0.3 1132  548   p1 S    10:31   0:00 /usr/local/gnu/sparc-sun-sunos4.1.4/bin/as - -o console.o
