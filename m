Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 16:32:30 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:39574 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025521AbZD2PcX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2009 16:32:23 +0100
Received: (qmail 26486 invoked by uid 1000); 29 Apr 2009 17:32:21 +0200
Date:	Wed, 29 Apr 2009 17:32:21 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: oops in futex_init()
Message-ID: <20090429153221.GA26387@roarinelk.homelinux.net>
References: <20090428124645.GA14347@roarinelk.homelinux.net> <20090429060317.GB15627@linux-mips.org> <20090429082556.GA22844@roarinelk.homelinux.net> <20090429083349.GB26289@linux-mips.org> <20090429114042.GA24576@roarinelk.homelinux.net> <20090429141411.GA25905@roarinelk.homelinux.net> <20090429143523.GA10242@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090429143523.GA10242@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Ralf, Kevin,

On Wed, Apr 29, 2009 at 04:35:23PM +0200, Ralf Baechle wrote:
> On Wed, Apr 29, 2009 at 04:14:11PM +0200, Manuel Lauss wrote:
> 
> > FWIW, I think I fixed it: I have a small area (< 4kB) with a lot of UARTs
> > and 3 interrupt controllers in it.  An ioremap() was done for each uart and
> > irq ctl area.  Now there's one ioremap of the whole area and the oops is
> > gone.  I don't know why, but it seems fixed. (The oops appeared after one
> > of the remapped areas was touched).
> 
> That should be benign - especially if the mappings are for physical
> addresses < 512MB which would become mapped as KSEG1 addresses.  The
> dangerous cases are where multiple mappings alias (can't happen on
> Alchemy caches) or where different machines use different cache modes
> which also shouldn't hit you because I/O addresses should be mapped
> uncachable.  So you may want to try out what Kevin suggested to get to
> the root of this.

This CS is outside the KSEG0/1 areas.  The code in question did an ioremap
on 3 adjacent 8-byte areas (at offset 0x8, 0x10 and 0x14 from the CS base)
for the irq controllers and then registered new irqs in a device_initcall.
I replaced this with an ioremap of a 16mb area and moved irq registration to
a subsys_initcall.

As I said, the oops appeared with 2.6.30 when I added support for the
TSC2007; for this I introduced yet another ioremap() for offset 0x10 (in
code unrelated to the irq stuff) for the pen-down callback.

I'm going to try Kevin's suggestion if it turns out that this whole ordeal
is not completely my own fault (which I assume it is).

Thank you,
	Manuel Lauss
