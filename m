Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 23:53:22 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:55658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007995AbbK3WxRfALGy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 23:53:17 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 01F9E20672
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 22:53:15 +0000 (UTC)
Received: from mail-yk0-f179.google.com (mail-yk0-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7482C20662
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 22:53:13 +0000 (UTC)
Received: by ykdv3 with SMTP id v3so203312729ykd.0
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 14:53:12 -0800 (PST)
X-Received: by 10.13.201.131 with SMTP id l125mr60972092ywd.150.1448923992743;
 Mon, 30 Nov 2015 14:53:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.254.65 with HTTP; Mon, 30 Nov 2015 14:52:53 -0800 (PST)
In-Reply-To: <1448900513-20856-2-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com> <1448900513-20856-2-git-send-email-paul.burton@imgtec.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Nov 2015 16:52:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ3cZEbWT_Ycrb1euWJ05cN31wOYikbwKhZSEyFu2rkrA@mail.gmail.com>
Message-ID: <CAL_JsqJ3cZEbWT_Ycrb1euWJ05cN31wOYikbwKhZSEyFu2rkrA@mail.gmail.com>
Subject: Re: [PATCH 01/28] serial: earlycon: allow MEM32 I/O for DT earlycon
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Mon, Nov 30, 2015 at 10:21 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> Read the reg-io-width property when earlycon is setup via device tree,
> and set the I/O type to UPIO_MEM32 when 4 is read. This behaviour
> matches that of the of_serial driver, and is needed for DT configured
> earlycon on the MIPS Boston board.
>
> Note that this is only possible when CONFIG_LIBFDT is enabled, but
> enabling it everywhere seems like overkill. Thus systems that need this
> functionality should select CONFIG_LIBFDT for themselves.

libfdt is enabled if you are booting from DT, so checking this
property should not add anything.

>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
>  drivers/of/fdt.c              |  2 +-
>  drivers/tty/serial/Makefile   |  1 +
>  drivers/tty/serial/earlycon.c | 15 ++++++++++++++-
>  include/linux/serial_core.h   |  2 +-
>  4 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d243029..71c7f0d 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -833,7 +833,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
>                 if (addr == OF_BAD_ADDR)
>                         return -ENXIO;
>
> -               of_setup_earlycon(addr, match->data);
> +               of_setup_earlycon(fdt, offset, addr, match->data);
>                 return 0;
>         }
>         return -ENODEV;
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 5ab4111..1d290d6 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_SERIAL_21285) += 21285.o
>
>  obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
>  obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
> +CFLAGS_earlycon.o += -I$(srctree)/scripts/dtc/libfdt

This is no longer necessary.

>
>  # These Sparc drivers have to appear before others such as 8250
>  # which share ttySx minor node space.  Otherwise console device
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index f096360..2b936a7 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -17,6 +17,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/libfdt.h>
>  #include <linux/serial_core.h>
>  #include <linux/sizes.h>
>  #include <linux/mod_devicetable.h>
> @@ -196,17 +197,29 @@ static int __init param_setup_earlycon(char *buf)
>  }
>  early_param("earlycon", param_setup_earlycon);
>
> -int __init of_setup_earlycon(unsigned long addr,
> +int __init of_setup_earlycon(const void *fdt, int offset, unsigned long addr,

I would add iotype as a parameter instead, and then...

>                              int (*setup)(struct earlycon_device *, const char *))
>  {
>         int err;
>         struct uart_port *port = &early_console_dev.port;
> +       const __be32 *prop;
>
>         port->iotype = UPIO_MEM;
>         port->mapbase = addr;
>         port->uartclk = BASE_BAUD * 16;
>         port->membase = earlycon_map(addr, SZ_4K);
>
> +       if (config_enabled(CONFIG_LIBFDT)) {
> +               prop = fdt_getprop(fdt, offset, "reg-io-width", NULL);
> +               if (prop) {
> +                       switch (be32_to_cpup(prop)) {
> +                       case 4:
> +                               port->iotype = UPIO_MEM32;
> +                               break;
> +                       }
> +               }

...move this parsing into fdt.c where we parse the address.

Rob
