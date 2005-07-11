Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 16:42:33 +0100 (BST)
Received: from mra04.ex.eclipse.net.uk ([IPv6:::ffff:212.104.129.139]:11484
	"EHLO mra04.ex.eclipse.net.uk") by linux-mips.org with ESMTP
	id <S8226467AbVGKPmQ>; Mon, 11 Jul 2005 16:42:16 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mra04.ex.eclipse.net.uk (Postfix) with ESMTP id 9D9F9133E27
	for <linux-mips@linux-mips.org>; Mon, 11 Jul 2005 16:43:10 +0100 (BST)
Received: from mra04.ex.eclipse.net.uk ([127.0.0.1])
 by localhost (mra04.ex.eclipse.net.uk [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 08014-01-98 for <linux-mips@linux-mips.org>;
 Mon, 11 Jul 2005 16:43:08 +0100 (BST)
Received: from euskadi.packetvision (unknown [82.152.104.245])
	by mra04.ex.eclipse.net.uk (Postfix) with ESMTP id 1F8A8133E7E
	for <linux-mips@linux-mips.org>; Mon, 11 Jul 2005 16:41:58 +0100 (BST)
Subject: Re: Benchmarking RM9000
From:	Alex Gonzalez <linux-mips@packetvision.com>
To:	linux-mips@linux-mips.org
In-Reply-To: <20050710231419.GA28518@linux-mips.org>
References: <20050708091711Z8226352-3678+1954@linux-mips.org>
	 <20050708120238.GA2816@linux-mips.org>
	 <1120825549.28569.949.camel@euskadi.packetvision>
	 <20050708130131.GC2816@linux-mips.org>
	 <1120833749.28569.965.camel@euskadi.packetvision>
	 <20050710231419.GA28518@linux-mips.org>
Content-Type: text/plain
Message-Id: <1121096632.28569.1107.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Mon, 11 Jul 2005 16:43:52 +0100
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <linux-mips@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@packetvision.com
Precedence: bulk
X-list: linux-mips

Thanks for all the feedback.

I enclose new results from the lmbench testing.

Answering some suggestions,

I won't use gmplayer as a benchmarking tool. The platform has no
graphics adapter. We're developing a streaming video application in an
embedded platform (no hdd either).

I'll check that the driver is using the write-gather functionality to
move data from/to the ethernet adapter.

As before, I'd appreciate some other results from modern systems to
compare with.

Regards,
Alex

-------------------------------------------------


 
                 L M B E N C H  3 . 0   S U M M A R Y
                 ------------------------------------
                 (Alpha software, do not distribute)
 
Basic system parameters
------------------------------------------------------------------------------
Host                 OS Description              Mhz  tlb  cache  mem   scal
                                                     pages line   par   load
                                                           bytes
--------- ------------- ----------------------- ---- ----- ----- ------ ----
192.168.1 Linux 2.6.12-          mips-linux-gnu  985     4    32 1.4200    1
 
Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
192.168.1 Linux 2.6.12-  985 0.19 0.49 4.29 150. 25.4 0.65 3.76 828. 5032 16.K
 
Basic integer operations - times in nanoseconds - smaller is better
-------------------------------------------------------------------
Host                 OS  intgr intgr  intgr  intgr  intgr
                          bit   add    mul    div    mod
--------- ------------- ------ ------ ------ ------ ------
192.168.1 Linux 2.6.12- 1.0200 1.0200 4.1500   43.5   41.5
 
Basic float operations - times in nanoseconds - smaller is better
-----------------------------------------------------------------
Host                 OS  float  float  float  float
                         add    mul    div    bogo
--------- ------------- ------ ------ ------ ------
192.168.1 Linux 2.6.12- 6.0700 6.0700   22.3   41.7
 
Basic double operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS  double double double double
                         add    mul    div    bogo
--------- ------------- ------  ------ ------ ------
192.168.1 Linux 2.6.12- 6.0700 9.1100   37.4   62.0
 
Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
192.168.1 Linux 2.6.12- 0.8400 5.6600 8.2600   22.6  235.2    58.9   242.3
 
*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
192.168.1 Linux 2.6.12- 0.840 6.775 13.4              38.0       143.
                                                                                                                                                       
File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
192.168.1 Linux 2.6.12-                              4926.0 0.622 2.59860  16.6
                                                                                                                                                       
*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
192.168.1 Linux 2.6.12- 141. 292. 57.2  140.5  224.7   97.1   88.2 224. 155.4
                                                                                                                                                       
Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
------------------------------------------------------------------------------
Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    Guesses
--------- -------------   ---   ----   ----    --------    --------    -------
192.168.1 Linux 2.6.12-   985 3.0750   45.4  109.5       254.9



On Mon, 2005-07-11 at 00:14, Ralf Baechle wrote:
> On Fri, Jul 08, 2005 at 03:42:29PM +0100, Alex Gonzalez wrote:
> 
> > The performance of our video application is well below our expectations.
> > We are still doing some profiling work on it, but we are also looking at
> > other possibilities.
> > 
> > What other benchmarking tool would you recommend?
> > 
> > Currently it's a NFS mounted system, but even if we could use a block
> > device the access speed wouldn't be more than 1.5 Mbps, so that is a
> > limitation for the benchmark.
> 
> As a shot into the dark ...
> 
> Make sure you exploit the RM9000's write-gathering capabilities when
> writing into the frame buffer.  If the frame buffer happens to be on
> a PCI device you're probably performing uncached writes which will
> slow down the thing to a crawl.
> 
>   Ralf
