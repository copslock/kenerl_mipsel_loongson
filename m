Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id FAA02528; Sun, 17 Mar 1996 05:01:11 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id FAA12187; Sun, 17 Mar 1996 05:01:06 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id FAA12182; Sun, 17 Mar 1996 05:01:05 -0800
Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <lmlinux@neteng.engr.sgi.com> id FAA02522; Sun, 17 Mar 1996 05:01:04 -0800
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id FAA12177; Sun, 17 Mar 1996 05:01:03 -0800
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id FAA04168; Sun, 17 Mar 1996 05:00:59 -0800
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id IAA28359; Sun, 17 Mar 1996 08:00:55 -0500
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id IAA22870; Sun, 17 Mar 1996 08:00:54 -0500
Date: Sun, 17 Mar 1996 08:00:54 -0500
Message-Id: <199603171300.IAA22870@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: linux-kernel@vger.rutgers.edu
CC: sparclinux@vger.rutgers.edu, lmlinux@neteng.engr.sgi.com
Subject: whee...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


"No worries." -Andrew Tridgell

All on the same exact hardware folks.


                    L M B E N C H  1 . 0   S U M M A R Y
                    ------------------------------------

            Processor, Processes - times in microseconds
            --------------------------------------------
Host                 OS  Mhz    Null    Null  Simple /bin/sh Mmap 2-proc 8-proc
                             Syscall Process Process Process  lat  ctxsw  ctxsw
--------- ------------- ---- ------- ------- ------- ------- ---- ------ ------
trombetas  Linux 1.3.74   50      13    8.7K   39.1K     53K  334     80     95
negro.rut SunOS 4.1.3_U   49     124   18.3K   63.9K    110K  470    152    262
geneva.ru     SunOS 5.5   50      31   33.7K  148.2K    274K  596    174    205

            *Local* Communication latencies in microseconds
            -----------------------------------------------
Host                 OS  Pipe       UDP    RPC/     TCP    RPC/
                                            UDP             TCP
--------- ------------- ------- ------- ------- ------- -------
trombetas  Linux 1.3.74     285    1004    1776    1406    2614
negro.rut SunOS 4.1.3_U     890    1375    2287    1573    2804
geneva.ru     SunOS 5.5     530    1563    2080    1354    2398

            *Local* Communication bandwidths in megabytes/second
            ----------------------------------------------------
Host                 OS Pipe  TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                                  reread reread (libc) (hand) read write
--------- ------------- ---- ---- ------ ------ ------ ------ ---- -----
trombetas  Linux 1.3.74    9  3.8   25.0   21.1     18     25   41    36
negro.rut SunOS 4.1.3_U    4  2.0   19.5    8.2     18     24   41    36
geneva.ru     SunOS 5.5    8  7.0   12.6   19.5     18     18   40    36

	    Memory latencies in nanoseconds
            (WARNING - may not be correct, check graphs)
            --------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    TLB    Guesses
--------- -------------   ---  ----   ----    --------    ---    -------
trombetas  Linux 1.3.74    50    19    169         179    659    No L2 cache?
negro.rut SunOS 4.1.3_U    49    20    175         183     -1    No L2 cache?
geneva.ru     SunOS 5.5    49     -      -           -      -    Bad mhz?
