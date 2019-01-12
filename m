Return-Path: <SRS0=GeJD=PU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CDFC43387
	for <linux-mips@archiver.kernel.org>; Sat, 12 Jan 2019 15:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA44620836
	for <linux-mips@archiver.kernel.org>; Sat, 12 Jan 2019 15:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbfALP0N (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:26:13 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:52648 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfALP0N (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 12 Jan 2019 10:26:13 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-101-80-nat.elisa-mobile.fi [85.76.101.80])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 0E0B540059;
        Sat, 12 Jan 2019 17:26:09 +0200 (EET)
Date:   Sat, 12 Jan 2019 17:26:09 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: Loongson 2F IDE/ATA broken with lemote2f_defconfig
Message-ID: <20190112152609.GE22416@darkstar.musicnaut.iki.fi>
References: <20190106124607.GK27785@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106124607.GK27785@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Sun, Jan 06, 2019 at 02:46:07PM +0200, Aaro Koskinen wrote:
> Commit 7ff7a5b1bfff ("MIPS: lemote2f_defconfig: Convert to use libata
> PATA drivers") switched from IDE to libata PATA on Loongson 2F, but
> neither PATA_AMD or PATA_CS5536 work well on this platform compared
> to the AMD74XX IDE driver.
> 
> During the ATA init/probe there is interrupt storm from irq 14, and
> majority of system boots end up with "nobody cared... IRQ disabled".
> So the result is a very slow disk access.
> 
> It seems that the interrupt gets crazy after the port freeze done early
> during the init, and for whatever reason it cannot be cleared.
> 
> With the below workaround I was able to boot the system normally. I
> guess that rather than going back to old IDE driver, we should just try
> to make pata_cs5536 work (and forget PATA AMD on this board)...?

Hmm, even with this hack I get ~500 spurious IRQs during the boot.

Also compared to old IDE, there's 33 vs 100 speed difference:

[    3.324000] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4ce0 irq 14
[    3.584000] ata1.00: ATA-8: WDC WD1600BEVS-00VAT0, 11.01A11, max UDMA/133
[    3.588000] ata1.00: 312581808 sectors, multi 16: LBA48
[    3.592000] ata1.00: limited to UDMA/33 due to 40-wire cable

[    4.540000] Probing IDE interface ide0...
[    4.992000] hda: WDC WD1600BEVS-00VAT0, ATA DISK drive
[    5.716000] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    5.716000] hda: UDMA/100 mode selected

A.

> diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
> index dc1255294628..71e485547ee8 100644
> --- a/drivers/ata/pata_cs5536.c
> +++ b/drivers/ata/pata_cs5536.c
> @@ -229,6 +229,16 @@ static void cs5536_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  	cs5536_write(pdev, ETC, etc);
>  }
>  
> +static void cs5536_noop_freeze(struct ata_port *ap)
> +{
> +	/*
> +	 * Some CS5536 controllers result in a screaming interrupt if ATA_NIEN
> +	 * is manipulated. Leave it alone and just clear pending IRQ.
> +	 */
> +	ap->ops->sff_check_status(ap);
> +	ata_bmdma_irq_clear(ap);
> +}
> +
>  static struct scsi_host_template cs5536_sht = {
>  	ATA_BMDMA_SHT(DRV_NAME),
>  };
> @@ -238,6 +248,7 @@ static struct ata_port_operations cs5536_port_ops = {
>  	.cable_detect		= cs5536_cable_detect,
>  	.set_piomode		= cs5536_set_piomode,
>  	.set_dmamode		= cs5536_set_dmamode,
> +	.freeze			= cs5536_noop_freeze,
>  };
>  
>  /**
