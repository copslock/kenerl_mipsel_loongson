Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jul 2004 22:51:11 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:2261
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225763AbUGLVvH>; Mon, 12 Jul 2004 22:51:07 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id i6CLowPb028303;
	Mon, 12 Jul 2004 14:50:58 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i6CLovAL003625;
	Mon, 12 Jul 2004 14:50:58 -0700 (PDT)
Message-ID: <020201c46859$fa6b98b0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <KevinK@mips.com>
To: "S C" <theansweriz42@hotmail.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
References: <BAY2-F27mxl2RtYP35u0000d191@hotmail.com>
Subject: Re: Strange, strange occurence
Date: Mon, 12 Jul 2004 23:48:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
X-Scanned-By: MIMEDefang 2.39
Return-Path: <KevinK@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KevinK@mips.com
Precedence: bulk
X-list: linux-mips

> And thinking about it a little more, I might as well clarfy my understanding 
> while we're on the topic.
> 
> Here's a code snippet from r4k_tlb_init() in arch/mips/mm/c-r4k.c
> 
> memcpy((void *)KSEG0, &except_vec0_r4000, 0x80);
> flush_icache_range(KSEG0, KSEG0 + 0x80);
> 
> So my understanding is that the TLB exception handler is being copied to the 
> right memory location, and just in case some other TLB exception handler 
> (YAMON's presumably) is residing in I-cache, to flush ( hit invalidate) it. 
> Is this correct?
> 
> Shouldn't there be code to writeback_invalidate the exception handler from 
> the data cache ? Presumably the memcpy causes the TLB handler to lodge 
> itself in the D cache till it is moved to RAM (either explicitly or when 
> some other lines replace the cache lines where the handler is), right?
> 
> Thanks in advance for helping me understand the issue here.

Your intuition is correct, and the code in r4k_tlb_init() does look scary.
But at least in the linux-mips CVS tree, flush_icache_range() tests to see
if "cpu_has_ic_fills_f_dc" (CPU has Icache fills from Dcache, I presume)
is set, and if it isn't, it pushes the specified range out of the Dcache before
flushing the Icache.  I would speculate that either your c-r4k.c is out of
sync with yout tlb-r4k.c, or you erroneously have cpu_has_ic_fills_f_dc
set.

            Regards,

            Kevin K.
