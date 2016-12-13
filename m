Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 19:40:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1658 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993061AbcLMSkpb901d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Dec 2016 19:40:45 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 8698C41F8E82;
        Tue, 13 Dec 2016 19:41:45 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 13 Dec 2016 19:41:45 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 13 Dec 2016 19:41:45 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 431C71EBD23CE;
        Tue, 13 Dec 2016 18:40:36 +0000 (GMT)
Received: from np-p-burton.localnet (10.100.200.105) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 13 Dec
 2016 18:40:39 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Nathan Sullivan <nathan.sullivan@ni.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: NI 169445 board support
Date:   Tue, 13 Dec 2016 18:40:31 +0000
Message-ID: <3462760.PnFL9sJqBx@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.3 (Linux/4.8.12-2-ARCH; KDE/5.28.0; x86_64; ; )
In-Reply-To: <1480693329-22265-1-git-send-email-nathan.sullivan@ni.com>
References: <1480693329-22265-1-git-send-email-nathan.sullivan@ni.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2783654.GHpK4RY9YK";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.105]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart2783654.GHpK4RY9YK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Nathan,

On Friday, 2 December 2016 09:42:09 GMT Nathan Sullivan wrote:
> Support the National Instruments 169445 board.
> 
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> ---
> "gpio: mmio: add support for NI 169445 NAND GPIO" and
> "devicetree: add vendor prefix for National Instruments" are required for
> the NAND on this board to work.
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
> diff --git a/Documentation/devicetree/bindings/mips/ni.txt
> b/Documentation/devicetree/bindings/mips/ni.txt new file mode 100644
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

This doesn't describe anything else you rely on, like the
mips-hpt-frequency property which you panic without.

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
> diff --git a/arch/mips/boot/dts/ni/169445.dts
> b/arch/mips/boot/dts/ni/169445.dts new file mode 100644
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
> +
> +		gpio1: nand-gpio-out@1f300010 {
> +			compatible = "ni,169445-nand-gpio";
> +			reg = <0x1f300010 0x4>;
> +			reg-names = "dat";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			ngpios = <5>;
> +		};
> +
> +		gpio2: nand-gpio-in@1f300014 {
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
> diff --git a/arch/mips/boot/dts/ni/Makefile b/arch/mips/boot/dts/ni/Makefile
> new file mode 100644
> index 0000000..5291c18
> --- /dev/null
> +++ b/arch/mips/boot/dts/ni/Makefile
> @@ -0,0 +1,9 @@
> +dtb-$(CONFIG_NI_169445)		+= 169445.dtb
> +
> +obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-				+= dummy.o
> +
> +always				:= $(dtb-y)
> +clean-files			:= *.dtb *.dtb.S
> diff --git a/arch/mips/configs/ni169445_defconfig
> b/arch/mips/configs/ni169445_defconfig new file mode 100644
> index 0000000..e5a34df
> --- /dev/null
> +++ b/arch/mips/configs/ni169445_defconfig
> @@ -0,0 +1,120 @@
> +CONFIG_NI_169445=y
> +CONFIG_CPU_MIPS32_R2=y
> +CONFIG_HZ_100=y
> +CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
> +# CONFIG_SWAP is not set
> +CONFIG_SYSVIPC=y
> +CONFIG_HZ_PERIODIC=y
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> +CONFIG_LOG_BUF_SHIFT=15
> +CONFIG_BLK_DEV_INITRD=y
> +# CONFIG_RD_GZIP is not set
> +# CONFIG_RD_LZMA is not set
> +# CONFIG_RD_XZ is not set
> +# CONFIG_RD_LZO is not set
> +# CONFIG_RD_LZ4 is not set
> +# CONFIG_SHMEM is not set
> +CONFIG_EMBEDDED=y
> +CONFIG_SLAB=y
> +CONFIG_PROFILING=y
> +# CONFIG_LBDAF is not set
> +# CONFIG_BLK_DEV_BSG is not set
> +# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> +# CONFIG_SUSPEND is not set
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_UNIX=y
> +CONFIG_INET=y
> +# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> +# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> +# CONFIG_INET_XFRM_MODE_BEET is not set
> +# CONFIG_INET_DIAG is not set
> +# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
> +# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
> +CONFIG_NETFILTER=y
> +CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
> +CONFIG_IP_NF_IPTABLES=y
> +CONFIG_IP_NF_FILTER=y
> +CONFIG_IP6_NF_IPTABLES=y
> +CONFIG_IP6_NF_FILTER=y
> +# CONFIG_WIRELESS is not set
> +CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_MTD=y
> +CONFIG_MTD_CMDLINE_PARTS=y
> +CONFIG_MTD_BLOCK_RO=y
> +CONFIG_MTD_NAND=y
> +CONFIG_MTD_NAND_ECC_BCH=y
> +CONFIG_MTD_NAND_GPIO=y
> +CONFIG_MTD_UBI=y
> +CONFIG_MTD_UBI_BLOCK=y
> +CONFIG_NETDEVICES=y
> +# CONFIG_NET_VENDOR_AMAZON is not set
> +# CONFIG_NET_VENDOR_ARC is not set
> +# CONFIG_NET_CADENCE is not set
> +# CONFIG_NET_VENDOR_BROADCOM is not set
> +# CONFIG_NET_VENDOR_EZCHIP is not set
> +# CONFIG_NET_VENDOR_INTEL is not set
> +# CONFIG_NET_VENDOR_MARVELL is not set
> +# CONFIG_NET_VENDOR_MICREL is not set
> +# CONFIG_NET_VENDOR_NATSEMI is not set
> +# CONFIG_NET_VENDOR_NETRONOME is not set
> +# CONFIG_NET_VENDOR_QUALCOMM is not set
> +# CONFIG_NET_VENDOR_RENESAS is not set
> +# CONFIG_NET_VENDOR_ROCKER is not set
> +# CONFIG_NET_VENDOR_SAMSUNG is not set
> +# CONFIG_NET_VENDOR_SEEQ is not set
> +# CONFIG_NET_VENDOR_SMSC is not set
> +# CONFIG_NET_VENDOR_STMICRO is not set
> +CONFIG_SYNOPSYS_DWC_ETH_QOS=y
> +# CONFIG_NET_VENDOR_VIA is not set
> +# CONFIG_NET_VENDOR_WIZNET is not set
> +# CONFIG_NET_VENDOR_XILINX is not set
> +# CONFIG_WLAN is not set
> +# CONFIG_INPUT_MOUSEDEV is not set
> +# CONFIG_INPUT_KEYBOARD is not set
> +# CONFIG_INPUT_MOUSE is not set
> +# CONFIG_SERIO is not set
> +# CONFIG_CONSOLE_TRANSLATIONS is not set
> +CONFIG_VT_HW_CONSOLE_BINDING=y
> +CONFIG_LEGACY_PTY_COUNT=32
> +CONFIG_SERIAL_8250=y
> +# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_NR_UARTS=2
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=2
> +CONFIG_SERIAL_OF_PLATFORM=y
> +# CONFIG_HW_RANDOM is not set
> +CONFIG_GPIOLIB=y
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_GPIO_GENERIC_PLATFORM=y
> +# CONFIG_HWMON is not set
> +# CONFIG_VGA_CONSOLE is not set
> +# CONFIG_HID is not set
> +# CONFIG_USB_SUPPORT is not set
> +# CONFIG_MIPS_PLATFORM_DEVICES is not set
> +# CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_UBIFS_FS=y
> +CONFIG_UBIFS_FS_ADVANCED_COMPR=y
> +# CONFIG_UBIFS_FS_ZLIB is not set
> +CONFIG_SQUASHFS=y
> +# CONFIG_SQUASHFS_ZLIB is not set
> +CONFIG_SQUASHFS_LZO=y
> +CONFIG_SQUASHFS_XZ=y
> +# CONFIG_NETWORK_FILESYSTEMS is not set
> +# CONFIG_FTRACE is not set
> +CONFIG_CRYPTO_CBC=y
> +CONFIG_CRYPTO_ECB=y
> +CONFIG_CRYPTO_CRC32C=y
> +CONFIG_CRYPTO_ARC4=y
> +# CONFIG_CRYPTO_HW is not set
> +# CONFIG_XZ_DEC_X86 is not set
> +# CONFIG_XZ_DEC_POWERPC is not set
> +# CONFIG_XZ_DEC_IA64 is not set
> +# CONFIG_XZ_DEC_ARM is not set
> +# CONFIG_XZ_DEC_ARMTHUMB is not set
> +# CONFIG_XZ_DEC_SPARC is not set
> diff --git a/arch/mips/ni169445/169445-console.c
> b/arch/mips/ni169445/169445-console.c new file mode 100644
> index 0000000..f07e48b
> --- /dev/null
> +++ b/arch/mips/ni169445/169445-console.c
> @@ -0,0 +1,38 @@
> +/*  Copyright 2016 National Instruments Corporation
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License as published by the
> Free + *  Software Foundation; either version 2 of the License, or (at your
> option) + *  any later version.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> WITHOUT + *  ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY or + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> General Public License for + *  more details.
> + */
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/serial_reg.h>
> +#include <linux/io.h>
> +
> +#define NI_UART0_REGS_BASE	((unsigned char __iomem *)0xbf380000)
> +
> +static inline unsigned char serial_in(int offset)
> +{
> +	return __raw_readb(NI_UART0_REGS_BASE + offset);
> +}
> +
> +static inline void serial_out(int offset, char value)
> +{
> +	__raw_writeb(value, NI_UART0_REGS_BASE + offset);
> +}
> +
> +int prom_putchar(char c)
> +{
> +	while ((serial_in(UART_LSR) & UART_LSR_THRE) == 0)
> +		;
> +
> +	serial_out(UART_TX, c);
> +
> +	return 1;
> +}

Could you use the generic 16550 earlycon support? (see CONFIG_SERIAL_8250_CONSOLE)

> diff --git a/arch/mips/ni169445/169445-init.c
> b/arch/mips/ni169445/169445-init.c new file mode 100644
> index 0000000..5c7ff5e
> --- /dev/null
> +++ b/arch/mips/ni169445/169445-init.c
> @@ -0,0 +1,39 @@
> +/*  Copyright 2016 National Instruments Corporation
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License as published by the
> Free + *  Software Foundation; either version 2 of the License, or (at your
> option) + *  any later version.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> WITHOUT + *  ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY or + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> General Public License for + *  more details.
> + */
> +#include <linux/init.h>
> +#include <linux/initrd.h>
> +#include <linux/io.h>
> +
> +#include <asm/bootinfo.h>
> +#include <asm/cacheflush.h>
> +#include <asm/traps.h>
> +#include <asm/mips-boards/generic.h>
> +#include <asm/fw/fw.h>
> +
> +void __init prom_init(void)
> +{
> +	fw_init_cmdline();
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	/* Read the initrd address from the firmware environment */
> +	initrd_start = fw_getenvl("initrd_start");
> +	if (initrd_start) {
> +		initrd_start = KSEG0ADDR(initrd_start);
> +		initrd_end = initrd_start + fw_getenvl("initrd_size");
> +	}
> +#endif
> +}
> +
> +void __init prom_free_prom_memory(void)
> +{
> +}
> diff --git a/arch/mips/ni169445/169445-int.c
> b/arch/mips/ni169445/169445-int.c new file mode 100644
> index 0000000..83caf79
> --- /dev/null
> +++ b/arch/mips/ni169445/169445-int.c
> @@ -0,0 +1,34 @@
> +/*  Copyright 2016 National Instruments Corporation
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License as published by the
> Free + *  Software Foundation; either version 2 of the License, or (at your
> option) + *  any later version.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> WITHOUT + *  ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY or + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> General Public License for + *  more details.
> + */
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/of_irq.h>
> +#include <linux/irqchip/mips-gic.h>
> +#include <linux/io.h>
> +
> +#include <asm/irq_cpu.h>
> +#include <asm/setup.h>
> +
> +static const struct of_device_id of_irq_ids[] __initconst = {
> +	{
> +		.compatible = "mti,cpu-interrupt-controller",
> +		.data = mips_cpu_irq_of_init
> +	},
> +	{},
> +};
> +
> +void __init arch_init_irq(void)
> +{
> +	of_irq_init(of_irq_ids);
> +}

The CPU interrupt controller driver already does an IRQCHIP_DECLARE to
provide its compatible string, so can you just use irqchip_init()?

> +
> diff --git a/arch/mips/ni169445/169445-setup.c
> b/arch/mips/ni169445/169445-setup.c new file mode 100644
> index 0000000..80a5c91
> --- /dev/null
> +++ b/arch/mips/ni169445/169445-setup.c
> @@ -0,0 +1,58 @@
> +/*  Copyright 2016 National Instruments Corporation
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License as published by the
> Free + *  Software Foundation; either version 2 of the License, or (at your
> option) + *  any later version.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> WITHOUT + *  ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY or + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> General Public License for + *  more details.
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
> +	return 0;
> +}
> +arch_initcall(customize_machine);
> +
> +static int __init plat_dev_init(void)
> +{
> +	of_clk_init(NULL);
> +	return 0;
> +}
> +device_initcall(plat_dev_init);
> diff --git a/arch/mips/ni169445/169445-time.c
> b/arch/mips/ni169445/169445-time.c new file mode 100644
> index 0000000..3d2499e
> --- /dev/null
> +++ b/arch/mips/ni169445/169445-time.c
> @@ -0,0 +1,35 @@
> +/*  Copyright 2016 National Instruments Corporation
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License as published by the
> Free + *  Software Foundation; either version 2 of the License, or (at your
> option) + *  any later version.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> WITHOUT + *  ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY or + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> General Public License for + *  more details.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/of.h>
> +
> +#include <asm/time.h>
> +
> +void __init plat_time_init(void)
> +{
> +	struct device_node *np;
> +	u32 freq;
> +
> +	np = of_find_node_by_name(NULL, "cpus");
> +	if (!np)
> +		panic("missing 'cpus' DT node");
> +	if (of_property_read_u32(np, "mips-hpt-frequency", &freq) < 0)
> +		panic("missing 'mips-hpt-frequency' property");

I think "clock-frequency" would be more standard, and the kernel would
then just halve it to find the frequency at which the cop0 count register
increments.

> +	of_node_put(np);
> +
> +	mips_hpt_frequency = freq;
> +
> +	/* IRQs will not work until the timer has been set at least once */
> +	write_c0_count(0);

Really? Do you have any details of this, it sounds weird. Do you mean
only the cop0 compare interrupt won't work until count is set? If so (and
that sounds strange in itself) perhaps r4k_clockevent_init() ought to do
this rather than some platform/board code.

> +}
> diff --git a/arch/mips/ni169445/Makefile b/arch/mips/ni169445/Makefile
> new file mode 100644
> index 0000000..f3a0c8c
> --- /dev/null
> +++ b/arch/mips/ni169445/Makefile
> @@ -0,0 +1,9 @@
> +#
> +#
> +obj-y				:= 169445-init.o \
> +				   169445-int.o 169445-setup.o \
> +				   169445-time.o
> +
> +obj-$(CONFIG_EARLY_PRINTK)	+= 169445-console.o
> +
> +CFLAGS_169445-setup.o = -I$(src)/../../../scripts/dtc/libfdt
> diff --git a/arch/mips/ni169445/Platform b/arch/mips/ni169445/Platform
> new file mode 100644
> index 0000000..9380312
> --- /dev/null
> +++ b/arch/mips/ni169445/Platform
> @@ -0,0 +1,6 @@
> +#
> +# National Instruments 169445 FPGA board
> +#
> +platform-$(CONFIG_NI_169445)	+= ni169445/
> +load-$(CONFIG_NI_169445)	+= 0xffffffff80002000
> +all-$(CONFIG_NI_169445)		:= $(COMPRESSION_FNAME).srec

Could all this platform/board code be scrapped in favour of adding your
system to the generic platform? There's some documentation over here
which I hope to get in-tree soon:

https://paulburton.eu/kernel-docs/mips/generic-platform.html

You can also see some further examples of systems converted to the
generic platform which I hope to get into mainline over the next few
cycles over here:

https://git.linux-mips.org/cgit/linux-mti.git/log/

But the core of the generic platform is already there & ought to be
usable for a system like this.

Thanks,
    Paul
--nextPart2783654.GHpK4RY9YK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlhQQJ8ACgkQgiDZ+mk8
HGWM7A/+J4wTpPE0PZG+suvoHxRK7spswy4u1Aog93fVVEJwaDhn8ibqpF0xMivC
jQjBHXHCSuk9oJFCKKCzxvv+QDS+d6g6862Y0TKwbEW5GTW3ikBNAqyYtiU8nT+D
aAfJnyAF7q92RF+bbH4gGuX5IenDtC41BuDpL3xXvTChFef7FLf0b2CzMaDy+GpO
3E2kDPGy0Lbjuyb+QiavWcQTgQ19DZEBUGkp6vRUExz0nh4Zc/qFbPTwQVrrqZyN
6eiDAGxQ9u17QVnoukUvALANTUW/68O6S9H3Knm1DS3pUN1PVIWEXI7qJjWHGxZ7
IHdCenpPECwJLWqjB7pLqPSbGiIiNPaDzO45uulEFLQbagUOG3+IGhCGzlNopyvQ
RBRnEoq6s0VMsysaQuuZFFFnu+JwRWTN83K6n/v74QzFEIpOJsHJTJutXS6iVxCZ
No/98xs/5BELj8be2jWbF7CoRs6XAw+lbNWAZgjrXrKdFMlWnG0zwyw7rW/NvhF8
CYz3+R6W6yko75WkiUP8IfsyHHYd40vpwK7ZlUFBLRQoYmamOwb6IG98VeW0W6Us
nighSrxpUjrB8WsGfP37WxktPLaRR8MyIB7HFjfVShmV+9HzY4R/oQrVC1v1JTta
lmIi3jOoB+G5bXWS1FkdPxSCgaKHu2V0UOWo3LGrBB7DbLzp/lE=
=tV6a
-----END PGP SIGNATURE-----

--nextPart2783654.GHpK4RY9YK--
