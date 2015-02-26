Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 10:30:05 +0100 (CET)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44714 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007403AbbBZJaCP43M6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 10:30:02 +0100
Received: by iecar1 with SMTP id ar1so12374815iec.11;
        Thu, 26 Feb 2015 01:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UiLZbRIl9PUT0wbWV13LslV3aEoGueFF+H5Y+RWaI0U=;
        b=0LKx1FVBFHUhzGtekTzEzDpXv0Kr8coSf8G9NRSmTP6FQKJB4j++b6nvzTWIySe7uu
         c/CbAc8Gis5XJrArplhJlnE+VBB3Orr2u8854iDSjarq2wfLUwZvvDtPcRPgCsRXyGns
         Oq6OioXu/ruUiNyXF9rGEYFykfKy0uFa19IZqGI652Zs0UK3feVSeVHLjm62J3wrCTip
         iUkNzyNUmqHIBQukwqyxgiPWfTY/q8v8GVBLr5Nbm0CNd7GrNsGFzhwR4rx6xmDkCX08
         gZL4PjhOX5nV+OtLSKufFKpEXJX6WH5inYp218422/AsV0eNEAqMwgfqSDNY+z7n4ooX
         g6tw==
X-Received: by 10.107.170.220 with SMTP id g89mr10178004ioj.31.1424942996924;
 Thu, 26 Feb 2015 01:29:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.252.202 with HTTP; Thu, 26 Feb 2015 01:29:36 -0800 (PST)
In-Reply-To: <1422003369-3019-2-git-send-email-chenhc@lemote.com>
References: <1422003369-3019-1-git-send-email-chenhc@lemote.com> <1422003369-3019-2-git-send-email-chenhc@lemote.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Thu, 26 Feb 2015 18:29:36 +0900
Message-ID: <CAAVeFuLgu8W7EaxbZHR9cnJ=jpycYEXZm=ccEN_e-NHFZq-smw@mail.gmail.com>
Subject: Re: [PATCH V7 4/8] MIPS: Move Loongson GPIO driver to drivers/gpio
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnurou@gmail.com
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

On Fri, Jan 23, 2015 at 5:56 PM, Huacai Chen <chenhc@lemote.com> wrote:
> Move Loongson-2's GPIO driver to drivers/gpio and add Kconfig options.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Same here, this patch places GPIO driver code where it should be, but
we need to ensure there is no breakage before taking this code.

> ---
>  arch/mips/configs/lemote2f_defconfig               |    1 +
>  arch/mips/loongson/common/Makefile                 |    1 -
>  drivers/gpio/Kconfig                               |    6 ++++++
>  drivers/gpio/Makefile                              |    1 +
>  .../common/gpio.c => drivers/gpio/gpio-loongson.c  |    0
>  5 files changed, 8 insertions(+), 1 deletions(-)
>  rename arch/mips/loongson/common/gpio.c => drivers/gpio/gpio-loongson.c (100%)
>
> diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
> index e51aad9..0cbc986 100644
> --- a/arch/mips/configs/lemote2f_defconfig
> +++ b/arch/mips/configs/lemote2f_defconfig
> @@ -171,6 +171,7 @@ CONFIG_SERIAL_8250_FOURPORT=y
>  CONFIG_LEGACY_PTY_COUNT=16
>  CONFIG_HW_RANDOM=y
>  CONFIG_RTC=y
> +CONFIG_GPIO_LOONGSON=y
>  CONFIG_THERMAL=y
>  CONFIG_MEDIA_SUPPORT=m
>  CONFIG_VIDEO_DEV=m
> diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
> index d87e033..e70c33f 100644
> --- a/arch/mips/loongson/common/Makefile
> +++ b/arch/mips/loongson/common/Makefile
> @@ -4,7 +4,6 @@
>
>  obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
>      bonito-irq.o mem.o machtype.o platform.o
> -obj-$(CONFIG_GPIOLIB) += gpio.o
>  obj-$(CONFIG_PCI) += pci.o
>
>  #
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 633ec21..3ac5473 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -475,6 +475,12 @@ config GPIO_GRGPIO
>           Select this to support Aeroflex Gaisler GRGPIO cores from the GRLIB
>           VHDL IP core library.
>
> +config GPIO_LOONGSON
> +       tristate "Loongson-2 GPIO support"
> +       depends on CPU_LOONGSON2
> +       help
> +         driver for GPIO functionality on Loongson-2F processors.
> +
>  config GPIO_TB10X
>         bool
>         select GENERIC_IRQ_CHIP
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 81755f1..caccfad 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_GPIO_JANZ_TTL)   += gpio-janz-ttl.o
>  obj-$(CONFIG_GPIO_KEMPLD)      += gpio-kempld.o
>  obj-$(CONFIG_ARCH_KS8695)      += gpio-ks8695.o
>  obj-$(CONFIG_GPIO_INTEL_MID)   += gpio-intel-mid.o
> +obj-$(CONFIG_GPIO_LOONGSON)    += gpio-loongson.o
>  obj-$(CONFIG_GPIO_LP3943)      += gpio-lp3943.o
>  obj-$(CONFIG_ARCH_LPC32XX)     += gpio-lpc32xx.o
>  obj-$(CONFIG_GPIO_LYNXPOINT)   += gpio-lynxpoint.o
> diff --git a/arch/mips/loongson/common/gpio.c b/drivers/gpio/gpio-loongson.c
> similarity index 100%
> rename from arch/mips/loongson/common/gpio.c
> rename to drivers/gpio/gpio-loongson.c
> --
> 1.7.7.3
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
