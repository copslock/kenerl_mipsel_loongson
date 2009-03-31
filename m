Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 08:52:09 +0100 (BST)
Received: from vervifontaine.sonytel.be ([80.88.33.193]:3495 "EHLO
	vervifontaine.sonycom.com") by ftp.linux-mips.org with ESMTP
	id S20027117AbZCaHwE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 08:52:04 +0100
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id BE29358ADF;
	Tue, 31 Mar 2009 09:51:53 +0200 (MEST)
Date:	Tue, 31 Mar 2009 09:51:53 +0200 (CEST)
From:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:	Grant Grundler <grundler@google.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	IDE/ATA Devel <linux-ide@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	LKML <linux-kernel@google.com>
Subject: Re: [PATCH] linux-next remove wmb() from ide-dma-sff.c and
 scc_pata.c
In-Reply-To: <da824cf30903301739l688e8eb2r46086953245ebbe5@mail.gmail.com>
Message-ID: <alpine.LRH.2.00.0903310950040.9551@vixen.sonytel.be>
References: <da824cf30903301739l688e8eb2r46086953245ebbe5@mail.gmail.com>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Geert.Uytterhoeven@sonycom.com
Precedence: bulk
X-list: linux-mips

On Mon, 30 Mar 2009, Grant Grundler wrote:
> Followup to "[PATCH 03/10] ide: destroy DMA mappings after ending DMA"
> email on March 14th:
>     http://lkml.org/lkml/2009/3/14/17
> 
> No maintainer is listed for "Toshiba CELL Reference Set IDE" (BLK_DEV_CELLEB)
> or tx4939ide.c in MAINTAINERS. I've CC'd "Ishizaki Kou" @Toshiba (Maintainer for
> "Spidernet Network Driver for CELL") and linuxppc-dev list in the hope
> someone else
> would know or would be able to ACK this patch.

tx49xx is MIPS, for Nemoto-san.

> This patch:
> o replaces "mask" variable in ide_dma_end() with #define.
> o removes use of wmb() in ide-dma-sff.c and scc_pata.c.
> o is not tested - I don't have (or want) the HW.
> 
> I did NOT remove wmb() use in tx4939ide.c. tx4939ide.c __raw_writeb()
> for MMIO transactions. __raw_writeb() does NOT guarantee memory
> transaction ordering.
> 
> tx4939ide also uses mmiowb(). AFAIK, mmiowb() only has an effect on
> SGI IA64 NUMA machines. I'm not going to guess how this driver might work.
> 
> Gmail is broken for sending patches (word wrap). My apologies.
> I've attached the patch: diff-next-remove_wmb_from_ide-01.txt
> 
> Patch is against linux-next tree:
>      git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next
> 
> Signed-off-by: Grant Grundler <grundler@google.com>

[ attachment converted to inline ]

> diff --git a/drivers/ide/ide-dma-sff.c b/drivers/ide/ide-dma-sff.c
> index 16fc46e..e4cdf78 100644
> --- a/drivers/ide/ide-dma-sff.c
> +++ b/drivers/ide/ide-dma-sff.c
> @@ -277,8 +277,6 @@ void ide_dma_start(ide_drive_t *drive)
>  		dma_cmd = inb(hwif->dma_base + ATA_DMA_CMD);
>  		outb(dma_cmd | ATA_DMA_START, hwif->dma_base + ATA_DMA_CMD);
>  	}
> -
> -	wmb();
>  }
>  EXPORT_SYMBOL_GPL(ide_dma_start);
>  
> @@ -286,7 +284,7 @@ EXPORT_SYMBOL_GPL(ide_dma_start);
>  int ide_dma_end(ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif = drive->hwif;
> -	u8 dma_stat = 0, dma_cmd = 0, mask;
> +	u8 dma_stat = 0, dma_cmd = 0;
>  
>  	/* stop DMA */
>  	if (hwif->host_flags & IDE_HFLAG_MMIO) {
> @@ -304,11 +302,10 @@ int ide_dma_end(ide_drive_t *drive)
>  	/* clear INTR & ERROR bits */
>  	ide_dma_sff_write_status(hwif, dma_stat | ATA_DMA_ERR | ATA_DMA_INTR);
>  
> -	wmb();
> +#define CHECK_DMA_MASK (ATA_DMA_ACTIVE | ATA_DMA_ERR | ATA_DMA_INTR)
>  
>  	/* verify good DMA status */
> -	mask = ATA_DMA_ACTIVE | ATA_DMA_ERR | ATA_DMA_INTR;
> -	if ((dma_stat & mask) != ATA_DMA_INTR)
> +	if ((dma_stat & CHECK_DMA_MASK) != ATA_DMA_INTR)
>  		return 0x10 | dma_stat;
>  	return 0;
>  }
> diff --git a/drivers/ide/scc_pata.c b/drivers/ide/scc_pata.c
> index 97f8e0e..dcbb299 100644
> --- a/drivers/ide/scc_pata.c
> +++ b/drivers/ide/scc_pata.c
> @@ -337,7 +337,6 @@ static void scc_dma_start(ide_drive_t *drive)
>  
>  	/* start DMA */
>  	scc_ide_outb(dma_cmd | 1, hwif->dma_base);
> -	wmb();
>  }
>  
>  static int __scc_dma_end(ide_drive_t *drive)
> @@ -354,7 +353,6 @@ static int __scc_dma_end(ide_drive_t *drive)
>  	/* clear the INTR & ERROR bits */
>  	scc_ide_outb(dma_stat | 6, hwif->dma_base + 4);
>  	/* verify good DMA status */
> -	wmb();
>  	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;
>  }

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village � Da Vincilaan 7-D1 � B-1935 Zaventem � Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 � RPR Brussels
Fortis � BIC GEBABEBB � IBAN BE41293037680010
