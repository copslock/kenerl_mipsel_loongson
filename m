Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA12432; Thu, 16 May 1996 00:05:53 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA22857 for linux-list; Thu, 16 May 1996 07:04:27 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA22842 for <linux@cthulhu.engr.sgi.com>; Thu, 16 May 1996 00:04:24 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA12382 for <lmlinux@neteng.engr.sgi.com>; Thu, 16 May 1996 00:04:23 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA22827; Thu, 16 May 1996 00:04:21 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id AAA15579; Thu, 16 May 1996 00:04:19 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id CAA22273; Thu, 16 May 1996 02:53:50 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id CAA12098; Thu, 16 May 1996 02:53:50 -0400
Date: Thu, 16 May 1996 02:53:50 -0400
Message-Id: <199605160653.CAA12098@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: lmlinux@neteng.engr.sgi.com
CC: torvalds@cs.helsinki.fi, sparclinux-cvs@caipfs.rutgers.edu, alan@cymru.net
Subject: lmbench with new checksum code...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


It's not as hot as I wanted it to be, ho hum... Just for flavor I've
included numbers for my 115MHZ hypersparc running SunOS so no none
forgets that this is all running on a shitty SparcClassic. ;-)

I'm probably stalling the chip stupidly in my code or not touching the
cache lines in the correct order, ugh this is pissing me off, I'll
check it out some more tomorrow when my head doesn't hurt so much...
I doubt I can get 2mb/s more out of my code to beat solaris, sigh,
where the heck could all this overhead possibly be???

                    L M B E N C H  1 . 0   S U M M A R Y
                    ------------------------------------

            Processor, Processes - times in microseconds
            --------------------------------------------
Host                 OS  Mhz    Null    Null  Simple /bin/sh Mmap 2-proc 8-proc
                             Syscall Process Process Process  lat  ctxsw  ctxsw
--------- ------------- ---- ------- ------- ------- ------- ---- ------ ------
trombetas  Linux 1.99.3   50      15    8.8K   40.9K     75K  350     83    100
geneva.ru     SunOS 5.5   50      31   33.7K  148.2K    274K  596    174    205
negro.rut SunOS 4.1.3_U   49     124   18.3K   63.9K    110K  470    152    262
huahaga.r   SunOS 4.1.4  115      32   10.4K   34.3K     59K  169     96    104

            *Local* Communication latencies in microseconds
            -----------------------------------------------
Host                 OS  Pipe       UDP    RPC/     TCP    RPC/
                                            UDP             TCP
--------- ------------- ------- ------- ------- ------- -------
trombetas  Linux 1.99.3     295    1016    1756    1408    2564
geneva.ru     SunOS 5.5     530    1563    2080    1354    2398
negro.rut SunOS 4.1.3_U     890    1375    2287    1573    2804
huahaga.r   SunOS 4.1.4     306     616     956     667    1161

            *Local* Communication bandwidths in megabytes/second
            ----------------------------------------------------
Host                 OS Pipe  TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                                  reread reread (libc) (hand) read write
--------- ------------- ---- ---- ------ ------ ------ ------ ---- -----
trombetas  Linux 1.99.3    8  4.8   25.0   17.4     18     24   41    36
geneva.ru     SunOS 5.5    8  7.0   12.6   19.5     18     18   40    36
negro.rut SunOS 4.1.3_U    4  2.0   19.5    8.2     18     24   41    36
huahaga.r   SunOS 4.1.4   14  5.3   30.2   19.9     20     22   48    37

            Memory latencies in nanoseconds
            (WARNING - may not be correct, check graphs)
            --------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    TLB    Guesses
--------- -------------   ---  ----   ----    --------    ---    -------
trombetas  Linux 1.99.3    50    20    170         180    600    No L2 cache?
geneva.ru     SunOS 5.5    49     -      -           -      -    Bad mhz?
negro.rut SunOS 4.1.3_U    49    20    175         183    659    No L2 cache?
huahaga.r   SunOS 4.1.4   115    17     17         510    842    No L1 cache?
