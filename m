Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2008 16:32:21 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:5373 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20092294AbYIJPcT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Sep 2008 16:32:19 +0100
Received: from localhost (p1216-ipad302funabasi.chiba.ocn.ne.jp [123.217.139.216])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 74DB9B3B8; Thu, 11 Sep 2008 00:32:14 +0900 (JST)
Date:	Thu, 11 Sep 2008 00:32:22 +0900 (JST)
Message-Id: <20080911.003222.51867360.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48C6B768.4010200@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<48C6B768.4010200@ru.mvista.com>
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
X-archive-position: 20442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 09 Sep 2008 21:50:32 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +static void tx4939ide_set_mode(ide_drive_t *drive, const u8 speed)
> > +{
> > +	ide_hwif_t *hwif = HWIF(drive);
> > +	unsigned long base = TX4939IDE_BASE(hwif);
> > +	int is_slave = drive->dn & 1;
> > +	u16 value;
> > +	int safe_speed = speed;
> > +	int i;
> > +
> > +	for (i = 0; i < MAX_DRIVES; i++) {
> 
>     Use ide_get_paired_drive() ISO this loop.

Thanks.  That's what I needed.

> > +		if (drive != &hwif->drives[i] &&
> > +		    (hwif->drives[i].dev_flags & IDE_DFLAG_PRESENT))
> > +			safe_speed = min(safe_speed,
> > +					 (int)hwif->drives[i].current_speed);
> 
>     You shouldn't clamp the command PIO mode timings like this, and shouldn't 
> do it at all when DMA mode is set. Call ide_get_best_pio_mode(255, 4) to get 
> the mate drive's fastest PIO mode which should be a clamping value.
> 
> > +	/* Command Transfer Mode Select */
> > +	switch (safe_speed) {
> > +	case XFER_UDMA_5:
> > +	case XFER_UDMA_4:
> > +	case XFER_UDMA_3:
> > +	case XFER_UDMA_2:
> > +	case XFER_UDMA_1:
> > +	case XFER_UDMA_0:
> > +	case XFER_MW_DMA_2:
> 
>     You shouldn't change the command PIO mode when DMA mode is selected.

But the "Command Transfer Mode Select" bits affects access timings on
setting task registers for DMA command.  Hmm... do you mean I should
not do it _here_?

> > +	case XFER_MW_DMA_1:
> > +	case XFER_MW_DMA_0:
> > +	case XFER_PIO_4:
> 
>     MWDMA0/1 timings don't match PIO4, they are [much] slower.

Oh thanks.  I will fix it.

> > +		hwif->select_data =
> > +			(hwif->select_data & ~0xffff0000) | (value << 16);
> 
>     Why not just 0x0000ffff?
> 
> > +	else
> > +		hwif->select_data = (hwif->select_data & ~0x0000ffff) | value;
> 
>     Why not just 0xffff0000?

Indeed.

> > +static void tx4939ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
> > +{
> > +	tx4939ide_set_mode(drive, XFER_PIO_0 + pio);
> > +}
> 
>     I suggest that you implement tx4939ide_set_{dma|pio}_mode() as seperate 
> functions, possibly using a common function to do a final part. These 2 
> methods are quite different functionally.
> 
> > +static int tx4939ide_dma_setup(ide_drive_t *drive)
> > +{
> > +	ide_hwif_t *hwif = HWIF(drive);
> > +	unsigned long base = TX4939IDE_BASE(hwif);
> > +	int is_slave = drive->dn & 1;
> > +	unsigned int nframes;
> > +	int rc, i;
> > +	unsigned int sect_size = queue_hardsect_size(drive->queue);
> > +	u16 select_data;
> > +
> > +	select_data = (hwif->select_data >> (is_slave ? 16 : 0)) & 0xffff;
> > +	TX4939IDE_writew(select_data, base, Sys_Ctl);
> 
>     Unfortunately, programming the timings from the dma_setup() method isn't 
> enough since it won't be called for PIO transfers.  You'll have to use the 
> selectproc() method.

Thanks.  I should rework whole timing setup code.

---
Atsushi Nemoto
