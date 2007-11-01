Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 17:47:31 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:19132 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026966AbXKARr3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Nov 2007 17:47:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA1Hl6io024297;
	Thu, 1 Nov 2007 17:47:06 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA1Hl5Er024296;
	Thu, 1 Nov 2007 17:47:05 GMT
Date:	Thu, 1 Nov 2007 17:47:05 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Put cast inside macro instead of all the callers
Message-ID: <20071101174705.GA23917@linux-mips.org>
References: <20071031141124.185599da@ripper.onstor.net> <200711011704.01079.eckhardt@satorlaser.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200711011704.01079.eckhardt@satorlaser.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 01, 2007 at 05:04:01PM +0100, Ulrich Eckhardt wrote:

> I'm by far not a MIPS expert, but I'm puzzled by the code and how it uses 
> signed integers for addresses. I just added some comments below, but I'm not 
> sure if they are valid. Thank you for any clarification!

When going from 32-bit to 64-bit MIPS did sign-extend register values and
addresses, that is for example 0x80000000 became 0xffffffff80000000.  That
is the code sequence which on 32-bit is used to load the first address
actually happens to load the 2nd value on a 64-bit machine.  Which is an
extremly elegant solution on the hardware level but at a few places
software need to know.  The code tries to make clever use of sign extension
by the compiler to avoid multiple constants.

> On Wednesday 31 October 2007, Andrew Sharp wrote:
> > Since all the callers of the PHYS_TO_XKPHYS macro call with a constant,
> > put the cast to LL inside the macro where it really should be rather
> > than in all the callers.  This makes macros like PHYS_TO_XKSEG_UNCACHED
> > work without gcc whining.
> 
> I'm not sure if this is always a compile-time constant so that you can adorn 
> it with a LL. However, note that this is not a cast, a cast is at runtime.

No.  The compiler can evaluate the cast of a constant value at compile
time and that exactly is what the code is exploiting here.

> >  	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
> >  		usp = CKSEG1ADDR(sp);
> >  #ifdef CONFIG_64BIT
> > -	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0LL, 0) &&
> > -		 (long long)sp < (long long)PHYS_TO_XKPHYS(8LL, 0))
> > -		usp = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
> > +	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0, 0) &&
> > +		 (long long)sp < (long long)PHYS_TO_XKPHYS(8, 0))
> > +		usp = PHYS_TO_XKPHYS(K_CALG_UNCACHED,
> >  				     XKPHYS_TO_PHYS((long long)sp));
> 
> I'd say this code is broken in way too many aspects:
> 1. A plethora of casts. PHYS_TO_XKPHYS() should return a physical address 
> (i.e. 32 or 64 bits unsigned integer) already, so casting its result should 
> not be necessary.

No argument about the beauty of the whole thing.

> 2. Using a signed integer of undefined size for an address. At least use an 
> explicit 64 bit unsigned integer (__u64).

long long is 64-bit on Linux.

> 3. The use of signed types makes me wonder about intended overflow semantics. 
> Just for the record, signed overflow in C causes undefined behaviour, no 
> diagnostic required, and recent GCC even assume that no overflow occurs as an 
> optimisation!

There is no overflow possible here.

> >  #define PHYS_TO_XKSEG_CACHED(p)		PHYS_TO_XKPHYS(K_CALG_COH_SHAREABLE,(p))
> >  #define XKPHYS_TO_PHYS(p)		((p) & TO_PHYS_MASK)
> >  #define PHYS_TO_XKPHYS(cm,a)		(_CONST64_(0x8000000000000000) | \
> > -					 ((cm)<<59) | (a))
> > +					 (_CONST64_(cm)<<59) | (a))
> 
> This macro will always(!!!) generate a negative number, is that intended?

Sort of.  Most users don't care, the address is just an address for them.
Note that the Linux idea of "all virtual addresses can be represented in
an unsigned long" and the MIPS concept of sign extending addresses conflict
at times, so sometimes addresses want to be handled with alot of care.

  Ralf
