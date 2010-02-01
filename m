Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 23:37:45 +0100 (CET)
Received: from kroah.org ([198.145.64.141]:59963 "EHLO coco.kroah.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492746Ab0BAWhl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2010 23:37:41 +0100
Received: from localhost (c-98-246-45-209.hsd1.or.comcast.net [98.246.45.209])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by coco.kroah.org (Postfix) with ESMTPSA id 5181148A11;
        Mon,  1 Feb 2010 14:37:38 -0800 (PST)
Date:   Mon, 1 Feb 2010 14:29:19 -0800
From:   Greg KH <greg@kroah.com>
To:     Wolfram Sang <w.sang@pengutronix.de>
Cc:     Maxime Bizon <mbizon@freebox.fr>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-serial@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] bcm63xx_uart: allow more than one uart to be
 registered.
Message-ID: <20100201222919.GD19294@kroah.com>
References: <1264873377-28479-1-git-send-email-mbizon@freebox.fr>
 <1264873377-28479-3-git-send-email-mbizon@freebox.fr>
 <20100130182343.GA6971@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100130182343.GA6971@pengutronix.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips

On Sat, Jan 30, 2010 at 07:23:43PM +0100, Wolfram Sang wrote:
> On Sat, Jan 30, 2010 at 06:42:57PM +0100, Maxime Bizon wrote:
> > The bcm6358 CPU has two uarts, make it possible to use the second one.
> > 
> > Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> > ---
> >  drivers/serial/bcm63xx_uart.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/serial/bcm63xx_uart.c b/drivers/serial/bcm63xx_uart.c
> > index f78ede8..6ab959a 100644
> > --- a/drivers/serial/bcm63xx_uart.c
> > +++ b/drivers/serial/bcm63xx_uart.c
> > @@ -35,7 +35,7 @@
> >  #include <bcm63xx_regs.h>
> >  #include <bcm63xx_io.h>
> >  
> > -#define BCM63XX_NR_UARTS	1
> > +#define BCM63XX_NR_UARTS	2
> >  
> >  static struct uart_port ports[BCM63XX_NR_UARTS];
> >  
> > @@ -784,7 +784,7 @@ static struct uart_driver bcm_uart_driver = {
> >  	.dev_name	= "ttyS",
> >  	.major		= TTY_MAJOR,
> >  	.minor		= 64,
> > -	.nr		= 1,
> > +	.nr		= 2,
> 
> Err, why not using the #define here?

Good idea, I've tweaked the patch to do that.

thanks,

greg k-h
