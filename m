Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2008 23:52:54 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:26796 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S24207736AbYLJXwo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Dec 2008 23:52:44 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 75BA53EC9; Wed, 10 Dec 2008 15:52:35 -0800 (PST)
Message-ID: <49405640.4020205@ru.mvista.com>
Date:	Thu, 11 Dec 2008 02:52:32 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] libata: Add another column to the ata_timing table.
References: <494052D1.10208@caviumnetworks.com> <1228952353-12323-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1228952353-12323-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:
> The forthcoming OCTEON SOC Compact Flash driver needs an additional
> timing value that was not available in the ata_timing table.  I add a
> new column for dmack_hold time.  The values were obtained from the
> Compact Flash specification Rev 4.1.
>   

   Note that I wasn't telling you to drop t4, just to correct its value 
for SWDMA modes.

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>   

   NAK, patch broken.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 5e2eb74..1be2dde 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2953,33 +2953,33 @@ int sata_set_spd(struct ata_link *link)
>   */
>  
>  static const struct ata_timing ata_timing[] = {
> -/*	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 960,   0 }, */
> -	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 600,   0 },
> -	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 383,   0 },
> -	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 240,   0 },
> -	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 180,   0 },
> -	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 120,   0 },
> -	{ XFER_PIO_5,     15,  65,  25, 100,  65,  25, 100,   0 },
> -	{ XFER_PIO_6,     10,  55,  20,  80,  55,  20,  80,   0 },
> -
> -	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },
> -	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
> -	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 240,   0 },
> -
> -	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 480,   0 },
> -	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 150,   0 },
> -	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 120,   0 },
> -	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 100,   0 },
> -	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20,  80,   0 },
> -
> -/*	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0,   0, 150 }, */
> -	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,   0, 120 },
> -	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0,   0,  80 },
> -	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0,   0,  60 },
> -	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },
> -	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
> -	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0,   0,  20 },
> -	{ XFER_UDMA_6,     0,   0,   0,   0,   0,   0,   0,  15 },
> +/*	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 0,  960,   0 }, */
> +	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 0,  600,   0 },
> +	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 0,  383,   0 },
> +	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 0,  240,   0 },
> +	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 0,  180,   0 },
> +	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 0,  120,   0 },
> +	{ XFER_PIO_5,     15,  65,  25, 100,  65,  25, 0,  100,   0 },
> +	{ XFER_PIO_6,     10,  55,  20,  80,  55,  20, 0,   80,   0 },
> +
> +	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 50, 960,   0 },
> +	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 30, 480,   0 },
> +	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 20, 240,   0 },
> +
> +	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 20, 480,   0 },
> +	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 5,  150,   0 },
> +	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 5,  120,   0 },
> +	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 5,  100,   0 },
> +	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20, 5,   80,   0 },
> +
> +/*	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0, 0,    0, 150 }, */
> +	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0, 0,    0, 120 },
> +	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0, 0,    0,  80 },
> +	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0, 0,    0,  60 },
> +	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0, 0,    0,  45 },
> +	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0, 0,    0,  30 },
> +	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0, 0,    0,  20 },
> +	{ XFER_UDMA_6,     0,   0,   0,   0,   0,   0, 0,    0,  15 },
>  
>  	{ 0xFF }
>  };
>   
[...]
> @@ -864,6 +866,8 @@ struct ata_timing {
>  	unsigned short cyc8b;		/* t0 for 8-bit I/O */
>  	unsigned short active;		/* t2 or tD */
>  	unsigned short recover;		/* t2i or tK */
> +	unsigned short write_hold;	/* t4 */
> +	unsigned short dmack_hold;	/* tj */
>  	unsigned short cycle;		/* t0 */
>  	unsigned short udma;		/* t2CYCTYP/2 */
>  };
>   

   This is broken. You're still adding 2 fields but initializer doesný 
much that.
 
WBR, Sergei
