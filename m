Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA299258 for <linux-archive@neteng.engr.sgi.com>; Sat, 20 Dec 1997 13:47:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA19746 for linux-list; Sat, 20 Dec 1997 13:45:45 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA19741 for <linux@engr.sgi.com>; Sat, 20 Dec 1997 13:45:40 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA21995
	for <linux@engr.sgi.com>; Sat, 20 Dec 1997 13:45:37 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-10.uni-koblenz.de [141.26.249.10])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id WAA15512
	for <linux@engr.sgi.com>; Sat, 20 Dec 1997 22:45:08 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id WAA25569;
	Sat, 20 Dec 1997 22:40:37 +0100
Message-ID: <19971220224036.52320@uni-koblenz.de>
Date: Sat, 20 Dec 1997 22:40:36 +0100
To: linux@cthulhu.engr.sgi.com
Subject: Polishing the cache routines ...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hoho,

minor side effects of polishing the cache routines ...

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
indy           IRIX 6.2  180  2.9  10.0  88  110 2.44K  6.2   36 7.0K  19K  32K
indy.wald  Linux 2.1.72  180  6.8  6.3   38   61 0.12K  6.3   18 2.0K  22K  70K
indy.wald  Linux 2.1.73  180  4.5  6.3   26   34 0.10K  7.9   15 1.6K  18K  55K
                                                                       ^^^
                                                      IRIX lost that one ...

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
dull.coba  Linux 2.0.27    5     52    171    64    244      75     325
indy           IRIX 6.2   13     20    135    94    301     143     482
indy.wald  Linux 2.1.72    4    111    251   155    655     155     655
indy.wald  Linux 2.1.73    5           282    92    685     155     748

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
dull.coba  Linux 2.0.27     5    19   36    89   212   139   289 1276
indy           IRIX 6.2    13    62  126   356   718   361   689 1321
indy.wald  Linux 2.1.72     4    34   52   103   280   165   406  597
indy.wald  Linux 2.1.73     5    49   66   108   278   160   412  635

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
dull.coba  Linux 2.0.27     59      4    106      9     7582     2    0.1K
indy           IRIX 6.2    450    813   1694   2325     3317         23.0K
indy.wald  Linux 2.1.72     61      8    132     16    14285     1        
indy.wald  Linux 2.1.73     75     22    110     14    12222     3    0.3K

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
dull.coba  Linux 2.0.27   53   29   23     41    121     49     51  123    88
indy           IRIX 6.2   33   39   26     23     57     26     54   57    43
indy.wald  Linux 2.1.72   55   24    6     26     60     28     60   65    44
indy.wald  Linux 2.1.73   49   22    7     29     60      0      0    0     0

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------   ---  ----   ----    --------    -------
dull.coba  Linux 2.0.27   200    10     88         146
indy           IRIX 6.2   180    11    197         485
indy.wald  Linux 2.1.72   180    10    200         460
indy.wald  Linux 2.1.73   180    10    210         460
