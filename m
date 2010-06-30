Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2010 22:37:41 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42940 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492450Ab0F3Ugy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jun 2010 22:36:54 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o5UEvPE8004392;
        Wed, 30 Jun 2010 15:57:25 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o5UEvPiV004390;
        Wed, 30 Jun 2010 15:57:25 +0100
Date:   Wed, 30 Jun 2010 15:57:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Phil Staub <phils@windriver.com>
Cc:     Adam Jiang <jiang.adam@gmail.com>, linux-mips@linux-mips.org
Subject: Re: How to detect STACKOVEFLOW on mips
Message-ID: <20100630145725.GB31938@linux-mips.org>
References: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com>
 <4C2B543E.2010309@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C2B543E.2010309@windriver.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 20566

On Wed, Jun 30, 2010 at 07:27:10AM -0700, Phil Staub wrote:

> >I'm having a problem with kernel mode stack on my box. It seems that
> >STACKOVERFLOW happened to Linux kernel. However, I can't prove it
> >because the lack of any detection in __do_IRQ() function just like on
> >the other architectures. If you know something about, please help me
> >on following two questions.
> >- Is there any possible to do this on MIPS?
> 
> The mechanisms I know about for detecting stack overflow include:
> 
> 1. Use of the MMU - stack ends at a page boundary, adjacent page is
> either unmapped or mapped read-only and causes an exception if violated.

Won't easily work on MIPS as the stack is allocated in KSEG0 / XKPHYS
which are unmapped segments.  It would be necessary to relocate the stack
into a mapped space.

Ultra-ancient Linux/MIPS kernels actually used to do that but that code
may well even predate everything that still exists on linux-mips.org.

> 2. Hooks inserted into toolchain to cause any stack decrement to be
> first tested against a limit.
> 
> 3. Fill entire stack with a recognizable pattern before first
> use. After suspected stack overflow, check to see if the pattern has
> been disturbed in the area of the stack limit.

This was afaik never ported to MIPS though that'd be easy.

> (Disclaimer: I've used all of these in some form on other OSes, but
> not on Linux. Someone else may have a more directly relevant answer.)
> 
> >- or, more simple question, how could I get the address $sp pointed by
> >asm() notation in C?
> 
> How about something like:
> 
> {
> 	long x;
> 	...
> 	asm("move %0,$29":"=g"(x));
> 	...
> }

That will do.  Or even something portable like:

{
	unsigned long foo;

	return &foo;
}

which used to work (GNU alloca and others were using this) but I'm sure
GCC has learned how to optimize this to shreds.

  Ralf
