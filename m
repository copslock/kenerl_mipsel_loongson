Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 15:25:42 +0100 (CET)
Received: from mail-la0-f47.google.com ([209.85.215.47]:38695 "EHLO
        mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012541AbaKJOZkaIzHq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 15:25:40 +0100
Received: by mail-la0-f47.google.com with SMTP id gd6so7803859lab.34
        for <linux-mips@linux-mips.org>; Mon, 10 Nov 2014 06:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=GIwXalY/+P3wVg3bLU5NEHble1Nn0r+LpZsCGEL4lqg=;
        b=mDlOYfhixbw1pdv/vm/sYIne0AMgcQziSRGVzBT2KWZVH81mt0V02pWGdNkG2cR3tI
         apA/GCfpvpu1s3+DHcOv3WKkP+Jhz6CKUQp0hYFWBguJjxaGIZJJscCBmal/9LJ7M6bl
         D8h/HuPXqI24CWm983zGWueF2L09cxigGJupI1aQOOJDU9bMiGvQVzoqt3aFhpMdK607
         4XZsgD/xiEs610P7uXMAggUqK60uUq/xjDP3/M6ckmZfI7T6ImUXBrWTksi7WT4PeX/l
         I5K56+f7Mbn4rNx3FhW8oxSGo8BxqTIaHut2Y14qx72BK+ovP0tBS5mw1VkF1FgZ8q9E
         W6XQ==
X-Received: by 10.152.20.130 with SMTP id n2mr14626247lae.39.1415629534800;
 Mon, 10 Nov 2014 06:25:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.112.11.233 with HTTP; Mon, 10 Nov 2014 06:25:14 -0800 (PST)
In-Reply-To: <1415523348-4631-2-git-send-email-cernekee@gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com> <1415523348-4631-2-git-send-email-cernekee@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Nov 2014 08:25:14 -0600
X-Google-Sender-Auth: pIxtYU8NSuquWiJxlzL2oTxAgek
Message-ID: <CAL_JsqLXznpCo3YjN+XqF6cDG38C6dKzO9DHJmzi6=sNnAU=hQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: bcm63xx: Allow device nodes to be
 renamed to /dev/ttyBCM*
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Grant Likely <grant.likely@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43954
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

On Sun, Nov 9, 2014 at 2:55 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> By default, bcm63xx_uart.c uses the standard 8250 device naming and
> major/minor numbers.  There are at least two situations where this could
> be a problem:
>
> 1) Multiplatform kernels that need to support some chips that have 8250
> UARTs and other chips that have bcm63xx UARTs.
>
> 2) Some older chips like BCM7125 have a mix of both UART types.
>
> Add a new Kconfig option to tell the driver whether to register itself
> as ttyS or ttyBCM.  By default it will retain the existing "ttyS"
> behavior to avoid surprises.

While I understand the desire to have stable names, this is the
opposite direction we want to go. Per platform tty names complicates
having a generic userspace. It is not so bad since most ARM platforms
use ttyS or ttyAMA, but just think what the kernel and userspace side
would look like if every single platform did this. We can't change
everything to ttyS because the other names are already an ABI.

This can be solved with a udev rule to create sym links. Or if you
just need to know which dev node is h/w uart X, you can get that from
sysfs.

Rob

> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/tty/serial/Kconfig        | 11 +++++++++++
>  drivers/tty/serial/bcm63xx_uart.c |  8 ++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index fdd851e..c82cfd2 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1302,6 +1302,17 @@ config SERIAL_BCM63XX_CONSOLE
>           If you have enabled the serial port on the BCM63xx CPU
>           you can make it the console by answering Y to this option.
>
> +config SERIAL_BCM63XX_TTYS
> +       bool "Use ttyS[01] device nodes for bcm63xx_uart"
> +       depends on SERIAL_BCM63XX
> +       default y
> +       help
> +         Say Y to name the serial ports /dev/ttyS0, ttyS1, ...
> +         This conflicts with the 8250 driver but may avoid breaking
> +         compatibility with existing init scripts.
> +
> +         Say N to name the serial ports /dev/ttyBCM0, ttyBCM1, ...
> +
>  config SERIAL_GRLIB_GAISLER_APBUART
>         tristate "GRLIB APBUART serial support"
>         depends on OF && SPARC
> diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
> index e04e580..9f3dcc8 100644
> --- a/drivers/tty/serial/bcm63xx_uart.c
> +++ b/drivers/tty/serial/bcm63xx_uart.c
> @@ -751,7 +751,11 @@ static int bcm_console_setup(struct console *co, char *options)
>  static struct uart_driver bcm_uart_driver;
>
>  static struct console bcm63xx_console = {
> +#ifdef CONFIG_SERIAL_BCM63XX_TTYS
>         .name           = "ttyS",
> +#else
> +       .name           = "ttyBCM",
> +#endif
>         .write          = bcm_console_write,
>         .device         = uart_console_device,
>         .setup          = bcm_console_setup,
> @@ -796,9 +800,13 @@ OF_EARLYCON_DECLARE(bcm63xx_uart, "brcm,bcm6345-uart", bcm_early_console_setup);
>  static struct uart_driver bcm_uart_driver = {
>         .owner          = THIS_MODULE,
>         .driver_name    = "bcm63xx_uart",
> +#ifdef CONFIG_SERIAL_BCM63XX_TTYS
>         .dev_name       = "ttyS",
>         .major          = TTY_MAJOR,
>         .minor          = 64,
> +#else
> +       .dev_name       = "ttyBCM",
> +#endif
>         .nr             = BCM63XX_NR_UARTS,
>         .cons           = BCM63XX_CONSOLE,
>  };
> --
> 2.1.1
>
