Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2LJIPG08639
	for linux-mips-outgoing; Thu, 21 Mar 2002 11:18:25 -0800
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2LJILq08635
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 11:18:21 -0800
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id SAA16066;
	Thu, 21 Mar 2002 18:29:34 -0800
Subject: Re: pci-pcmcia bridges/adapters
From: Pete Popov <ppopov@mvista.com>
To: sjhill@cotw.com
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <3C9A15AA.304AE304@cotw.com>
References: <1016683254.4951.168.camel@zeus>  <3C9A15AA.304AE304@cotw.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 21 Mar 2002 10:22:43 -0800
Message-Id: <1016734963.24217.31.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2002-03-21 at 09:17, Steven J. Hill wrote:
> Pete Popov wrote:
> > 
> > Has anyone gotten a pci-pcmcia adapter card to work with any 16 bit
> > pcmcia card in it on mips linux?
> > 
> Your first priority should be to look at the main PCMCIA page for
> Linux and find a PCI adapter that has a supported chipset, otherwise
> you are wasting your time. I bought a PCI->PCMCIA adapter from LinkSys
> for one of my wireless cards and the driver never worked, so my
> experience has not been good. 

I don't really have a choice in adapters, but the one that I'm working
with, Ricoh R5C478 is supported just fine by the yenta driver.  The card
I'm trying to get to work is a 16 bit wireless card based on the prismII
chipset. The card by itself works fine in another mips board for which I
wrote a socket driver.  But I'm having a hell of a time with the
pci-pcmcia bridge _and_ the card behind it.  Attribute memory accesses
do work -- they get passed to the card by the bridge and the card is
recognized. But the ExCA register definition, which the bridge must
support, allows for this "Optional memory window x upper byte of start
address".  It is this optional register that allows me to setup the 32
bit pci memory address. The IO windows registers, on the other hand,
allow you to setup 16 bit addresses only.  So I can't figure out how I
can put a 32 bit pci address on the bus, and have the bridge forward
that address to the 16 bit pcmcia card.

If there's any experts in this field, I would appreciate some input.

Pete
