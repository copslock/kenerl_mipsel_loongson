Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 10:21:42 +0000 (GMT)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55996 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S23813052AbYKUKV1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Nov 2008 10:21:27 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mALALcHv007647;
	Fri, 21 Nov 2008 10:21:38 GMT
Date:	Fri, 21 Nov 2008 10:21:37 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash
 interface.
Message-ID: <20081121102137.634616c5@lxorguk.ukuu.org.uk>
In-Reply-To: <49261BE5.2010406@caviumnetworks.com>
References: <49261BE5.2010406@caviumnetworks.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; x86_64-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> + * Called to enable the use of DMA based on kernel command line.
> + */
> +void octeon_cf_enable_dma(void)
> +{
> +	use_cf_dma = 1;
> +}

Why not use the standard module parameter interface ?


> +	/*
> +	 * PIO modes 0-4 all allow the device to deassert IORDY to slow down
> +	 * the host.
> +	 */

See ata_timing_compute() which also knows about master/slave timing,
PIO5/6 rules and timing adjustments as well as doing bus clock
quantisations and lengthenings for you.

> +	use_iordy = 1;

This depends on the device as well and gets quite complicated. We have
ata_pio_need_iordy() to do the work for you.

> +	t1 = (t1 * clocks_us) / 1000 / 2;
> +	if (t1)
> +		t1--;

Even if you wanted to do it this way you could just use arrays and lookup
tables as many other drivers do - ie

	pio = dev->pio_mode - XFER_PIO_0;
	t1 = data[pio];


> +	mio_boot_reg_tim.s.wr_hld = t4;

What guarantees the computation results always fit the bit fields. This
is one reason the kerne strongly favours masks - it is a lot easier to
check such things.

> +static void octeon_cf_set_dmamode(struct ata_port *ap, struct ata_device *dev)
> +{

> +	case XFER_MW_DMA_0:
> +		dma_ackh = 20;	/* Tj */
> +		To = 480;
> +		Td = 215;
> +		Tkr = 50;
> +		break;

Same comments apply as to PIO


> +	/*
> +	 * Odd lengths are not supported. We should always be a
> +	 * multiple of 512.
> +	 */
> +	BUG_ON(buflen & 1);

If you get a request for an odd length you should write an extra word
containing the last byte and one other. See how the standard methods
handle this.


> +	if (ocd->is16bit) {

Or you could have two methods and two transfer routines defined

> +			while (words--) {
> +				*(uint16_t *)buffer = ioread16(data_addr);
> +				buffer += sizeof(uint16_t);

By definition tht is 2. Do you have an ioread16_rep ?


> +
> +/**
> + * Get ready for a dma operation.  We do nothing, as all DMA
> + * operations are taken care of in octeon_cf_bmdma_start.
> + */
> +void octeon_cf_qc_prep(struct ata_queued_cmd *qc)
> +{
> +}

ata_noop_qc_prep


> +/**
> + * Check if any queued commands have more DMAs, if so start the next
> + * transfer, else do standard handling.
> + */
> +irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)

A lot of these functions could be static it seems

>
> +static void octeon_cf_delayed_irq(unsigned long data)
> +{

What stops the following occuring

	ATA irq
		BUSY still set
		Queue tasklet

	Other irq on same line
	ATA busy clear
		Handle command

	Tasklet runs but command was sorted out

(or a reset of the ata controller in the gap)

> +	base = cs0 + ocd->base_region_bias;
> +	if (!ocd->is16bit) {

	ata_std_
> +		ap->ioaddr.cmd_addr	= base + ATA_REG_CMD;

ata_sff_std_ports ? (at least for the 8bit case)


Alan
--
	"Alan, I'm getting a bit worried about you."
				-- Linus Torvalds
