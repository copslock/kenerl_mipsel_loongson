Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA123843 for <linux-archive@neteng.engr.sgi.com>; Sat, 21 Mar 1998 22:56:01 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id WAA2296813
	for linux-list;
	Sat, 21 Mar 1998 22:55:10 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA2300105
	for <linux@engr.sgi.com>;
	Sat, 21 Mar 1998 22:55:07 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id WAA16330
	for <linux@engr.sgi.com>; Sat, 21 Mar 1998 22:55:05 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-12.uni-koblenz.de [141.26.249.12])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id HAA22202
	for <linux@engr.sgi.com>; Sun, 22 Mar 1998 07:55:02 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id HAA04812;
	Sun, 22 Mar 1998 07:54:52 +0100
Message-ID: <19980322075452.09681@uni-koblenz.de>
Date: Sun, 22 Mar 1998 07:54:52 +0100
To: linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Cc: lm@who.net
Subject: Lmbench results for Linux/MIPS 2.1.90
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

here is another round of lmbench results.  Most notably all benchmarks
that depend on the overhead of syscall entry have improved remarkably.
For comparison I've included some more machines in the table.

The machines:

 indy:     Indy R5000SC 180MHz, 512mb l2 cache, 96mb memory.
 sv002076: Sun Ultra Enterprise E450, 2 x 296MHz Ultra2 CPUs,
           1gb memory (two interleaved).
 dull:     Dell Pentium 200 MMX, 32mb, running Redhat's 2.0.27.
 tbird:    SNI RM200, R4600 133MHz, no second level cache, 32mb memory.

I'm thinking about not saving the temporary registers on syscall entry;
I'm just not shure if this would break the semantics of ptrace(2).
Comments?

Btw, it's a shame for Sun than we can beat their numbers on so much
weaker hardware.

  Ralf

                 L M B E N C H  1 . 9   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos       inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
indy           IRIX 6.2  180  2.9  10.0   88  110 2.44K  6.2   36 7.0K  19K  32K
sv002076    SunOS 5.5.1  196  2.6  4.7   31   34 0.21K  5.6   48 2.2K  12K  23K
dull.coba  Linux 2.0.27  200  1.1  1.8   29   44 0.08K  2.5    5 0.8K   5K  15K
indy.wald  Linux 2.1.73  180  4.5  5.4   24   29 0.11K  7.3   19 18.3K  18K  65K
indy.wald  Linux 2.1.90  180  1.3  2.1   23   29 0.10K  3.6   10 1.7K  18K  60K
tbird.wal  Linux 2.1.56  133  6.4  9.2   42   56 0.19K 11.7   26 2.1K  26K  83K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
indy           IRIX 6.2   13     20    135    94    301     143     482
sv002076    SunOS 5.5.1   12     16     14    40     23      48      92
dull.coba  Linux 2.0.27    5     52    171    64    244      75     325
indy.wald  Linux 2.1.73    1     27    238          322             780
indy.wald  Linux 2.1.90    2     36    205    55    655      92     717
tbird.wal  Linux 2.1.56   14    176    506   177    516     178     513

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
indy           IRIX 6.2    13    62  126   356   718   361   689 1321
sv002076    SunOS 5.5.1    12    48   70   130         118        840
dull.coba  Linux 2.0.27     5    19   36    89   212   139   289 1276
indy.wald  Linux 2.1.73     1    48  103   105   258   165   412  597
indy.wald  Linux 2.1.90     2    15   31    91   251   170   409  581
tbird.wal  Linux 2.1.56    14    75  168   351   795   575  1120 1549

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
indy           IRIX 6.2    450    813   1694   2325     3317         23.0K
sv002076    SunOS 5.5.1   2083    826   2777   3030     4066    13    8.2K
dull.coba  Linux 2.0.27     59      4    106      9     7582     2    0.1K
indy.wald  Linux 2.1.73    112     28                  12222    16    0.3K
indy.wald  Linux 2.1.90                                11000     2    0.3K
tbird.wal  Linux 2.1.56    143     34                  15026     0    0.3K

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
indy           IRIX 6.2   33   39   26     23     57     26     54   57    43
sv002076    SunOS 5.5.1   99  134   95    146    156    296    139  157   208
dull.coba  Linux 2.0.27   53   29   23     41    121     49     51  123    88
indy.wald  Linux 2.1.73   57   18    7     28     60      0      0    0     0
indy.wald  Linux 2.1.90   65   26   15     27     60      0      0    0     0
tbird.wal  Linux 2.1.56   22   16    4     25     77     38     74   77    56

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------   ---  ----   ----    --------    -------
indy           IRIX 6.2   180    11    197         485
sv002076    SunOS 5.5.1   196     6     33         248
dull.coba  Linux 2.0.27   200    10     88         146
indy.wald  Linux 2.1.73   180    10    250         480
indy.wald  Linux 2.1.90   180    10    190         480
tbird.wal  Linux 2.1.56   133    15    274         281    No L2 cache?
