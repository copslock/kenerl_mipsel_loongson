Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2003 23:03:54 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:5873 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224772AbTHDWDw>;
	Mon, 4 Aug 2003 23:03:52 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA18053;
	Mon, 4 Aug 2003 15:03:50 -0700
Subject: Re: udelay
From: Pete Popov <ppopov@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030804213812.GA21327@linux-mips.org>
References: <1059788948.9224.62.camel@zeus.mvista.com>
	 <20030804014132.GA4419@linux-mips.org>
	 <1060018159.9217.93.camel@zeus.mvista.com>
	 <20030804213812.GA21327@linux-mips.org>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1060034667.9224.219.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Aug 2003 15:04:27 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, 2003-08-04 at 14:38, Ralf Baechle wrote:
> On Mon, Aug 04, 2003 at 10:29:20AM -0700, Pete Popov wrote:
> 
> > > > Looks like the latest udelay in 2.4 is borked. Anyway else notice that
> > > > problem?  I did a 10 sec test: mdelay works, udelay is broken, at least
> > > > for the CPU and toolchain I'm using.
> > > 
> > > That just doesn't make sense.  Mdelay is based on udelay so if udelay
> > > is broken mdelay should be broken, too.
> > 
> > I think the problem may be occurring when udelay is used with very large
> > values, like 10000. I've told the developer that that's not recommended
> > and to use mdelays in that case.
> 
> Any bug report for udelay arguments larger than 1000 will probably be
> ignored ...

I found the 'bug' before I saw your udelay comment ;)

Pete
