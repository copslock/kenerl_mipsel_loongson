Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 10:41:14 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.187]:56257
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226433AbVGLJk7>; Tue, 12 Jul 2005 10:40:59 +0100
Received: from p54A2AB5C.dip0.t-ipconnect.de [84.162.171.92] (helo=[192.168.178.44])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML25U-1DsHH0140Y-0005o4; Tue, 12 Jul 2005 11:41:54 +0200
Message-ID: <42D39096.7010500@cantastic.de>
Date:	Tue, 12 Jul 2005 11:42:46 +0200
From:	=?ISO-8859-15?Q?Ralf_R=F6sch?= <linux@cantastic.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To:	Alex Gonzalez <linux-mips@packetvision.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Benchmarking RM9000
References: <20050708091711Z8226352-3678+1954@linux-mips.org>	 <20050708120238.GA2816@linux-mips.org>	 <1120825549.28569.949.camel@euskadi.packetvision>	 <20050708130131.GC2816@linux-mips.org>	 <1120833749.28569.965.camel@euskadi.packetvision>	 <20050710231419.GA28518@linux-mips.org> <1121096632.28569.1107.camel@euskadi.packetvision>
In-Reply-To: <1121096632.28569.1107.camel@euskadi.packetvision>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fe0074b40cafaf3a4e4a4699a3836908
Return-Path: <linux@cantastic.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@cantastic.de
Precedence: bulk
X-list: linux-mips


>As before, I'd appreciate some other results from modern systems to
>compare with.
>
>  
>
Alex, below you can find our LMBENCH 3.0-a4 test results. 
Our machine is a Toshiba TX4937 based system (in the hope "modern enough") running with 
333MHz CPU-Clock and 133 MHz SDRAM-Clock (64bit).
The bench was run on the Debian based mipsel-distribution.
I'm surprised about the big difference in test results compared to your RM9000 system.
I would expect that your system should be much faster and I think there must be
a blocking part (hardware, software)  in your system. 

Regards
  Ralf (Roesch)

                 L M B E N C H  3 . 0   S U M M A R Y

                 ------------------------------------

         (Alpha software, do not distribute)

Basic system parameters
------------------------------------------------------------------------------
Host                 OS Description              Mhz  tlb  cache  mem   scal
                                                     pages line   par   load
                                                           bytes  
--------- ------------- ----------------------- ---- ----- ----- ------ ----
debian-mi  Linux 2.6.12        mipsel-linux-gnu  326     4    32 1.0700    1

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
debian-mi  Linux 2.6.12  326 0.41 1.22 8.37 9.96 78.1 1.85 7.77 1437 8018 36.K

Basic integer operations - times in nanoseconds - smaller is better
-------------------------------------------------------------------
Host                 OS  intgr intgr  intgr  intgr  intgr  
                          bit   add    mul    div    mod   
--------- ------------- ------ ------ ------ ------ ------ 
debian-mi  Linux 2.6.12 3.0600 0.0500   18.3  122.4  124.8

Basic float operations - times in nanoseconds - smaller is better
-----------------------------------------------------------------
Host                 OS  float  float  float  float
                         add    mul    div    bogo
--------- ------------- ------ ------ ------ ------ 
debian-mi  Linux 2.6.12   15.6   15.1   64.9  126.7

Basic double operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS  double double double double
                         add    mul    div    bogo
--------- ------------- ------  ------ ------ ------ 
debian-mi  Linux 2.6.12   24.7   24.2  106.5  217.8

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
debian-mi  Linux 2.6.12 1.1100   29.8   28.4   71.2   18.6    70.2    24.5

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
debian-mi  Linux 2.6.12 1.110  16.4 35.3  73.8 205.7 146.8 313.1 560.

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
debian-mi  Linux 2.6.12  252.1  349.2  753.6  536.2   69.0K 1.830 5.18150  44.3

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
debian-mi  Linux 2.6.12 41.0 42.0 36.5   55.7  166.1   89.8   89.0 166. 153.4

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
------------------------------------------------------------------------------
Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    Guesses
--------- -------------   ---   ----   ----    --------    --------    -------
debian-mi  Linux 2.6.12   326 6.3470  125.0  127.1       302.4    No L2 cache?
