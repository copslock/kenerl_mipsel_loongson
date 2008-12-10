Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2008 11:42:41 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:4960 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S24038846AbYLJLmg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Dec 2008 11:42:36 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 76DCB3EC9; Wed, 10 Dec 2008 03:42:29 -0800 (PST)
Message-ID: <493FAB21.2030905@ru.mvista.com>
Date:	Wed, 10 Dec 2008 14:42:25 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] libata: Add two more columns to the ata_timing table.
References: <493DCBEA.9090007@caviumnetworks.com> <1228786798-20369-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1228786798-20369-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21563
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
> columns for write_hold and dmack_hold times.  The values were obtained
> from the Compact Flash specification Rev 4.1.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>   

   Well, you got it right except fot the SWDMA modes. :-)

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 5e2eb74..b156d83 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2953,33 +2953,33 @@ int sata_set_spd(struct ata_link *link) 
>   
[...]
> +	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 30, 20, 960,   0 },
> +	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 30, 20, 480,   0 },
> +	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 15, 20, 240,   0 },
>   

   Well, I don't know what CF 4.1 has but ATA/ATA-2 have minimum -DIOx 
to -DMACK hold time (tJ) for SW DMA modes always 0 ns, and -DIOW data 
hold time (tH) of 50, 30, and 20 for modes 0, 1, and 2 respectfully.

> @@ -864,6 +868,8 @@ struct ata_timing {
>  	unsigned short cyc8b;		/* t0 for 8-bit I/O */
>  	unsigned short active;		/* t2 or tD */
>  	unsigned short recover;		/* t2i or tK */
> +	unsigned short write_hold;	/* t4 */
>   

   The comment should be "t4 or tH", to be completely correct.

MBR, Sergei
