Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jul 2004 11:05:21 +0100 (BST)
Received: from p508B77FA.dip.t-dialin.net ([IPv6:::ffff:80.139.119.250]:17460
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225330AbUGJKFR>; Sat, 10 Jul 2004 11:05:17 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6AA4D5H023994;
	Sat, 10 Jul 2004 12:04:13 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6AA4CaF023993;
	Sat, 10 Jul 2004 12:04:12 +0200
Date: Sat, 10 Jul 2004 12:04:12 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: S C <theansweriz42@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
Message-ID: <20040710100412.GA23624@linux-mips.org>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 09, 2004 at 06:50:00PM +0000, S C wrote:

> Using MontaVista Linux 3.1 on a Toshiba RBTx4938 board. Using YAMON, when I 
> download the kernel via the debug ethernet port it runs fine. If I download 
> the kernel via the Tx4938 inbuilt ethernet controller, it crashes!

If you're using a Montavista kernel you should report to Montavista.  We
don't have the source so any comment here is speculation.

> The crash is occuring inside the function r4k_flush_icache_range().
> 
> I tried 'flush -i' and 'flush -d' on YAMON after the download but before 
> the 'go', but that didn't help. I also tried completely disabling caches 
> and loading/running uncached, but it gave the same error.
> 
> Now, the final twist! Using an ICE, I set a breakpoint at the 
> r4k_flush_icache_range function. Then I loaded the kernel as usual, ran it 
> with the ICE, stepped through a few instructions inside the 
> r4k_flush_icache_range function and then did a 'cont'. The kernel now 
> booted fine!

As already pointed out by the other poster Niels Sterrenburg using a
debugger unavoidably changes the state of the system to be debugged.

For at least some of the TX49xx processors there is a problem under certain
circumstances if a flush of an I-cache line flushes that cache instruction
itself.  Make sure you're not getting hit by that one.

  Ralf
