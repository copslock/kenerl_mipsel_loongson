Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2003 22:38:19 +0100 (BST)
Received: from p508B61A2.dip.t-dialin.net ([IPv6:::ffff:80.139.97.162]:26518
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224772AbTHDViR>; Mon, 4 Aug 2003 22:38:17 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h74LcDpR028775;
	Mon, 4 Aug 2003 23:38:13 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h74LcC3B028774;
	Mon, 4 Aug 2003 23:38:12 +0200
Date: Mon, 4 Aug 2003 23:38:12 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Pete Popov <ppopov@mvista.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: udelay
Message-ID: <20030804213812.GA21327@linux-mips.org>
References: <1059788948.9224.62.camel@zeus.mvista.com> <20030804014132.GA4419@linux-mips.org> <1060018159.9217.93.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060018159.9217.93.camel@zeus.mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 04, 2003 at 10:29:20AM -0700, Pete Popov wrote:

> > > Looks like the latest udelay in 2.4 is borked. Anyway else notice that
> > > problem?  I did a 10 sec test: mdelay works, udelay is broken, at least
> > > for the CPU and toolchain I'm using.
> > 
> > That just doesn't make sense.  Mdelay is based on udelay so if udelay
> > is broken mdelay should be broken, too.
> 
> I think the problem may be occurring when udelay is used with very large
> values, like 10000. I've told the developer that that's not recommended
> and to use mdelays in that case.

Any bug report for udelay arguments larger than 1000 will probably be
ignored ...

  Ralf
