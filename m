Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2004 00:10:41 +0100 (BST)
Received: from bay2-f19.bay2.hotmail.com ([IPv6:::ffff:65.54.247.19]:52233
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225842AbUGLXKh>; Tue, 13 Jul 2004 00:10:37 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 12 Jul 2004 16:10:30 -0700
Received: from 209.243.128.191 by by2fd.bay2.hotmail.msn.com with HTTP;
	Mon, 12 Jul 2004 23:10:29 GMT
X-Originating-IP: [209.243.128.191]
X-Originating-Email: [theansweriz42@hotmail.com]
X-Sender: theansweriz42@hotmail.com
From: "S C" <theansweriz42@hotmail.com>
To: KevinK@mips.com, ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
Date: Mon, 12 Jul 2004 23:10:29 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F193cew8k69RKL00052644@hotmail.com>
X-OriginalArrivalTime: 12 Jul 2004 23:10:30.0227 (UTC) FILETIME=[6CF61A30:01C46865]
Return-Path: <theansweriz42@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: theansweriz42@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi Kevin and Ralf,

Thanks for your inputs and suggestions! In the case of the Tx49 family, the 
primary I and D cache lines are both the same size (8 words), so the problem 
you mention below will not arise.

  I didn't think about the meaning of cpu_has_ic_fills_f_dc before writing 
my previous mail, and I see now that my intuition (and your explanation 
helps) was correct.

  For the moment, the problem is fixed. But I'm going to try and get to the 
bottom of this when I have the time.

  Thanks,
-Steve.


>From: "Kevin D. Kissell" <KevinK@mips.com>
>To: "Kevin D. Kissell" <KevinK@mips.com>, "S C" 
><theansweriz42@hotmail.com>,        "Ralf Baechle" <ralf@linux-mips.org>
>CC: <linux-mips@linux-mips.org>
>Subject: Re: Strange, strange occurence
>Date: Tue, 13 Jul 2004 00:25:37 +0200
>
> > Your intuition is correct, and the code in r4k_tlb_init() does look 
>scary.
> > But at least in the linux-mips CVS tree, flush_icache_range() tests to 
>see
> > if "cpu_has_ic_fills_f_dc" (CPU has Icache fills from Dcache, I presume)
> > is set, and if it isn't, it pushes the specified range out of the Dcache 
>before
> > flushing the Icache.  I would speculate that either your c-r4k.c is out 
>of
> > sync with yout tlb-r4k.c, or you erroneously have cpu_has_ic_fills_f_dc
> > set.
>
>Hmm.  On closer examination, there *is* a bug in the current 
>r4k_flush_icache_range(),
>in that it computes its cache flush loop for the I-cache based on the 
>D-cache line size.
>Those line sizes are *usually* the same.  By any chance are they different 
>for the
>TX49 family?  If the icache line is longer than the dcache line, there 
>should be no
>functional problem, just some wasted cycles.  But if the dcache line were, 
>say,
>twice the length of the Icache line, only half of the icache lines would be 
>invalidated...
>
>             Regards,
>
>             Kevin K.
>

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar – get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/
