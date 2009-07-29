Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2009 09:16:03 +0200 (CEST)
Received: from mail-fx0-f220.google.com ([209.85.220.220]:42134 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492094AbZG2HP5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Jul 2009 09:15:57 +0200
Received: by fxm20 with SMTP id 20so592128fxm.0
        for <multiple recipients>; Wed, 29 Jul 2009 00:15:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=okpSer6TeansZfby3z4xcRQEJ5lgLrmzC9X3SBLmpjQ=;
        b=ks0ol3LpxRb6TlNo6I+jM2JM5Del7qo7l7hUpjK+GvnqHfH5+Xno1ulpu8FcM9ueSL
         URtiVBZj3x3+KLun3rrE33uNcV2H2I9VGsUgAu1Q2WpCS0uqN+6OOCjPtM6NN1/hNYm0
         f4vfnPlq+GcQ4Scd7bWZ9sBlyrhsfL+Ol7fUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aeAznEGok3gcljK6QLD/2rE8CS/j+vyH76HYRb+b+Is17yZPyPs68SDgfeNtQOchnM
         M+g59MkrSEq4tSIhhq3623k9ZrC8ctCjZJb9iLOHdAcrfwzwrtAkPVDXgIf+Ii2ymA6Q
         i5Imq5+7jzDw9YiZrYqhUTgl4nQcQ8+b4zkJ8=
MIME-Version: 1.0
Received: by 10.223.115.12 with SMTP id g12mr4047790faq.92.1248851752104; Wed, 
	29 Jul 2009 00:15:52 -0700 (PDT)
In-Reply-To: <200907282300.14118.florian@openwrt.org>
References: <200907282300.14118.florian@openwrt.org>
Date:	Wed, 29 Jul 2009 09:15:52 +0200
Message-ID: <f861ec6f0907290015v34d277beh18efed6aac10aa79@mail.gmail.com>
Subject: Re: [PATCH 1/4] alchemy: register au1000_eth as a platform driver 
	part one
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Florian,

On Tue, Jul 28, 2009 at 11:00 PM, Florian Fainelli<florian@openwrt.org> wrote:
> --- a/arch/mips/alchemy/common/platform.c
> +++ b/arch/mips/alchemy/common/platform.c
> @@ -331,6 +331,61 @@ static struct platform_device pbdb_smbus_device = {
>  };
>  #endif
>
> +/* All Alchemy board have at least one Ethernet MAC */

Au1200/1300 don't have a MAC (unfortunately, IMO).


>  static int __init au1xxx_platform_init(void)
>  {
>        unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
> -       int i;
> +       int i, ni;
>
>        /* Fill up uartclk. */
>        for (i = 0; au1x00_uart_data[i].flags; i++)
>                au1x00_uart_data[i].uartclk = uartclk;
>
> +       /* Register second MAC if enabled in pinfunc */
> +#ifndef CONFIG_SOC_AU1100
> +        ni = (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
> +        if (!(ni + 1))
> +               platform_device_register(&au1xxx_eth1_device);
> +#endif
> +

This won't work on Au1200/Au1300 since their SYS_PINFUNC register
has a different bit layout.


And you already know that I'm not very fond of alchemy/common/platform.c ;-)
I still think you should add appropriate MAC platform information to the boards
which actually use it.

Manuel Lauss
