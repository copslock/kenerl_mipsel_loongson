Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Dec 2017 14:23:05 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:41635
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990935AbdLRNW5wppJu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Dec 2017 14:22:57 +0100
Received: by mail-io0-x244.google.com with SMTP id o2so9745470ioe.8;
        Mon, 18 Dec 2017 05:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vF05NIukDCE23ZJz2SmKxkl3O1K8f25Whg6XpYuwrO8=;
        b=RlScCcaR3HtmKGw/AsgHLaVsagdNJ4M9jeq47WI2nPpKUl/3U2iQuoAqZHkMMBnkR1
         z+IYFIbFuU3SGi1G4xWUCO0KW6kZMwlUo27xOaA4BkKXw9Yw6moJjygA30V1+qdqRXzv
         iwSetVVVaCcVXmr6DTcJHztpYPsPmSeNGPzo1f7vZpO8G0X4VgqZXa5V4M5g2IB95jCb
         +4+OgHhQ+BRA6L/mFqD4wI9GPXWV+3KM4wgU8zeK5FLHZ4eBydQvZZaZ2CCHe0zTEczP
         bpRvuOq8l9s2EmxMDJVnZKhV844cVWzAWuvonmyQq+kB3CENJjoRslMl/xTS3Z/5xm0n
         nv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vF05NIukDCE23ZJz2SmKxkl3O1K8f25Whg6XpYuwrO8=;
        b=HkYC1o5/L5tKuS5h3YVVxFN77iY36v3Cr/MN+KP4so5epOkZcrV9sVjWzMcuCdQbIt
         87ry+5fNnOyaP1Cu8zM4/NTabomMG0S4z0nyusX+KgGp6o/vnNpPimnf3WR7VRcto3L7
         nJ2tesqYLv7YoJqc4ZNIT5dnF9/ibSQyEmuTSQKP3Yobs8OIiI6jl/SuikDq8zA5G9Yx
         O0tQ9Aao7qwKasM8veORgryxH9/zHg14KQAPMx0gpYPZP+oy/W1etZ0HZ+03OxWlSdfU
         LDF5X5cAr+hdsqEvNdCOV/ztPfbdzkI4TlHx/yn6WcSvy5nQsguLWQ2a11hw3joSe7C+
         vYPA==
X-Gm-Message-State: AKGB3mJZZrTuQfD36tFaMaaW88Dw2UzDCdUQPvSGb+K46sy4dDOlj9aE
        NugDi7QLmDF7CidWyen12W36jIg3QPciIQpQmF0=
X-Google-Smtp-Source: ACJfBov6HiCCyBfe8WSnQ5K2kR/88L2xeA3P5bzStObZ65HzHLwOIHsaldfMPEH1zXXfsCqrRaZ61AeLBmTe7/SXciY=
X-Received: by 10.107.141.78 with SMTP id p75mr25218257iod.165.1513603371349;
 Mon, 18 Dec 2017 05:22:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.169.20 with HTTP; Mon, 18 Dec 2017 05:22:50 -0800 (PST)
In-Reply-To: <20171208154618.20105-11-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com> <20171208154618.20105-11-alexandre.belloni@free-electrons.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Mon, 18 Dec 2017 18:52:50 +0530
Message-ID: <CANc+2y7sgjnuRBEgFrBJDn+Fe0K8=Z31+1+MLK=ejVt-+i5Yig@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] MIPS: mscc: add ocelot dtsi
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61510
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

Hi Alexandre,

On 8 December 2017 at 21:16, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Add a device tree include file for the Microsemi Ocelot SoC.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/mips/boot/dts/Makefile         |   1 +
>  arch/mips/boot/dts/mscc/Makefile    |   4 ++
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 115 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+)
>  create mode 100644 arch/mips/boot/dts/mscc/Makefile
>  create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi
>
> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index e2c6f131c8eb..1e79cab8e269 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -4,6 +4,7 @@ subdir-y        += cavium-octeon
>  subdir-y       += img
>  subdir-y       += ingenic
>  subdir-y       += lantiq
> +subdir-y       += mscc
>  subdir-y       += mti
>  subdir-y       += netlogic
>  subdir-y       += ni
> diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
> new file mode 100644
> index 000000000000..f0a155a74e02
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/Makefile
> @@ -0,0 +1,4 @@
> +obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-                           += dummy.o
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> new file mode 100644
> index 000000000000..97f85431aa16
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/* Copyright (c) 2017 Microsemi Corporation */
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       compatible = "mscc,ocelot";
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               mips-hpt-frequency = <250000000>;
> +
> +               cpu@0 {
> +                       compatible = "mscc,ocelot";
> +                       device_type = "cpu";
> +                       reg = <0>;
> +               };
> +       };
> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       cpuintc: interrupt-controller@0 {
> +               #address-cells = <0>;
> +               #interrupt-cells = <1>;
> +               interrupt-controller;
> +               compatible = "mti,cpu-interrupt-controller";
> +       };
> +
> +       ahb_clk: ahb-clk {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <250000000>;
> +       };
> +
> +       ahb {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0 0x70000000 0x2000000>;
> +
> +               interrupt-parent = <&intc>;
> +
> +               cpu_ctrl: syscon@0 {
> +                       compatible = "mscc,ocelot-cpu-syscon", "syscon";
> +                       reg = <0x0 0x2c>;
> +               };
> +
> +               intc: interrupt-controller@70 {
> +                       compatible = "mscc,ocelot-icpu-intr";
> +                       reg = <0x70 0x70>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-controller;
> +                       interrupt-parent = <&cpuintc>;
> +                       interrupts = <2>;
> +               };
> +
> +               uart0: serial@100000 {
> +                       pinctrl-0 = <&uart_pins>;
> +                       pinctrl-names = "default";
> +                       compatible = "ns16550a";
> +                       reg = <0x100000 0x20>;
> +                       interrupts = <6>;
> +                       clocks = <&ahb_clk>;
> +                       reg-io-width = <4>;
> +                       reg-shift = <2>;
> +
> +                       status = "disabled";
> +               };
> +
> +               uart2: serial@100800 {
> +                       pinctrl-0 = <&uart2_pins>;
> +                       pinctrl-names = "default";
> +                       compatible = "ns16550a";
> +                       reg = <0x100800 0x20>;
> +                       interrupts = <7>;
> +                       clocks = <&ahb_clk>;
> +                       reg-io-width = <4>;
> +                       reg-shift = <2>;
> +
> +                       status = "disabled";
> +               };
> +
> +               chip_regs: syscon@1070000 {
> +                       compatible = "mscc,ocelot-chip-regs", "simple-mfd", "syscon";
> +                       reg = <0x1070000 0x1c>;
> +
> +                       reset {
> +                               compatible = "mscc,ocelot-chip-reset";
> +                               mscc,cpucontrol = <&cpu_ctrl>;
> +                       };
> +               };
> +
> +               gpio: pinctrl@1070034 {
> +                       compatible = "mscc,ocelot-pinctrl";
> +                       reg = <0x1070034 0x28>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       gpio-ranges = <&gpio 0 0 22>;
> +
> +                       uart_pins: uart-pins {
> +                               pins = "GPIO_6", "GPIO_7";
> +                               function = "uart";
> +                       };
> +
> +                       uart2_pins: uart2-pins {
> +                               pins = "GPIO_12", "GPIO_13";
> +                               function = "uart2";
> +                       };
> +               };
> +       };
> +};
> --
> 2.15.1
>
>

Looks good to me.
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Regards,
PrasannaKumar
