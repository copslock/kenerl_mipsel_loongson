Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 10:48:27 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.198]:55678 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133510AbWBMKsS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 10:48:18 +0000
Received: by nproxy.gmail.com with SMTP id y25so216185nfb
        for <linux-mips@linux-mips.org>; Mon, 13 Feb 2006 02:54:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nhbqPXjcV4lAEJD5BSV/FD7DASA1WTN87hGlPNI7xcmyNmr72jvXj45OjKtBgUDdyK6Yrhz8sX1fmS1KPyH4rsp2N7ENqdqKDJA+r6ilEqMgD2tKAfzy3/2ITaNUUG6Bl3pYta0YpU+tmSL3R3v8Zds6LuQK2mNqob1abQEo5Vo=
Received: by 10.48.157.5 with SMTP id f5mr759101nfe;
        Mon, 13 Feb 2006 02:54:33 -0800 (PST)
Received: by 10.48.49.10 with HTTP; Mon, 13 Feb 2006 02:54:33 -0800 (PST)
Message-ID: <58cb370e0602130254ga67a53cu32e54f5bf8e71bb7@mail.gmail.com>
Date:	Mon, 13 Feb 2006 11:54:33 +0100
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: [PATCH] Enable MwDMA for AU1200 IDE driver
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	enrico.walther@amd.com
In-Reply-To: <20060210182033.GA24353@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060210182033.GA24353@cosmic.amd.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 2/10/06, Jordan Crouse <jordan.crouse@amd.com> wrote:
> Greetings all - the attached patch enables MwDMA mode for the AU1200
> IDE driver.  If one heavily uses the USB on the DB1200 board with IDE
> in PIO mode, you may experience hangs from overloading the bus with
> interrupts - this should help.  Since it is obvious that this is the
> desired mode, I'm adding it to the defconfig to enable by default.
>
> Also, I snuck in a fix for a warning (mixed code and declarations = evil!).

if this refers to drive_list_entry - it is fixed in Linus' tree

> Applies against latest lmo git, but it should work for linux-ide as well.

> [PATCH] Enable MWDMA mode for the AU1200 IDE driver
>
> This enables MwDMA mode for the AU1200 driver - this will benefit
> anybody using IDE + USB, which together seem to cause hangs when IDE is
> in PIO due to the large number of interrupts on the same bus.

ide-au1xxx driver enables IRQ unmasking unconditionally,
could it be that hardware actually needs IRQs to be masked
during PIO transfers?

> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> ---
>
>  arch/mips/configs/db1200_defconfig        |    4 ++--
>  drivers/ide/mips/au1xxx-ide.c             |   14 ++++++++++++--
>  include/asm-mips/mach-au1x00/au1xxx_ide.h |    9 ---------
>  3 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
> index 9288847..355b32f 100644
> --- a/arch/mips/configs/db1200_defconfig
> +++ b/arch/mips/configs/db1200_defconfig
> @@ -497,8 +497,8 @@ CONFIG_BLK_DEV_IDECS=m
>  #
>  CONFIG_IDE_GENERIC=y
>  CONFIG_BLK_DEV_IDE_AU1XXX=y
> -CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA=y
> -# CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA is not set
> +#CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA is not set
> +CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA=y
>  CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ=128
>  # CONFIG_IDE_ARM is not set
>  # CONFIG_BLK_DEV_IDEDMA is not set
> diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-ide.c
> index 32431dc..c2bf766 100644
> --- a/drivers/ide/mips/au1xxx-ide.c
> +++ b/drivers/ide/mips/au1xxx-ide.c
> @@ -652,6 +652,7 @@ static int au_ide_probe(struct device *d
>         struct platform_device *pdev = to_platform_device(dev);
>         _auide_hwif *ahwif = &auide_hwif;
>         ide_hwif_t *hwif;
> +       hw_regs_t *hw;
>         struct resource *res;
>         int ret = 0;
>
> @@ -690,17 +691,26 @@ static int au_ide_probe(struct device *d
>         /* FIXME:  This might possibly break PCMCIA IDE devices */
>
>         hwif                            = &ide_hwifs[pdev->id];
> -       hw_regs_t *hw                   = &hwif->hw;
> +       hw                              = &hwif->hw;
>         hwif->irq = hw->irq             = ahwif->irq;
>         hwif->chipset                   = ide_au1xxx;
>
>         auide_setup_ports(hw, ahwif);
>         memcpy(hwif->io_ports, hw->io_ports, sizeof(hwif->io_ports));
>
> +#ifdef CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
> +       hwif->rqsize = CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ;
> +       hwif->rqsize = ((hwif->rqsize > AU1XXX_ATA_RQSIZE)
> +                       || (hwif->rqsize < 32))
> +                        ? AU1XXX_ATA_RQSIZE : hwif->rqsize;
> +#else /* if kernel config is not set */
> +       hwif->rqsize                    = AU1XXX_ATA_RQSIZE;
> +#endif
> +

Patch description says nothing about this change...

NAK.  Please don't re-introduce
CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ.

Either this controller works reliably with rqsize > 32 or not.

>         hwif->ultra_mask                = 0x0;  /* Disable Ultra DMA */
>  #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
>         hwif->mwdma_mask                = 0x07; /* Multimode-2 DMA  */
> -       hwif->swdma_mask                = 0x00;
> +       hwif->swdma_mask                = 0x07;

Also not mentioned in the patch description.
I don't see any code in the driver to handle SWDMA?

Thanks,
Bartlomiej
