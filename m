Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2004 18:49:15 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:63448
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225761AbUGNRtJ> convert rfc822-to-8bit; Wed, 14 Jul 2004 18:49:09 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id i6EHj9UX011470;
	Wed, 14 Jul 2004 10:45:09 -0700 (PDT)
Received: from laptopuhler ([192.168.1.193])
	by mercury.mips.com (8.12.11/8.12.11) with ESMTP id i6EHixx9007630;
	Wed, 14 Jul 2004 10:45:03 -0700 (PDT)
From: "Michael Uhler" <uhler@mips.com>
To: "'Dominic Sweetman'" <dom@mips.com>,
	"'Ralf Baechle'" <ralf@linux-mips.org>
Cc: "'Kevin D. Kissell'" <KevinK@mips.com>,
	"'S C'" <theansweriz42@hotmail.com>, <linux-mips@linux-mips.org>
Subject: RE: Strange, strange occurence
Date: Wed, 14 Jul 2004 10:45:15 -0700
Organization: MIPS Technologies, Inc.
Message-ID: <001101c469ca$573be5b0$4001a8c0@MIPS.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <16629.24775.778491.754688@arsenal.mips.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
X-Scanned-By: MIMEDefang 2.39
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

Dom's proposed solution is probably the right thing to do.  We've got some
code in MIPS that does exactly this, and I've suggested that we convert this
to provide to the Linux community.

/gmu

---
Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.   Email: uhler@mips.com
1225 Charleston Road      Voice:  (650)567-5025   FAX:   (650)567-5225
Mountain View, CA 94043   Mobile: (650)868-6870   Admin: (650)567-5085


> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of 
> Dominic Sweetman
> Sent: Wednesday, July 14, 2004 9:35 AM
> To: Ralf Baechle
> Cc: Kevin D. Kissell; S C; linux-mips@linux-mips.org
> Subject: Re: Strange, strange occurence
> 
> 
> 
> Ralf Baechle (ralf@linux-mips.org) writes:
> 
> > > A truly safe and general I-cache flush routine should itself run 
> > > uncached...
> 
> It depends what you mean by general, and uncached is not the 
> only option.  The spec says:
> 
>  "The operation of the instruction is UNPREDICTABLE if the cache line
>   that contains the CACHE instruction is the target of an
>   invalidate..." 
> 
> If you use hit-type cache operations in a kernel routine, 
> then you're safe.  I can't envisage any circumstance in which 
> Linux would try to invalidate kernel mainline code locations 
> from the I-cache (well, you might be doing something fabulous 
> with debugging the kernel, but that's not normal and you'd 
> hardly expect to be able to support such an activity with 
> standard cache management calls).
> 
> So this problem can only arise on index-type I-cache 
> invalidation.  I claim that a running kernel on a MIPS CPU 
> should only use index-type invalidation when it is necessary 
> to invalidate the entire I-cache. (If you use index-type 
> operations for a range which doesn't resolve to "the whole 
> cache" then that should be fixed).
> 
> That implies that a MIPS32-paranoid "invalidate-whole-I-cache" routine
> should:
> 
> 1. Identify which indexes might alias to cache lines 
>    containing the routines's own 'cache invalidate' instruction(s),
>    and thus hit the problem.  There won't be that many of them.
> 
> 2. Arrange to skip those indexes when zapping the cache, then do
>    something weird to invalidate that handful of lines.  You could 
>    do that by running uncached, but you could also do it just by using
>    some auxiliary routine which is known to be more than a cache line
>    but much less than a whole I-cache span distant, so can't possibly
>    alias to the same thing...
> 
> This is fiddly, but not terribly difficult and should have a 
> negligible performance impact.
> 
> Does that make sense?  Am I now, having named the solution, 
> responsible for figuring out a patch (yeuch, I never wanted 
> to be a kernel programmer again...).
> 
> --
> Dominic Sweetman
> MIPS Technologies
> 
> 
