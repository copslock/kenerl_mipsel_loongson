Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id DAA16828; Mon, 18 Mar 1996 03:14:39 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id DAA21641; Mon, 18 Mar 1996 03:14:35 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id DAA21632; Mon, 18 Mar 1996 03:14:34 -0800
Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <lmlinux@neteng.engr.sgi.com> id DAA16823; Mon, 18 Mar 1996 03:14:33 -0800
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id DAA21622; Mon, 18 Mar 1996 03:14:32 -0800
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id DAA11636; Mon, 18 Mar 1996 03:14:31 -0800
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id GAA10267; Mon, 18 Mar 1996 06:14:30 -0500
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id GAA03222; Mon, 18 Mar 1996 06:14:29 -0500
Date: Mon, 18 Mar 1996 06:14:29 -0500
Message-Id: <199603181114.GAA03222@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: torvalds@cs.helsinki.fi
CC: lmlinux@neteng.engr.sgi.com
Subject: 1.3.75 is a little better...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


0.2MB improvement in TCP bandwidth...


                    L M B E N C H  1 . 0   S U M M A R Y
                    ------------------------------------

            Processor, Processes - times in microseconds
            --------------------------------------------
Host                 OS  Mhz    Null    Null  Simple /bin/sh Mmap 2-proc 8-proc
                             Syscall Process Process Process  lat  ctxsw  ctxsw
--------- ------------- ---- ------- ------- ------- ------- ---- ------ ------
trombetas  Linux 1.3.74   50      15    9.2K   40.2K     54K  342     89     99
trombetas  Linux 1.3.75   50      13    8.6K   34.0K     57K  338     81    105
negro.rut SunOS 4.1.3_U   49     124   18.3K   63.9K    110K  470    152    262
geneva.ru     SunOS 5.5   50      31   33.7K  148.2K    274K  596    174    205

            *Local* Communication latencies in microseconds
            -----------------------------------------------
Host                 OS  Pipe       UDP    RPC/     TCP    RPC/
                                            UDP             TCP
--------- ------------- ------- ------- ------- ------- -------
trombetas  Linux 1.3.74     285    1026    1754    1384    2582
trombetas  Linux 1.3.75     295    1040    1798    1380    2606
negro.rut SunOS 4.1.3_U     890    1375    2287    1573    2804
geneva.ru     SunOS 5.5     530    1563    2080    1354    2398

            *Local* Communication bandwidths in megabytes/second
            ----------------------------------------------------
Host                 OS Pipe  TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                                  reread reread (libc) (hand) read write
--------- ------------- ---- ---- ------ ------ ------ ------ ---- -----
trombetas  Linux 1.3.74    8  3.8   23.5   21.1     18     24   41    36
trombetas  Linux 1.3.75    8  4.0   25.0   20.0     18     25   41    36
negro.rut SunOS 4.1.3_U    4  2.0   19.5    8.2     18     24   41    36
geneva.ru     SunOS 5.5    8  7.0   12.6   19.5     18     18   40    36

	    Memory latencies in nanoseconds
            (WARNING - may not be correct, check graphs)
            --------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    TLB    Guesses
--------- -------------   ---  ----   ----    --------    ---    -------
trombetas  Linux 1.3.74    50    20    170         180     -1    No L2 cache?
trombetas  Linux 1.3.75    50    20    170         180    659    No L2 cache?
negro.rut SunOS 4.1.3_U    49    20    175         183     -1    No L2 cache?
geneva.ru     SunOS 5.5    49     -      -           -      -    Bad mhz?
