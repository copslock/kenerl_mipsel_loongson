Received:  by oss.sgi.com id <S42225AbQHBSPE>;
	Wed, 2 Aug 2000 11:15:04 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:61720 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42282AbQHBSOl>; Wed, 2 Aug 2000 11:14:41 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA04652
	for <linux-mips@oss.sgi.com>; Wed, 2 Aug 2000 11:20:05 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA95454
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Aug 2000 11:13:54 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA02909
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Aug 2000 11:13:54 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id LAA03103;
	Wed, 2 Aug 2000 11:12:42 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id LAA28193;
	Wed, 2 Aug 2000 11:12:42 -0700 (PDT)
Message-ID: <01ac01bffcad$a767c240$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Jun Sun" <jsun@mvista.com>
Cc:     <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <ralf@oss.sgi.com>
Subject: Re: PROPOSAL : multi-way cache support in Linux/MIPS
Date:   Wed, 2 Aug 2000 20:15:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

-->A couple of questions :
>
>. What about the actual cache operation routines (flush_cache_page,
>...)?  Are they divided into R4xxx, R3xx, etc?  I guess I am curious how
>the code is organized.

We kept pretty much the existing 2.2 structure for these things.
We created the module "r4k.c" in arch/mips/mm which was
essentially parallel to the old r4xx0.c module, but which implemented
the various TLB and cache functions (a) using the information in
the mips_cpu structure wherever it made sense and (b) in ways
that are fully compatible with the "MIPS32" ISA+CP0 model
as well as with the original R4000 family and its descendants.
It's possible to write code that is compatible with an R4000 but
not MIPS32, and vice versa, but they are 99% identical.  

>. Your structure gives the number of ways, but no info about how to
>select a way.  How would do an index-based cache operation?  It seems to
>me you probably need something like cache_way_selection_offset in the
>cpu table.


The MIPS32 spec for the CACHE instruction gives a trivial
mapping from sets/ways/linesize into CACHE instruction
operands.  In fact, the same technique works for most pre
MIPS32 multi-way caches as well.  The only exception that
comes to mind is the R10000.  If one wanted to support the
R10K or other oddball CACHE-implementations in this
system, I would suggest adding a  MIPS_CACHE_R10KWAYSEL 
or some flag to the flags field of the cache descriptor,
and tweaking any routines that need to select indices 
(such a routine to hunt down and kill all possible virtual 
aliases of an address) to handle the special case.

The primitives in Linux 2.2 did not require much knowedge 
of multi-way caches as such - they could all be implemented
either using hit-based CACHE operations, or by cycling
through all possible indices using knowledge of the total
size and the line size.  But the newer synthesizable MIPS
cores allow cache configurations to be "dialed in" in ways
that the old code could not handle.  The CPUs themselves
can be interrogated to determine the line size/nways/nsets
geometry, so we mirror that in the Linux code and use those
parameters to compute total size, way size, etc.  The 
PrID-based lookup table and the dynamic probe routines
are there to allow older parts to use the same mechanisms.

            Regards,

            Kevin K.
