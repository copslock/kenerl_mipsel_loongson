Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2004 14:25:41 +0000 (GMT)
Received: from p508B7260.dip.t-dialin.net ([IPv6:::ffff:80.139.114.96]:35442
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225539AbUA2OZk>; Thu, 29 Jan 2004 14:25:40 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0TEPbex029090;
	Thu, 29 Jan 2004 15:25:37 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0TEPbCJ029089;
	Thu, 29 Jan 2004 15:25:37 +0100
Date: Thu, 29 Jan 2004 15:25:37 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] 32bit module support
Message-ID: <20040129142537.GA14160@linux-mips.org>
References: <20040123182436.C27362@mvista.com> <20040129140450.GA5589@linux-mips.org> <Pine.LNX.4.55.0401291516270.13474@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401291516270.13474@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 29, 2004 at 03:18:33PM +0100, Maciej W. Rozycki wrote:

> > What still needs to be done is adding module supprt for 64-bit also - but
> > that's not functional in 2.4 either and I have no plans to implement
> > 64-bit modules in 2.4.
> 
>  AFAIK, what would be needed for 2.4 is an update to modutils, not the 
> kernel itself.  It can be done any time provided the interested party 
> writes appropriate code.

You're right, for 2.4 modutils would need to be updated since the entire
relocation is done in userspace.  The work that needs to be done on
userspace rsp. kernel utilities is similar though - 80% of the relocation
code in 2.6 were taken from the old modutils; the remaining 20% were
needed rewriting since the kernel environment for the relocation code is
different than in modutils.  In short, once 64-bit modules are working
for the one kernel version it's going to be easy to support the other also.

  Ralf
