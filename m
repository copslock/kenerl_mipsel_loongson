Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 07:57:49 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53617 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021705AbZEVG5m (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 May 2009 07:57:42 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4M6vROc013899;
	Fri, 22 May 2009 07:57:27 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4M6vQ2c013894;
	Fri, 22 May 2009 07:57:26 +0100
Date:	Fri, 22 May 2009 07:57:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] rb532: check irq number when handling GPIO
	interrupts
Message-ID: <20090522065726.GB12444@linux-mips.org>
References: <200905211949.47486.florian@openwrt.org> <4A15A2DD.2000203@ru.mvista.com> <200905220703.28939.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200905220703.28939.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 22, 2009 at 07:03:28AM +0200, Florian Fainelli wrote:

> That's actually 14, numbering starting from 0, I should learn how to count. 
> Ralf, do you want me to resubmit that one with the proper message / 
> descriptions ?
> 
> >
> > >  			rb532_gpio_set_istat(0, irq_nr - GPIO_MAPPED_IRQ_BASE);
> > >
> > >  		/*
> > > @@ -174,7 +175,7 @@ static int rb532_set_type(unsigned int irq_nr,
> > > unsigned type) int gpio = irq_nr - GPIO_MAPPED_IRQ_BASE;
> > >  	int group = irq_to_group(irq_nr);
> > >
> > > -	if (group != GPIO_MAPPED_IRQ_GROUP)
> > > +	if (group != GPIO_MAPPED_IRQ_GROUP || irq_nr > (GROUP4_IRQ_BASE + 13))
> >
> >     ... and >= here.
> >
> > >  		return (type == IRQ_TYPE_LEVEL_HIGH) ? 0 : -EINVAL;
> > >
> > >  	switch (type) {

Queued for 2.6.31 with the comment fix and the change from > to >=.

Thanks,

  Ralf
