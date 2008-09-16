Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2008 22:59:35 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:20582 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20162380AbYIPV7d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2008 22:59:33 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 5FEE23EC9; Tue, 16 Sep 2008 14:59:29 -0700 (PDT)
Message-ID: <48D02C3C.90705@ru.mvista.com>
Date:	Wed, 17 Sep 2008 01:59:24 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> This is the driver for the Toshiba TX4939 SoC ATA controller.
>
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/port_ops routines.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   
[...]
> diff --git a/drivers/ide/mips/tx4939ide.c b/drivers/ide/mips/tx4939ide.c
> new file mode 100644
> index 0000000..ba9776d
> --- /dev/null
> +++ b/drivers/ide/mips/tx4939ide.c
> @@ -0,0 +1,762 @@
>   
[...]
> +static int __tx4939ide_dma_setup(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct request *rq = HWGROUP(drive)->rq;
> +	unsigned int reading;
> +	u8 dma_stat;
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +
> +	if (rq_data_dir(rq))
> +		reading = 0;
> +	else
> +		reading = 1 << 3;
> +
> +	/* fall back to pio! */
> +	if (!ide_build_dmatable(drive, rq)) {
> +		ide_map_sg(drive, rq);
> +		return 1;
> +	}
> +#ifdef __BIG_ENDIAN
> +	{
> +		unsigned int *table = hwif->dmatable_cpu;
>   

   s/unsigned int/__le32/ perhaps?

> +		while (1) {
> +			cpu_to_le64s((u64 *)table);
>   

   Wait, PRD is already already in LE format, so this should be 
le64_to_cpus().

> +			if (*table & 0x80000000)
>   

   Hum... you don't have to check that with ide_build_dmatable() 
returning the PRD count...

> +				break;
> +			table += 2;
> +		}
> +	}
> +#endif
>   

MBR, Sergei
