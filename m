Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2004 12:00:42 +0000 (GMT)
Received: from p508B7879.dip.t-dialin.net ([IPv6:::ffff:80.139.120.121]:50003
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225301AbUCWMAl>; Tue, 23 Mar 2004 12:00:41 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2NC0YoM006232;
	Tue, 23 Mar 2004 13:00:34 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2NC0Xr4006231;
	Tue, 23 Mar 2004 13:00:33 +0100
Date: Tue, 23 Mar 2004 13:00:33 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
Message-ID: <20040323120033.GA6151@linux-mips.org>
References: <404D28B1.4010608@gentoo.org> <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl> <4058BC76.9020204@gentoo.org> <Pine.LNX.4.55.0403172202060.14525@jurand.ds.pg.gda.pl> <4058DAE2.8000902@gentoo.org> <Pine.LNX.4.55.0403180041560.14525@jurand.ds.pg.gda.pl> <4058E89B.3010208@gentoo.org> <Pine.LNX.4.55.0403180141400.14525@jurand.ds.pg.gda.pl> <Pine.LNX.4.55.0403221255200.6539@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0403221255200.6539@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 23, 2004 at 12:49:02PM +0100, Maciej W. Rozycki wrote:

> >  Essentially all platforms that currently set the address to something
> > that's not aligned to a 64kB boundry.  I'd like binutils to be fixed
> > instead, though -- I'll try to track the problem down and cook a patch
> > before 2.15.  I think the problem may be considered serious enough the
> > release may even be deferred for a few days if necessary (since I believe
> > it's quite close).
> 
>  After a study of the relevant BFD code, I'm now pretty sure it does its
> job right -- the .text section which is placed at a fixed offset by the
> linker script only imposes an alignment of 4 and the 64kB alignment is
> required by the segment the section is placed in.  So BFD does the right 
> job by lowering the segment's VMA so that the .text section is placed at 
> the requested offset.
> 
>  What's important, segment alignment happens under the assumption a binary 
> will be used in a paged environment.  This is not normally the case with a 
> MIPS Linux kernel, so I think the right solution is to ask the linker not 
> to do page aligning using the "-n" option.  Here's a patch that should do 
> that.
> 
>  Ralf, OK to apply this?

Sure, I don't see any possible drawback from this.

  Ralf
