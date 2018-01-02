Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 17:09:25 +0100 (CET)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:41661
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993096AbeABQJO36zv1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 17:09:14 +0100
Received: by mail-it0-x243.google.com with SMTP id x28so39209517ita.0;
        Tue, 02 Jan 2018 08:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vVjFEm+/QSMlcrPX0Iy7S2ZITLdLZIkpS26gmAqijH8=;
        b=tMspgq7LDt7Bcq7MtoOOqTA6i1OhH02sjcWnlDX6Iq6VK4gTvwrBBNMyCTYoGWXNtZ
         N5UVJDJ65ImeBR6W/PjsYFS0xg2xf08FcCIoDABj1WGKzPUmQqdov771MfEzdJUr5q9d
         O+Js+Aia6BYuGZhgUJaeiK3xlFmm3PNtSq4xUgnjrfHae80USBbfHeAYoRDlK6c3DSjC
         lnKm+RTIS4Rvqy2ATraUmKuhIulv+ta5koD7SX/Q1oHsKO6j/CSxsnbPDfLwp/m4SPfH
         vupOuKCvwzSERVQkq/8ByTP/sAkoTxWyrWmxmt1xV/pzi/RCa1KzydRKoUVpuI9jT6IM
         N5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vVjFEm+/QSMlcrPX0Iy7S2ZITLdLZIkpS26gmAqijH8=;
        b=etkOhMibwuvW8iLFyrqCSS6n3luHIpoKYIautKpgICTRq3JjVPrL1pSqmlW6c44xSu
         2m+rCpJFZP43aYXscYggVTOflWfl3DKlvWPsxk/Vjdo6a38oea1j4ggAOhWhE4aoNICW
         hO1RFGnXP9zmPZ52Rxwwd12oOkZ7ydeeMin2XD1XHNEpcyH0ogM2O/cHf4ab+eKcWEjE
         6Hx9dEzPWt9B3UJ7aEl2EB3vhcr/uhrEiLNmW/jcS9tgiGH1PK4i6wtSJ/LXVRJRpeYb
         ptiaECpiak+9nL39vrLBUdWY2jko5U1hTqEWlBbKCNfC8cwfrY2qJq5x11ZpWQgzqQgk
         8Ofw==
X-Gm-Message-State: AKGB3mLEL12MT2WVfAdNSsHEmYZ78EsuD6WFD93mvnpDsRXpPLOiJSKe
        SJWJnCCazVSlTjv6F6crx1rJTPxKEOxuIb70SK4=
X-Google-Smtp-Source: ACJfBosWA1JHjao8ltV+mcOeAluK/pmg0+X3VGttMueHssM7mB7ipWUiswK7hVsT9hp2lm6fIPUVehHtrt8i51QqcNs=
X-Received: by 10.36.236.4 with SMTP id g4mr46664740ith.33.1514909348175; Tue,
 02 Jan 2018 08:09:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.144.208 with HTTP; Tue, 2 Jan 2018 08:09:07 -0800 (PST)
In-Reply-To: <20180102150848.11314-11-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net> <20180102150848.11314-11-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 2 Jan 2018 21:39:07 +0530
Message-ID: <CANc+2y7Raw_cmV7U84mCx_ZVULOSxmk_qHSebDNSt+M9=zByQA@mail.gmail.com>
Subject: Re: [PATCH v5 11/15] MIPS: ingenic: Initial JZ4770 support
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Paul,

On 2 January 2018 at 20:38, Paul Cercueil <paul@crapouillou.net> wrote:
> Provide just enough bits (clocks, clocksource, uart) to allow a kernel
> to boot on the JZ4770 SoC to a initramfs userspace.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/dts/ingenic/jz4770.dtsi | 212 +++++++++++++++++++++++++++++++++
>  arch/mips/jz4740/Kconfig               |   6 +
>  arch/mips/jz4740/time.c                |   2 +-
>  3 files changed, 219 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/boot/dts/ingenic/jz4770.dtsi
>
>  v2: No change
>  v3: No change
>  v4: No change
>  v5: Use SPDX license identifier
>
> diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/ingenic/jz4770.dtsi
> new file mode 100644
> index 000000000000..7c2804f3f5f1
> --- /dev/null
> +++ b/arch/mips/boot/dts/ingenic/jz4770.dtsi
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dt-bindings/clock/jz4770-cgu.h>
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       compatible = "ingenic,jz4770";
> +
> +       cpuintc: interrupt-controller {
> +               #address-cells = <0>;
> +               #interrupt-cells = <1>;
> +               interrupt-controller;
> +               compatible = "mti,cpu-interrupt-controller";
> +       };
> +
> +       intc: interrupt-controller@10001000 {
> +               compatible = "ingenic,jz4770-intc";
> +               reg = <0x10001000 0x40>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +
> +               interrupt-parent = <&cpuintc>;
> +               interrupts = <2>;
> +       };
> +
> +       ext: ext {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +       };
> +
> +       osc32k: osc32k {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <32768>;
> +       };
> +
> +       cgu: jz4770-cgu@10000000 {
> +               compatible = "ingenic,jz4770-cgu";
> +               reg = <0x10000000 0x100>;
> +
> +               clocks = <&ext>, <&osc32k>;
> +               clock-names = "ext", "osc32k";
> +
> +               #clock-cells = <1>;
> +       };
> +
> +       pinctrl: pin-controller@10010000 {
> +               compatible = "ingenic,jz4770-pinctrl";
> +               reg = <0x10010000 0x600>;
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               gpa: gpio@0 {
> +                       compatible = "ingenic,jz4770-gpio";
> +                       reg = <0>;
> +
> +                       gpio-controller;
> +                       gpio-ranges = <&pinctrl 0 0 32>;
> +                       #gpio-cells = <2>;
> +
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +
> +                       interrupt-parent = <&intc>;
> +                       interrupts = <17>;
> +               };
> +
> +               gpb: gpio@1 {
> +                       compatible = "ingenic,jz4770-gpio";
> +                       reg = <1>;
> +
> +                       gpio-controller;
> +                       gpio-ranges = <&pinctrl 0 32 32>;
> +                       #gpio-cells = <2>;
> +
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +
> +                       interrupt-parent = <&intc>;
> +                       interrupts = <16>;
> +               };
> +
> +               gpc: gpio@2 {
> +                       compatible = "ingenic,jz4770-gpio";
> +                       reg = <2>;
> +
> +                       gpio-controller;
> +                       gpio-ranges = <&pinctrl 0 64 32>;
> +                       #gpio-cells = <2>;
> +
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +
> +                       interrupt-parent = <&intc>;
> +                       interrupts = <15>;
> +               };
> +
> +               gpd: gpio@3 {
> +                       compatible = "ingenic,jz4770-gpio";
> +                       reg = <3>;
> +
> +                       gpio-controller;
> +                       gpio-ranges = <&pinctrl 0 96 32>;
> +                       #gpio-cells = <2>;
> +
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +
> +                       interrupt-parent = <&intc>;
> +                       interrupts = <14>;
> +               };
> +
> +               gpe: gpio@4 {
> +                       compatible = "ingenic,jz4770-gpio";
> +                       reg = <4>;
> +
> +                       gpio-controller;
> +                       gpio-ranges = <&pinctrl 0 128 32>;
> +                       #gpio-cells = <2>;
> +
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +
> +                       interrupt-parent = <&intc>;
> +                       interrupts = <13>;
> +               };
> +
> +               gpf: gpio@5 {
> +                       compatible = "ingenic,jz4770-gpio";
> +                       reg = <5>;
> +
> +                       gpio-controller;
> +                       gpio-ranges = <&pinctrl 0 160 32>;
> +                       #gpio-cells = <2>;
> +
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +
> +                       interrupt-parent = <&intc>;
> +                       interrupts = <12>;
> +               };
> +       };
> +
> +       uart0: serial@10030000 {
> +               compatible = "ingenic,jz4770-uart";
> +               reg = <0x10030000 0x100>;
> +
> +               clocks = <&ext>, <&cgu JZ4770_CLK_UART0>;
> +               clock-names = "baud", "module";
> +
> +               interrupt-parent = <&intc>;
> +               interrupts = <5>;
> +
> +               status = "disabled";
> +       };
> +
> +       uart1: serial@10031000 {
> +               compatible = "ingenic,jz4770-uart";
> +               reg = <0x10031000 0x100>;
> +
> +               clocks = <&ext>, <&cgu JZ4770_CLK_UART1>;
> +               clock-names = "baud", "module";
> +
> +               interrupt-parent = <&intc>;
> +               interrupts = <4>;
> +
> +               status = "disabled";
> +       };
> +
> +       uart2: serial@10032000 {
> +               compatible = "ingenic,jz4770-uart";
> +               reg = <0x10032000 0x100>;
> +
> +               clocks = <&ext>, <&cgu JZ4770_CLK_UART2>;
> +               clock-names = "baud", "module";
> +
> +               interrupt-parent = <&intc>;
> +               interrupts = <3>;
> +
> +               status = "disabled";
> +       };
> +
> +       uart3: serial@10033000 {
> +               compatible = "ingenic,jz4770-uart";
> +               reg = <0x10033000 0x100>;
> +
> +               clocks = <&ext>, <&cgu JZ4770_CLK_UART3>;
> +               clock-names = "baud", "module";
> +
> +               interrupt-parent = <&intc>;
> +               interrupts = <2>;
> +
> +               status = "disabled";
> +       };
> +
> +       uhc: uhc@13430000 {
> +               compatible = "generic-ohci";
> +               reg = <0x13430000 0x1000>;
> +
> +               clocks = <&cgu JZ4770_CLK_UHC>, <&cgu JZ4770_CLK_UHC_PHY>;
> +               assigned-clocks = <&cgu JZ4770_CLK_UHC>;
> +               assigned-clock-rates = <48000000>;
> +
> +               interrupt-parent = <&intc>;
> +               interrupts = <20>;
> +
> +               status = "disabled";
> +       };
> +};
> diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
> index 643af2012e14..29a9361a2b77 100644
> --- a/arch/mips/jz4740/Kconfig
> +++ b/arch/mips/jz4740/Kconfig
> @@ -18,6 +18,12 @@ config MACH_JZ4740
>         bool
>         select SYS_HAS_CPU_MIPS32_R1
>
> +config MACH_JZ4770
> +       bool
> +       select MIPS_CPU_SCACHE
> +       select SYS_HAS_CPU_MIPS32_R2
> +       select SYS_SUPPORTS_HIGHMEM
> +
>  config MACH_JZ4780
>         bool
>         select MIPS_CPU_SCACHE
> diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
> index bb1ad5119da4..2ca9160f642a 100644
> --- a/arch/mips/jz4740/time.c
> +++ b/arch/mips/jz4740/time.c
> @@ -113,7 +113,7 @@ static struct clock_event_device jz4740_clockevent = {
>  #ifdef CONFIG_MACH_JZ4740
>         .irq = JZ4740_IRQ_TCU0,
>  #endif
> -#ifdef CONFIG_MACH_JZ4780
> +#if defined(CONFIG_MACH_JZ4770) || defined(CONFIG_MACH_JZ4780)
>         .irq = JZ4780_IRQ_TCU2,
>  #endif
>  };
> --
> 2.11.0
>
>

Looks good to me.
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
