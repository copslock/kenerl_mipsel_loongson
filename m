Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 13:18:23 +0100 (CET)
Received: from p508B747B.dip.t-dialin.net ([80.139.116.123]:43754 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123997AbSKYMSW>; Mon, 25 Nov 2002 13:18:22 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAPCI7n12349;
	Mon, 25 Nov 2002 13:18:07 +0100
Date: Mon, 25 Nov 2002 13:18:07 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
Message-ID: <20021125131807.B12113@linux-mips.org>
References: <20021125102458.B22046@linux-mips.org> <Pine.GSO.3.96.1021125123643.8769B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021125123643.8769B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Nov 25, 2002 at 12:55:11PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 25, 2002 at 12:55:11PM +0100, Maciej W. Rozycki wrote:

> > The whole watch stuff in the the kernel is pretty much an ad-hoc API
> > which I did create to debug a stack overflow.  I'm sure if you're
> > going to use it you'll find problems.  For userspace for example you'd
> > have to switch the watch register when switching the MMU context so
> > each process gets it's own virtual watch register.  Beyond that there
> > are at least two different formats of watch registers implemented in
> > actual silicon, the original R4000-style and the MIPS32/MIPS64 style
> > watch registers and the kernel's watch code only know the R4000 style
> > one.  So check your CPU's manual ...
> 
>  I think the best use of the watch exception would be making it available
> to userland via PTRACE_PEEKUSR and PTRACE_POKEUSR for hardware watchpoint
> support (e.g. for gdb).  Hardware support is absolutely necessary for
> watching read accesses and much beneficial for write ones (otherwise gdb
> single-steps code which sucks performace-wise).

Agreed.  And because such an extension would be fully backward compatible
introduction is no problem.  So time to come up with a reasonable API.
MIPS32 / MIPS64 extend the R4000's watch capabilities significantly,
something we don't want to ignore.

  Ralf
