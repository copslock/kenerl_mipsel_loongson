Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B88VRw016464
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 01:08:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B88VaM016463
	for linux-mips-outgoing; Thu, 11 Jul 2002 01:08:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from elvis.franken.de (mail@dns.franken.de [193.175.24.33])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B88NRw016454;
	Thu, 11 Jul 2002 01:08:24 -0700
Received: from tsbogend by elvis.franken.de with local (Exim 3.22 #1)
	id 17SZ47-0003wd-00; Thu, 11 Jul 2002 10:12:43 +0200
Date: Thu, 11 Jul 2002 10:12:43 +0200
From: Thomas Bogendoerfer <tsbogend@elvis.franken.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@oss.sgi.com>, marcelo@conectiva.com.br
Subject: Re: [2.4 PATCH] pcnet32.c - tx underflow error
Message-ID: <20020711081243.GA14912@elvis.franken.de>
Reply-To: tsbogend@alpha.franken.de
References: <3D2CCC83.6090304@mvista.com> <E17STUx-0008LR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17STUx-0008LR-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 11, 2002 at 03:16:03AM +0100, Alan Cox wrote:
> > I even suspect this is the default setting on PCI cards on PC.  Can someone 
> > verify?  If that is the case, that will explain why driver never sets this 
> > bit.  Maybe we don't have any "real computers" after all. :-)
> 
> Most PC hardware can deliver that kind of DMA guarantee. UDMA100 doesn't
> work very well otherwise.

I've seen this problem on a lot of PC hardware, too. The best fix would
be to enable full packet mode, when the driver sees too much TX underruns.

Thomas.
