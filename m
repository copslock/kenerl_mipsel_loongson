Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 11:04:15 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:21287 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S22720742AbYJ3LDz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 11:03:55 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CA94D3EC9; Thu, 30 Oct 2008 04:03:48 -0700 (PDT)
Message-ID: <4909948F.3090202@ru.mvista.com>
Date:	Thu, 30 Oct 2008 14:03:43 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	akpm@linux-foundation.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	alessandro.zummo@towertech.it, tsbogend@alpha.franken.de
Subject: Re: [patch 3/3] drivers/rtc/rtc-m48t35.c is borked too
References: <200810292121.m9TLLYjd019910@imap1.linux-foundation.org>
In-Reply-To: <200810292121.m9TLLYjd019910@imap1.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

akpm@linux-foundation.org wrote:

> From: Andrew Morton <akpm@linux-foundation.org>
>
> drivers/rtc/rtc-m48t35.c: In function 'm48t35_read_time':
> drivers/rtc/rtc-m48t35.c:59: error: implicit declaration of function 'readb'
> drivers/rtc/rtc-m48t35.c:60: error: implicit declaration of function 'writeb'
> drivers/rtc/rtc-m48t35.c: In function 'm48t35_probe':
> drivers/rtc/rtc-m48t35.c:168: error: implicit declaration of function 'ioremap'
> drivers/rtc/rtc-m48t35.c:168: warning: assignment makes pointer from integer without a cast
> drivers/rtc/rtc-m48t35.c:188: error: implicit declaration of function 'iounmap'
>   

   I wonder how that's possible with the correct #include's?

> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>   
[...]
> diff -puN drivers/rtc/Kconfig~drivers-rtc-rtc-m48t35c-is-borked-too drivers/rtc/Kconfig
> --- a/drivers/rtc/Kconfig~drivers-rtc-rtc-m48t35c-is-borked-too
> +++ a/drivers/rtc/Kconfig
> @@ -432,6 +432,7 @@ config RTC_DRV_M48T86
>  
>  config RTC_DRV_M48T35
>  	tristate "ST M48T35"
> +	depends on MIPS
>   

   It shouldn't really be MIPS specific -- the patch seems wrong.

WBR, Sergei
