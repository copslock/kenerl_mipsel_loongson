Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 11:41:38 +0100 (CET)
Received: from p508B747B.dip.t-dialin.net ([80.139.116.123]:55785 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1121742AbSKYKlh>; Mon, 25 Nov 2002 11:41:37 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAPAf9Z32634;
	Mon, 25 Nov 2002 11:41:09 +0100
Date: Mon, 25 Nov 2002 11:41:09 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: atul srivastava <atulsrivastava9@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Re: watch exception only for kseg0 addresses..?
Message-ID: <20021125114109.A32007@linux-mips.org>
References: <20021125100152.6471.qmail@mailweb33.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021125100152.6471.qmail@mailweb33.rediffmail.com>; from atulsrivastava9@rediffmail.com on Mon, Nov 25, 2002 at 10:01:52AM -0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 25, 2002 at 10:01:52AM -0000, atul srivastava wrote:

> >The whole watch stuff in the the kernel is pretty much an ad-hoc 
> >API
> >which I did create to debug a stack overflow.  I'm sure if 
> >you're
> >going to use it you'll find problems.  For userspace for example 
> >you'd
> >have to switch the watch register when switching the MMU context 
> >so
> >each process gets it's own virtual watch register.
> Beyond that there
> >are at least two different formats of watch registers implemented 
> >in
> >actual silicon, the original R4000-style and the MIPS32/MIPS64 
> >style
> >watch registers and the kernel's watch code only know the R4000 
> >style

(It's horrible what mailprograms accounts do to mail formatting ...)

> my cpu manual ( IDT RC32334) talks about two watch registers 
> CP0_IWATCH and CP0_DWATCH where it is required to just put desired 
> VIRTUAL( bits 2--31) addresses to be watched , there is no mention 
> of CP0_WATCHLO and CP0_WATCHHI .
> 
> additionally i guees for userspace virtual watch register problem, 
> the hardware takes care of all , i just need to specify my virual 
> address this is what i understand from my  manual.
> 
> and one more problem i face when i try to debug a mysterious page 
> fault problem, that i get my watch exception but after page fault 
> ..hence I can't really debug , shouldn't the priority of watch 
> exceptions should be higher than atleast instruction fetch 
> exception.? or the scope of debugging by watch exception is 
> limited by design.....

No, the watch exception is one of the lowest priority exceptions.  In case
EXL/ERL are set it might even be defered making it the lowest priority
exception.

  Ralf
