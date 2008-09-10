Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2008 16:06:51 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:28379 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20087612AbYIJPGr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Sep 2008 16:06:47 +0100
Received: from localhost (p1216-ipad302funabasi.chiba.ocn.ne.jp [123.217.139.216])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6BBC9B3B8; Thu, 11 Sep 2008 00:06:41 +0900 (JST)
Date:	Thu, 11 Sep 2008 00:06:49 +0900 (JST)
Message-Id: <20080911.000649.39154743.anemo@mba.ocn.ne.jp>
To:	alan@lxorguk.ukuu.org.uk
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080909174459.2aa9808a@lxorguk.ukuu.org.uk>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<20080909174459.2aa9808a@lxorguk.ukuu.org.uk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 9 Sep 2008 17:44:59 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > command/status registers, but the register layout is swapped on big
> > endian.  There are some other endian issue and some special registers
> > which requires many custom dma_ops/port_ops routines.
> 
> It would probably be a lot cleaner using the libata framework, and also
> go obsolete less soon.

Yes, that's future plan.

> > +#define TX4939IDE_writeb(val, base, reg) \
> > +	__raw_writeb(val, (void __iomem *)((base) + TX4939IDE_REG8(reg)))
> 
> It's generally frowned upon to hide all the detail in macros, it is much
> easier to read and understand the code if you don't do this.

OK, I'll try to make much readble.

> > +#define TX4939IDE_BASE(hwif)	((hwif)->io_ports.data_addr & ~0xfff)
> 
> Why do you have void __iomem casts all over the write methods not in the
> _BASE() method - that would let sparse do its job properly

Indeed. I'll do it.

> > +	for (i = 0; i < MAX_DRIVES; i++) {
> > +		if (drive != &hwif->drives[i] &&
> 
> You don't actually need the first test. This also appears wrong. In your
> tests MW_DMA_0 is 'faster' than PIO4 but in fact MW_DMA_0 PIO timings are
> *slower* than PIO4 so the mode is not in fact slower.
> 
> > +	case XFER_MW_DMA_2:
> > +	case XFER_MW_DMA_1:
> > +	case XFER_MW_DMA_0:
> > +	case XFER_PIO_4:
> > +		value |= 0x0400;
> > +		break;
> 
> This looks odd according to the speed tables. Can you clarify what is
> going on ?

As you and Sergei pointed out, the code seems somewhat broken.  I'll
rework on it.

> > +#ifdef __BIG_ENDIAN
> > +	{
> > +		unsigned int *table = hwif->dmatable_cpu;
> > +		while (1) {
> > +			cpu_to_le64s((u64 *)table);
> > +			if (*table & 0x80000000)
> > +				break;
> 
> You modify the table but you never ensure the data is not still in
> temporary variables from the compiler or flushed from cache

The dmatable_cpu is allocated by pci_alloc_consistent so that flush is
not needed.  But... this is not PCI device.  I should not use
ide_allocate_dma_engine().  I'll fix it.

Thank you for review.
---
Atsushi Nemoto
