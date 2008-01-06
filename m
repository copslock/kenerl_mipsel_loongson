Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jan 2008 11:38:56 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:19084 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20024325AbYAFLir (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 6 Jan 2008 11:38:47 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JBTpx-0000Fk-00; Sun, 06 Jan 2008 12:38:41 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 06D50DE4E5; Sun,  6 Jan 2008 12:38:16 +0100 (CET)
Date:	Sun, 6 Jan 2008 12:38:16 +0100
To:	David Miller <davem@davemloft.net>
Cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, jgarzik@pobox.com
Subject: Re: [PATCH] METH: fix MAC address handling
Message-ID: <20080106113815.GA6140@alpha.franken.de>
References: <20080105224842.78EDCC2EFB@solo.franken.de> <20080106.002305.99653155.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080106.002305.99653155.davem@davemloft.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Jan 06, 2008 at 12:23:05AM -0800, David Miller wrote:
> > +	u64 macaddr;
> >  
> > -	for (i = 0; i < 6; i++)
> > -		dev->dev_addr[i] = o2meth_eaddr[i];
> >  	DPRINTK("Loading MAC Address: %s\n", print_mac(mac, dev->dev_addr));
> > -	mace->eth.mac_addr = (*(unsigned long*)o2meth_eaddr) >> 16;
> > +	macaddr = 0;
> > +	for (i = 0; i < 6; i++)
> > +		macaddr |= dev->dev_addr[i] << ((5 - i) * 8);
> > +
> > +	mace->eth.mac_addr = macaddr;
> >  }
> >  
> >  /*
> 
> Can you double-check that this conversion is equivalent.

yes, I did.

> I know that this whole driver is full of assumptions about
> the endianness of the system this chip is found on, so
> I'm only interested in if the transformation is equivalent
> and the driver will keep working properly.

I've tested the driver and it's still working :-)

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
