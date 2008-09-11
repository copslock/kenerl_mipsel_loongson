Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 10:35:27 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:31882 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20163493AbYIKJfX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2008 10:35:23 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B1B723ECA; Thu, 11 Sep 2008 02:35:18 -0700 (PDT)
Message-ID: <48C8E652.5000800@ru.mvista.com>
Date:	Thu, 11 Sep 2008 13:35:14 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org
Subject: Re: [PATCH 2/2] TXx9: Add TX4939 ATA support
References: <20080910.010830.51865999.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080910.010830.51865999.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> Add a helper routine to register tx4939ide driver and use it on
> RBTX4939 board.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   
[...]
> diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
> index f14a497..ee00bde 100644
> --- a/arch/mips/txx9/generic/setup_tx4939.c
> +++ b/arch/mips/txx9/generic/setup_tx4939.c
>   
[...]
> @@ -389,6 +390,34 @@ void __init tx4939_mtd_init(int ch)
>  	txx9_physmap_flash_init(ch, start, size, &pdata);
>  }
>  
> +void __init tx4939_ata_init(void)
> +{
> +	__u64 pcfg = __raw_readq(&tx4939_ccfgptr->pcfg);
> +	if (pcfg & (TX4939_PCFG_ATA0MODE | TX4939_PCFG_ATA1MODE)) {
> +		struct resource res[2];
> +		int i;
> +		memset(res, 0, sizeof(res));
> +		for (i = 0; i < 2; i++) {
> +			if (i == 0 &&
> +			    !(pcfg & TX4939_PCFG_ATA0MODE))
> +				continue;
> +			if (i == 1 &&
> +			    (pcfg & (TX4939_PCFG_ATA1MODE |
> +				     TX4939_PCFG_ET1MODE |
> +				     TX4939_PCFG_ET0MODE)) !=
> +			    TX4939_PCFG_ATA1MODE)
> +				continue;
> +			res[0].start = TX4939_ATA_REG(i) & 0xfffffffffULL;
> +			res[0].end = res[0].start + 0x1000 - 1;
> +			res[0].flags = IORESOURCE_MEM;
> +			res[1].start = TXX9_IRQ_BASE + TX4939_IR_ATA(i);
> +			res[1].flags = IORESOURCE_IRQ;
> +			platform_device_register_simple("tx4939ide", i,
> +							res, ARRAY_SIZE(res));
>   

   Hm, why not declare both IDE platform devices statically an then 
register them depending on the TX4939_PCFG_ATA[01]MODE bits?
This loop doesn't look nice. You could at least have used an array to 
check TX4939_PCFG_ATA[01]MODE bitmasks but I think it's better to just 
declare devices statically...

MBR, Sergei
