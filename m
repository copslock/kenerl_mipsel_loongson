Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2002 18:20:07 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:25538 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123396AbSJGQUG>;
	Mon, 7 Oct 2002 18:20:06 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g97GJINf025009;
	Mon, 7 Oct 2002 09:19:18 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA28486;
	Mon, 7 Oct 2002 09:19:53 -0700 (PDT)
Message-ID: <01fd01c26e1d$add77240$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Johannes Stezenbach" <js@convergence.de>,
	<linux-mips@linux-mips.org>
References: <20020916164034.GA12489@convergence.de> <20021007144749.GB16641@convergence.de>
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Date: Mon, 7 Oct 2002 18:21:52 +0200
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
X-archive-position: 391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> Hi all,
> 
> On Mon, Sep 16, 2002 at 06:40:34PM +0200, I wrote:
> > 
> > The NEC VR41xx CPU has no LL/SC instructions, so they must
> > be emulated by the kernel, which slows down the test-and-set
> > and compare-and-swap operations (used by linux-threads)
> > considerably. For the VR41xx (and other CPUs which have
> > branch-likely instructions), there exisits a workaround
> > which enables userspace-only atomic operations, with minor
> > help from the kernel: The kernel must guarantee that register
> > k1 is not equal to some magic value after every transition
> > to userspace.
> > 
> > Two things were left open in July:
> > - find out the minimal amount of changes to the kernel
> >   to guarantee k1 != MAGIC after eret
> > - determine how to tell glibc to use the branch-likely
> >   workaround instead of emulated LL/SC
> 
> Since there have been no follow-ups I must assume that
> this topic is no longer of interest. Is this so? Or
> is the way I approach it deemed inappropriate?

When I first proposed the branch-likely hack last winter,
I thought it might be worth while to do a through code
inspection to determine what set of values could never
be returned in k1 (or k0 for all I care) if an exception
was taken, such that there would be no mods to the
kernel required whatsoever.  I spent a little time going 
down that path, and it does look at first glance as if one 
could guarantee that one will never come out of an exception 
with k1 equal to 0xffdadaff in current oss/linux-mips cvs
sources, but the guys at Sony, who have a big interest in 
this technique, given that the PS2 has no LL/SC,
prefered a more conservative approach which explicitly
clobbered the selective register on all exceptions,
even if it meant some small performance impact.
That's probably going to be a more reliable design,
though I would still consider leaving the TLB refill handler
untouched and counting on the fact that k1 must contain
a non-lethal EntryLo value on return from the exception.

As for glibc, the possibilities are numerous and I'm not
the guy who'd have to make it work.

            Regards,

            Kevin K.
