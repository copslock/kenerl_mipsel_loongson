Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Oct 2017 12:57:21 +0200 (CEST)
Received: from mail-wm0-x22f.google.com ([IPv6:2a00:1450:400c:c09::22f]:46700
        "EHLO mail-wm0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990491AbdJDK5LZm17R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Oct 2017 12:57:11 +0200
Received: by mail-wm0-x22f.google.com with SMTP id m72so22062541wmc.1
        for <linux-mips@linux-mips.org>; Wed, 04 Oct 2017 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=g/+1E/FvCLLpqRNlBJJtsv9jHbbXVzj0tq0l82riPAI=;
        b=IMOK+hQJpd7T01oxR8jmVwL2i2Q7aAE4o6bOj/bOJsvxkoojcj6TcXznMbMmqSF65c
         iCreH+7exoi0V5lc0GTFa0x3C7Gh3VR9CMPbaOO7mERnHGtocFeXZZxe340VDGOWV4N5
         bP3fch/f3tCfqgmrsnvkRR4297C7ecvS/4NqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=g/+1E/FvCLLpqRNlBJJtsv9jHbbXVzj0tq0l82riPAI=;
        b=SH8nv5UkHZWHDkLLFyXC65jpz66HBzgoOihEl3S6pFbyGKnRqcRTvD9gK/Pqpq4kK3
         mmJsTsDSnl2y0Emmvuyr/6OoA18x6q4xwhCcfYQVuFTy+Y5PkOoebV9l+qPy/+uz8N/K
         Dcd87l1meKchx74V1MyY5K2+9mvbisw+tuiZ51V9zanXelF0I4CcPyJASPFQtYzck/6J
         GdbKDt9teKmiTlHi9woXLcKWcIToavBzX6WUkR3AgBURGSb9BwgTAsI3jypthLAuKyNg
         azJrgO9C3Z0vGBCQN+CdSUgrUJfiJOqC8fcw3PrwzK8V8rOQ0+NkDLgtMWf3FulMhUk4
         C11A==
X-Gm-Message-State: AHPjjUjM25zcj5k2tky7PT8EfGl+aAMP3FF3dHGEfZnAaHS4/fGknT41
        NxEx9y0r7RXZmut9qQb2oRWdDg==
X-Google-Smtp-Source: AOwi7QAXmf4V5xxqGsEyyv14J9FEIqG9vZruV1b3Am2sycy/02/yTVIx6yk1xd/lTdpZEhMmPxPIbg==
X-Received: by 10.80.212.40 with SMTP id t40mr28803272edh.67.1507114625862;
        Wed, 04 Oct 2017 03:57:05 -0700 (PDT)
Received: from dell ([2.27.167.120])
        by smtp.gmail.com with ESMTPSA id h33sm13528445edh.70.2017.10.04.03.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Oct 2017 03:57:05 -0700 (PDT)
Date:   Wed, 4 Oct 2017 11:57:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/7] i2c: gpio: Convert to use descriptors
Message-ID: <20171004105703.qmahtqieimw4kn3p@dell>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170917093906.16325-2-linus.walleij@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lee.jones@linaro.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, 17 Sep 2017, Linus Walleij wrote:

> This converts the GPIO-based I2C-driver to using GPIO
> descriptors instead of the old global numberspace-based
> GPIO interface. We:
> 
> - Convert the driver to unconditionally grab two GPIOs
>   from the device by index 0 (SDA) and 1 (SCL) which
>   will work fine with device tree and descriptor tables.
>   The existing device trees will continue to work just
>   like before, but without any roundtrip through the
>   global numberspace.
> 
> - Brutally convert all boardfiles still passing global
>   GPIOs by registering descriptor tables associated with
>   the devices instead so this driver does not need to keep
>   supporting passing any GPIO numbers as platform data.
> 
> There is no stepwise approach as elegant as this, I
> strongly prefer this big hammer over any antsteps for this
> conversion. This way the old GPIO numbers go away and
> NEVER COME BACK.
> 
> Special conversion for the different boards utilizing
> I2C-GPIO:
> 
> - EP93xx (arch/arm/mach-ep93xx): pretty straight forward as
>   all boards were using the same two GPIO lines, just define
>   these two in a lookup table for "i2c-gpio" and register
>   these along with the device. None of them define any
>   other platform data so just pass NULL as platform data.
>   This platform selects GPIOLIB so all should be smooth.
>   The pins appear on a gpiochip for bank "G" as pins 1 (SDA)
>   and 0 (SCL).
> 
> - IXP4 (arch/arm/mach-ixp4): descriptor tables have to
>   be registered for each board separately. They all use
>   "IXP4XX_GPIO_CHIP" so it is pretty straight forward.
>   Most board define no other platform data than SCL/SDA
>   so they can drop the #include of <linux/i2c-gpio.h> and
>   assign NULL to platform data.
> 
>   The "goramo_mlr" (Goramo Multilink Router) board is a bit
>   worrisome: it implements its own I2C bit-banging in the
>   board file, and optionally registers an I2C serial port,
>   but claims the same GPIO lines for itself in the board file.
>   This is not going to work: there will be competition for the
>   GPIO lines, so delete the optional extra I2C bus instead, no
>   I2C devices are registered on it anyway, there are just hints
>   that it may contain an EEPROM that may be accessed from
>   userspace. This needs to be fixed up properly by the serial
>   clock using I2C emulation so drop a note in the code.
> 
> - KS8695 board acs5k (arch/arm/mach-ks8695/board-acs5.c)
>   has some platform data in addition to the pins so it needs to
>   be kept around sans GPIO lines. Its GPIO chip is named
>   "KS8695" and the arch selects GPIOLIB.
> 
> - PXA boards (arch/arm/mach-pxa/*) use some of the platform
>   data so it needs to be preserved here. The viper board even
>   registers two GPIO I2Cs. The gpiochip is named "gpio-pxa" and
>   the arch selects GPIOLIB.
> 
> - SA1100 Simpad (arch/arm/mach-sa1100/simpad.c) defines a GPIO
>   I2C bus, and the arch selects GPIOLIB.
> 
> - Blackfin boards (arch/blackfin/bf533 etc) for these I assume
>   their I2C GPIOs refer to the local gpiochip defined in
>   arch/blackfin/kernel/bfin_gpio.c names "BFIN-GPIO".
>   The arch selects GPIOLIB. The boards get spiked with
>   IF_ENABLED(I2C_GPIO) but that is a side effect of it
>   being like that already (I would just have Kconfig select
>   I2C_GPIO and get rid of them all.) I also delete any
>   platform data set to 0 as it will get that value anyway
>   from static declartions of platform data.
> 
> - The MIPS selects GPIOLIB and the Alchemy machine is using
>   two local GPIO chips, one of them has a GPIO I2C. We need
>   to adjust the local offset from the global number space here.
>   The ATH79 has a proper GPIO driver in drivers/gpio/gpio-ath79.c
>   and AFAICT the chip is named "ath79-gpio" and the PB44
>   PCF857x expander spawns from this on GPIO 1 and 0. The latter
>   board only use the platform data to specify pins so it can be
>   cut altogether after this.
> 
> - The MFD Silicon Motion SM501 is a special case. It dynamically
>   spawns an I2C bus off the MFD using sm501_create_subdev().
>   We use an approach to dynamically create a machine descriptor
>   table and attach this to the "SM501-LOW" or "SM501-HIGH"
>   gpiochip. We use chip-local offsets to grab the right lines.
>   We can get rid of two local static inline helpers as part
>   of this refactoring.
> 
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: Heiko Schocher <hs@denx.de>
> Acked-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Fix a minor typo in error path (scl was sda from copy-paste)
> - Collected Olof's ACK
> 
> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.
> Lee: requesting ACK for Wolfram to take this patch.
> SM501 users: requesting Tested-by on this patch.
> ---
>  arch/arm/mach-ep93xx/core.c                  |  39 ++++----
>  arch/arm/mach-ep93xx/edb93xx.c               |  15 +--
>  arch/arm/mach-ep93xx/include/mach/platform.h |   4 +-
>  arch/arm/mach-ep93xx/simone.c                |  12 +--
>  arch/arm/mach-ep93xx/snappercl15.c           |  12 +--
>  arch/arm/mach-ep93xx/vision_ep9307.c         |   7 +-
>  arch/arm/mach-ixp4xx/avila-setup.c           |  17 +++-
>  arch/arm/mach-ixp4xx/dsmg600-setup.c         |  16 +++-
>  arch/arm/mach-ixp4xx/fsg-setup.c             |  16 +++-
>  arch/arm/mach-ixp4xx/goramo_mlr.c            |  24 ++---
>  arch/arm/mach-ixp4xx/ixdp425-setup.c         |  16 +++-
>  arch/arm/mach-ixp4xx/nas100d-setup.c         |  16 +++-
>  arch/arm/mach-ixp4xx/nslu2-setup.c           |  16 +++-
>  arch/arm/mach-ks8695/board-acs5k.c           |  13 ++-
>  arch/arm/mach-pxa/palmz72.c                  |  12 ++-
>  arch/arm/mach-pxa/viper.c                    |  27 +++++-
>  arch/arm/mach-sa1100/simpad.c                |  12 ++-
>  arch/blackfin/mach-bf533/boards/blackstamp.c |  19 +++-
>  arch/blackfin/mach-bf533/boards/ezkit.c      |  18 +++-
>  arch/blackfin/mach-bf533/boards/stamp.c      |  18 +++-
>  arch/blackfin/mach-bf561/boards/ezkit.c      |  18 +++-
>  arch/mips/alchemy/board-gpr.c                |  19 +++-
>  arch/mips/ath79/mach-pb44.c                  |  16 +++-
>  drivers/i2c/busses/i2c-gpio.c                | 134 +++++++++++++--------------
>  drivers/mfd/sm501.c                          |  49 +++++-----

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
