Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 15:23:10 +0000 (GMT)
Received: from p508B7363.dip.t-dialin.net ([IPv6:::ffff:80.139.115.99]:63553
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225226AbUBBPXK>; Mon, 2 Feb 2004 15:23:10 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i12FN8ex028989;
	Mon, 2 Feb 2004 16:23:08 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i12FN8Cg028988;
	Mon, 2 Feb 2004 16:23:08 +0100
Date: Mon, 2 Feb 2004 16:23:07 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20040202152307.GB28673@linux-mips.org>
References: <20040202141939Z8225226-9616+1555@linux-mips.org> <Pine.LNX.4.55.0402021611490.6182@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0402021611490.6182@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 02, 2004 at 04:13:28PM +0100, Maciej W. Rozycki wrote:

> > 	PMC-Sierra says that the workaround for errata #18 of the R4600 V1.7
> > 	and a similar erratum in V2.0 don't require disabling of interrupts,
> > 	so remove that code.
> 
>  How do we assure tails of interrupt handlers don't trigger the errata?

The problem can only be triggered if instructions surrounding the
cacheop use the dcache; exceptions such as interrupts are not relevant.

Which I'm really happy about.  Disabling interrupts is a problem in cases
were we can't avoid page faults.

  Ralf
