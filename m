Received:  by oss.sgi.com id <S305290AbQEBL3A>;
	Tue, 2 May 2000 04:29:00 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:14098 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305164AbQEBL2k>;
	Tue, 2 May 2000 04:28:40 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA03043; Tue, 2 May 2000 04:23:53 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA15799
	for linux-list;
	Tue, 2 May 2000 04:16:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA97822
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 May 2000 04:16:54 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA03195
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 May 2000 04:16:53 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA06302;
	Tue, 2 May 2000 04:16:50 -0700 (PDT)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA22937;
	Tue, 2 May 2000 04:16:47 -0700 (PDT)
Message-ID: <00b401bfb428$34aae610$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     <fisher@sgi.com>
Cc:     <linux-mips@vger.rutgers.edu>,
        "Linux/MIPS fnet" <linux-mips@fnet.fr>,
        <linux@cthulhu.engr.sgi.com>
Subject: Re: VC exceptions
Date:   Tue, 2 May 2000 13:18:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>> The R8000 was some kind of CPU hack which SGI came up with when the
>> R4400 performance was begining to look bad in comparison to the Alphas
>> and the R10000 project still would have taken quite some time.  It was
featuring
>> roughly the integer performance and twice or trice the fp performance of
>> a 250MHz R4400 while running at just 75 - 90 MHz.  It was used only by
>> SGI.

Please forgive me if I put on my MIPS historian hat for a moment...

The R8000 a.k.a. "TFP" started as a project at SGI before SGI bought
MIPS Computer, and before the R4400 was ever shipped, if I recall
correctly.   It was an radical microarchitectural departure from any
other MIPS chips before or since, with a two-way superscalar FPU,
dual load paths from the cache, streaming cache design, and a much
larger TLB than any MIPS part before or since.   For reasons that
remain obscure (at least to me) it was implemented in BiCMOS,
and consumed two chips.   The interchip interconnect was one of the
reasons why the clock speed was so limited relative to other designs
from the same period.   On vectorisable floating-point codes that could
take advantage of the dual FP issue and the streaming caches, it was
a good performer, really amazing in terms of FLOPS/MHz.  But it
performed relatively badly on integer or control-intensive codes, and
for whatever reason - exotic technology, packaging, or design - the
R8000 "Power Challenge" CPU boards had a reputation for
poor reliability.

The most important legacy of the R8000 is that it was the first
MIPS IV ISA processor and the first superscalar MIPS chip.
That's why one often uses the gcc -mcpu=r8000 to generate
code for R5xxx-class CPUs.

>> The R7000 is kind of a successor to the R5000 featuring roughly R10000
>> performance but at a much lower price.  This was developed by either
>> IDT or QED mostly for embedded purposes.

It was developed for QED for high-end embedded and consumer apps.
It's microarchitecture has virtually nothing in common with the R8000.
As others have noted, whether the performance of the RM7000 (which
is QED's actual designation for the part) is on a par with an R10000
will depend a great deal on the code, the frequency, and the memory
subsystem.   But the R10000 was engineered for performance-at-any-price,
wheras the RM7000 was engineered for price/performance.

> The R5000, was designed and built by QED whom SGI funded to build the
processor
> for the O2 product line. SGI still owns the rights via MTI and is allowed to
> license them to the various MIPS Licensees.

I think it would be more correct to say that among the various bits
of IP that MIPS Technologies took with them when they were spun
back out of SGI was the R5000 design.

> The QED folks ARE the original RXXXX Series designers who originally worked
> for MIPS Computer System until SGI bought the company in 1992. The various
> processor designs which they developed included the R2000/2010, R3000/3010,
> R4000, R4400, R5000 and R7000 processors. Nearly all of the original MIPS
> Computer systems processor designers are now working at QED.

I think "nearly all" is a bit of an overstatement.   There are veterans
of the early days of MIPS in a lot of companies in the valley.  I'm not
going to name names here, but QED is merely the largest of several
MIPS spin-offs.

> MIPS Technoloy  Inc, MTI, is mostly SGI processor designers and lots
> of new engineers who own the SGI rights to the various MIPS processor
> designs.

I prefer to think of Mips Technologies as owning the *MIPS* rights
to the various MIPS processor designs.  And the patents behind
them.  And the ISA.  ;-)

> The R8000 was shipped in a VME based machine which was placed in the
> Challenge line which included R4400, R8000 and R10000 processors. As was noted
> it was an SGI design in total and had a very short life-time.

Quibble here:  The Challenge/PowerChallenge bus had
little or nothing to do with VME.   I recall that it was a synchronous,
"pended operation" bus, and VME is neither.

            Regards,

            Kevin K.

Disclaimer:  I guess I need to say that the above opinions, analysis,
and reminiscences are my own and not necessarily those of MIPS
Technologies Inc.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
