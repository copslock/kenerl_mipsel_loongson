Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2004 22:08:21 +0000 (GMT)
Received: from p508B619B.dip.t-dialin.net ([IPv6:::ffff:80.139.97.155]:21052
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225310AbUBMWIU>; Fri, 13 Feb 2004 22:08:20 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i1DM7mex001605;
	Fri, 13 Feb 2004 23:07:48 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i1DM7PYa001598;
	Fri, 13 Feb 2004 23:07:25 +0100
Date: Fri, 13 Feb 2004 23:07:25 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
Message-ID: <20040213220725.GA31847@linux-mips.org>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl> <20040213145316.GA23810@linux-mips.org> <20040213175141.GB16718@mvista.com> <Pine.LNX.4.55.0402131908370.15042@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0402131908370.15042@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 13, 2004 at 07:35:01PM +0100, Maciej W. Rozycki wrote:

>  If we want to tolerate performance loss, then it's easily doable.  That 
> can be done with the current setup, with a jump instruction to the 
> referred function added at the end and "__attribute__((used))" or perhaps 
> "asm("foo")" added to the function declaration.
> 
>  I can choose this path if we agree on it.

The inline version is fundemantally fragile.  The outline version has
problems with getting reordered by later gcc which can be solved by
putting a jump to the C function at the end; the C function also needs
the right __attribute__s so it won't get eleminated by gcc.

  Ralf
