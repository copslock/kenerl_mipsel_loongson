Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 17:23:37 +0000 (GMT)
Received: from mail.onstor.com ([66.201.51.107]:56270 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S20026298AbXKARX2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2007 17:23:28 +0000
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 1 Nov 2007 10:23:00 -0700
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 1 Nov 2007 10:23:00 -0700
Date:	Thu, 1 Nov 2007 10:23:00 -0700
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Put cast inside macro instead of all the callers
Message-ID: <20071101102300.1db4ff6a@ripper.onstor.net>
In-Reply-To: <200711011704.01079.eckhardt@satorlaser.com>
References: <20071031141124.185599da@ripper.onstor.net>
	<200711011704.01079.eckhardt@satorlaser.com>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Nov 2007 17:23:00.0489 (UTC) FILETIME=[DA24CF90:01C81CAB]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

On Thu, 1 Nov 2007 17:04:01 +0100 Ulrich Eckhardt
<eckhardt@satorlaser.com> wrote:

> I'm by far not a MIPS expert, but I'm puzzled by the code and how it
> uses signed integers for addresses. I just added some comments below,
> but I'm not sure if they are valid. Thank you for any clarification!
> 
> On Wednesday 31 October 2007, Andrew Sharp wrote:
> > Since all the callers of the PHYS_TO_XKPHYS macro call with a
> > constant, put the cast to LL inside the macro where it really
> > should be rather than in all the callers.  This makes macros like
> > PHYS_TO_XKSEG_UNCACHED work without gcc whining.
> 
> I'm not sure if this is always a compile-time constant so that you
> can adorn it with a LL. However, note that this is not a cast, a cast
> is at runtime.

It is always a constant.

> >  	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
> >  		usp = CKSEG1ADDR(sp);
> >  #ifdef CONFIG_64BIT
> > -	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0LL,
> > 0) &&
> > -		 (long long)sp < (long long)PHYS_TO_XKPHYS(8LL, 0))
> > -		usp = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
> > +	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0, 0)
> > &&
> > +		 (long long)sp < (long long)PHYS_TO_XKPHYS(8, 0))
> > +		usp = PHYS_TO_XKPHYS(K_CALG_UNCACHED,
> >  				     XKPHYS_TO_PHYS((long
> > long)sp));
> 
> I'd say this code is broken in way too many aspects:
> 1. A plethora of casts. PHYS_TO_XKPHYS() should return a physical
> address (i.e. 32 or 64 bits unsigned integer) already, so casting its
> result should not be necessary.
> 2. Using a signed integer of undefined size for an address. At least
> use an explicit 64 bit unsigned integer (__u64).
> 3. The use of signed types makes me wonder about intended overflow
> semantics. Just for the record, signed overflow in C causes undefined
> behaviour, no diagnostic required, and recent GCC even assume that no
> overflow occurs as an optimisation!
> 
> >  #define PHYS_TO_XKSEG_CACHED(p)
> > PHYS_TO_XKPHYS(K_CALG_COH_SHAREABLE,(p)) #define
> > XKPHYS_TO_PHYS(p)		((p) & TO_PHYS_MASK) #define
> > PHYS_TO_XKPHYS(cm,a)		(_CONST64_(0x8000000000000000)
> > | \
> > -					 ((cm)<<59) | (a))
> > +					 (_CONST64_(cm)<<59) | (a))
> 
> This macro will always(!!!) generate a negative number, is that
> intended?

Well, it's an address, not a number.  Does that help?  The point of the
macro is to convert physical addresses to a selectable type of virtual
address, of which mips has several.

Cheers,

a
