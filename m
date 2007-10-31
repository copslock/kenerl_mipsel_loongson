Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 14:59:06 +0000 (GMT)
Received: from host148-217-dynamic.16-79-r.retail.telecomitalia.it ([79.16.217.148]:61380
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S28575956AbXJaO66 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2007 14:58:58 +0000
Received: from 89-96-243-184.ip14.fastwebnet.it ([89.96.243.184] helo=[192.168.215.30])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1InF1x-000358-Jz
	for linux-mips@linux-mips.org; Wed, 31 Oct 2007 15:58:55 +0100
Subject: Re: Preliminary patch for ip32 ttyS* device
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	mips kernel list <linux-mips@linux-mips.org>
In-Reply-To: <20071031130828.GE14187@linux-mips.org>
References: <20071030214015.050b7950.giuseppe@eppesuigoccas.homedns.org>
	 <20071031130828.GE14187@linux-mips.org>
Content-Type: text/plain
Date:	Wed, 31 Oct 2007 15:59:26 +0100
Message-Id: <1193842766.16429.7.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mer, 31/10/2007 alle 13.08 +0000, Ralf Baechle ha scritto:
> On Tue, Oct 30, 2007 at 09:40:15PM +0100, Giuseppe Sacco wrote:
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

Right, for a few days I tried to correctly initialise mapbase and
setting UPF_IOREMAP in order to let this code calculate membase:

up->port.membase = ioremap(up->port.mapbase, size);

(drivers/serial/8250.c, function serial8250_request_std_resource)

but maybe we can just leave mapbase == 0 and change uart_match_port() as
in my patch.

Any other option?
