Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Nov 2002 09:55:47 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:19646 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123966AbSKRIzq>;
	Mon, 18 Nov 2002 09:55:46 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gAI8tUNf002200;
	Mon, 18 Nov 2002 00:55:30 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA11678;
	Mon, 18 Nov 2002 00:55:34 -0800 (PST)
Message-ID: <007301c28ee0$cb2eb6d0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralph Metzler" <rjkm@metzlerbros.de>,
	"Bob Lund" <bob.lund@visi.com>
Cc: <linux-mips@linux-mips.org>
References: <01cd01c28e57$21f37ee0$0a00000a@blund> <15832.25401.226111.893020@gargle.gargle.HOWL>
Subject: Re: Linux on LSI SC2005
Date: Mon, 18 Nov 2002 09:58:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

From: "Ralph Metzler" <rjkm@metzlerbros.de>
> Hi, 
> 
> Bob Lund writes:
>  > I'm trying to figure out how much effort would be involved in getting Linux
>  > running on the MIPS core found in the LSI Logic SC2005. According to the LSI
>  > documentation:
>  > 
>  > MIPS R3000 CPU, executing MIPS I & II and 16 instructions
>  > BBCC with four write back buffers included
>  > Two 32-bit timers
>  > MMU 64-entry TLB RAM
>  > 1 to 32 Kbytes of direct mapped or 2 to 64 Kbytes of set associative I-cache
>  > 1 to 32 Kbytes of direct mapped D-cache
>  > 
>  > Any information is appreciated.
> 
> I did some work on an SC2000 about 18 months ago but only for one or two
> weeks. The kernel and networking on the eval board was basically
> working then but, AFAIR, there were problems (as in total lock up) with 
> enabled cache in user mode. Without cache it was veeeeery slow.

I don't have documentation on the SC2000, so I had hesitated
to respond to the question, but I can at least make the general
comment that LSI put a lot of different cache and MMU designs
around the basic R3000 execution pipe.  Some of those were
close enough to the original R3000 design to be easily supported
by Linux, others less so.  The MMU is the nastiest part of the problem,
so if you managed to get Linux running uncached, I am more
optimistic than I would otherwise be.  The LSI cores for which
I do have documantation use a non-standard mechanism
(an explicit cache control register in the System Coprocessor)
for cache management.  I would not be surprised if the SC2000
used much the same techniques, and if so, it would be necessary
to either hack up arch/mips/mm/c-r3k.c or (better software
engineering but more work) create arch/mips/mm/c-sc2k.c
with the SC2000 cache manipulation routines and add the
necessary configuration hooks to use it for your build.

            Kevin K.
