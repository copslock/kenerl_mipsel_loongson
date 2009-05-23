Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 May 2009 12:18:46 +0100 (BST)
Received: from mail-ew0-f171.google.com ([209.85.219.171]:62341 "EHLO
	mail-ew0-f171.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022593AbZEWLST convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 May 2009 12:18:19 +0100
Received: by mail-ew0-f171.google.com with SMTP id 19so2487456ewy.0
        for <linux-mips@linux-mips.org>; Sat, 23 May 2009 04:18:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=h9XO/pJ8Nzos439L9vzymIBMvvidUDpDcnqkkCfhlOY=;
        b=uV2vPcO55iuoVmfYK0ooRvVq+EGE2QABEnpSqcG/uxC20ruWAxr70jMAjwECCw2bCy
         BAQW1ZjbwHoRHo3SmHmL3etCUbGs6lhUmXiMjMnqdzDwRAhuOn//MPrWvUr+hX9qQ5Nj
         rvxrTX5c8EsFzO/gYEvSvO6rEhTa6COR3loBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=duu712xnO7SnOO99ox5+fayB/GhO+r8ZCGDdXkr3m2b2rq+IDyTvCUp62lQgg9KQU2
         gQtj+S/FYHP3xQvQtYp7S3TopiV8/HeVEfGoKUmcNfUb1mxI6KOdMZosKYC2T8MJ+AxI
         UWF9HIdaDm2n8N288p3ja8V6m3p4Aqi8OYLCs=
Received: by 10.210.143.9 with SMTP id q9mr2144774ebd.59.1243077499227;
        Sat, 23 May 2009 04:18:19 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 28sm3740454eyg.34.2009.05.23.04.18.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 04:18:18 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH 4/4] Alchemy: xxs1500: use linux gpio api.
Date:	Sat, 23 May 2009 13:18:17 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
References: <1243023899-10343-1-git-send-email-mano@roarinelk.homelinux.net> <1243023899-10343-3-git-send-email-mano@roarinelk.homelinux.net> <1243023899-10343-4-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1243023899-10343-4-git-send-email-mano@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200905231318.17741.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Friday 22 May 2009 22:24:59 Manuel Lauss, vous avez écrit :
> Remove a few GPIO register accesses in the board init code with calls
> to the gpio api.
>
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  arch/mips/alchemy/xxs1500/board_setup.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/arch/mips/alchemy/xxs1500/board_setup.c
> b/arch/mips/alchemy/xxs1500/board_setup.c index a2634fa..ed7d999 100644
> --- a/arch/mips/alchemy/xxs1500/board_setup.c
> +++ b/arch/mips/alchemy/xxs1500/board_setup.c
> @@ -23,6 +23,7 @@
>   *  675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>
> +#include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/delay.h>
>
> @@ -65,20 +66,21 @@ void __init board_setup(void)
>  	au_writel(0x01, UART3_ADDR + UART_MCR); /* UART_MCR_DTR is 0x01??? */
>
>  #ifdef CONFIG_PCMCIA_XXS1500
> -	/* Setup PCMCIA signals */
> -	au_writel(0, SYS_PININPUTEN);
> +	alchemy_gpio2_enable();
>
>  	/* GPIO 0, 1, and 4 are inputs */
> -	au_writel(1 | (1 << 1) | (1 << 4), SYS_TRIOUTCLR);
> +	alchemy_gpio_direction_input(0);
> +	alchemy_gpio_direction_input(1);
> +	alchemy_gpio_direction_input(4);
>
> -	/* Enable GPIO2 if not already enabled */
> -	au_writel(1, GPIO2_ENABLE);
>  	/* GPIO2 208/9/10/11 are inputs */
> -	au_writel((1 << 8) | (1 << 9) | (1 << 10) | (1 << 11), GPIO2_DIR);
> +	alchemy_gpio_direction_input(208);
> +	alchemy_gpio_direction_input(209);
> +	alchemy_gpio_direction_input(210);
> +	alchemy_gpio_direction_input(211);
>
>  	/* Turn off power */
> -	au_writel((au_readl(GPIO2_PINSTATE) & ~(1 << 14)) | (1 << 30),
> -		  GPIO2_OUTPUT);
> +	alchemy_gpio_direction_output(214, 0);
>  #endif
>
>  #ifdef CONFIG_PCI



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
