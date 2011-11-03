Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2011 23:04:40 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:50222 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904057Ab1KCWEe convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Nov 2011 23:04:34 +0100
Received: by faaq17 with SMTP id q17so2664274faa.36
        for <multiple recipients>; Thu, 03 Nov 2011 15:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1tZE7ezX44ehJ5LMMaO0LxfTRN4D65Tb/nGLmn5edCM=;
        b=GTGF5zP2VIPZ/BA7q3fJMdzOGY0Qt9xTY2d+00tKjghe2gg8aV81h/oJO0cFBHZrpR
         VcRqT1DGJV5Ce1kEDgZl5XWYZN8QvCS6/A36fcT0pyxiaZAMPvITOZn2UEPDX3HwXFP+
         d38Le6t5SabOe4QtwFBTXnADz6sH+9lsCTRYg=
Received: by 10.223.1.137 with SMTP id 9mr18793831faf.19.1320357869138; Thu,
 03 Nov 2011 15:04:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.105.141 with HTTP; Thu, 3 Nov 2011 15:04:08 -0700 (PDT)
In-Reply-To: <2526064.yKTpR1Kdyv@flexo>
References: <2526064.yKTpR1Kdyv@flexo>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 3 Nov 2011 23:04:08 +0100
Message-ID: <CAOiHx=mHcdRc1UpTo20=eO8nydx9D-qtEUjZvRyzc1Ab7g8QpQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47xxx: fix build with GENERIC_GPIO configuration
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3078

Hi,

On 3 November 2011 16:05, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Since eb9ae7f2 (gpio: fix build error in include/asm-generic/gpio.h)
> the generic version of gpio.h calls __gpio_{set,get}_value which we
> do not define. Get rid of asm-generic/gpio.h and define the missing
> stubs directly for BCM47xx to build.
>
> Reported-by: Ralf Baechle <ralf@linux-mips.org>
> CC: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/include/asm/mach-bcm47xx/gpio.h b/arch/mips/include/asm/mach-bcm47xx/gpio.h
> index 76961ca..26cc815 100644
> --- a/arch/mips/include/asm/mach-bcm47xx/gpio.h
> +++ b/arch/mips/include/asm/mach-bcm47xx/gpio.h
> @@ -36,6 +36,8 @@ static inline int gpio_get_value(unsigned gpio)
>        return -EINVAL;
>  }
>
> +#define gpio_get_value_cansleep        gpio_get_value
> +
>  static inline void gpio_set_value(unsigned gpio, int value)
>  {
>        switch (bcm47xx_bus_type) {
> @@ -54,6 +56,19 @@ static inline void gpio_set_value(unsigned gpio, int value)
>        }
>  }
>
> +#define gpio_set_value_cansleep gpio_set_value
> +
> +static inline int gpio_cansleep(unsigned gpio)
> +{
> +       return 0;
> +}
> +
> +static inline int gpio_is_valid(unsigned gpio)
> +{
> +       return gpio < (BCM47XX_EXTIF_GPIO_LINES + BCM47XX_EXTIF_GPIO_LINES);

This looks wrong; did you perhaps mean BCM47XX_EXTIF_GPIO_LINES +
BCM47XX_CHIPCO_GPIO_LINES?

BCM47XX_CHIPCO_GPIO_LINES (=16) is bigger than (2 *
BCM47XX_EXTIF_GPIO_LINES(=5)), which would make the upper 6 chipco
gpios always invalid.


Regards,
Jonas
