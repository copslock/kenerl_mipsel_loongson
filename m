Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id DAA157433 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Dec 1997 03:09:33 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA16985 for linux-list; Tue, 16 Dec 1997 03:08:54 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA16978 for <linux@engr.sgi.com>; Tue, 16 Dec 1997 03:08:52 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA20279
	for <linux@engr.sgi.com>; Tue, 16 Dec 1997 03:08:49 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id MAA23609
	for <linux@engr.sgi.com>; Tue, 16 Dec 1997 12:08:17 +0100 (MET)
Received: by zaphod (SMI-8.6/KO-2.0)
	id MAA01786; Tue, 16 Dec 1997 12:08:15 +0100
Message-ID: <19971216120814.45661@zaphod.uni-koblenz.de>
Date: Tue, 16 Dec 1997 12:08:14 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com
Subject: Benchmarks
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hia,

just for fun I ran lmbench on Linux and IRIX, here are the results.
Some of the results are obviously bogus ...

The machines:

 - Dull, a 200MHz Pentium MMX clone
 - Indy, a 180MHz R5000SC machine

  Ralf


                 L M B E N C H  1 . 9   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos       inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
dull.coba  Linux 2.0.27  200  1.1  1.8   29   44 0.08K  2.5    5 0.8K   5K  15K
indy.wald  Linux 2.1.72  180  6.8  6.3   38   61 0.12K  6.3   18 2.0K  22K  70K
indy           IRIX 6.2  180  2.9  10.0   88  110 2.44K  6.2   36 7.0K  19K  32K
                              ^^^
  Had this down to 1.8 for Linux 2.0.30, time to port the stuff to 2.1.


Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
dull.coba  Linux 2.0.27    5     52    171    64    244      75     325
indy.wald  Linux 2.1.72    4           251   155    655     155     655
indy           IRIX 6.2   13     20    135    94    301     143     482

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
dull.coba  Linux 2.0.27     5    19   36    89   212   139   289 1276
indy.wald  Linux 2.1.72     4    34   52   103   280   165   406  597
indy           IRIX 6.2    13    62  126   356   718   361   689 1321

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
dull.coba  Linux 2.0.27     59      4    106      9     7582     2    0.1K
indy.wald  Linux 2.1.72                                14285     1        
indy           IRIX 6.2    450    813   1694   2325     3317         23.0K

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
dull.coba  Linux 2.0.27   53   29   23     41    121     49     51  123    88
indy.wald  Linux 2.1.72   55   24    6     26     60      0      0    0     0
indy           IRIX 6.2   33   39   26     23     57     26     54   57    43

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------   ---  ----   ----    --------    -------
dull.coba  Linux 2.0.27   200    10     88         146
indy.wald  Linux 2.1.72   180    10    200         460
indy           IRIX 6.2   180    11    197         485
