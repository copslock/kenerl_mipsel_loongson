Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 23:38:39 +0000 (GMT)
Received: from pD9562327.dip.t-dialin.net ([IPv6:::ffff:217.86.35.39]:52526
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225214AbUKXXia>; Wed, 24 Nov 2004 23:38:30 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAONcPdM026562;
	Thu, 25 Nov 2004 00:38:25 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAONcOAm026561;
	Thu, 25 Nov 2004 00:38:24 +0100
Date: Thu, 25 Nov 2004 00:38:24 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Manish Lachwani <mlachwani@prometheus.mvista.com>
Cc: linux-mips@linux-mips.org, yuasa@hh.iij4u.or.jp
Subject: Re: [PATCH] Support for NEC VR4133 and NEC CMBVR4133 in 2.6
Message-ID: <20041124233824.GA23178@linux-mips.org>
References: <20041119200214.GB25310@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041119200214.GB25310@prometheus.mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 19, 2004 at 12:02:14PM -0800, Manish Lachwani wrote:

The various functions calling ENTER_CONFIG_MODE(port) ...
EXIT_CONFIG_MODE(port) are being called fairly late so you may want to
consider protecting that with a spinlock.

(I don´t have chidocs so I can't say for sure but it was looking suspcious.)

> Index: linux/arch/mips/vr41xx/nec-cmbvr4133/irq.c
> ===================================================================
> --- /dev/null
> +++ linux/arch/mips/vr41xx/nec-cmbvr4133/irq.c
> @@ -0,0 +1,114 @@
> +/*
> + * arch/mips/vr41xx/nec-cmbvr4133/irq.c
> + *
> + * Interrupt routines for the NEC CMB-VR4133 board.
> + *
> + * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
> + *         Alex Sapkov <asapkov@ru.mvista.com>
> + *
> + * 2003-2004 (c) MontaVista, Software, Inc. This file is licensed under

An interesting simiarity to arch/{i386,mips}/kernel/i8259.c.  Except the
copyright messages.

> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + *
> + * Support for NEC-CMBVR4133 in 2.6
> + * Manish Lachwani (mlachwani@mvista.com)
> + */
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/interrupt.h>
> +
> +#include <asm/io.h>
> +#include <asm/vr41xx/cmbvr4133.h>
> +
> +extern void enable_8259A_irq(unsigned int irq);
> +extern void disable_8259A_irq(unsigned int irq);
> +extern void mask_and_ack_8259A(unsigned int irq);
> +extern void init_8259A(int hoge);
> +                                                                                                    
> +extern int vr4133_rockhopper;
> +                                                                                                    
> +static unsigned int startup_i8259_irq(unsigned int irq)
> +{
> +	enable_8259A_irq(irq - I8259_IRQ_BASE);
> +	 return 0;
> +}
> +
> +static void shutdown_i8259_irq(unsigned int irq)
> +{
> +	disable_8259A_irq(irq - I8259_IRQ_BASE);
> +}
> +
> +static void enable_i8259_irq(unsigned int irq)
> +{
> +	enable_8259A_irq(irq - I8259_IRQ_BASE);
> +}
> +
> +static void disable_i8259_irq(unsigned int irq)
> +{
> +	disable_8259A_irq(irq - I8259_IRQ_BASE);
> +}
> +
> +static void ack_i8259_irq(unsigned int irq)
> +{
> +	mask_and_ack_8259A(irq - I8259_IRQ_BASE);
> +}
> +
> +static void end_i8259_irq(unsigned int irq)
> +{
> +	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
> +		enable_8259A_irq(irq - I8259_IRQ_BASE);
> +}
> +
> +static struct hw_interrupt_type i8259_irq_type = {
> +	.typename       = "XT-PIC",
> +	.startup        = startup_i8259_irq,
> +	.shutdown       = shutdown_i8259_irq,
> +	.enable         = enable_i8259_irq,
> +	.disable        = disable_i8259_irq,
> +	.ack            = ack_i8259_irq,
> +	.end            = end_i8259_irq,
> +};
> +
> +static int i8259_get_irq_number(int irq)

Use i8259_irq().

> +	return I8259_IRQ_BASE + irq;

Hmmm..

> #define I8259_IRQ_BASE                 72

Is this the reason why this file that mostly is code duplication exists?

In case any legacy devices could ever be used on this platform you better
assign numbers starting from 0 or you'll have fun with stoneage drivers.

> +config NEC_CMBVR4133
> +	bool "Support for NEC CMB-VR4133"
> +	depends on MACH_VR41XX
> +	select CPU_VR41XX
> +	select DMA_NONCOHERENT
> +	select IRQ_CPU
> +	select HW_HAS_PCI
> +	select PCI_VR41XX
> +
> +config ROCKHOPPER
> +	bool "Support for Rockhopper baseboard"
> +	depends on NEC_CMBVR4133
> +	select I8259
> +	select HAVE_STD_PC_SERIAL_PORT

A short help text would be nice.

> Index: linux/arch/mips/pci/fixup-vr4133.c
> ===================================================================
> --- /dev/null
> +++ linux/arch/mips/pci/fixup-vr4133.c

> +extern int vr4133_rockhopper;
> +extern void ali_m1535plus_init(struct pci_dev *dev);
> +extern void ali_m5229_init(struct pci_dev *dev);
> +
> +/* Do platform specific device initialization at pci_enable_device() time */
> +int pcibios_plat_dev_init(struct pci_dev *dev)
> +{

Why do you configure half the system in this hook?  Alone the pci_dev
argument should already imply that this is really meant to deal with one
device only.  If anything deal with this through some PCI fixup.

> +	/* 
> +	 * we have to open the bridges' windows down to 0 because otherwise
> + 	 * we cannot access ISA south bridge I/O registers that get mapped from
> +	 * 0. for example, 8259 PIC would be unaccessible without that
> +	 */
> +	if(dev->vendor == 0x8086 && dev->device == 0xb152) {

Please use the constants from pci_ids.h.  And if there is none, define one.

> +
> +int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	extern int pci_probe_only;
> +	pci_probe_only = 1;
> +
> +#ifdef CONFIG_ROCKHOPPER
> +	i8259_init();

You're kidding?  This is not a device initalization function.

> +	if( dev->bus->number == 1 && vr4133_rockhopper )  {
> +		if(slot == ROCKHOPPER_PCI1_SLOT || slot == ROCKHOPPER_PCI2_SLOT)
> +			dev->irq = CMBVR41XX_INTA_IRQ;

No.  All pcibios_map_irq is allowed to is returning the interrupt number
of the device.

> +			dev->irq = rockhopper_get_irq(dev, pin, slot);

> +++ linux/include/asm-mips/vr41xx/cmbvr4133.h
> +
> +#include <linux/config.h>

This file does not need config.h

  Ralf
