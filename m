Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id CAA18142; Thu, 14 Mar 1996 02:23:49 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id CAA16030; Thu, 14 Mar 1996 02:23:45 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id CAA16025; Thu, 14 Mar 1996 02:23:43 -0800
Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <lmlinux@neteng.engr.sgi.com> id CAA18137; Thu, 14 Mar 1996 02:23:43 -0800
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id CAA16020; Thu, 14 Mar 1996 02:23:42 -0800
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id CAA03175; Thu, 14 Mar 1996 02:23:41 -0800
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id FAA11619; Thu, 14 Mar 1996 05:21:17 -0500
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id FAA08455; Thu, 14 Mar 1996 05:21:16 -0500
Date: Thu, 14 Mar 1996 05:21:16 -0500
Message-Id: <199603141021.FAA08455@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: torvalds@cs.helsinki.fi
CC: lmlinux@neteng.engr.sgi.com
Subject: Oh baby...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


We now officially slaughter SunOS ;-)  Now on to Solaris, that piece
of trash...

                    L M B E N C H  1 . 0   S U M M A R Y
                    ------------------------------------

            Processor, Processes - times in microseconds
            --------------------------------------------
Host                 OS  Mhz    Null    Null  Simple /bin/sh Mmap 2-proc 8-proc
                             Syscall Process Process Process  lat  ctxsw  ctxsw
--------- ------------- ---- ------- ------- ------- ------- ---- ------ ------
trombetas  Linux 1.3.71   49      13   16.2K   49.6K     78K  324     86     97
trombetas  Linux 1.3.71   50      13   16.8K   51.1K     80K  456     89     98
trombetas  Linux 1.3.73   50      15   16.7K   50.6K     79K  332     87    101
negro.rut SunOS 4.1.3_U   49     124   18.3K   63.9K    110K  470    152    262

            *Local* Communication latencies in microseconds
            -----------------------------------------------
Host                 OS  Pipe       UDP    RPC/     TCP    RPC/
                                            UDP             TCP
--------- ------------- ------- ------- ------- ------- -------
trombetas  Linux 1.3.71     300    1034    1780    1576    2834
trombetas  Linux 1.3.71     285    1042    1800    1592    2788
trombetas  Linux 1.3.73     295    1042    1802    1378    2632
negro.rut SunOS 4.1.3_U     890    1375    2287    1573    2804

            *Local* Communication bandwidths in megabytes/second
            ----------------------------------------------------
Host                 OS Pipe  TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                                  reread reread (libc) (hand) read write
--------- ------------- ---- ---- ------ ------ ------ ------ ---- -----
trombetas  Linux 1.3.71    8  3.2   23.5   20.0     18     25   41    36
trombetas  Linux 1.3.71    8  3.5   22.2   18.2     18     24   41    36
trombetas  Linux 1.3.73    8  3.9   23.5   20.0     18     25   41    36
negro.rut SunOS 4.1.3_U    4  2.0   19.5    8.2     18     24   41    36

	    Memory latencies in nanoseconds
            (WARNING - may not be correct, check graphs)
            --------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    TLB    Guesses
--------- -------------   ---  ----   ----    --------    ---    -------
trombetas  Linux 1.3.71    49    20    170         180     -1    No L2 cache?
trombetas  Linux 1.3.71    50    20    170         180     -1    No L2 cache?
trombetas  Linux 1.3.73    50    19    169         179    659    No L2 cache?
negro.rut SunOS 4.1.3_U    49    20    175         183     -1    No L2 cache?
