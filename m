Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 12:07:04 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:45068 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022470AbXEKLHD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 May 2007 12:07:03 +0100
Received: (qmail 16336 invoked by uid 1000); 11 May 2007 13:07:02 +0200
Date:	Fri, 11 May 2007 13:07:02 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Pierre Ossman <drzeus@drzeus.cx>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mmc: au1xmmc command types check from data flags
Message-ID: <20070511110702.GA16041@roarinelk.homelinux.net>
References: <20070511125919.350c53a8.yoichi_yuasa@tripeaks.co.jp> <4643F57C.5060409@drzeus.cx> <200705110516.l4B5GMQJ053603@mbox33.po.2iij.net> <4643FD2B.8020103@drzeus.cx> <20070511192948.38937fd0.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070511192948.38937fd0.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Yoichi,

> --- mips-orig/drivers/mmc/host/au1xmmc.c	2007-05-11 10:27:01.068483750 +0900
> +++ mips/drivers/mmc/host/au1xmmc.c	2007-05-11 19:13:11.426283750 +0900
> @@ -189,7 +189,7 @@ static void au1xmmc_tasklet_finish(unsig
> @@ -213,24 +213,17 @@ static int au1xmmc_send_command(struct a
>  		return MMC_ERR_INVALID;
>  	}
>  
> -	switch(cmd->opcode) {
> -	case MMC_READ_SINGLE_BLOCK:
> -	case SD_APP_SEND_SCR:
> -		mmccmd |= SD_CMD_CT_2;
> -		break;
> -	case MMC_READ_MULTIPLE_BLOCK:
> -		mmccmd |= SD_CMD_CT_4;
> -		break;
> -	case MMC_WRITE_BLOCK:
> -		mmccmd |= SD_CMD_CT_1;
> -		break;
> -
> -	case MMC_WRITE_MULTIPLE_BLOCK:
> -		mmccmd |= SD_CMD_CT_3;
> -		break;
> -	case MMC_STOP_TRANSMISSION:
> -		mmccmd |= SD_CMD_CT_7;
> -		break;
> +	flags = cmd->data->flags;
		^^^^^^^^
This line oopses the driver on my Au1200
->data can be NULL

> +	if (flags & MMC_DATA_READ) {
> +		if (flags & MMC_DATA_MULTI)
> +			mmccmd |= SD_CMD_CT_4;
> +		else
> +			mmccmd |= SD_CMD_CT_2;
> +	} else if (flags & MMC_DATA_WRITE) {
> +		if (flags & MMC_DATA_MULTI)
> +			mmccmd |= SD_CMD_CT_3;
> +		else
> +			mmccmd |= SD_CMD_CT_1;
>  	}

what about SD_CMD_CT_7?

Hows this:

	if (cmd->data)
		flags = cmd->data->flags;
	else if (cmd->opcode == 12)
		mmccmd |= CD_SMD_CT_7;
	else
		flags = 0;

	if (flags & MMC_DATA_READ) {
	[...]
 
>  	au_writel(cmd->arg, HOST_CMDARG(host));
> 

Thanks,
	Manuel Lauss
