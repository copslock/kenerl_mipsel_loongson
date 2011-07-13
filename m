Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2011 22:40:04 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:56327 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491187Ab1GMUjz convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jul 2011 22:39:55 +0200
Received: by yxj20 with SMTP id 20so2980678yxj.36
        for <multiple recipients>; Wed, 13 Jul 2011 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=J+JwlHC2XZThFQvj6GRIBMdaBb57R+z5U405CA/y3RA=;
        b=TZIYcgziIDOYvUd0kQwrf8Ldanf2YZsAjqksk0FvDENiAwWNQS/UPNYat/+R0D2fHO
         Lp+sqg7e0bfEz0YFqodg96Mk6PJLqr5HOrp0dVtSGRpF2ExJ7hjm1zbtNKiNVPuVZVsu
         v3zD9QSn2zg7CziPi7q2DWy6/mN/P8ZKEjQLY=
Received: by 10.150.175.13 with SMTP id x13mr1617820ybe.355.1310589589166;
 Wed, 13 Jul 2011 13:39:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.158.21 with HTTP; Wed, 13 Jul 2011 13:39:29 -0700 (PDT)
In-Reply-To: <1310209563-6405-6-git-send-email-hauke@hauke-m.de>
References: <1310209563-6405-1-git-send-email-hauke@hauke-m.de> <1310209563-6405-6-git-send-email-hauke@hauke-m.de>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 13 Jul 2011 22:39:29 +0200
Message-ID: <CAOiHx=mpRNUtmLHFBw4n9XC4-cf4agc1tn4_twYFvz7=TQStzQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] bcma: add mips driver
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        zajec5@gmail.com, linux-mips@linux-mips.org, mb@bu3sch.de,
        george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9681

On 9 July 2011 13:05, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
> index 2ca5eeb..ba9a357 100644
> --- a/drivers/bcma/main.c
> +++ b/drivers/bcma/main.c
> @@ -79,6 +79,7 @@ static int bcma_register_cores(struct bcma_bus *bus)
>                case BCMA_CORE_CHIPCOMMON:
>                case BCMA_CORE_PCI:
>                case BCMA_CORE_PCIE:
> +               case BCMA_CORE_MIPS_74K:
>                        continue;
>                }
>
> @@ -138,6 +139,15 @@ int bcma_bus_register(struct bcma_bus *bus)
>                bcma_core_chipcommon_init(&bus->drv_cc);
>        }
>
> +#ifdef CONFIG_BCMA_DRIVER_MIPS
> +       /* Init MIPS core */
> +       core = bcma_find_core(bus, BCMA_CORE_MIPS_74K);
> +       if (core) {
> +               bus->drv_mips.core = core;
> +               bcma_core_mips_init(&bus->drv_mips);
> +       }
> +#endif

You could avoid the ugly ifdefs here by moving it to
bcma_driver_mips.h and change

extern void bcma_core_mips_init(struct bcma_drv_mips *mcore);

to
#ifdef CONFIG_BCMA_DRIVER_MIPS
extern void bcma_core_mips_init(struct bcma_drv_mips *mcore);
#else
static inline void bcma_core_mips_init(struct bcma_drv_mips *mcore) { }
#endif

assuming the bus->drv_mips.core being set doesn't have any side
effects in the no mips core driver case.

> +
>        /* Init PCIE core */
>        core = bcma_find_core(bus, BCMA_CORE_PCIE);
>        if (core) {
> @@ -200,6 +210,15 @@ int __init bcma_bus_early_register(struct bcma_bus *bus,
>                bcma_core_chipcommon_init(&bus->drv_cc);
>        }
>
> +#ifdef CONFIG_BCMA_DRIVER_MIPS
> +       /* Init MIPS core */
> +       core = bcma_find_core(bus, BCMA_CORE_MIPS_74K);
> +       if (core) {
> +               bus->drv_mips.core = core;
> +               bcma_core_mips_init(&bus->drv_mips);
> +       }
> +#endif

Ditto.
