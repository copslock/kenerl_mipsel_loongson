Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id SAA09229; Sat, 9 Mar 1996 18:04:14 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id SAA19431; Sat, 9 Mar 1996 18:04:10 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id SAA19426; Sat, 9 Mar 1996 18:04:09 -0800
Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <lmlinux@neteng.engr.sgi.com> id SAA09224; Sat, 9 Mar 1996 18:04:07 -0800
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id SAA19417; Sat, 9 Mar 1996 18:04:06 -0800
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id SAA22326; Sat, 9 Mar 1996 18:04:04 -0800
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id VAA01784; Sat, 9 Mar 1996 21:03:48 -0500
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id VAA19761; Sat, 9 Mar 1996 21:03:48 -0500
Date: Sat, 9 Mar 1996 21:03:48 -0500
Message-Id: <199603100203.VAA19761@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: lmlinux@neteng.engr.sgi.com
CC: torvalds@cs.helsinki.fi, adrian@remus.rutgers.edu
Subject: Linux 1.3.71 lmbench on Sparc
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Oh baby... we almost have the TCP latencies in our favor against
SunOS, all other categories rip SunOS to shreds on the MicroSparcI.  I
plan on having results on the SS5 against Solaris-2.5 (adrian, I can
release 2.5 benchmarks as long as it isn't 2.5.1beta right?) soon.


                    L M B E N C H  1 . 0   S U M M A R Y
                    ------------------------------------

            Processor, Processes - times in microseconds
            --------------------------------------------
Host                 OS  Mhz    Null    Null  Simple /bin/sh Mmap 2-proc 8-proc
                             Syscall Process Process Process  lat  ctxsw  ctxsw
--------- ------------- ---- ------- ------- ------- ------- ---- ------ ------
trombetas  Linux 1.3.71   49      13   16.2K   49.6K     78K  324     86     97
negro.rut SunOS 4.1.3_U   49     124   18.3K   63.9K    110K  470    152    262

            *Local* Communication latencies in microseconds
            -----------------------------------------------
Host                 OS  Pipe       UDP    RPC/     TCP    RPC/
                                            UDP             TCP
--------- ------------- ------- ------- ------- ------- -------
trombetas  Linux 1.3.71     300    1034    1780    1576    2834
negro.rut SunOS 4.1.3_U     890    1375    2287    1573    2804

            *Local* Communication bandwidths in megabytes/second
            ----------------------------------------------------
Host                 OS Pipe  TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                                  reread reread (libc) (hand) read write
--------- ------------- ---- ---- ------ ------ ------ ------ ---- -----
trombetas  Linux 1.3.71    8  3.2   23.5   20.0     18     25   41    36
negro.rut SunOS 4.1.3_U    4  2.0   19.5    8.2     18     24   41    36

	    Memory latencies in nanoseconds
            (WARNING - may not be correct, check graphs)
            --------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    TLB    Guesses
--------- -------------   ---  ----   ----    --------    ---    -------
trombetas  Linux 1.3.71    49    20    170         180    659    No L2 cache?
negro.rut SunOS 4.1.3_U    49    20    175         183     -1    No L2 cache?
