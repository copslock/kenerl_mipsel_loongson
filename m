Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 14:45:38 +0000 (GMT)
Received: from host153-171-dynamic.9-87-r.retail.telecomitalia.it ([87.9.171.153]:41437
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20032189AbXKGOpa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Nov 2007 14:45:30 +0000
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1Ipm6h-0008F3-Ol
	for linux-mips@linux-mips.org; Wed, 07 Nov 2007 15:42:17 +0100
Subject: Re: Preliminary patch for ip32 ttyS* device
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	mips kernel list <linux-mips@linux-mips.org>
In-Reply-To: <20071031130828.GE14187@linux-mips.org>
References: <20071030214015.050b7950.giuseppe@eppesuigoccas.homedns.org>
	 <20071031130828.GE14187@linux-mips.org>
Content-Type: text/plain
Date:	Wed, 07 Nov 2007 15:43:05 +0100
Message-Id: <1194446585.5849.21.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mer, 31/10/2007 alle 13.08 +0000, Ralf Baechle ha scritto:
[...]
> > diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
> > index 3bb5d24..7caa877 100644
> > --- a/drivers/serial/serial_core.c
> > +++ b/drivers/serial/serial_core.c
> > @@ -2455,6 +2455,8 @@ int uart_match_port(struct uart_port *port1, struct uart_port *port2)
> >  	case UPIO_AU:
> >  	case UPIO_TSI:
> >  	case UPIO_DWAPB:
> > +		if (port1->mapbase==0 && port2->mapbase==0)
> > +			return (port1->membase == port2->membase);
> 
> This hack is only needed because ->mapbase is not initialized.

I have been investigating about it for one week and I am still not
convinced that mapbase must be initialised. I tried to understand the
meaning of mapbase and membase, but I am unsure about the value I should
set mapbase to.

I learnt that when specifying mapbase its region would be registered and
reserved using request_mem_region(). Otherwise, if you do not specify
mapbase, the region is not reserved. Apart from reserving the memory
region, mapbase isn't use anymore. Is mapbase mandatory? 

If mapbase isn't mandatory, the second part of my patch is probably
right and fixes a bug.

Bye,
Giuseppe
