Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jul 2004 21:54:56 +0100 (BST)
Received: from bay2-f6.bay2.hotmail.com ([IPv6:::ffff:65.54.247.6]:15109 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225758AbUGLUyv>;
	Mon, 12 Jul 2004 21:54:51 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 12 Jul 2004 13:49:10 -0700
Received: from 209.243.128.191 by by2fd.bay2.hotmail.msn.com with HTTP;
	Mon, 12 Jul 2004 20:49:10 GMT
X-Originating-IP: [209.243.128.191]
X-Originating-Email: [theansweriz42@hotmail.com]
X-Sender: theansweriz42@hotmail.com
From: "S C" <theansweriz42@hotmail.com>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
Date: Mon, 12 Jul 2004 20:49:10 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F6yXBrjeiy9aLi0000d891@hotmail.com>
X-OriginalArrivalTime: 12 Jul 2004 20:49:10.0816 (UTC) FILETIME=[AED6AA00:01C46851]
Return-Path: <theansweriz42@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: theansweriz42@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi Niels, Ralf, Kevin

Thanks for responding to my query! For the moment, I have fixed the 
symptoms, but still don't know what the problem is (it could be what you 
guys suspect it to be). The r4k_flush_icache_range() was being called from 
inside r4k_tlb_init() and the range being specified was KSEG0 to KSEG0 + 
0x80, i.e. the TLB handler. I commented out the call to 
r4k_flush_icache_range and now the kernel seems to boot normally! But I 
suspect I have not fixed a problem, merely sidestepped it.

So now maybe I should repeat the question Niels asked: why was that call 
necessary?

Thanks again,
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
FREE pop-up blocking with the new MSN Toolbar – get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/
