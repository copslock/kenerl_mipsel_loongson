Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id KAA03923; Wed, 28 Feb 1996 10:16:37 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id KAA09495; Wed, 28 Feb 1996 10:16:34 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id KAA09486; Wed, 28 Feb 1996 10:16:32 -0800
Received: from localhost by neteng.engr.sgi.com via SMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id KAA03916; Wed, 28 Feb 1996 10:16:30 -0800
Message-Id: <199602281816.KAA03916@neteng.engr.sgi.com>
To: linux@neteng.engr.sgi.com, greg@neteng.engr.sgi.com,
        jmb@neteng.engr.sgi.com, jmw@neteng.engr.sgi.com,
        nn@neteng.engr.sgi.com, aje@neteng.engr.sgi.com
Subject: a chuckle for you
Date: Wed, 28 Feb 1996 10:16:30 -0800
From: Larry McVoy <lm@neteng.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Linus has a 300Mhz Alpha running linux.  He's pissed at me because
I didn't ever anticipate any OS being able to do a null system call
(write a byte /dev/null) in a really short time.  I measure in usecs,
he needs nanoseconds.

Think about it: he has an entry into the system so fast that he needs to 
measure it in nanoseconds.

I included R10K, Ultrasparc, Alpha, and P6 numbers below Linus' note.

--lm

    But Larry: we really do need more than microsecond accuracy:

	    [torvalds@tiirakari linux]$ ./lat_syscall 
	    $Id: lat_syscall.c,v 1.2 1995/09/24 01:32:37 lm Exp $
	    Null syscall: 1 microseconds

    We're definitely approaching the limit..

		    Linus


                 L M B E N C H  1 . 1   S U M M A R Y
                 ------------------------------------

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz Null sig  sig  fork exec sh  
                             call inst hndl Proc Proc Proc
--------- ------------- ---- ---- ---- ---- ---- ---- ----
Alpha300   Linux 1.3.70  300   1    8    1  0.4K   1K   6K
P6-aurora  Linux 1.3.37  200   4    7    3  0.4K   5K  14K
ultraspar     SunOS 5.5  167   6   59    5  3.7K  20K  37K
R10K      IRIX64 6.2-no  200   4   15    9  1.8K   8K  13K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
Alpha300   Linux 1.3.70    2     14     97    26    150      35     151
P6-aurora  Linux 1.3.37    6     12     32    14    325      50     327
ultraspar     SunOS 5.5   14     51     30    90    185      96     204
R10K      IRIX64 6.2-no   21     24     25    32     48      72     223

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe   UDP  RPC/   TCP  RPC/ TCP
                        ctxsw               UDP         TCP conn
--------- ------------- ----- ----- ----- ----- ----- ----- ----
Alpha300   Linux 1.3.70     2    12    73   152    97   204    0
P6-aurora  Linux 1.3.37     6    26    93   180   216   346  263
ultraspar     SunOS 5.5    14    62   197   267   162   346  852
R10K      IRIX64 6.2-no    21    74   362   829   197   390  951

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
Alpha300   Linux 1.3.70     49      4     83     11       10    -1    0.0K
P6-aurora  Linux 1.3.37     75      4    213     35       36    -1    0.0K
ultraspar     SunOS 5.5   1818    833   2564   1851      212    -1    2.7K
R10K      IRIX64 6.2-no    374    389    353    387       55    -1   21.5K

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe  TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                                  reread reread (libc) (hand) read write
--------- ------------- ---- ---- ------ ------ ------ ------ ---- -----
Alpha300   Linux 1.3.70  131   38    108    114     65     66  129   110
P6-aurora  Linux 1.3.37   89   18     40     36     56     42  208    56
ultraspar     SunOS 5.5   61   51     85    101    167     85  129   152
R10K      IRIX64 6.2-no   85   53     75     92     44     59  101    84

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------   ---  ----   ----    --------    -------
Alpha300   Linux 1.3.70   300     0     48         360
P6-aurora  Linux 1.3.37   200    10     53         179
ultraspar     SunOS 5.5   166     6     42         270
R10K      IRIX64 6.2-no   200     5     55        1115
