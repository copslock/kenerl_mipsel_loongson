Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2005 17:21:56 +0000 (GMT)
Received: from fed1rmmtao05.cox.net ([IPv6:::ffff:68.230.241.34]:219 "EHLO
	fed1rmmtao05.cox.net") by linux-mips.org with ESMTP
	id <S8225429AbVA1RVl>; Fri, 28 Jan 2005 17:21:41 +0000
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-117-20041022) with ESMTP
          id <20050128172133.BYAN14815.fed1rmmtao05.cox.net@liberty.homelinux.org>;
          Fri, 28 Jan 2005 12:21:33 -0500
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id KAA09290;
	Fri, 28 Jan 2005 10:20:56 -0700
Date:	Fri, 28 Jan 2005 10:20:56 -0700
From:	Matt Porter <mporter@kernel.crashing.org>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	Ulrich Eckhardt <eckhardt@satorlaser.com>,
	linux-mips@linux-mips.org
Subject: Re: bitrot in drivers/net/au1000_eth.c
Message-ID: <20050128102056.A9216@cox.net>
References: <200501281501.19162.eckhardt@satorlaser.com> <41FA6FF0.4060302@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41FA6FF0.4060302@embeddedalley.com>; from ppopov@embeddedalley.com on Fri, Jan 28, 2005 at 09:01:36AM -0800
Return-Path: <mmporter@cox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mporter@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 28, 2005 at 09:01:36AM -0800, Pete Popov wrote:
> Ulrich Eckhardt wrote:

<snip>

> > 3. Split off the MII handling code or, better, reuse the facility already 
> > provided by drivers/net/mii.c. This would mean a significant rewrite of 
> > au1x00.c, including probably breaking things on the way.
> 
> That's a possibility too but more code needs to be added to mii.c. I 
> actually revisited the code yesterday and was trying to figure out 
> how to clean it up. But someone told me that there is 2.6 work in 
> progress to do this so I decided to just wait. Maybe someone knows 
> more about it.

I suggest everyone take a look at the effort posted to netdev:

http://oss.sgi.com/archives/netdev/2004-12/msg00643.html

It's an attempt at a phy abstraction layer that goes the next
logical step after the minimal support provided in mii.h.

It's evolved out of the in-driver abstraction that is currently
used in the sungem, ibm_emac, and gianfar drivers in 2.6. It
was just a matter of time before somebody got tired of copying
the same PHY mgmt bits into every driver. :)

-Matt
