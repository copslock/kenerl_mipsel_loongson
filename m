Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA24789; Sat, 6 Apr 1996 21:36:38 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id VAA22757; Sat, 6 Apr 1996 21:36:29 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id VAA22752; Sat, 6 Apr 1996 21:36:27 -0800
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA24779 for <lmlinux@neteng.engr.sgi.com>; Sat, 6 Apr 1996 21:36:26 -0800
Received: from caipfs.rutgers.edu by deliverator.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/951211.SGI.AUTO)
	 id VAA14783; Sat, 6 Apr 1996 21:36:23 -0800
Received: from caip.rutgers.edu (caip.rutgers.edu [128.6.19.83]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id AAA22276; Sun, 7 Apr 1996 00:36:21 -0500
Received: (davem@localhost) by caip.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id AAA13292; Sun, 7 Apr 1996 00:36:21 -0500
Date: Sun, 7 Apr 1996 00:36:21 -0500
Message-Id: <199604070536.AAA13292@caip.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: sparclinux@vger.rutgers.edu
CC: lmlinux@neteng.engr.sgi.com, user@host.rutgers.edu
Subject: ho hum...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Can your multi-national, client server, multi-threaded, customer ready
bloat OS with enhanced interoperability do this?

? ps -auxwww | grep crashme
davem     5869  0.0  0.0  148   68   p4 S    05:02   0:00 ./crashme +2000.80 666 100 1:10:30 2
davem     5885 10.0  0.0  152   76   p4 R    05:02   2:47 ./crashme +2000.80 681 100 16 2 subprocess
davem     5888  0.0  0.0  148   68   p4 S    05:02   0:00 ./crashme +2000 666 100 1:10:30 2
davem     5915  9.6  0.1  348  268   p4 R    05:03   2:39 ./crashme +2000 686 100 21 2 subprocess
davem     5997  7.8  0.0  232  152   p4 R    05:06   1:55 ./crashme +2000 721 100 56 2 subprocess
davem     6041  7.0  0.1  348  268   p4 R    05:07   1:36 ./crashme +2000 741 100 76 2 subprocess
davem     6062  6.3  0.1  348  268   p4 R    05:08   1:25 ./crashme +2000 750 100 85 2 subprocess
davem     6082  6.0  0.0  176   96   p4 R    05:09   1:17 ./crashme +2000 759 100 94 2 subprocess
davem     6116  5.4  0.1  256  176   p4 R    05:10   1:05 ./crashme +2000 775 100 110 2 subprocess
davem     6130  5.1  0.0  160   84   p4 R    05:11   1:00 ./crashme +2000.80 782 100 117 2 subprocess
davem     6137  5.1  0.1  252  176   p4 R    05:11   0:59 ./crashme +2000 784 100 119 2 subprocess
davem     6140  5.2  0.1  284  204   p4 R    05:11   1:00 ./crashme +2000 785 100 120 2 subprocess
davem     6161  5.0  0.0  196  116   p4 R    05:12   0:56 ./crashme +2000 792 100 127 2 subprocess
davem     6276  4.5  0.0  220  144   p4 R    05:15   0:41 ./crashme +2000 833 100 168 2 subprocess
davem     6288  4.5  0.0  156   80   p4 R    05:15   0:40 ./crashme +2000.80 839 100 174 2 subprocess
davem     6298  4.3  0.0  156   80   p4 R    05:16   0:37 ./crashme +2000.80 844 100 179 2 subprocess
davem     6343  4.2  0.0  160   84   p4 R    05:17   0:32 ./crashme +2000.80 860 100 195 2 subprocess
davem     6370  4.1  0.0  152   76   p4 R    05:18   0:29 ./crashme +2000.80 871 100 206 2 subprocess
davem     6372  4.1  0.1  312  236   p4 R    05:18   0:30 ./crashme +2000 871 100 206 2 subprocess
davem     6389  4.0  0.0  160   84   p4 R    05:19   0:27 ./crashme +2000.80 880 100 215 2 subprocess
davem     6406  4.0  0.1  256  176   p4 R    05:19   0:26 ./crashme +2000 887 100 222 2 subprocess
davem     6481  3.8  0.1 2248  260   p4 R    05:22   0:18 ./crashme +2000 920 100 255 2 subprocess
davem     6487  3.8  0.0  228  152   p4 R    05:22   0:17 ./crashme +2000 923 100 258 2 subprocess
davem     6519  3.7  0.0  208  128   p4 R    05:24   0:14 ./crashme +2000 939 100 274 2 subprocess
davem     6520  3.7  0.0  156   76   p4 R    05:24   0:14 ./crashme +2000.80 940 100 275 2 subprocess
davem     6525  3.7  0.1  348  268   p4 R    05:24   0:13 ./crashme +2000 942 100 277 2 subprocess
davem     6633  4.1  0.0  232  152   p4 R    05:28   0:05 ./crashme +2000 992 100 327 2 subprocess
davem     6646  4.3  0.0  156   76   p4 R    05:29   0:03 ./crashme +2000.80 999 100 334 2 subprocess
davem     6661  5.0  0.1  348  268   p4 R    05:29   0:02 ./crashme +2000 1006 100 341 2 subprocess
davem     6679 18.8  0.1  332  256   p4 R    05:30   0:01 ./crashme +2000 1015 100 350 2 subprocess
davem     6684  0.0  0.1  604  200   p4 S    05:30   0:00 grep crashme
? uname -a
Linux huahaga 1.3.83 #5 Sat Apr 6 21:46:09 EST 1996 sparc
? cat /proc/meminfo 
Mem:  179937280 175955968  3981312 11505664 66658304 93188096
Swap: 67088384    16384 67072000
MemTotal:    175720 kB
MemFree:       3888 kB
MemShared:    11236 kB
Buffers:      65096 kB
Cached:       91004 kB
SwapTotal:    65516 kB
SwapFree:     65500 kB
cpuinfo
? cat /proc/cpuinfo
cpu             : ROSS HyperSparc RT625
fpu             : ROSS HyperSparc combined IU/FPU
promlib         : Version 3 Revision 2
type            : sun4m
Elf Support     : yes
BogoMips        : 115.91
MMU type        : ROSS HyperSparc
invall          : 197856
invmm           : 17135
invrnge         : 338517
invpg           : 12818739
contexts        : 4096
big_chunks      : 0
little_chunks   : 0
? uptime
  5:34am  up  1:54,  3 users,  load average: 30.60, 27.64, 19.27
?

I didn't think so... but I get a few of these every once in a while:

<4>WARNING: FPU exception from kernel mode. at pc=f00116cc
<4>              \|/ ____ \|/
<4>              "@'/ ,. \`@"
<4>              /_| \__/ |_\
<4>                 \__U_/
<4>crashme(6723): Too many Penguin-FPU traps from kernel mode
<4>PSR: 1e8010c2 PC: f00116d0 NPC: f00116d4 Y: 9e63031f
<4>%g0: f0bc8000 %g1: ffffffef %g2: 00000020 %g3: 000221c4
<4>%g4: f0bc8000 %g5: 00000000 %g6: 00000000 %g7: 00001100
<4>%o0: f0c0f460 %o1: f0c0f560 %o2: f0c0f568 %o3: f0c0f564
<4>%o4: f00fec00 %o5: 0000000f %sp: f0daff08 %ret_pc: f0012a90
<4>Instruction DUMP:

It doesn't stop the machine, it's just annoying.  But I'll fix that.

Later,
David S. Miller
davem@caip.rutgers.edu
