Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2005 14:00:28 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:53767 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8226100AbVDTNAN> convert rfc822-to-8bit;
	Wed, 20 Apr 2005 14:00:13 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1DOEr1-0004ab-00; Wed, 20 Apr 2005 14:02:55 +0100
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1DOElw-0004vY-00; Wed, 20 Apr 2005 13:57:40 +0100
Received: from dom by arsenal.mips.com with local (Exim 4.44)
	id 1DOElx-0001Sw-4b; Wed, 20 Apr 2005 13:57:41 +0100
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16998.20933.14301.397793@arsenal.mips.com>
Date:	Wed, 20 Apr 2005 13:57:41 +0100
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: ieee754[sd]p_neg workaround
In-Reply-To: <Pine.LNX.4.61L.0504201312520.7109@blysk.ds.pg.gda.pl>
References: <20050420.174023.113589096.nemoto@toshiba-tops.co.jp>
	<Pine.LNX.4.61L.0504201312520.7109@blysk.ds.pg.gda.pl>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.835,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Maciej W. Rozycki (macro@linux-mips.org) writes:

> > I have a long standing patch for FPU emulator to fix a segmentation
> > fault in pow() library function.
> > 
> > Here is a test program to reproduce it.
> > 
> > main()
> > {
> > 	union {
> > 		double d;
> > 		struct {
> > #ifdef __MIPSEB
> > 			unsigned int high, low;
> > #else
> > 			unsigned int low, high;
> > #endif
> > 		} i;
> > 	} x, y, z;
> >         x.i.low = 0x00000000;
> >         x.i.high = 0xfff00001;
> >         y.i.low = 0x80000000;
> >         y.i.high = 0xcff00000;
> >         z.d = pow(x.d, y.d);
> >         printf("%x %x\n", z.i.high, z.i.low);
> >         return 0;
> > }
> > 
> > 
> > If you run this program, you will get segmentation fault (unless your
> > FPU does not raise Unimplemented exception for NaN operands).  The
> > segmentation fault is caused by endless recursion in __ieee754_pow().
> > 
> > It looks glibc's pow() assume unary '-' operation for any number
> > (including NaN) always invert its sign bit.
> 
>  AFAICS, the IEEE 754 standard explicitly leaves interpretation of the 
> sign bit for NaNs as unspecified.  Therefore our implementation is correct 
> and its glibc that should be fixed instead.  Please file a bug report 
> against glibc.

You are both right, in a sense.

"Annex A Recommended Functions and Predicates" of IEEE754 (the
annexe is not part of the formal spec) includes a recommendation:

   "­x is x copied with its sign reversed, not 0­x; the distinction is
    germane when x is ±0 or NaN."

And in fact that's how the MIPS neg.d operation works: it never
generates an exception, just blindly flips the sign bit.

In the body of IEEE754 it says:

   "This standard does not interpret the sign of an NaN."

So there you are.  According to the book, the library function should
not depend on the sign of a NaN, but it would also be better if the
compiler/emulator/whatever ensures that "-x" is always and only
implemented by reversing the sign bit.

So file a bug against glibc, but we should fix the emulator so it
correctly imitates the MIPS instruction set...

--
Dominic Sweetman
MIPS Technologies.
