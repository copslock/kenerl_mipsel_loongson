Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jul 2004 22:23:46 +0100 (BST)
Received: from bay2-f27.bay2.hotmail.com ([IPv6:::ffff:65.54.247.27]:12046
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225763AbUGLVXl>; Mon, 12 Jul 2004 22:23:41 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 12 Jul 2004 14:23:20 -0700
Received: from 209.243.128.191 by by2fd.bay2.hotmail.msn.com with HTTP;
	Mon, 12 Jul 2004 21:23:20 GMT
X-Originating-IP: [209.243.128.191]
X-Originating-Email: [theansweriz42@hotmail.com]
X-Sender: theansweriz42@hotmail.com
From: "S C" <theansweriz42@hotmail.com>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
Date: Mon, 12 Jul 2004 21:23:20 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F27mxl2RtYP35u0000d191@hotmail.com>
X-OriginalArrivalTime: 12 Jul 2004 21:23:20.0394 (UTC) FILETIME=[747B72A0:01C46856]
Return-Path: <theansweriz42@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: theansweriz42@hotmail.com
Precedence: bulk
X-list: linux-mips

And thinking about it a little more, I might as well clarfy my understanding 
while we're on the topic.

Here's a code snippet from r4k_tlb_init() in arch/mips/mm/c-r4k.c

memcpy((void *)KSEG0, &except_vec0_r4000, 0x80);
flush_icache_range(KSEG0, KSEG0 + 0x80);

So my understanding is that the TLB exception handler is being copied to the 
right memory location, and just in case some other TLB exception handler 
(YAMON's presumably) is residing in I-cache, to flush ( hit invalidate) it. 
Is this correct?

Shouldn't there be code to writeback_invalidate the exception handler from 
the data cache ? Presumably the memcpy causes the TLB handler to lodge 
itself in the D cache till it is moved to RAM (either explicitly or when 
some other lines replace the cache lines where the handler is), right?

Thanks in advance for helping me understand the issue here.

Regards,
-Steve.





>From: Ralf Baechle <ralf@linux-mips.org>
>To: S C <theansweriz42@hotmail.com>
>CC: linux-mips@linux-mips.org
>Subject: Re: Strange, strange occurence
>Date: Sat, 10 Jul 2004 12:04:12 +0200
>
>On Fri, Jul 09, 2004 at 06:50:00PM +0000, S C wrote:
>
> > Using MontaVista Linux 3.1 on a Toshiba RBTx4938 board. Using YAMON, 
>when I
> > download the kernel via the debug ethernet port it runs fine. If I 
>download
> > the kernel via the Tx4938 inbuilt ethernet controller, it crashes!
>
>If you're using a Montavista kernel you should report to Montavista.  We
>don't have the source so any comment here is speculation.
>
> > The crash is occuring inside the function r4k_flush_icache_range().
> >
> > I tried 'flush -i' and 'flush -d' on YAMON after the download but before
> > the 'go', but that didn't help. I also tried completely disabling caches
> > and loading/running uncached, but it gave the same error.
> >
> > Now, the final twist! Using an ICE, I set a breakpoint at the
> > r4k_flush_icache_range function. Then I loaded the kernel as usual, ran 
>it
> > with the ICE, stepped through a few instructions inside the
> > r4k_flush_icache_range function and then did a 'cont'. The kernel now
> > booted fine!
>
>As already pointed out by the other poster Niels Sterrenburg using a
>debugger unavoidably changes the state of the system to be debugged.
>
>For at least some of the TX49xx processors there is a problem under certain
>circumstances if a flush of an I-cache line flushes that cache instruction
>itself.  Make sure you're not getting hit by that one.
>
>   Ralf

_________________________________________________________________
Check out the latest news, polls and tools in the MSN 2004 Election Guide! 
http://special.msn.com/msn/election2004.armx
