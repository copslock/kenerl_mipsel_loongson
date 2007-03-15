Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2007 14:03:38 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:51043 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022305AbXCOODd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2007 14:03:33 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 336053EC9; Thu, 15 Mar 2007 07:02:57 -0700 (PDT)
Message-ID: <45F9520A.2000804@ru.mvista.com>
Date:	Thu, 15 Mar 2007 17:02:50 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Daniel Mack <daniel@caiaq.de>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] IDE/DMA for au1xxx
References: <20070315122012.GA8612@ipxXXXXX>
In-Reply-To: <20070315122012.GA8612@ipxXXXXX>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Daniel Mack wrote:
> Hi,

> this makes the DMA part of Au1xxx's IDE interface compile again.

> Signed-of-by: Daniel Mack <daniel@caiaq.de>

> ------------------------------------------------------------------------

> diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-ide.c
> index b2dc028..806b6d1 100644
> --- a/drivers/ide/mips/au1xxx-ide.c
> +++ b/drivers/ide/mips/au1xxx-ide.c
> @@ -443,7 +443,6 @@ static void auide_dma_host_on(ide_drive_t *drive)
>  static int auide_dma_on(ide_drive_t *drive)
>  {
>  	drive->using_dma = 1;
> -
>  	return 0;
>  }
>  
> @@ -638,6 +637,7 @@ static int au_ide_probe(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	_auide_hwif *ahwif = &auide_hwif;
>  	ide_hwif_t *hwif;
> +	hw_regs_t *hw;
>  	struct resource *res;
>  	int ret = 0;
>  
> @@ -681,7 +681,7 @@ static int au_ide_probe(struct device *dev)
>  	/* FIXME:  This might possibly break PCMCIA IDE devices */
>  
>  	hwif                            = &ide_hwifs[pdev->id];
> -	hw_regs_t *hw 			= &hwif->hw;
> +	hw 				= &hwif->hw;
>  	hwif->irq = hw->irq             = ahwif->irq;
>  	hwif->chipset                   = ide_au1xxx;

    The patch consisting of these 2 hunks has been already posted to linux-ide 
by Ralf... Your patch looks more complete though.

> diff --git a/include/asm-mips/mach-au1x00/au1xxx_ide.h b/include/asm-mips/mach-au1x00/au1xxx_ide.h
> index e9fa252..e747814 100644
> --- a/include/asm-mips/mach-au1x00/au1xxx_ide.h
> +++ b/include/asm-mips/mach-au1x00/au1xxx_ide.h
> @@ -166,13 +166,13 @@ int __init auide_probe(void);
>          static int auide_dma_setup(ide_drive_t *drive);
>          static int auide_dma_check(ide_drive_t *drive);
>          static int auide_dma_test_irq(ide_drive_t *drive);
> -        static int auide_dma_host_off(ide_drive_t *drive);
> -        static int auide_dma_host_on(ide_drive_t *drive);
> +        static void auide_dma_host_off(ide_drive_t *drive);
> +        static void auide_dma_host_on(ide_drive_t *drive);
>          static int auide_dma_lostirq(ide_drive_t *drive);
>          static int auide_dma_on(ide_drive_t *drive);
>          static void auide_ddma_tx_callback(int irq, void *param);
>          static void auide_ddma_rx_callback(int irq, void *param);
> -        static int auide_dma_off_quietly(ide_drive_t *drive);
> +        static void auide_dma_off_quietly(ide_drive_t *drive);
>  #endif /* end CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */

    WTF these protos are doing in include/asm-mips/ -- being purely IDE 
subsystem specific?! :-O
    Could you move them into the driver (if they are indeed necessary)?

MBR, Sergei
