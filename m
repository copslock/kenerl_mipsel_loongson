Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 11:02:18 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:61038 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23903338AbYKYLCN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2008 11:02:13 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 2CD173EC9; Tue, 25 Nov 2008 03:02:05 -0800 (PST)
Message-ID: <492BDB28.8020103@ru.mvista.com>
Date:	Tue, 25 Nov 2008 14:02:00 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:

> The forthcoming OCTEON SOC Compact Flash driver needs a few more
> timing values than were available in the ata_timing table.  I add new
> columns for write_hold, read_hold, and read_holdz times.  The values
> were obtained from the Compact Flash specification Rev 4.1.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>   

   Not quite correct...

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4214bfb..b29b7df 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2946,33 +2946,33 @@ int sata_set_spd(struct ata_link *link)
>   */
>  
>  static const struct ata_timing ata_timing[] = {
>   
[...]
> +/*	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 30, 5, 30, 960,   0 }, */
> +	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 30, 5, 30, 600,   0 },
> +	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 20, 5, 30, 383,   0 },
> +	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 15, 5, 30, 240,   0 },
> +	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 10, 5, 30, 180,   0 },
> +	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 10, 5, 30, 120,   0 },
> +	{ XFER_PIO_5,     15,  65,  25, 100,  65,  25,  5, 5, 20, 100,   0 },
> +	{ XFER_PIO_6,     10,  55,  20,  80,  55,  20,  5, 5, 20,  80,   0 },
> +
> +	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 30, 5, 0,  960,   0 },
> +	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 30, 5, 0,  480,   0 },
> +	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 15, 5, 0,  240,   0 },
> +
> +	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 20, 20, 0, 480,   0 },
>   

   Wrong, -DIOR hold time is 5 ns for MWDMA0 as well as for all other modes.

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 59b0f1c..7c44e45 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
>   
[...]
> @@ -863,6 +868,9 @@ struct ata_timing {
>  	unsigned short cyc8b;		/* t0 for 8-bit I/O */
>  	unsigned short active;		/* t2 or tD */
>  	unsigned short recover;		/* t2i or tK */
> +	unsigned short write_hold;	/* t4 */
> +	unsigned short read_hold;	/* t6 */
>   

   -DIOR hold time is 5 ns for all PIO and MWDMA modes -- there's no 
sense in storing it here.

> +	unsigned short read_holdz;	/* t6z  or tj */
>   

   T6z and Tj are not the same timing. Well, you specify it as 0 for  
DMA modes anyway...

MBR, Sergei
