Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 11:58:06 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:64455 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492448AbZH1J6A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Aug 2009 11:58:00 +0200
Received: by ewy25 with SMTP id 25so1924013ewy.33
        for <multiple recipients>; Fri, 28 Aug 2009 02:57:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cD1OvI3OVifavFpuAPiIa6OuD2qi0XZY/MPU33S05t4=;
        b=Xy4qz3zGunyLjWiPUmTIv4OEjKZmznztCsiFCH+aHFE75mTTqUuiJ9KvQ+ChWcnrSU
         Hbu+mODRhBua7pIUwcxwH6pQGlg/O2YsFy957hmqkA6UcjrILQ91oOzk2vnVgWGFcLpA
         xdd+C5Q35tS6ajidadmBd3kVydkGfBm2mu038=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SmzgdATHwcRGilkcCnvfJPTYbM63SYCuxjcXICtYZ1gNQstQcsd5fzPuL8ze7huK8y
         52S3SVX/k5X+T0bOEBRJT0FbQG0E/+xxuGw+0awAWrJjd/jp9j+Tvzrbs8OgokJCTUxA
         WgWM3r/QxOFJycz5nklPqUA9E/lFHFjrZDVFo=
Received: by 10.210.136.1 with SMTP id j1mr20246ebd.74.1251453472321;
        Fri, 28 Aug 2009 02:57:52 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 7sm41136eyb.10.2009.08.28.02.57.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 02:57:51 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: MTX build failure
Date:	Fri, 28 Aug 2009 11:57:44 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
References: <20090828074709.GA11637@linux-mips.org> <4A979B0E.106@gmail.com> <4A97A2E2.2090108@gmail.com>
In-Reply-To: <4A97A2E2.2090108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908281157.47387.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Friday 28 August 2009 11:26:58 Manuel Lauss, vous avez écrit :
> I wrote:
> > Ralf Baechle wrote:
> >>   CC      drivers/input/keyboard/gpio_keys.o
> >> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c: In
> >> function ‘gpio_keys_probe’:
> >> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:123:
> >> error: implicit declaration of function ‘gpio_request’
> >> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:135:
> >> error: implicit declaration of function ‘gpio_free’ make[5]: ***
> >> [drivers/input/keyboard/gpio_keys.o] Error 1
> >> make[4]: *** [drivers/input/keyboard] Error 2
> >> make[3]: *** [drivers/input] Error 2
> >> make[2]: *** [drivers] Error 2
> >> make[1]: *** [sub-make] Error 2
> >
> > Either something like the patch below, or adding stubs for
> > gpio_request/gpio_free to asm/mach-au1x00/gpio-au1000.h in the
> > CONFIG_GPIOLIB=n case should fix it.
>
> Florian, Ralf, I prefer the latter approach;  saves everyone from
> having to add #ifdef CONFIG_GPIOLIB around gpio_request() calls.
>
> Here's an untested patch.  What do you think?  If it works for you, please
> add it to your patchqueue!
>
> Thanks!
>
> ---
>
> From: Manuel Lauss <manuel.lauss@gmail.com>
> Subject: [PATCH] Alchemy: add gpio_request/gpio_free stubs for
> CONFIG_GPIOLIB=n
>
> Some drivers use gpio_request/gpio_free regardless of whether
> gpiolib is actually built;  add stubs to work around the ensuing
> compile failures.

This is better, though fixing the gpio keyboard driver might probably be a good approach.

>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Tested-by: Florian Fainelli <florian@openwrt.org>

> ---
>  arch/mips/include/asm/mach-au1x00/gpio-au1000.h |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
> b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h index 127d4ed..feea001
> 100644
> --- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
> +++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
> @@ -578,6 +578,15 @@ static inline int irq_to_gpio(int irq)
>  	return alchemy_irq_to_gpio(irq);
>  }
>
> +static inline int gpio_request(unsigned gpio, const char *label)
> +{
> +	return 0;
> +}
> +
> +static inline void gpio_free(unsigned gpio)
> +{
> +}
> +
>  #endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
>
>
> --
> 1.6.4.1
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
