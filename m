Received:  by oss.sgi.com id <S553893AbRBLSZ5>;
	Mon, 12 Feb 2001 10:25:57 -0800
Received: from [12.44.186.158] ([12.44.186.158]:15857 "EHLO hermes.mvista.com")
	by oss.sgi.com with ESMTP id <S553878AbRBLSZm>;
	Mon, 12 Feb 2001 10:25:42 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f1CIJj829136;
	Mon, 12 Feb 2001 10:19:45 -0800
Message-ID: <3A8829B9.17B7F691@mvista.com>
Date:   Mon, 12 Feb 2001 10:21:45 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: config option vs. run-time detection (the debate continues ...)
References: <Pine.GSO.3.96.1010210094331.2153A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Maciej W. Rozycki" wrote:
> 
>  Well, the number of places a run-time condition exist is small and they
> are not performance-critical.
> 
> > I actually don't understand your IDT quote.  It requires one to call mfc1 to
> > get FCR0.  On many CPUs without a FPU, this will generate an exception.  Are
> > you suggesting that we should catch the exception and from that we conclude
> > there is no FPU present?
> 
>  I don't have an FPU-less system and I can't check such code.  I need to
> depend on others (I couldn't test all possible configurations anyway).

However, with CONFIG_HAS_FPU approach I know for sure it will work for any
MIPS CPU, as long as the programmer specifies it correctly. :-)

> If
> we have a chance to get an exception we have to catch it, of course
> (that's trivial to handle in Linux).
> 

No effort (as in CONFIG_HAS_FPU approach) is still better than trivial or
small effort ( as in run-time detection).  :-)

---

I am very curious what makes you object to the CONFIG_HAS_FPU approach,
especially you said earlier it was not about the inability to support both FPU
and FPU-less CPUs with the same kernel image.

Jun
