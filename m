Received:  by oss.sgi.com id <S553663AbRBIVd1>;
	Fri, 9 Feb 2001 13:33:27 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:62455 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553647AbRBIVdL>;
	Fri, 9 Feb 2001 13:33:11 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f19LT3820818;
	Fri, 9 Feb 2001 13:29:03 -0800
Message-ID: <3A84619B.94224C30@mvista.com>
Date:   Fri, 09 Feb 2001 13:31:07 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: config option vs. run-time detection (the debate continues ...)
References: <Pine.GSO.3.96.1010209212607.13007B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Maciej W. Rozycki" wrote:
> 
> On Fri, 9 Feb 2001, Jun Sun wrote:
> 
> > Do you like run-time detection better because it allows a kernel to run on
> > CPUs both with a FPU and without a FPU?  Or there is something else to it?
> 
>  Nope.  There are certain explicit actions that are to be performed by the
> kernel if a real FPU is present, such as saving and restoring its
> registers or setting the control register.  Therefore the kernel has to
> know if a real part is present and act accordingly.  Maintaining a table
> of all CPU ids ever manufactured and manually setting the FPU presence bit
> is unreliable, especially as there are chips which cannot be classified
> this way, e.g. knowing your CPU is an R3000A you don't know if an R3010A
> FPU is soldered as well or not.
> 

Apparently you did not read my first email on this thread. :-)

I agree "Maintaining a table of all CPU ids ever manufactured and manually
setting the FPU presence bit is unreliable ...".

I was debating about how we let kernel know if there is a real FPU:

  a) an explicit config option, CONFIG_HAS_FPU, (which is not associated with
PrID), plus "#ifdef CONFIG_HAS_FPU ..." code.  Or

  b) have run-time detection and many "if .. then .." code.

I listed some pro's and con's for both of them in my first email.  Right now,
I found myself not having a strong preference but still biased towards config
option approach ( - as if that really matters. :-0)

> > Another question.  I know with mips32 and mips64 we can do run-time detection
> > reliably.  What about other existing processors?
> 
>  I've sent a quote from an IDT manual recently.  It recommended to use the
> FPU implementation ID to check if an FP hw is present.  I believe it
> should work for any sane implementation of a MIPS CPU.  See the mail for
> details.
> 

I actually don't understand your IDT quote.  It requires one to call mfc1 to
get FCR0.  On many CPUs without a FPU, this will generate an exception.  Are
you suggesting that we should catch the exception and from that we conclude
there is no FPU present?

Jun
