Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 17:33:03 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:61547 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491849Ab1EMPdA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 17:33:00 +0200
Received: by ewy3 with SMTP id 3so876191ewy.36
        for <linux-mips@linux-mips.org>; Fri, 13 May 2011 08:32:54 -0700 (PDT)
Received: by 10.14.0.133 with SMTP id 5mr722946eeb.144.1305300774149;
        Fri, 13 May 2011 08:32:54 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id y3sm1516274eeh.23.2011.05.13.08.32.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2011 08:32:51 -0700 (PDT)
Message-ID: <4DCD4EC9.1070804@mvista.com>
Date:   Fri, 13 May 2011 19:31:21 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Alexander Clouter <alex@digriz.org.uk>
CC:     linux-mips@linux-mips.org, florian@openwrt.org
Subject: Re: [PATCH] MIPS: AR7: Fix GCC 4.6.0 build error.
References: <20110513152855.GM25017@chipmunk>
In-Reply-To: <20110513152855.GM25017@chipmunk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Alexander Clouter wrote:

>   CC      arch/mips/ar7/gpio.o
> arch/mips/ar7/gpio.c: In function 'ar7_gpio_init':
> arch/mips/ar7/gpio.c:318:11: error: variable 'size' set but not used [-Werror=unused-but-set-variable]
> cc1: all warnings being treated as errors

> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/mips/ar7/gpio.c |   12 ++----------
>  1 files changed, 2 insertions(+), 10 deletions(-)

> diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
> index 425dfa5..6917427 100644
> --- a/arch/mips/ar7/gpio.c
> +++ b/arch/mips/ar7/gpio.c
> @@ -314,16 +314,8 @@ static void titan_gpio_init(void)
>  int __init ar7_gpio_init(void)
>  {
>  	int ret;
> -	struct ar7_gpio_chip *gpch;
> -	unsigned size;
> -
> -	if (!ar7_is_titan()) {
> -		gpch = &ar7_gpio_chip;
> -		size = 0x10;
> -	} else {
> -		gpch = &titan_gpio_chip;
> -		size = 0x1f;
> -	}
> +	struct ar7_gpio_chip *gpch = (!ar7_is_titan())

    Parens around (!x) are not really necessary. Perhaps Ralf could remove them 
while applying...

> +		? &ar7_gpio_chip : &titan_gpio_chip;

WBR, Sergei
