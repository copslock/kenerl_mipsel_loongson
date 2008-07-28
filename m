Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 23:21:55 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:44500 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20026809AbYG1WVq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Jul 2008 23:21:46 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B0D9F3EC9; Mon, 28 Jul 2008 15:21:41 -0700 (PDT)
Message-ID: <488E4670.7090305@ru.mvista.com>
Date:	Tue, 29 Jul 2008 02:21:36 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	drzeus@drzeus.cx, linux-mips@linux-mips.org
Subject: Re: [PATCH] au1xmmc: raise segment size limit.
References: <20080728133120.GB26494@roarinelk.homelinux.net>
In-Reply-To: <20080728133120.GB26494@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:
> Please apply this patch, as it fixes an oops when MMC-DMA and network
> traffic are active at the same time.  This seems to be a 2.6.27-only thing;
> the current au1xmmc code (minus the polling parts) works fine on 2.6.26.
>
> ---
>
> Raise the DMA block size limit from 2048 bytes to the maximum supported
> by the DMA controllers on the chip (128kB on Au1100, 4MB on Au1200).
>
> This gives a small performance boost and apparently fixes an oops when
> MMC-DMA and network traffic are active at the same time.
>
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>
>   
[...]
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index 99b2091..dd414f1 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -61,7 +61,13 @@
>  
>  /* Hardware definitions */
>  #define AU1XMMC_DESCRIPTOR_COUNT 1
> -#define AU1XMMC_DESCRIPTOR_SIZE  2048
> +
> +/* max DMA seg size: 64kB on Au1100, 4MB on Au1200 */
>   

  So, it's 64 or 128 KB? KB since k prefix usualy means decimal kilo... :-)

WBR, Sergei
