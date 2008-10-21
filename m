Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2008 18:51:03 +0100 (BST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:33235 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S22031721AbYJURvB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Oct 2008 18:51:01 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id B8245112404F; Tue, 21 Oct 2008 19:51:00 +0200 (CEST)
Subject: Re: [PATCH/RFC v1 10/12] [MIPS] BCM63XX: Add integrated ethernet
	PHY support for phylib.
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Andy Fleming <afleming@freescale.com>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org
In-Reply-To: <B812781E-031F-4A1E-8FDB-E0482F495325@freescale.com>
References: <1224382023-24412-1-git-send-email-mbizon@freebox.fr>
	 <B812781E-031F-4A1E-8FDB-E0482F495325@freescale.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Freebox
Date:	Tue, 21 Oct 2008 19:51:00 +0200
Message-Id: <1224611460.30307.70.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Tue, 2008-10-21 at 12:08 -0500, Andy Fleming wrote:

Hi Andy, thanks for reviewing.

> > +config BCM63XX_PHY
> > +	tristate "Drivers for Broadcom 63xx SOCs internal PHY"
> > +	depends on BCM63XX

> This is probably right, but just to check: These PHYs will never be  
> used outside of the BCM63xx family?

Correct, the PHY is actually inside the SOC.


> > +	/* Mask interrupts globally.  */
> > +	reg |= MII_BCM63XX_IR_GMASK;
> > +	err = phy_write(phydev, MII_BCM63XX_IR, reg);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	/* Unmask events we are interested in  */
> > +	reg = ~(MII_BCM63XX_IR_DUPLEX |
> > +		MII_BCM63XX_IR_SPEED |
> > +		MII_BCM63XX_IR_LINK) |
> > +		MII_BCM63XX_IR_EN;
> 
> You just cleared the global interrupt mask.  I have two problems with  
> that:

That should be '&=' yes, and I could do one write instead of two.

Yet the current code does not clear the global interrupt mask, IR_GMASK
bit is still set, so interrupts are disabled after init.

I will fix that, it seems another bit in this register controls a LED, I
should not force it to 1.


> The other comment I have is that these probably should go in the  
> broadcom.c file.  I'm not deeply tied to the notion of one file per  
> company, but it has become the way it is done.

Ok will do, I just hope the file won't become too big, that would be
quite wasted space since there is no chance to find the other PHYs on
any bcm63xx boards.


Thanks

-- 
Maxime
