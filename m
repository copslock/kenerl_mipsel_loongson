Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2011 21:52:41 +0200 (CEST)
Received: from mail-yi0-f49.google.com ([209.85.218.49]:51785 "EHLO
        mail-yi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491187Ab1GMTwd convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jul 2011 21:52:33 +0200
Received: by yib17 with SMTP id 17so2962616yib.36
        for <multiple recipients>; Wed, 13 Jul 2011 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=neyNCn8R8SqY+9G0hSyBpFahem1RRmEMUaDTRUv12EI=;
        b=IVQgN9OJkj8NUfYUnRNdEnBNvarmHYvVvOz+vi0c2aieIYmx5pXs6KIe5KaMfCuwhk
         GWgN7gTEGE+uM1Os/mkKoaHBzRLOzvmzIFa4xaP6ve2WMvm8Pz5wfAxq+0/DXbBKbhbk
         KnOock3S1JnxnQC+Bk9n1r7O81iGD//F4+jF8=
Received: by 10.151.21.17 with SMTP id y17mr1670718ybi.13.1310586747120; Wed,
 13 Jul 2011 12:52:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.158.21 with HTTP; Wed, 13 Jul 2011 12:52:07 -0700 (PDT)
In-Reply-To: <1310209563-6405-11-git-send-email-hauke@hauke-m.de>
References: <1310209563-6405-1-git-send-email-hauke@hauke-m.de> <1310209563-6405-11-git-send-email-hauke@hauke-m.de>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 13 Jul 2011 21:52:07 +0200
Message-ID: <CAOiHx=myVVQYJumwhy7FwoSp5-mebhryDs1xnKMLCZpn=NP-7Q@mail.gmail.com>
Subject: Re: [PATCH 10/11] bcm47xx: add support for bcma bus
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        zajec5@gmail.com, linux-mips@linux-mips.org, mb@bu3sch.de,
        george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9641

On 9 July 2011 13:06, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This patch add support for the bcma bus. Broadcom uses only Mips 74K
> CPUs on the new SoC and on the old ons using ssb bus there are no Mips
> 74K CPUs.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/bcm47xx/Kconfig                    |   13 ++++++
>  arch/mips/bcm47xx/gpio.c                     |   22 +++++++++++
>  arch/mips/bcm47xx/nvram.c                    |   10 +++++
>  arch/mips/bcm47xx/serial.c                   |   29 ++++++++++++++
>  arch/mips/bcm47xx/setup.c                    |   53 +++++++++++++++++++++++++-
>  arch/mips/bcm47xx/time.c                     |    5 ++
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    8 ++++
>  arch/mips/include/asm/mach-bcm47xx/gpio.h    |   41 ++++++++++++++++++++
>  drivers/watchdog/bcm47xx_wdt.c               |   11 +++++
>  9 files changed, 190 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
> index 0346f92..6210b8d 100644
> --- a/arch/mips/bcm47xx/Kconfig
> +++ b/arch/mips/bcm47xx/Kconfig
> @@ -15,4 +15,17 @@ config BCM47XX_SSB
>
>         This will generate an image with support for SSB and MIPS32 R1 instruction set.
>
> +config BCM47XX_BCMA
> +       bool "BCMA Support for Broadcom BCM47XX"
> +       select SYS_HAS_CPU_MIPS32_R2
> +       select BCMA
> +       select BCMA_HOST_SOC
> +       select BCMA_DRIVER_MIPS
> +       select BCMA_DRIVER_PCI_HOSTMODE if PCI
> +       default y
> +       help
> +        Add support for new Broadcom BCM47xx boards with Broadcom specific Advanced Microcontroller Bus.
> +
> +        This will generate an image with support for BCMA and MIPS32 R2 instruction set.
> +

BCM47XX_SSB and BCM47XX_BCMA should either exclude each other, or
SYS_HAS_CPU_MIPS32_R2 should only be selected when BCM47XX_SSB isn't
selected.
I would expect an image built when having both selected to also
support both systems, but selecting MIPS32_R2 as the CPU this will
make it actually not work on SSB systems.

> diff --git a/arch/mips/bcm47xx/gpio.c b/arch/mips/bcm47xx/gpio.c
> index 3320e91..9d5bafe 100644
> --- a/arch/mips/bcm47xx/gpio.c
> +++ b/arch/mips/bcm47xx/gpio.c
> @@ -36,6 +36,16 @@ int gpio_request(unsigned gpio, const char *tag)
>
>                return 0;
>  #endif
> +#ifdef CONFIG_BCM47XX_BCMA
> +       case BCM47XX_BUS_TYPE_BCMA:
> +               if ((unsigned)gpio >= BCM47XX_CHIPCO_GPIO_LINES)

gpio is already unsigned, you shouldn't need to cast it.

> +                       return -EINVAL;
> +
> +               if (test_and_set_bit(gpio, gpio_in_use))
> +                       return -EBUSY;
> +
> +               return 0;
> +#endif
>        }
>        return -EINVAL;
>  }
> @@ -57,6 +67,14 @@ void gpio_free(unsigned gpio)
>                clear_bit(gpio, gpio_in_use);
>                return;
>  #endif
> +#ifdef CONFIG_BCM47XX_BCMA
> +       case BCM47XX_BUS_TYPE_BCMA:
> +               if ((unsigned)gpio >= BCM47XX_CHIPCO_GPIO_LINES)

Ditto.
