Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BFv1Rw007233
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 08:57:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BFv1Yc007230
	for linux-mips-outgoing; Thu, 11 Jul 2002 08:57:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft18-f21.dialo.tiscali.de [62.246.18.21])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BFusRw007172
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 08:56:55 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6BBjnt11932;
	Thu, 11 Jul 2002 13:45:49 +0200
Date: Thu, 11 Jul 2002 13:45:49 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Kevin D. Kissell" <kevink@mips.com>, "H. J. Lu" <hjl@lucon.org>,
   Jun Sun <jsun@mvista.com>, Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: Malta crashes on the latest 2.4 kernel
Message-ID: <20020711134549.B11700@dea.linux-mips.net>
References: <005c01c228a2$fb2bf450$10eca8c0@grendel> <Pine.GSO.4.21.0207110854250.8371-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0207110854250.8371-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Thu, Jul 11, 2002 at 08:56:17AM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 11, 2002 at 08:56:17AM +0200, Geert Uytterhoeven wrote:

> On Thu, 11 Jul 2002, Kevin D. Kissell wrote:
> > I note that Ralf has, in fact, applied the fix to the
> > OSS CVS repository.  I also note that "BARRIER"
> > is still defined to be a string of 6 nops.  I would argue
> > (again) that those really, really ought to be ssnops,
> > and that if they *were* ssnops, one could probably
> > have fewer of them.
> 
> Sorry for being ignorant, but what's the difference between nop and ssnop?
> 
> I see that SSNOP is defined to be `sll zero,zero,1' in <asm/asm.h>, but that
> doesn't give me any clue.

Ssnop is a superscalar nop.  It's instruction encoding is the same as of
sll, zero, zero, 1.  Unlike a normal nop a ssnop is guaranteed to single
issue even on superscalar implementations.

  Ralf
