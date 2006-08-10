Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2006 14:28:32 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:29436 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20043400AbWHJN2a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2006 14:28:30 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 4F8253ED9; Thu, 10 Aug 2006 06:28:25 -0700 (PDT)
Message-ID: <44DB34C2.3090302@ru.mvista.com>
Date:	Thu, 10 Aug 2006 17:29:38 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 2/7 AU1100 MMC support
References: <20060809210843.GC13145@enneenne.com>
In-Reply-To: <20060809210843.GC13145@enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:
> Protect code on "BCSR" device.

> Signed-off-by: Rodolfo Giometti <giometti@linux.it>

> ------------------------------------------------------------------------

> diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
> index b0dc1d0..6084bb8 100644
> --- a/drivers/mmc/au1xmmc.c
> +++ b/drivers/mmc/au1xmmc.c
> @@ -65,8 +65,8 @@ #endif
>  const struct {
>  	u32 iobase;
>  	u32 tx_devid, rx_devid;
> -	u16 bcsrpwr;
> -	u16 bcsrstatus;
> +	u16 power;
> +	u16 status;
>  	u16 wpstatus;
>  } au1xmmc_card_table[] = {
>  	{ SD0_BASE, DSCR_CMD0_SDMS_TX0, DSCR_CMD0_SDMS_RX0,
> @@ -138,24 +138,42 @@ static inline void SEND_STOP(struct au1x
>  static void au1xmmc_set_power(struct au1xmmc_host *host, int state)
>  {
>  
> -	u32 val = au1xmmc_card_table[host->id].bcsrpwr;
> +	u32 val;
>  
> +	val = au1xmmc_card_table[host->id].power;
> +
> +#if defined(CONFIG_MIPS_DB1200)
>  	bcsr->board &= ~val;
>  	if (state) bcsr->board |= val;
> +#endif
>  
>  	au_sync_delay(1);
>  }

    If DBAu1100 doesn't allow to control slot power, then I don't think 
pretending it does is a good thing. Shouldn't these #ifdef's be in 
au1xmmc_set_ios() instead (the function is void anyway but that would allow us 
to save on the code size a bit more)?

>  static inline int au1xmmc_card_inserted(struct au1xmmc_host *host)
>  {
> -	return (bcsr->sig_status & au1xmmc_card_table[host->id].bcsrstatus)
> -		? 1 : 0;
> +	u32 val, data = 1;
> +
> +	val = au1xmmc_card_table[host->id].status;
> +
> +#if defined(CONFIG_MIPS_DB1200)
> +	data = bcsr->sig_status & val;
> +#endif
> +
> +	return !!data;
>  }

    Hrm, are you sure there's no way to sense that the card is *really* 
inserted or not?

>  static inline int au1xmmc_card_readonly(struct au1xmmc_host *host)
>  {
> -	return (bcsr->status & au1xmmc_card_table[host->id].wpstatus)
> -		? 1 : 0;
> +	u32 val, data = 0;
> +
> +	val = au1xmmc_card_table[host->id].wpstatus;
> +
> +#if defined(CONFIG_MIPS_DB1200)
> +	data = bcsr->status & val;
> +#endif
> +
> +	return !!data;
>  }

    Ditto.

WBR, Sergei
