Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2004 16:40:12 +0000 (GMT)
Received: from p508B76C0.dip.t-dialin.net ([IPv6:::ffff:80.139.118.192]:12407
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225512AbUBJQkM>; Tue, 10 Feb 2004 16:40:12 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i1AGdXex030723;
	Tue, 10 Feb 2004 17:39:34 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i1AGdXiY030722;
	Tue, 10 Feb 2004 17:39:33 +0100
Date: Tue, 10 Feb 2004 17:39:33 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] irq_cpu.c clean-ups
Message-ID: <20040210163933.GB30617@linux-mips.org>
References: <Pine.LNX.4.55.0402101716130.6769@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0402101716130.6769@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 10, 2004 at 05:19:33PM +0100, Maciej W. Rozycki wrote:

>  The two copies of irq_cpu.c should both in theory and in practice be the 
> same, but for some reason they are not.  Here's a patch for 2.4 to bring 
> them to sync.  The next step would be a trivial update for 2.6 to make 
> that version the same as these two as well.
> 
>  OK to apply?

Yes,

  Ralf
