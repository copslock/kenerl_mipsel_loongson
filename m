Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Apr 2004 14:01:20 +0100 (BST)
Received: from p508B7EE5.dip.t-dialin.net ([IPv6:::ffff:80.139.126.229]:51537
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224927AbUDRNBS>; Sun, 18 Apr 2004 14:01:18 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3ID0qxr016368;
	Sun, 18 Apr 2004 15:00:52 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3ID0UFe016367;
	Sun, 18 Apr 2004 15:00:30 +0200
Date: Sun, 18 Apr 2004 15:00:30 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Bradley D. LaRonde" <brad@laronde.org>, linux-mips@linux-mips.org,
	Eric Christopher <echristo@redhat.com>,
	Daniel Jacobowitz <dan@debian.org>
Subject: Re: [PATCH] gcc 3.4 drops "accum" clobber, replace with "hi" intime.c
Message-ID: <20040418130029.GA23489@linux-mips.org>
References: <Pine.GSO.4.10.10404122244110.8735-100000@helios.et.put.poznan.pl> <20040412231309.GA702@linux-mips.org> <03f301c420e7$d8de2d70$8d01010a@prefect> <048e01c420f1$ad4ae3b0$8d01010a@prefect> <1081818125.19719.14.camel@dzur.sfbay.redhat.com> <04d501c420f3$6c836a30$8d01010a@prefect> <20040413010732.GA7560@nevyn.them.org> <04f501c420f4$5563f620$8d01010a@prefect> <053c01c420f5$ec230190$8d01010a@prefect> <Pine.LNX.4.55.0404131451200.15949@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0404131451200.15949@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 13, 2004 at 02:57:07PM +0200, Maciej W. Rozycki wrote:

> 
> > OK, so this patch actually builds, and it sounds like it will do the job,
> > since "accum" means "hi and low", "lo" is already clobbered in all cases,
> > and either "hi" is the output and doesn't need clobbering (hunks 1, 2, and
> > 4), or "hi" is already clobbered (hunk 3).
> 
>  There are more places this should be dealt with and I have the following 
> preliminary patch for this, but I'm unsure about removal of "accum" being 
> completely safe for older compilers.

From everything I know about the behavior of older compilers this should
be save.  "accum" was treated a little strage in some context anyway, so
I'm happy to see it go ...

  Ralf
