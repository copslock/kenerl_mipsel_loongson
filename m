Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA09680; Tue, 30 Apr 1996 18:31:32 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id SAA26901; Tue, 30 Apr 1996 18:31:28 -0700
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id SAA26890; Tue, 30 Apr 1996 18:31:26 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA09668 for <lmlinux@neteng.engr.sgi.com>; Tue, 30 Apr 1996 18:31:16 -0700
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id SAA26820; Tue, 30 Apr 1996 18:31:15 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id SAA16437; Tue, 30 Apr 1996 18:31:13 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id VAA01363 for <lmlinux@neteng.engr.sgi.com>; Tue, 30 Apr 1996 21:31:10 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id VAA05228; Tue, 30 Apr 1996 21:31:10 -0400
Date: Tue, 30 Apr 1996 21:31:10 -0400
Message-Id: <199605010131.VAA05228@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: lmlinux@neteng.engr.sgi.com
Subject: whee
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Syscalls are a bit faster, just started optimizing again

                    L M B E N C H  1 . 0   S U M M A R Y
                    ------------------------------------

            Processor, Processes - times in microseconds
            --------------------------------------------
Host                 OS  Mhz    Null    Null  Simple /bin/sh Mmap 2-proc 8-proc
                             Syscall Process Process Process  lat  ctxsw  ctxsw
--------- ------------- ---- ------- ------- ------- ------- ---- ------ ------
trombetas  Linux 1.3.90   50      17    9.3K   38.6K     58K  370     88    109
trombetas  Linux 1.3.97   50      14    8.9K   38.3K     56K  354     86    101
negro.rut SunOS 4.1.3_U   49     124   18.3K   63.9K    110K  470    152    262
geneva.ru     SunOS 5.5   50      31   33.7K  148.2K    274K  596    174    205

            *Local* Communication latencies in microseconds
            -----------------------------------------------
Host                 OS  Pipe       UDP    RPC/     TCP    RPC/
                                            UDP             TCP
--------- ------------- ------- ------- ------- ------- -------
trombetas  Linux 1.3.90     285    1028    1754    1368    2610
trombetas  Linux 1.3.97     300    1016    1752    1376    2598
negro.rut SunOS 4.1.3_U     890    1375    2287    1573    2804
geneva.ru     SunOS 5.5     530    1563    2080    1354    2398

            *Local* Communication bandwidths in megabytes/second
            ----------------------------------------------------
Host                 OS Pipe  TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                                  reread reread (libc) (hand) read write
--------- ------------- ---- ---- ------ ------ ------ ------ ---- -----
trombetas  Linux 1.3.90    8  4.0   23.5   17.4     18     25   42    37
trombetas  Linux 1.3.97    8  4.0   23.5   17.4     18     25   41    37
negro.rut SunOS 4.1.3_U    4  2.0   19.5    8.2     18     24   41    36
geneva.ru     SunOS 5.5    8  7.0   12.6   19.5     18     18   40    36

            Memory latencies in nanoseconds
            (WARNING - may not be correct, check graphs)
            --------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    TLB    Guesses
--------- -------------   ---  ----   ----    --------    ---    -------
trombetas  Linux 1.3.90    50    20    170         180     -1    No L2 cache?
trombetas  Linux 1.3.97    50    20    170         180    659    No L2 cache?
negro.rut SunOS 4.1.3_U    49    20    175         183     -1    No L2 cache?
geneva.ru     SunOS 5.5    49     -      -           -      -    Bad mhz?
