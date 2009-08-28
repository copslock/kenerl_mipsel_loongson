Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 11:08:17 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:36909 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492470AbZH1JIL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Aug 2009 11:08:11 +0200
Received: by ewy25 with SMTP id 25so1896835ewy.33
        for <multiple recipients>; Fri, 28 Aug 2009 02:08:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JXnLD3uzb+dd2tBln2OifXVUepWrCQkMJfqbEsX9UiI=;
        b=nRGX9PNLk04wwE2k2IBb6D3Lu+VdQnYLmbStGbw05zVuz+Ecz7cg9VQC7WF+kygbWy
         GTa71o4XQ/B1MKk3GaARn5bVkNWTJroSAzIkTYrpxTQOk4R5ua919dz3pkkQ3oZIGoEI
         x+kNOg6es404k6O4pM0l/Qdlu59IuahCc3wq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PmpEOPavp7/GIvCLBO0JSBDf8BnL/0ESCyiOhO5KN5KiEMwsBF//cBaSmDhtZIPvq0
         o5QVT63eUy3G7m9zHXJv9/uR75+LedJRE5Aj5YjARTRqWjipMRAU+H7+6ZrVPPhjSv88
         dJE4pe64i4n0DQBe7W6nRza4F8z/qoUmTkTPA=
Received: by 10.210.115.15 with SMTP id n15mr8656261ebc.43.1251450484742;
        Fri, 28 Aug 2009 02:08:04 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 10sm1747172eyz.9.2009.08.28.02.08.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 02:08:04 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: MTX build failure
Date:	Fri, 28 Aug 2009 11:07:59 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
References: <20090828074709.GA11637@linux-mips.org> <4A979B0E.106@gmail.com>
In-Reply-To: <4A979B0E.106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908281108.00945.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Friday 28 August 2009 10:53:34 Manuel Lauss, vous avez écrit :
> Ralf Baechle wrote:
> >   CC      drivers/input/keyboard/gpio_keys.o
> > /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c: In
> > function ‘gpio_keys_probe’:
> > /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:123:
> > error: implicit declaration of function ‘gpio_request’
> > /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:135:
> > error: implicit declaration of function ‘gpio_free’ make[5]: ***
> > [drivers/input/keyboard/gpio_keys.o] Error 1
> > make[4]: *** [drivers/input/keyboard] Error 2
> > make[3]: *** [drivers/input] Error 2
> > make[2]: *** [drivers] Error 2
> > make[1]: *** [sub-make] Error 2
>
> Either something like the patch below, or adding stubs for
> gpio_request/gpio_free to asm/mach-au1x00/gpio-au1000.h in the
> CONFIG_GPIOLIB=n case should fix it.

The patch below fixes it for me, so feel free to add my:
Tested-by: Florian Fainelli <florian@openwrt.org>

>
> diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
> index 1e0a6df..f0c930a 100644
> --- a/arch/mips/alchemy/Kconfig
> +++ b/arch/mips/alchemy/Kconfig
> @@ -20,6 +20,7 @@ config MIPS_MTX1
>  	select HW_HAS_PCI
>  	select SOC_AU1500
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
> +	select GPIOLIB
>
>  config MIPS_BOSPORUS
>  	bool "Alchemy Bosporus board"
>
>
> 	Manuel Lauss
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
