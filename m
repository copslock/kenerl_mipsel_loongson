Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA2022530 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Mar 1998 21:16:05 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id VAA4382645
	for linux-list;
	Thu, 26 Mar 1998 21:15:32 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA4380169
	for <linux@engr.sgi.com>;
	Thu, 26 Mar 1998 21:15:29 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id VAA02269
	for <linux@engr.sgi.com>; Thu, 26 Mar 1998 21:15:27 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-04.uni-koblenz.de [141.26.249.4])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id GAA10347
	for <linux@engr.sgi.com>; Fri, 27 Mar 1998 06:15:23 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id GAA04320;
	Fri, 27 Mar 1998 06:15:13 +0100
Message-ID: <19980327061512.43491@uni-koblenz.de>
Date: Fri, 27 Mar 1998 06:15:12 +0100
To: linux@cthulhu.engr.sgi.com
Subject: Banzai ...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ok, somebody sent me congratulations when I presented 1.3us per syscall.
Thought that was provoking :-)  So now we're at 861ns.  The tricks was
essentially to take out the syscall processing from the general exception
processing such that we don't need to save / restore the temp / hi / lo
registers.


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
E450        SunOS 5.5.1  296  2.6  4.7   31   34 0.21K  5.6   48 2.2K  12K  23K
indy.wald  Linux 2.1.90  180  1.3  2.1   23   29 0.10K  3.6   10 1.7K  18K  60K
indy.wald  Linux 2.1.90  180  0.9  1.7   23   26 0.10K  3.2   12 1.8K  18K  60K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
dull.coba  Linux 2.0.27    5     52    171    64    244      75     325
indy           IRIX 6.2   13     20    135    94    301     143     482
E450        SunOS 5.5.1   12     16     14    40     23      48      92
indy.wald  Linux 2.1.90    2     36    205    55    655      92     717
indy.wald  Linux 2.1.90    3     36    214   155    414     155     789

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
dull.coba  Linux 2.0.27     5    19   36    89   212   139   289 1276
indy           IRIX 6.2    13    62  126   356   718   361   689 1321
E450        SunOS 5.5.1    12    48   70   130         118        840
indy.wald  Linux 2.1.90     2    15   31    91   251   170   409  581
indy.wald  Linux 2.1.90     3    13   31    78   234   165   393  597

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
dull.coba  Linux 2.0.27     59      4    106      9     7582     2    0.1K
indy           IRIX 6.2    450    813   1694   2325     3317         23.0K
E450        SunOS 5.5.1   2083    826   2777   3030     4066    13    8.2K
indy.wald  Linux 2.1.90                                11000     2    0.3K
indy.wald  Linux 2.1.90     58      6    107     12    12000     0    0.3K

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
dull.coba  Linux 2.0.27   53   29   23     41    121     49     51  123    88
indy           IRIX 6.2   33   39   26     23     57     26     54   57    43
E450        SunOS 5.5.1   99  134   95    146    156    296    139  157   208
indy.wald  Linux 2.1.90   65   26   15     27     60      0      0    0     0
indy.wald  Linux 2.1.90   55   24   13     27     60     26     56   60    42

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------   ---  ----   ----    --------    -------
dull.coba  Linux 2.0.27   200    10     88         146
indy           IRIX 6.2   180    11    197         485
E450        SunOS 5.5.1   296     6     33         248
indy.wald  Linux 2.1.90   180    10    190         480
indy.wald  Linux 2.1.90   180    10    190         480

  Ralf
