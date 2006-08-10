Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2006 14:17:10 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:17660 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20043395AbWHJNRH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2006 14:17:07 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 8D3E83ED9; Thu, 10 Aug 2006 06:16:33 -0700 (PDT)
Message-ID: <44DB31FB.8010806@ru.mvista.com>
Date:	Thu, 10 Aug 2006 17:17:47 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 3/7 AU1100 MMC support
References: <20060809210927.GD13145@enneenne.com>
In-Reply-To: <20060809210927.GD13145@enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:

> Kernel messages fixup.

    I guess the MMC patches should go to the appropriate maintainer, Russel 
King <rmk+mmc@arm.linux.org.uk>.

> Signed-off-by: Rodolfo Giometti <giometti@linux.it>

> ------------------------------------------------------------------------
> 
> diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
> index 6084bb8..560d6e3 100644
> --- a/drivers/mmc/au1xmmc.c
> +++ b/drivers/mmc/au1xmmc.c
> @@ -54,13 +54,16 @@ #include "au1xmmc.h"
>  
>  #define DRIVER_NAME "au1xxx-mmc"
>  
> -/* Set this to enable special debugging macros */
> -
> -#ifdef DEBUG
> -#define DBG(fmt, idx, args...) printk("au1xx(%d): DEBUG: " fmt, idx, ##args)
> +#ifdef CONFIG_MMC_DEBUG
> +#define dbg(fmt, idx, args...) printk(KERN_DEBUG "%s(%d): DEBUG: " \
> +					fmt, DRIVER_NAME, idx, ##args)

    Could also use pr_debug() here. If DEBUG is #defined, it'll print what you 
need, if not then no.

>  #else
> -#define DBG(fmt, idx, args...)
> +#define dbg(fmt, idx, args...)
>  #endif
> +#define err(fmt, idx, args...) printk(KERN_DEBUG "%s(%d): ERROR: " \
> +					fmt, DRIVER_NAME, idx, ##args)

    Are you sure KERN_DEBUG fits best for error messages, not KERN_ERR?

> +#define info(fmt, idx, args...) printk(KERN_INFO "%s(%d): " \
> +					fmt, DRIVER_NAME, idx, ##args)

    Could use pr_info() there...

WBR, Sergei
