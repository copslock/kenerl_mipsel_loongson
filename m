Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 09:54:53 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:64835 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491108Ab1FJHys (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2011 09:54:48 +0200
Received: by wwb17 with SMTP id 17so2062584wwb.24
        for <multiple recipients>; Fri, 10 Jun 2011 00:54:42 -0700 (PDT)
Received: by 10.217.1.212 with SMTP id n62mr7392456wes.25.1307692482323;
        Fri, 10 Jun 2011 00:54:42 -0700 (PDT)
Received: from localhost (cpc3-chap8-2-0-cust205.aztw.cable.virginmedia.com [94.171.253.206])
        by mx.google.com with ESMTPS id e1sm1811429wbh.5.2011.06.10.00.54.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 00:54:41 -0700 (PDT)
Date:   Fri, 10 Jun 2011 08:54:26 +0100
From:   Jamie Iles <jamie@jamieiles.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org,
        Marc St-Jean <bluezzer@gmail.com>,
        Shane McDonald <mcdonald.shane@gmail.com>,
        Anoop P A <anoop.pa@gmail.com>, alan@linux.intel.com
Subject: Re: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct
 accessors
Message-ID: <20110610075426.GM3711@pulham.picochip.com>
References: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
 <20110610035817.GA6740@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110610035817.GA6740@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamie@jamieiles.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8877

On Fri, Jun 10, 2011 at 04:58:17AM +0100, Ralf Baechle wrote:
> On Thu, Jun 09, 2011 at 11:48:45AM +0100, Jamie Iles wrote:
> 
> > Don't pass a pointer to the USR register through the private_data field
> > of the platform data.  This isn't type safe and it's not clear what is
> > happening.  Add the USR offset to serial_reg.h and use an explicit
> > serial_in() to read it with the correct accessor.
> > 
> > Fix up the only in-tree user to not pass anything through private_data.
> > 
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> > ---
> >  arch/mips/pmc-sierra/msp71xx/msp_serial.c |    1 -
> >  drivers/tty/serial/8250.c                 |    3 +--
> >  include/linux/serial_reg.h                |    3 +++
> >  3 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/mips/pmc-sierra/msp71xx/msp_serial.c b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
> > index f726162..5ccfdcc 100644
> > --- a/arch/mips/pmc-sierra/msp71xx/msp_serial.c
> > +++ b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
> > @@ -63,7 +63,6 @@ void __init msp_serial_setup(void)
> >  	up.flags        = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> >  	up.type         = PORT_16550A;
> >  	up.line         = 0;
> > -	up.private_data		= (void*)UART0_STATUS_REG;
> >  	if (early_serial_setup(&up))
> >  		printk(KERN_ERR "Early serial init of port 0 failed\n");
> >  
> > diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
> > index b40f7b9..0596caa 100644
> > --- a/drivers/tty/serial/8250.c
> > +++ b/drivers/tty/serial/8250.c
> > @@ -1666,8 +1666,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
> >  			 * interrupt meaning an LCR write attempt occurred while the
> >  			 * UART was busy. The interrupt must be cleared by reading
> >  			 * the UART status register (USR) and the LCR re-written. */
> > -			unsigned int status;
> > -			status = *(volatile u32 *)up->port.private_data;
> > +			(void)serial_in(up, UART_DWAPB_USR);
> >  			serial_out(up, UART_LCR, up->lcr);
> >  
> >  			handled = 1;
> > diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
> > index c75bda3..abfd8ea 100644
> > --- a/include/linux/serial_reg.h
> > +++ b/include/linux/serial_reg.h
> > @@ -350,6 +350,9 @@
> >  #define UART_OMAP_SYSS		0x16	/* System status register */
> >  #define UART_OMAP_WER		0x17	/* Wake-up enable register */
> >  
> > +/* Extra serial register definitions for the Synopsys DesignWare UART. */
> > +#define UART_DWAPB_USR		0x1F	/* UART status register */
> > +
> >  /*
> >   * These are the definitions for the MDR1 register
> >   */
> 
> NAck.
> 
> The original read access was for a read access at offset 0xc0 from the
> base address.  Your patch changes this to offset 0x1f * 4 = 0x7c.
> 
> If you look at arch/mips/include/asm/pmc-sierra/msp71xx/msp_regs.h there's
> 
> #define MSP_UART0_BASE          (MSP_SLP_BASE + 0x100)
>                                         /* UART0 controller base        */
> #define MSP_BCPY_CTRL_BASE      (MSP_SLP_BASE + 0x120)
>                                         /* Block Copy controller base   */
> 
> So there are just 0x20 of address space reserved for that UART.  Me thinks
> that PMC-Sierra clamped the 256 byte address space of the DesignWare APB
> UART to what is standard for 16550 class UARTs, 8 registers which at a
> shift of 4 is 0x20 bytes and the status register being accesses is really
> something else.  I'd guess PMC-Sierra just remapped the register to
> another address.

Ahh, yes.  The Synopsys docs put the status reg at 0x7C.  I hadn't 
twigged that it wasn't the same for the PMC-Sierra.  I guess that's why 
it wasn't done this way before.

> A more proper cleanup would probably be passing something like
> 
> struct serial_private {
> 	void (*dw_abp_int_callback)(void);
> 	unsigned long private;
> };
> 
> then in the 8250 interrupt handler something like:
> 
>                 } else if ((up->port.iotype == UPIO_DWAPB ||
>                             up->port.iotype == UPIO_DWAPB32) &&
>                           (iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
> 			struct serial_private *sp;
> 
> 			sp = (void *) up->port.private_data;
> 			if (sp->dw_abp_int_callback)
> 				sp->dw_abp_int_callback(sp->private);
>                         serial_out(up, UART_LCR, up->lcr);
> 
>                         handled = 1;
> 
>                         end = NULL;
> 		}
> 
> On a 2nd thought I wonder if the restricted address space of the PMC-Sierra
> variant and the strange remapping would justify treating it as a subvariant
> of the DW APB UART, rename it to UPIO_PMC_MSP_DWAPB, hardcode the access to
> the remapped status register.  And get rid of the unused UPIO_DWAPB32 ...

Hmm, I'm not sure what the best option is there.  With regards to 
UPIO_DWAPB32 it's used in several of our devices what I'm trying to 
mainline at the moment so I'd like to come up with something that works 
for both.

I found this series from Alan 
(http://www.spinics.net/lists/linux-serial/msg03484.html) which looks 
like it would do the job if we added the extra irq callback.  Ideally we 
just remove both of the UPIO_DWAPB and UPIO_DWAPB32 and let the platform 
specify the ops.

Jamie
