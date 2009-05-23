Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 May 2009 12:18:22 +0100 (BST)
Received: from mail-ew0-f171.google.com ([209.85.219.171]:62341 "EHLO
	mail-ew0-f171.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022573AbZEWLSN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 May 2009 12:18:13 +0100
Received: by ewy19 with SMTP id 19so2487456ewy.0
        for <linux-mips@linux-mips.org>; Sat, 23 May 2009 04:18:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zkvuBWg8DP9WoXb36E9r1qsidMGIe9MrWVRGElk9Hig=;
        b=FqCRyXgm2rpcamkKbCFW2efFn7Y0WhWigHqyWC9oOE6L6v8j972NJ8Cv2SvFyrjZ3m
         gqWIAanE36XDgBDIDczLv9y17ka/8Ix65B6J5ijdj3uqcNVS1xTLQ+k/OI6ge/97YA6D
         OalZCA6VccCqrfu3Yy3e3+btVf4lx1cdKwswk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TN0CfrosTR3pCgX1GMQib8dEVSVwllMRAXyQd/CmGN2KBaN5meeJlJycjMVIBRYydB
         jXDzJnimwFpSx576Dj9Bj1LKEM6sm6DElNhCACKbEZaN0yTN9wAUq+SAPzinyGsR5W9h
         Vq2OK5+LaLxQxYtGXWqLboo1Zh1RifGbID+yI=
Received: by 10.210.57.3 with SMTP id f3mr2158666eba.35.1243077486375;
        Sat, 23 May 2009 04:18:06 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 7sm1523057eyb.35.2009.05.23.04.18.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 04:18:04 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH 3/4] Alchemy: mtx-1: use linux gpio api.
Date:	Sat, 23 May 2009 13:18:04 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
References: <1243023899-10343-1-git-send-email-mano@roarinelk.homelinux.net> <1243023899-10343-2-git-send-email-mano@roarinelk.homelinux.net> <1243023899-10343-3-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1243023899-10343-3-git-send-email-mano@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200905231318.04430.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Friday 22 May 2009 22:24:58 Manuel Lauss, vous avez écrit :
> Remove a few GPIO register accesses in the board init code with calls
> to the gpio api.
>
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  arch/mips/alchemy/mtx-1/board_setup.c |   24 +++++++++++++-----------
>  1 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/arch/mips/alchemy/mtx-1/board_setup.c
> b/arch/mips/alchemy/mtx-1/board_setup.c index 8ed1ae1..3356a0d 100644
> --- a/arch/mips/alchemy/mtx-1/board_setup.c
> +++ b/arch/mips/alchemy/mtx-1/board_setup.c
> @@ -28,6 +28,7 @@
>   *  675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>
> +#include <linux/gpio.h>
>  #include <linux/init.h>
>
>  #include <asm/mach-au1x00/au1000.h>
> @@ -55,10 +56,11 @@ void __init board_setup(void)
>  	}
>  #endif
>
> +	alchemy_gpio2_enable();
> +
>  #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
>  	/* Enable USB power switch */
> -	au_writel(au_readl(GPIO2_DIR) | 0x10, GPIO2_DIR);
> -	au_writel(0x100000, GPIO2_OUTPUT);
> +	alchemy_gpio_direction_output(4, 0);
>  #endif /* defined(CONFIG_USB_OHCI_HCD) ||
> defined(CONFIG_USB_OHCI_HCD_MODULE) */
>
>  #ifdef CONFIG_PCI
> @@ -74,14 +76,14 @@ void __init board_setup(void)
>
>  	/* Initialize GPIO */
>  	au_writel(0xFFFFFFFF, SYS_TRIOUTCLR);
> -	au_writel(0x00000001, SYS_OUTPUTCLR); /* set M66EN (PCI 66MHz) to OFF */
> -	au_writel(0x00000008, SYS_OUTPUTSET); /* set PCI CLKRUN# to OFF */
> -	au_writel(0x00000002, SYS_OUTPUTSET); /* set EXT_IO3 ON */
> -	au_writel(0x00000020, SYS_OUTPUTCLR); /* set eth PHY TX_ER to OFF */
> +	alchemy_gpio_direction_output(0, 0);	/* set M66EN (PCI 66MHz) to OFF */
> +	alchemy_gpio_direction_output(3, 1);	/* set PCI CLKRUN# to OFF */
> +	alchemy_gpio_direction_output(1, 1);	/* set EXT_IO3 ON */
> +	alchemy_gpio_direction_output(5, 0);	/* set eth PHY TX_ER to OFF */
>
>  	/* Enable LED and set it to green */
> -	au_writel(au_readl(GPIO2_DIR) | 0x1800, GPIO2_DIR);
> -	au_writel(0x18000800, GPIO2_OUTPUT);
> +	alchemy_gpio_direction_output(211, 1);	/* green on */
> +	alchemy_gpio_direction_output(212, 0);	/* red off */
>
>  	board_pci_idsel = mtx1_pci_idsel;
>
> @@ -101,10 +103,10 @@ mtx1_pci_idsel(unsigned int devsel, int assert)
>
>  	if (assert && devsel != 0)
>  		/* Suppress signal to Cardbus */
> -		au_writel(0x00000002, SYS_OUTPUTCLR); /* set EXT_IO3 OFF */
> +		gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
>  	else
> -		au_writel(0x00000002, SYS_OUTPUTSET); /* set EXT_IO3 ON */
> +		gpio_set_value(1, 1);	/* set EXT_IO3 ON */
> +
>  	au_sync_udelay(1);
>  	return 1;
>  }
> -



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
