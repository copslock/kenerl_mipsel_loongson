Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 04:16:35 +0100 (CET)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:56936 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010101AbaKSDQdie6oy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 04:16:33 +0100
Received: by mail-wg0-f49.google.com with SMTP id x12so1533381wgg.36
        for <linux-mips@linux-mips.org>; Tue, 18 Nov 2014 19:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JHOzKPilAb3afJ7RVcFLXQtegwohRhcIEx9BobA/cXA=;
        b=o/XqiX6QlicjPI6k1RyQ6tv+R+3mTjIAsthPEdfqoyX+70pitaSe4U0B82yDAh9gsH
         MRR5Pr71KkwOsgNpeGBK3jxS1JkIUM0s8kL2aZqOoJRfq94gPblvNnNhgXvElpRLs30e
         RCrUnohm1DR4HCpEhYrC+F38sOaiJ3IOd1dxSHY7WC3K3vpxqbyt5jGry07HieO8RZNy
         sdioBbwMmTiioPvYYhDJ5f+cvl5GLo0x/810zCWOqH+nkDMrT1HcjJVR1gh8ypab9jor
         fRkLQcNZes9Rq7zD6tHleBuvG2xYOo99Kg9qfl5LdLzZXaVsOk9ioiCAEJOekmBiNmlN
         Y8NA==
X-Received: by 10.180.96.106 with SMTP id dr10mr9197889wib.58.1416366988387;
 Tue, 18 Nov 2014 19:16:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.91.207 with HTTP; Tue, 18 Nov 2014 19:16:08 -0800 (PST)
In-Reply-To: <1415825647-6024-10-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com> <1415825647-6024-10-git-send-email-cernekee@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Nov 2014 21:16:08 -0600
X-Google-Sender-Auth: JlSO93Jc1OzSizNKcKnnAV8kG_g
Message-ID: <CAL_JsqJ5+=kp-_bKiNxasB7gm1Pj4C6-FfO_+7DcyhvcgYEaAg@mail.gmail.com>
Subject: Re: [PATCH V2 09/10] serial: earlycon: Set UPIO_MEM32BE based on DT properties
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, Grant Likely <grant.likely@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Nov 12, 2014 at 2:54 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> If an earlycon (stdout-path) node is being used, check for "big-endian"
> or "native-endian" properties and pass the appropriate iotype to the
> driver.
>
> Note that LE sets UPIO_MEM (8-bit) but BE sets UPIO_MEM32BE (32-bit).  The
> big-endian property only really makes sense in the context of 32-bit
> registers, since 8-bit accesses never require data swapping.
>
> At some point, the of_earlycon code may want to pass in the reg-io-width,
> reg-offset, and reg-shift parameters too.
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/of/fdt.c              | 9 ++++++++-
>  drivers/tty/serial/earlycon.c | 4 ++--
>  include/linux/serial_core.h   | 2 +-
>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 30e97bc..15f80c9 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -10,6 +10,7 @@
>   */
>
>  #include <linux/kernel.h>
> +#include <linux/kconfig.h>
>  #include <linux/initrd.h>
>  #include <linux/memblock.h>
>  #include <linux/of.h>
> @@ -784,7 +785,13 @@ int __init early_init_dt_scan_chosen_serial(void)
>                 if (!addr)
>                         return -ENXIO;
>
> -               of_setup_earlycon(addr, match->data);
> +               if (fdt_getprop(fdt, offset, "big-endian", NULL) ||
> +                   (fdt_getprop(fdt, offset, "native-endian", NULL) &&

Is native-endian documented?

> +                    IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))) {
> +                       of_setup_earlycon(addr, UPIO_MEM32BE, match->data);
> +               } else {
> +                       of_setup_earlycon(addr, UPIO_MEM, match->data);
> +               }

I'd rather see something like this, so we can more easily add any
other properties later:

               iotype = 0;
               if (fdt_getprop(fdt, offset, "big-endian", NULL) ||
                   (fdt_getprop(fdt, offset, "native-endian", NULL) &&
                    IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)))
                          iotype = UPIO_MEM32BE;

               of_setup_earlycon(addr, iotype ? : UPIO_MEM, match->data);

>                 return 0;
>         }
>         return -ENODEV;
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index a514ee6..548f7d7 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -148,13 +148,13 @@ int __init setup_earlycon(char *buf, const char *match,
>         return 0;
>  }
>
> -int __init of_setup_earlycon(unsigned long addr,
> +int __init of_setup_earlycon(unsigned long addr, unsigned char iotype,
>                              int (*setup)(struct earlycon_device *, const char *))
>  {
>         int err;
>         struct uart_port *port = &early_console_dev.port;
>
> -       port->iotype = UPIO_MEM;
> +       port->iotype = iotype;
>         port->mapbase = addr;
>         port->uartclk = BASE_BAUD * 16;
>         port->membase = earlycon_map(addr, SZ_4K);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index d2d5bf6..0d60c64 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -310,7 +310,7 @@ struct earlycon_device {
>  int setup_earlycon(char *buf, const char *match,
>                    int (*setup)(struct earlycon_device *, const char *));
>
> -extern int of_setup_earlycon(unsigned long addr,
> +extern int of_setup_earlycon(unsigned long addr, unsigned char iotype,
>                              int (*setup)(struct earlycon_device *, const char *));
>
>  #define EARLYCON_DECLARE(name, func) \
> --
> 2.1.1
>
