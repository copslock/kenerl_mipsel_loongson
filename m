Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2015 04:55:19 +0100 (CET)
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35267 "EHLO
        mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbbKLDzQf6phU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Nov 2015 04:55:16 +0100
Received: by ykba77 with SMTP id a77so81962415ykb.2;
        Wed, 11 Nov 2015 19:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ALWdC+bgRKQFPTZyotAI7b09ZpOltCRFWqz+s92tLcw=;
        b=v+YO0VoIxIgiDd1XEfWQorrg8X/GP6G70g3SrFazIFOZ0QRzSrTTt0fcTUjQ2jhsUb
         e/Hm9yno4SGugpyTyHeinpwQsNEIRCn07/T3SfQlxZ2C/UvrEMrnQwCcFiKuCe4cw4J7
         JKS4aA8HuYo8uFQny4lOyXVejme+5sN9RW7Qq9+ME7lZ/aMGkuTrFYBfg/hBhtGN11O5
         eCh1mil9wvYgmDzVwXOW1P/lVV1+Bxj4caw8xG35nl6A/uHzDkz1QomE2mC93m5mx+Vb
         /a+Mm2gOeY0rg/u1pnbL7dp/w9scK+BcXIEP/d2Irz01RhU9ENzhI+LQTNC0E92z1THh
         O0YA==
MIME-Version: 1.0
X-Received: by 10.13.237.198 with SMTP id w189mr14629509ywe.211.1447300509984;
 Wed, 11 Nov 2015 19:55:09 -0800 (PST)
Received: by 10.37.68.212 with HTTP; Wed, 11 Nov 2015 19:55:09 -0800 (PST)
In-Reply-To: <1444198082-24128-3-git-send-email-chenhc@lemote.com>
References: <1444198082-24128-1-git-send-email-chenhc@lemote.com>
        <1444198082-24128-3-git-send-email-chenhc@lemote.com>
Date:   Thu, 12 Nov 2015 11:55:09 +0800
X-Google-Sender-Auth: yuRib605Yw9EZ3xpfhZpNmMlqoU
Message-ID: <CAAhV-H6cQ9842jZajOVKGnwmTLA6+BQto=JHt0qrDT3vfS8uiw@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] MIPS: Loongson-3: Move chipset ACPI code from
 drivers to arch
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Ralf,

Can this patch be merged? or does it have problems to be fix?

Huacai

On Wed, Oct 7, 2015 at 2:08 PM, Huacai Chen <chenhc@lemote.com> wrote:
> SB700/SB710/SB800 chipset ACPI code is mostly Loongson-3 specific
> routines rather than a "platform driver".
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/loongson64/loongson-3/Makefile                              | 2 +-
>  .../platform/mips => arch/mips/loongson64/loongson-3}/acpi_init.c     | 0
>  drivers/platform/mips/Kconfig                                         | 4 ----
>  drivers/platform/mips/Makefile                                        | 1 -
>  4 files changed, 1 insertion(+), 6 deletions(-)
>  rename {drivers/platform/mips => arch/mips/loongson64/loongson-3}/acpi_init.c (100%)
>
> diff --git a/arch/mips/loongson64/loongson-3/Makefile b/arch/mips/loongson64/loongson-3/Makefile
> index 622fead..44bc148 100644
> --- a/arch/mips/loongson64/loongson-3/Makefile
> +++ b/arch/mips/loongson64/loongson-3/Makefile
> @@ -1,7 +1,7 @@
>  #
>  # Makefile for Loongson-3 family machines
>  #
> -obj-y                  += irq.o cop2-ex.o platform.o
> +obj-y                  += irq.o cop2-ex.o platform.o acpi_init.o
>
>  obj-$(CONFIG_SMP)      += smp.o
>
> diff --git a/drivers/platform/mips/acpi_init.c b/arch/mips/loongson64/loongson-3/acpi_init.c
> similarity index 100%
> rename from drivers/platform/mips/acpi_init.c
> rename to arch/mips/loongson64/loongson-3/acpi_init.c
> diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
> index 125e569..b3ae30a 100644
> --- a/drivers/platform/mips/Kconfig
> +++ b/drivers/platform/mips/Kconfig
> @@ -15,10 +15,6 @@ menuconfig MIPS_PLATFORM_DEVICES
>
>  if MIPS_PLATFORM_DEVICES
>
> -config MIPS_ACPI
> -       bool
> -       default y if LOONGSON_MACH3X
> -
>  config CPU_HWMON
>         tristate "Loongson CPU HWMon Driver"
>         depends on LOONGSON_MACH3X
> diff --git a/drivers/platform/mips/Makefile b/drivers/platform/mips/Makefile
> index 4341284..8dfd039 100644
> --- a/drivers/platform/mips/Makefile
> +++ b/drivers/platform/mips/Makefile
> @@ -1,2 +1 @@
> -obj-$(CONFIG_MIPS_ACPI) += acpi_init.o
>  obj-$(CONFIG_CPU_HWMON) += cpu_hwmon.o
> --
> 2.4.6
>
>
>
>
>
