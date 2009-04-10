Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Apr 2009 09:43:56 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.244]:20032 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20032966AbZDJInu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Apr 2009 09:43:50 +0100
Received: by an-out-0708.google.com with SMTP id c3so624791ana.24
        for <linux-mips@linux-mips.org>; Fri, 10 Apr 2009 01:43:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cTc9/pYgPvSIfHhi403XRdNNDEsqDFKlxIpHbW+42/s=;
        b=EmzyX3tLNqd/ITcRbojrzuyOdrrUJrtIZAFmvemC2hnxLfTiw27TvvKnDsR9vR5WXH
         iIYWozwTsCKHhVWkcNhVutu7dF4jxpQU3OwM5sMTWwEGV0ZbKgTuY/1Qpb13uuUziRAz
         G5h5lGKZ+VgeqiKd7hljGB0v9Q39HHfmJGwgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=lYX4a5AtotUWVNAt3p5k9JM0nqAVUh3riCG96dEULSEpqxK07J4W5XjLlLBrIYeqDr
         XEwRat8qoIXE0vGE0SklQk/I7EGEqZtLltT7/dxCsbroE0Kw3CypraIZLri3ghfY/iBY
         VR5jGDP/ixFZqD5NJvKY1hVqv8oeerCkw3Gjo=
Received: by 10.100.57.13 with SMTP id f13mr2108738ana.77.1239353028680;
        Fri, 10 Apr 2009 01:43:48 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id b37sm4595272ana.19.2009.04.10.01.43.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Apr 2009 01:43:48 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH v3 1/2] Alchemy: rewrite GPIO support.
Date:	Fri, 10 Apr 2009 10:43:13 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
References: <1239299363-28762-1-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1239299363-28762-1-git-send-email-mano@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200904101043.13674.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Thursday 09 April 2009 19:49:22 Manuel Lauss, vous avez écrit :
> The current approach is not sufficiently generic for my needs:
> I want to use generic functions which deal with the GPIO1 and GPIO2
> blocks, but don't want the default gpio numberspace as imposed by the
> databooks;  instead I also want the option to register gpio_chips for
> my board with a custom gpio namespace.
>
> To address this, the following changes are made to the alchemy gpio
> code:
>
> - create linux-gpio-system compatible functions which deal with
>   manipulating the GPIO1/2 blocks.  These functions are universally
>   useful.
> - gpiolib is optional
>
>   If CONFIG_GPIOLIB is not enabled, provide the equivalent functions
>   by directly inlining the GPIO1/2 functions.  Obviously this limits
>   the usable GPIOs to those present on the Alchemy chip.  GPIOs can
>   be accessed as documented in the datasheets (GPIO0-31 and 200-215).
>
>   If CONFIG_GPIOLIB is selected, by default 2 gpio_chips for GPIO1/2
>   are registered, and the inlines are no longer usable.  The number-
>   space is as is documented in the datasheets.
>
>   However this is not yet flexible enough for my uses.  My Alchemy
>   systems have a documented "external" gpio interface (fixed number-
>   space) and can support a variety of baseboards, some of which are
>   equipped with I2C gpio expanders.  I want to be able to provide
>   the default 16 GPIOs of the CPU board numbered as 0..15 and also
>   support gpio expanders, if present, starting as gpio16.
>
>   To achieve this, a new Kconfig symbol for Alchemy is introduced,
>   CONFIG_ALCHEMY_GPIO_INDIRECT, which boards can enable to signal
>   that they are not okay with the default Alchemy GPIO functions AND
>   numberspace and want to provide their own.  This also works for both
>   CONFIG_GPIOLIB=y and CONFIG_GPIOLIB=n.  When this config symbol is
>   selected, boards must provide their own gpio_* functions; either in
>   a custom gpio.h header (in board include directory) or with gpio_chips.
>
>   To make the board-specific inlined gpio functions work, the MIPS
>   Makefile must be changed so that the mach-au1x00/gpio.h header is
>   included _after_ the board headers.
>
>   see arch/mips/include/asm/mach-au1x00/gpio.h for more info.

That's fine with me, I do not see obvious breakages for boards that will use 
the standard GPIO interface. Thanks for your work !

>
> Cc: Florian Fainelli <florian@openwrt.org>

Acked-by: <florian@openwrt.org>
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
