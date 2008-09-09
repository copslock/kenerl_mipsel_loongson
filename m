Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Sep 2008 17:45:17 +0100 (BST)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46547 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S32707080AbYIIQpO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Sep 2008 17:45:14 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id m89GixX1002302;
	Tue, 9 Sep 2008 17:44:59 +0100
Date:	Tue, 9 Sep 2008 17:44:59 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Message-ID: <20080909174459.2aa9808a@lxorguk.ukuu.org.uk>
In-Reply-To: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.11; x86_64-redhat-linux-gnu)
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
X-archive-position: 20422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/port_ops routines.

It would probably be a lot cleaner using the libata framework, and also
go obsolete less soon.

> +#define TX4939IDE_readl(base, reg) \
> +	__raw_readl((void __iomem *)((base) + TX4939IDE_REG32(reg)))
> +#define TX4939IDE_readw(base, reg) \
> +	__raw_readw((void __iomem *)((base) + TX4939IDE_REG16(reg)))
> +#define TX4939IDE_readb(base, reg) \
> +	__raw_readb((void __iomem *)((base) + TX4939IDE_REG8(reg)))
> +#define TX4939IDE_writel(val, base, reg) \
> +	__raw_writel(val, (void __iomem *)((base) + TX4939IDE_REG32(reg)))
> +#define TX4939IDE_writew(val, base, reg) \
> +	__raw_writew(val, (void __iomem *)((base) + TX4939IDE_REG16(reg)))
> +#define TX4939IDE_writeb(val, base, reg) \
> +	__raw_writeb(val, (void __iomem *)((base) + TX4939IDE_REG8(reg)))

It's generally frowned upon to hide all the detail in macros, it is much
easier to read and understand the code if you don't do this.

> +#define TX4939IDE_BASE(hwif)	((hwif)->io_ports.data_addr & ~0xfff)

Why do you have void __iomem casts all over the write methods not in the
_BASE() method - that would let sparse do its job properly

> +	for (i = 0; i < MAX_DRIVES; i++) {
> +		if (drive != &hwif->drives[i] &&

You don't actually need the first test. This also appears wrong. In your
tests MW_DMA_0 is 'faster' than PIO4 but in fact MW_DMA_0 PIO timings are
*slower* than PIO4 so the mode is not in fact slower.

> +	case XFER_MW_DMA_2:
> +	case XFER_MW_DMA_1:
> +	case XFER_MW_DMA_0:
> +	case XFER_PIO_4:
> +		value |= 0x0400;
> +		break;

This looks odd according to the speed tables. Can you clarify what is
going on ?

> +#ifdef __BIG_ENDIAN
> +	{
> +		unsigned int *table = hwif->dmatable_cpu;
> +		while (1) {
> +			cpu_to_le64s((u64 *)table);
> +			if (*table & 0x80000000)
> +				break;

You modify the table but you never ensure the data is not still in
temporary variables from the compiler or flushed from cache
