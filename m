Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 18:18:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:26270 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023345AbXIYRSY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 18:18:24 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8PHINHd011722;
	Tue, 25 Sep 2007 18:18:23 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8PHINs4011721;
	Tue, 25 Sep 2007 18:18:23 +0100
Date:	Tue, 25 Sep 2007 18:18:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	linux-mips@linux-mips.org, blogic@openwrt.org, nbd@openwrt.org
Subject: Re: [PATCH 2/3] Au1000 : fix PCI controller registration
Message-ID: <20070925171823.GA11640@linux-mips.org>
References: <200709251707.29067.florian.fainelli@telecomint.eu> <20070925171119.GA11350@linux-mips.org> <200709251917.15431.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709251917.15431.florian.fainelli@telecomint.eu>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 25, 2007 at 07:17:10PM +0200, Florian Fainelli wrote:

> > >  #define IOPORT_RESOURCE_START 0x00001000 /* skip legacy probing */
> > > -#define IOPORT_RESOURCE_END   0xffffffff
> > > +#define IOPORT_RESOURCE_END   0xfffffffffULL
> >
> > So you're saying that PCI has just under 64GB worth of ioport address space
> > on Alchemy?  That's not how I recall my PCI spec ...
> 
> Errm, no, actually, Alchemy has a 36bits PCI adressing mode if I recall right.

Nope.  IOspace is max. 4GB with PCI, even on 64-bit PCI.

  Ralf
