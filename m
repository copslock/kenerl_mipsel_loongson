Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 11:28:17 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:63967 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012035AbaJVJ2PjS3kn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 11:28:15 +0200
Received: by mail-la0-f46.google.com with SMTP id gi9so2607295lab.33
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 02:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sZXti4+C1SGXAfX4QEvtbvPXBBl3OO8r10AgsAIDFBg=;
        b=wM95iQrp6SmT8ua9+WRVOa/GVVfuq0V1nO2gJ8iIo4BHq+3nAp0eyOdAdmQxn7OujD
         B0D8132SpsNJp/Xqf57DaHLt319LhIoetT6pzLBFALw9tr7rTLxBzPstnO5S4pE3L09v
         /3qOWpJOa3gRkGW3vwsAhm387RtK96cDbsXGkOjDsN93TsQBBrS1+fo+Xg76FS1TmyCz
         fdUjFxY/lWhZYkG5o/W3etG6ApEMIMkldvdhBDRIJy5TfMWGEAH1VNiANJ/75Pabj0vk
         t0hE8Tq573K3MtZ2kwYXCAXtnzsF+AJDJLdGthZSaMGSy8DwCj8TbFCX6AENhOAdrdFS
         IMQQ==
X-Received: by 10.112.201.201 with SMTP id kc9mr34109565lbc.76.1413970089995;
 Wed, 22 Oct 2014 02:28:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.11.233 with HTTP; Wed, 22 Oct 2014 02:27:49 -0700 (PDT)
In-Reply-To: <1413930186-23168-10-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com> <1413930186-23168-10-git-send-email-cernekee@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Oct 2014 17:27:49 +0800
X-Google-Sender-Auth: LTCXN1Bs1ZoAgWVNMgrNlYJ6UL0
Message-ID: <CAL_Jsq+AuqTOU7UFdYi28YGjL1QorY=3zOSccN43Vb1a=q6SHw@mail.gmail.com>
Subject: Re: [PATCH V3 09/10] tty: serial: of-serial: Allow OF earlycon to
 default to "on"
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Grant Likely <grant.likely@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Florian Fainelli <f.fainelli@gmail.com>, mbizon@freebox.fr,
        Jonas Gorski <jogo@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43477
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

On Wed, Oct 22, 2014 at 6:23 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> On many development systems it is very common to see failures during the
> early stages of the boot process, e.g. SMP boot or PCIe initialization.
> This is one likely reason why some existing earlyprintk implementations,
> such as arch/mips/kernel/early_printk.c, are enabled unconditionally
> at compile time.
>
> Now that earlycon's operating parameters can be passed into the kernel
> via DT, it is helpful to be able to configure the kernel to turn it on
> automatically.  Introduce a new CONFIG_SERIAL_EARLYCON_FORCE option for
> this purpose.

You can already force this using the CMDLINE_EXTEND option. I'm not
sure we need more options.

>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/of/fdt.c           |  5 +++++
>  drivers/tty/serial/Kconfig | 11 +++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 20193cc..3e2ea1e 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1013,6 +1013,11 @@ bool __init early_init_dt_verify(void *params)
>
>  void __init early_init_dt_scan_nodes(void)
>  {
> +#ifdef CONFIG_SERIAL_EARLYCON_FORCE
> +       if (early_init_dt_scan_chosen_serial() < 0)
> +               pr_warn("Unable to set up earlycon from stdout-path\n");
> +#endif

Doesn't this make the earlycon get scanned and setup twice? Hopefully
that is safe...

This also introduces the scanning at another point in time during boot
which may not work depending on the arch.

Rob

> +
>         /* Retrieve various information from the /chosen node */
>         of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index fdd851e..bc4ebcc 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -14,6 +14,17 @@ config SERIAL_EARLYCON
>           the console before standard serial driver is probed. The console is
>           enabled when early_param is processed.
>
> +config SERIAL_EARLYCON_FORCE
> +       bool "Always enable early console"
> +       depends on SERIAL_EARLYCON
> +       help
> +         Traditionally, enabling the early console has required passing in
> +         the "earlycon" parameter on the kernel command line.  On systems
> +         under development it may be desirable to enable earlycon
> +         unconditionally rather than to force the user to manually add it
> +         to the boot argument string, as boot failures often occur before
> +         the standard serial driver is probed.
> +
>  source "drivers/tty/serial/8250/Kconfig"
>
>  comment "Non-8250 serial port support"
> --
> 2.1.1
>
