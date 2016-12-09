Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 22:18:49 +0100 (CET)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35948 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992157AbcLIVSjyUssA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2016 22:18:39 +0100
Received: by mail-oi0-f67.google.com with SMTP id u15so3910989oie.3;
        Fri, 09 Dec 2016 13:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xBcIPbOfAGT5SXxFXrp+F15yM2pIoJh3wB+PNP9BhrQ=;
        b=e3ZWG3oUbF+wxhg+ENP1VT30r/dU3NRc4QGy8QhlYpitGkBc6hlFdQ3xYuQGTWnnIv
         Irjwlat2loCK4qm4iZpde7Hsb/tsN9m017ptdd+mArn6j126r1ZLLigS+Bwp66eYh/CG
         XlaMFChIGpUGLgAk6bp1SoJiyyMx5HO+QKyUt+wOObcLP2D+ACgXP54JPDm1KjSugmB+
         PY22f0tJcG/sUuOHxfxyNdKyM3GYz72l4MwIJsaclkGsAkuJaodE81B5PCVzlGPoxUAx
         Cmdaqckx/ZQoazKGYU8+i85S85ExFtDtjbNx6ZrC1xVu8vKbb5JBiy6Pm7AuU2Q/SL0b
         44Tg==
X-Gm-Message-State: AKaTC02XFhAyEQQf4QgLz8v7e53axDhLf2GEGiOftXsUR/KAXx/NXA8PpLO0ovRXSj0SWQ==
X-Received: by 10.202.198.23 with SMTP id w23mr45806338oif.187.1481318310072;
        Fri, 09 Dec 2016 13:18:30 -0800 (PST)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id t78sm13023086oih.19.2016.12.09.13.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Dec 2016 13:18:29 -0800 (PST)
Date:   Fri, 9 Dec 2016 15:18:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nathan Sullivan <nathan.sullivan@ni.com>
Cc:     ralf@linux-mips.org, mark.rutland@arm.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: NI 169445 board support
Message-ID: <20161209211828.dykl2l4kmthqgq6e@rob-hp-laptop>
References: <1480693329-22265-1-git-send-email-nathan.sullivan@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1480693329-22265-1-git-send-email-nathan.sullivan@ni.com>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55991
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

On Fri, Dec 02, 2016 at 09:42:09AM -0600, Nathan Sullivan wrote:
> Support the National Instruments 169445 board.
> 
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> ---
> "gpio: mmio: add support for NI 169445 NAND GPIO" and 
> "devicetree: add vendor prefix for National Instruments" are required for the
> NAND on this board to work.

These should have been a series, but I already applied the first one.

> 
>  Documentation/devicetree/bindings/mips/ni.txt |   7 ++
>  arch/mips/Kbuild.platforms                    |   1 +
>  arch/mips/Kconfig                             |  26 ++++++
>  arch/mips/boot/dts/Makefile                   |   1 +
>  arch/mips/boot/dts/ni/169445.dts              |  99 +++++++++++++++++++++
>  arch/mips/boot/dts/ni/Makefile                |   9 ++
>  arch/mips/configs/ni169445_defconfig          | 120 ++++++++++++++++++++++++++
>  arch/mips/ni169445/169445-console.c           |  38 ++++++++
>  arch/mips/ni169445/169445-init.c              |  39 +++++++++
>  arch/mips/ni169445/169445-int.c               |  34 ++++++++
>  arch/mips/ni169445/169445-setup.c             |  58 +++++++++++++
>  arch/mips/ni169445/169445-time.c              |  35 ++++++++
>  arch/mips/ni169445/Makefile                   |   9 ++
>  arch/mips/ni169445/Platform                   |   6 ++
>  14 files changed, 482 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/ni.txt
>  create mode 100644 arch/mips/boot/dts/ni/169445.dts
>  create mode 100644 arch/mips/boot/dts/ni/Makefile
>  create mode 100644 arch/mips/configs/ni169445_defconfig
>  create mode 100644 arch/mips/ni169445/169445-console.c
>  create mode 100644 arch/mips/ni169445/169445-init.c
>  create mode 100644 arch/mips/ni169445/169445-int.c
>  create mode 100644 arch/mips/ni169445/169445-setup.c
>  create mode 100644 arch/mips/ni169445/169445-time.c
>  create mode 100644 arch/mips/ni169445/Makefile
>  create mode 100644 arch/mips/ni169445/Platform
> 
> diff --git a/Documentation/devicetree/bindings/mips/ni.txt b/Documentation/devicetree/bindings/mips/ni.txt
> new file mode 100644
> index 0000000..722bf2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/ni.txt
> @@ -0,0 +1,7 @@
> +National Instruments MIPS platforms
> +
> +required root node properties:
> +	- compatible: must be "ni,169445"
> +
> +CPU Nodes
> +	- compatible: must be "mti,mips14KEc"
> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
> index f5f1bdb..f2d7b5c 100644
> --- a/arch/mips/Kbuild.platforms
> +++ b/arch/mips/Kbuild.platforms
> @@ -20,6 +20,7 @@ platforms += loongson32
>  platforms += loongson64
>  platforms += mti-malta
>  platforms += netlogic
> +platforms += ni169445
>  platforms += paravirt
>  platforms += pic32
>  platforms += pistachio
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b3c5bde..d24d11f 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -574,6 +574,32 @@ config NXP_STB225
>  	help
>  	 Support for NXP Semiconductors STB225 Development Board.
>  
> +config NI_169445
> +	bool "NI 169445 board"
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select BOOT_ELF32
> +	select BOOT_RAW
> +	select BUILTIN_DTB
> +	select CEVT_R4K
> +	select CSRC_R4K
> +	select CPU_MIPSR2_IRQ_VI
> +	select CPU_MIPSR2_IRQ_EI
> +	select DMA_NONCOHERENT
> +	select IRQ_MIPS_CPU
> +	select LIBFDT
> +	select MIPS_MSC
> +	select SYS_HAS_CPU_MIPS32_R1
> +	select SYS_HAS_CPU_MIPS32_R2
> +	select SYS_HAS_EARLY_PRINTK
> +	select SYS_SUPPORTS_32BIT_KERNEL
> +	select SYS_SUPPORTS_LITTLE_ENDIAN
> +	select USE_OF
> +	select COMMON_CLK
> +	help
> +	  This enables support for the National Instruments 169445A
> +	  board.
> +
> +
>  config PMC_MSP
>  	bool "PMC-Sierra MSP chipsets"
>  	select CEVT_R4K
> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index fc7a0a9..65a0ad8 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -3,6 +3,7 @@ dts-dirs	+= cavium-octeon
>  dts-dirs	+= ingenic
>  dts-dirs	+= lantiq
>  dts-dirs	+= mti
> +dts-dirs	+= ni
>  dts-dirs	+= netlogic
>  dts-dirs	+= pic32
>  dts-dirs	+= qca
> diff --git a/arch/mips/boot/dts/ni/169445.dts b/arch/mips/boot/dts/ni/169445.dts
> new file mode 100644
> index 0000000..a2b49f9
> --- /dev/null
> +++ b/arch/mips/boot/dts/ni/169445.dts
> @@ -0,0 +1,99 @@
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "ni,169445";
> +
> +	cpus {
> +		mips-hpt-frequency = <25000000>;
> +
> +		cpu@0 {
> +			compatible = "mti,mips14KEc";
> +		};
> +	};
> +
> +	memory {

memory@0

> +		device_type = "memory";
> +		reg = <0x0 0x08000000>;
> +	};
> +
> +	clocks {
> +		baseclk: baseclock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <50000000>;
> +		};
> +	};
> +
> +	cpu_intc: cpu_intc {
> +		#address-cells = <0>;
> +		compatible = "mti,cpu-interrupt-controller";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +	};
> +
> +	ahb@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;

If everything is under 0x1f3xxxxx, then add in the ranges here (and the 
unit address).

> +
> +		gpio1: nand-gpio-out@1f300010 {

As in the binding example: gpio-controller@...

> +			compatible = "ni,169445-nand-gpio";
> +			reg = <0x1f300010 0x4>;
> +			reg-names = "dat";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			ngpios = <5>;
> +		};
> +
> +		gpio2: nand-gpio-in@1f300014 {

ditto

> +			compatible = "ni,169445-nand-gpio";
> +			reg = <0x1f300014 0x4>;
> +			reg-names = "dat";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			ngpios = <1>;
> +		};
> +
> +		nand@1f300000 {
> +			compatible = "gpio-control-nand";
> +			nand-on-flash-bbt;
> +			nand-ecc-mode = "soft_bch";
> +			nand-ecc-step-size = <512>;
> +			nand-ecc-strength = <4>;
> +			reg = <0x1f300000 4>;
> +			gpios = <&gpio2 0 0>, /* rdy */
> +				<&gpio1 1 0>, /* nce */
> +				<&gpio1 2 0>, /* ale */
> +				<&gpio1 3 0>, /* cle */
> +				<&gpio1 4 0>; /* nwp */
> +		};
> +
> +		serial@1f380000 {
> +			compatible = "ns16550a";
> +			reg = <0x1f380000 0x1000>;
> +			interrupt-parent = <&cpu_intc>;
> +			interrupts = <6>;
> +			clocks = <&baseclk>;
> +			reg-shift = <0>;
> +		};
> +
> +		ethernet@1f340000 {
> +			compatible = "snps,dwc-qos-ethernet-4.10";
> +			interrupt-parent = <&cpu_intc>;
> +			interrupts = <5>;
> +			reg = <0x1f340000 0x2000>;
> +			clock-names = "apb_pclk", "phy_ref_clk";
> +			clocks = <&baseclk>, <&baseclk>;
> +
> +			phy-mode = "rgmii";
> +
> +			fixed-link {
> +				speed = <1000>;
> +				full-duplex;
> +			};
> +		};
> +	};
> +};

[...]

> diff --git a/arch/mips/ni169445/169445-setup.c b/arch/mips/ni169445/169445-setup.c
> new file mode 100644
> index 0000000..80a5c91
> --- /dev/null
> +++ b/arch/mips/ni169445/169445-setup.c
> @@ -0,0 +1,58 @@
> +/*  Copyright 2016 National Instruments Corporation
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License as published by the Free
> + *  Software Foundation; either version 2 of the License, or (at your option)
> + *  any later version.
> + *
> + *  This program is distributed in the hope that it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + *  more details.
> + */
> +#include <linux/init.h>
> +#include <linux/clk-provider.h>
> +#include <linux/libfdt.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_fdt.h>
> +
> +#include <asm/prom.h>
> +#include <asm/fw/fw.h>
> +
> +#include <asm/mips-boards/generic.h>
> +
> +const char *get_system_type(void)
> +{
> +	return "NI 169445 FPGA";

Perhaps this should come from model property. There's a patch in flight 
to add a function to get machine name.

> +}
> +
> +void __init plat_mem_setup(void)
> +{
> +	/*
> +	 * Load the builtin devicetree. This causes the chosen node to be
> +	 * parsed resulting in our memory appearing
> +	 */
> +	__dt_setup_arch(__dtb_start);
> +}
> +
> +void __init device_tree_init(void)
> +{
> +	if (!initial_boot_params)
> +		return;
> +
> +	unflatten_and_copy_device_tree();
> +}
> +
> +static int __init customize_machine(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);

This should happen by default now.

> +	return 0;
> +}
> +arch_initcall(customize_machine);
