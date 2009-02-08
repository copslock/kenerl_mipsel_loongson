Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Feb 2009 11:45:12 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:56261 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S21103038AbZBHLpJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Feb 2009 11:45:09 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 5586D3EDB; Sun,  8 Feb 2009 03:45:03 -0800 (PST)
Message-ID: <498EC5BA.4080002@ru.mvista.com>
Date:	Sun, 08 Feb 2009 14:44:58 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> This is the driver for the Toshiba TX4938 SoC EBUS controller ATA mode.
> It has custom set_pio_mode and some hacks for big endian.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   
[...]
> +static void tx4938ide_input_data_swap(ide_drive_t *drive, struct request *rq,
> +				void *buf, unsigned int len)
> +{
> +	unsigned long port = drive->hwif->io_ports.data_addr;
> +	unsigned short *ptr = buf;
> +	unsigned int count = (len + 1) / 2;
> +
> +	while (count--)
> +		*ptr++ = cpu_to_le16(__raw_readw((void __iomem *)port));
> +	__ide_flush_dcache_range((unsigned long)buf, count * 2);
> +}
> +
> +static void tx4938ide_output_data_swap(ide_drive_t *drive, struct request *rq,
> +				void *buf, unsigned int len)
> +{
> +	unsigned long port = drive->hwif->io_ports.data_addr;
> +	unsigned short *ptr = buf;
> +	unsigned int count = (len + 1) / 2;
> +
> +	while (count--) {
> +		__raw_writew(le16_to_cpu(*ptr), (void __iomem *)port);
> +		ptr++;
> +	}
> +	__ide_flush_dcache_range((unsigned long)buf, count * 2);
> +}

   Atsushi, does TX49 really suffer from the issue that these flushes 
are trying to address?

MBR, Sergei
