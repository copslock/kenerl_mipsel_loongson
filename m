Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2005 19:38:51 +0000 (GMT)
Received: from [85.8.13.51] ([85.8.13.51]:9896 "EHLO smtp.drzeus.cx")
	by ftp.linux-mips.org with ESMTP id S8133868AbVLBTid (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2005 19:38:33 +0000
Received: from [10.100.1.247] ([::ffff:213.115.244.31])
  (AUTH: PLAIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Fri, 02 Dec 2005 20:42:07 +0100
  id 0006271A.4390A390.00006C1A
Message-ID: <4390A38A.1010907@drzeus.cx>
Date:	Fri, 02 Dec 2005 20:42:02 +0100
From:	Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To:	Jordan Crouse <jordan.crouse@amd.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] ALCHEMY:  Add SD support to AU1200 MMC/SD driver
References: <20051202190108.GF28227@cosmic.amd.com>
In-Reply-To: <20051202190108.GF28227@cosmic.amd.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <drzeus@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus@drzeus.cx
Precedence: bulk
X-list: linux-mips

Jordan Crouse wrote:
> Add SD support to the AU1200 MMC driver.  This can
> be added post 2.6.15, I'm just sending them out today so the various
> maintainers can get them queued up. 
> 
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> ---
> 
>  drivers/mmc/au1xmmc.c |  124 ++++++++++++++++++++++++++++---------------------
>  1 files changed, 71 insertions(+), 53 deletions(-)
> 

Russell is still the maintainer of the MMC layer. :)

I still have some comments though.

> @@ -124,8 +132,8 @@ static inline void IRQ_OFF(struct au1xmm
>  static inline void SEND_STOP(struct au1xmmc_host *host) 
>  {
>  
> -	/* We know the value of CONFIG2, so avoid a read we don't need */
> -	u32 mask = SD_CONFIG2_EN;
> +	/* Penalty box for Jordan - NEVER ASSUME! */
> +	u32 mask = au_readl(HOST_CONFIG2(host));
>  
>  	WARN_ON(host->status != HOST_S_DATA);
>  	host->status = HOST_S_STOP;

This comment will be terribly confusing to anyone reading your code.

> @@ -196,7 +207,11 @@ static int au1xmmc_send_command(struct a
>  
>  	switch(cmd->flags) {
>  	case MMC_RSP_R1:
> -		mmccmd |= SD_CMD_RT_1;
> +		if (cmd->opcode == 0x03 && host->mmc->mode == MMC_MODE_SD)
> +			mmccmd |= SD_CMD_RT_6;
> +		else
> +			mmccmd |= SD_CMD_RT_1;
> +
>  		break;
>  	case MMC_RSP_R1B:
>  		mmccmd |= SD_CMD_RT_1B;

No, no, no! Even if this wasn't already fixed in the current kernel you
never hack around bugs in other parts of the kernel, you fix them!

> @@ -504,8 +519,8 @@ static void au1xmmc_cmd_complete(struct 
>  		r[3] = au_readl(host->iobase + SD_RESP0);
>  		
>  		/* The CRC is omitted from the response, so really we only got
> -		 * 120 bytes, but the engine expects 128 bits, so we have to shift
> -		 * things up 
> +		 * 120 bytes, but the engine expects 128 bits, so we have to 
> +		 * shift things up 
>  		 */
>  		
>  		for(i = 0; i < 4; i++) {

s/bytes/bits/

> @@ -611,7 +635,7 @@ au1xmmc_prepare_data(struct au1xmmc_host
>  			
>  			int len = (datalen > sg_len) ? sg_len : datalen;
>  
> -			if (i == host->dma.len - 1)
> +		if (i == (host->dma.len - 1))
>  				flags = DDMA_FLAGS_IE;
>  
>      			if (host->flags & HOST_F_XMIT){

broken indentation.

> @@ -627,23 +651,11 @@ au1xmmc_prepare_data(struct au1xmmc_host
>  					len, flags);
>  			}
>  
> -    			if (!ret) 
> +    		if (ret == 0) 
>  				goto dataerr;
>  
>  			datalen -= len;
>  		}
> -	}
> -	else {
> -		host->pio.index = 0;
> -		host->pio.offset = 0;
> -		host->pio.len = datalen;
> -		
> -		if (host->flags & HOST_F_XMIT)
> -			IRQ_ON(host, SD_CONFIG_TH);
> -		else 
> -			IRQ_ON(host, SD_CONFIG_NE);
> -			//IRQ_ON(host, SD_CONFIG_RA|SD_CONFIG_RF);
> -	}
>  
>  	return MMC_ERR_NONE;
>  

Here aswell. And it seems the block above will get the wrong indentation.

Rgds
Pierre
