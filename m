Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id DAA27247; Sat, 16 Mar 1996 03:59:14 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id DAA17604; Sat, 16 Mar 1996 03:59:10 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id DAA17599; Sat, 16 Mar 1996 03:59:09 -0800
Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <lmlinux@neteng.engr.sgi.com> id DAA27241; Sat, 16 Mar 1996 03:59:08 -0800
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id DAA17593; Sat, 16 Mar 1996 03:59:07 -0800
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id DAA26770; Sat, 16 Mar 1996 03:59:06 -0800
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id GAA27166; Sat, 16 Mar 1996 06:59:05 -0500
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id GAA10448; Sat, 16 Mar 1996 06:59:04 -0500
Date: Sat, 16 Mar 1996 06:59:04 -0500
Message-Id: <199603161159.GAA10448@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: torvalds@cs.helsinki.fi
CC: lmlinux@neteng.engr.sgi.com, adrian@remus.rutgers.edu
Subject: you want numbers?  I got numbers...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


WHeee...


                    L M B E N C H  1 . 0   S U M M A R Y
                    ------------------------------------

            Processor, Processes - times in microseconds
            --------------------------------------------
Host                 OS  Mhz    Null    Null  Simple /bin/sh Mmap 2-proc 8-proc
                             Syscall Process Process Process  lat  ctxsw  ctxsw
--------- ------------- ---- ------- ------- ------- ------- ---- ------ ------
trombetas  Linux 1.3.74   50      13   11.4K   45.0K     64K  326     82     93
trombetas  Linux 1.3.74   50      13    8.7K   39.1K     53K  334     80     95
negro.rut SunOS 4.1.3_U   49     124   18.3K   63.9K    110K  470    152    262
madeira.r   SunOS 5.5.1   13      40   35.7K  155.1K    298K  600    176    212

            *Local* Communication latencies in microseconds
            -----------------------------------------------
Host                 OS  Pipe       UDP    RPC/     TCP    RPC/
                                            UDP             TCP
--------- ------------- ------- ------- ------- ------- -------
trombetas  Linux 1.3.74     295    1012    1774    1370    2614
trombetas  Linux 1.3.74     285    1004    1776    1406    2614
negro.rut SunOS 4.1.3_U     890    1375    2287    1573    2804
madeira.r   SunOS 5.5.1     557    1601    2065    1379    2508

            *Local* Communication bandwidths in megabytes/second
            ----------------------------------------------------
Host                 OS Pipe  TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                                  reread reread (libc) (hand) read write
--------- ------------- ---- ---- ------ ------ ------ ------ ---- -----
trombetas  Linux 1.3.74    8  3.9   23.5   21.1     18     25   41    36
trombetas  Linux 1.3.74    9  3.8   25.0   21.1     18     25   41    36
negro.rut SunOS 4.1.3_U    4  2.0   19.5    8.2     18     24   41    36
madeira.r   SunOS 5.5.1    8  6.9   13.9   19.5     18     18   40    36

	    Memory latencies in nanoseconds
            (WARNING - may not be correct, check graphs)
            --------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    TLB    Guesses
--------- -------------   ---  ----   ----    --------    ---    -------
trombetas  Linux 1.3.74    50    20    170         180     -1    No L2 cache?
trombetas  Linux 1.3.74    50    19    169         179    659    No L2 cache?
negro.rut SunOS 4.1.3_U    49    20    175         183     -1    No L2 cache?
madeira.r   SunOS 5.5.1    12     -      -           -      -    Bad mhz?
