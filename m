Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 00:28:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33286 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992936AbdFWW2pnTbd4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jun 2017 00:28:45 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id CE07F41F8DBB;
        Sat, 24 Jun 2017 00:38:30 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sat, 24 Jun 2017 00:38:30 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sat, 24 Jun 2017 00:38:30 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 030B033C75823;
        Fri, 23 Jun 2017 23:28:35 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 23 Jun
 2017 23:28:40 +0100
Date:   Fri, 23 Jun 2017 23:28:39 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v5 4/4] MIPS: generic: Support MIPS Boston development
 boards
Message-ID: <20170623222839.GG31455@jhogan-linux.le.imgtec.org>
References: <20170617205249.1391-1-paul.burton@imgtec.com>
 <20170617205249.1391-5-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Content-Disposition: inline
In-Reply-To: <20170617205249.1391-5-paul.burton@imgtec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 17, 2017 at 01:52:49PM -0700, Paul Burton wrote:
> Add support for the MIPS Boston development board to generic kernels,
> which essentially amounts to:
>=20
>   - Adding the device tree source for the MIPS Boston board.
>=20
>   - Adding a Kconfig fragment which enables the appropriate drivers for
>     the MIPS Boston board.
>=20
> With these changes in place generic kernels will support the board by
> default, and kernels with only the drivers needed for Boston enabled can
> be configured by setting BOARDS=3Dboston during configuration. For
> example:
>=20
>   $ make ARCH=3Dmips 64r6el_defconfig BOARDS=3Dboston
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

LGTM
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>=20
> ---
>=20
> Changes in v5:
> - Adjust interrupt-map to match pcie-xilinx driver patchset changes.
>=20
> Changes in v4:
> - Most of the series already went in, rebase on v4.12-rc3.
> - Adjust DT to move img,boston-clock under the plat_regs syscon node.
> - Enable CONFIG_BLK_DEV_SD in board-boston.cfg to SATA disk access.
> - Enable CONFIG_GPIOLIB so that the GPIO driver is actually enabled.
> - Update MAINTAINERS entry.
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  MAINTAINERS                                   |   2 +
>  arch/mips/boot/dts/img/Makefile               |   2 +
>  arch/mips/boot/dts/img/boston.dts             | 224 ++++++++++++++++++++=
++++++
>  arch/mips/configs/generic/board-boston.config |  48 ++++++
>  arch/mips/generic/Kconfig                     |  12 ++
>  arch/mips/generic/vmlinux.its.S               |  25 +++
>  6 files changed, 313 insertions(+)
>  create mode 100644 arch/mips/boot/dts/img/boston.dts
>  create mode 100644 arch/mips/configs/generic/board-boston.config
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2749877a4574..70acd8ee18ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8503,6 +8503,8 @@ M:	Paul Burton <paul.burton@imgtec.com>
>  L:	linux-mips@linux-mips.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/img,boston-clock.txt
> +F:	arch/mips/boot/dts/img/boston.dts
> +F:	arch/mips/configs/generic/board-boston.config
>  F:	drivers/clk/imgtec/clk-boston.c
>  F:	include/dt-bindings/clock/boston-clock.h
> =20
> diff --git a/arch/mips/boot/dts/img/Makefile b/arch/mips/boot/dts/img/Mak=
efile
> index c178cf56f5b8..3d70958d0f5a 100644
> --- a/arch/mips/boot/dts/img/Makefile
> +++ b/arch/mips/boot/dts/img/Makefile
> @@ -1,3 +1,5 @@
> +dtb-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+=3D boston.dtb
> +
>  dtb-$(CONFIG_MACH_PISTACHIO)	+=3D pistachio_marduk.dtb
>  obj-$(CONFIG_MACH_PISTACHIO)	+=3D pistachio_marduk.dtb.o
> =20
> diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/b=
oston.dts
> new file mode 100644
> index 000000000000..53bfa29a7093
> --- /dev/null
> +++ b/arch/mips/boot/dts/img/boston.dts
> @@ -0,0 +1,224 @@
> +/dts-v1/;
> +
> +#include <dt-bindings/clock/boston-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/mips-gic.h>
> +
> +/ {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	compatible =3D "img,boston";
> +
> +	chosen {
> +		stdout-path =3D "uart0:115200";
> +	};
> +
> +	aliases {
> +		uart0 =3D &uart0;
> +	};
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu@0 {
> +			device_type =3D "cpu";
> +			compatible =3D "img,mips";
> +			reg =3D <0>;
> +			clocks =3D <&clk_boston BOSTON_CLK_CPU>;
> +		};
> +	};
> +
> +	memory@0 {
> +		device_type =3D "memory";
> +		reg =3D <0x00000000 0x10000000>;
> +	};
> +
> +	pci0: pci@10000000 {
> +		compatible =3D "xlnx,axi-pcie-host-1.00.a";
> +		device_type =3D "pci";
> +		reg =3D <0x10000000 0x2000000>;
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		#interrupt-cells =3D <1>;
> +
> +		interrupt-parent =3D <&gic>;
> +		interrupts =3D <GIC_SHARED 2 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		ranges =3D <0x02000000 0 0x40000000
> +			  0x40000000 0 0x40000000>;
> +
> +		interrupt-map-mask =3D <0 0 0 7>;
> +		interrupt-map =3D <0 0 0 1 &pci0_intc 1>,
> +				<0 0 0 2 &pci0_intc 2>,
> +				<0 0 0 3 &pci0_intc 3>,
> +				<0 0 0 4 &pci0_intc 4>;
> +
> +		pci0_intc: interrupt-controller {
> +			interrupt-controller;
> +			#address-cells =3D <0>;
> +			#interrupt-cells =3D <1>;
> +		};
> +	};
> +
> +	pci1: pci@12000000 {
> +		compatible =3D "xlnx,axi-pcie-host-1.00.a";
> +		device_type =3D "pci";
> +		reg =3D <0x12000000 0x2000000>;
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		#interrupt-cells =3D <1>;
> +
> +		interrupt-parent =3D <&gic>;
> +		interrupts =3D <GIC_SHARED 1 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		ranges =3D <0x02000000 0 0x20000000
> +			  0x20000000 0 0x20000000>;
> +
> +		interrupt-map-mask =3D <0 0 0 7>;
> +		interrupt-map =3D <0 0 0 1 &pci1_intc 1>,
> +				<0 0 0 2 &pci1_intc 2>,
> +				<0 0 0 3 &pci1_intc 3>,
> +				<0 0 0 4 &pci1_intc 4>;
> +
> +		pci1_intc: interrupt-controller {
> +			interrupt-controller;
> +			#address-cells =3D <0>;
> +			#interrupt-cells =3D <1>;
> +		};
> +	};
> +
> +	pci2: pci@14000000 {
> +		compatible =3D "xlnx,axi-pcie-host-1.00.a";
> +		device_type =3D "pci";
> +		reg =3D <0x14000000 0x2000000>;
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		#interrupt-cells =3D <1>;
> +
> +		interrupt-parent =3D <&gic>;
> +		interrupts =3D <GIC_SHARED 0 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		ranges =3D <0x02000000 0 0x16000000
> +			  0x16000000 0 0x100000>;
> +
> +		interrupt-map-mask =3D <0 0 0 7>;
> +		interrupt-map =3D <0 0 0 1 &pci2_intc 1>,
> +				<0 0 0 2 &pci2_intc 2>,
> +				<0 0 0 3 &pci2_intc 3>,
> +				<0 0 0 4 &pci2_intc 4>;
> +
> +		pci2_intc: interrupt-controller {
> +			interrupt-controller;
> +			#address-cells =3D <0>;
> +			#interrupt-cells =3D <1>;
> +		};
> +
> +		pci2_root@0,0,0 {
> +			compatible =3D "pci10ee,7021";
> +			reg =3D <0x00000000 0 0 0 0>;
> +
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			#interrupt-cells =3D <1>;
> +
> +			eg20t_bridge@1,0,0 {
> +				compatible =3D "pci8086,8800";
> +				reg =3D <0x00010000 0 0 0 0>;
> +
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				#interrupt-cells =3D <1>;
> +
> +				eg20t_mac@2,0,1 {
> +					compatible =3D "pci8086,8802";
> +					reg =3D <0x00020100 0 0 0 0>;
> +					phy-reset-gpios =3D <&eg20t_gpio 6
> +							   GPIO_ACTIVE_LOW>;
> +				};
> +
> +				eg20t_gpio: eg20t_gpio@2,0,2 {
> +					compatible =3D "pci8086,8803";
> +					reg =3D <0x00020200 0 0 0 0>;
> +
> +					gpio-controller;
> +					#gpio-cells =3D <2>;
> +				};
> +
> +				eg20t_i2c@2,12,2 {
> +					compatible =3D "pci8086,8817";
> +					reg =3D <0x00026200 0 0 0 0>;
> +
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +
> +					rtc@0x68 {
> +						compatible =3D "st,m41t81s";
> +						reg =3D <0x68>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	gic: interrupt-controller@16120000 {
> +		compatible =3D "mti,gic";
> +		reg =3D <0x16120000 0x20000>;
> +
> +		interrupt-controller;
> +		#interrupt-cells =3D <3>;
> +
> +		timer {
> +			compatible =3D "mti,gic-timer";
> +			interrupts =3D <GIC_LOCAL 1 IRQ_TYPE_NONE>;
> +			clocks =3D <&clk_boston BOSTON_CLK_CPU>;
> +		};
> +	};
> +
> +	cdmm@16140000 {
> +		compatible =3D "mti,mips-cdmm";
> +		reg =3D <0x16140000 0x8000>;
> +	};
> +
> +	cpc@16200000 {
> +		compatible =3D "mti,mips-cpc";
> +		reg =3D <0x16200000 0x8000>;
> +	};
> +
> +	plat_regs: system-controller@17ffd000 {
> +		compatible =3D "img,boston-platform-regs", "syscon";
> +		reg =3D <0x17ffd000 0x1000>;
> +
> +		clk_boston: clock {
> +			compatible =3D "img,boston-clock";
> +			#clock-cells =3D <1>;
> +		};
> +	};
> +
> +	reboot: syscon-reboot {
> +		compatible =3D "syscon-reboot";
> +		regmap =3D <&plat_regs>;
> +		offset =3D <0x10>;
> +		mask =3D <0x10>;
> +	};
> +
> +	uart0: uart@17ffe000 {
> +		compatible =3D "ns16550a";
> +		reg =3D <0x17ffe000 0x1000>;
> +		reg-shift =3D <2>;
> +
> +		interrupt-parent =3D <&gic>;
> +		interrupts =3D <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		clocks =3D <&clk_boston BOSTON_CLK_SYS>;
> +	};
> +
> +	lcd: lcd@17fff000 {
> +		compatible =3D "img,boston-lcd";
> +		reg =3D <0x17fff000 0x8>;
> +	};
> +};
> diff --git a/arch/mips/configs/generic/board-boston.config b/arch/mips/co=
nfigs/generic/board-boston.config
> new file mode 100644
> index 000000000000..19560a45b683
> --- /dev/null
> +++ b/arch/mips/configs/generic/board-boston.config
> @@ -0,0 +1,48 @@
> +CONFIG_FIT_IMAGE_FDT_BOSTON=3Dy
> +
> +CONFIG_ATA=3Dy
> +CONFIG_SATA_AHCI=3Dy
> +CONFIG_SCSI=3Dy
> +CONFIG_BLK_DEV_SD=3Dy
> +
> +CONFIG_AUXDISPLAY=3Dy
> +CONFIG_IMG_ASCII_LCD=3Dy
> +
> +CONFIG_COMMON_CLK_BOSTON=3Dy
> +
> +CONFIG_DMADEVICES=3Dy
> +CONFIG_PCH_DMA=3Dy
> +
> +CONFIG_GPIOLIB=3Dy
> +CONFIG_GPIO_SYSFS=3Dy
> +CONFIG_GPIO_PCH=3Dy
> +
> +CONFIG_I2C=3Dy
> +CONFIG_I2C_EG20T=3Dy
> +
> +CONFIG_MMC=3Dy
> +CONFIG_MMC_SDHCI=3Dy
> +CONFIG_MMC_SDHCI_PCI=3Dy
> +
> +CONFIG_NETDEVICES=3Dy
> +CONFIG_PCH_GBE=3Dy
> +
> +CONFIG_PCI=3Dy
> +CONFIG_PCI_MSI=3Dy
> +CONFIG_PCIE_XILINX=3Dy
> +
> +CONFIG_PCH_PHUB=3Dy
> +
> +CONFIG_RTC_CLASS=3Dy
> +CONFIG_RTC_DRV_M41T80=3Dy
> +
> +CONFIG_SERIAL_8250=3Dy
> +CONFIG_SERIAL_8250_CONSOLE=3Dy
> +CONFIG_SERIAL_OF_PLATFORM=3Dy
> +
> +CONFIG_SPI=3Dy
> +CONFIG_SPI_TOPCLIFF_PCH=3Dy
> +
> +CONFIG_USB=3Dy
> +CONFIG_USB_EHCI_HCD=3Dy
> +CONFIG_USB_OHCI_HCD=3Dy
> diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> index a606b3f9196c..3b74d4ed9140 100644
> --- a/arch/mips/generic/Kconfig
> +++ b/arch/mips/generic/Kconfig
> @@ -9,6 +9,8 @@ config LEGACY_BOARDS
>  	  kernel is booted without being provided with an FDT via the UHI
>  	  boot protocol.
> =20
> +comment "Legacy (non-UHI/non-FIT) Boards"
> +
>  config LEGACY_BOARD_SEAD3
>  	bool "Support MIPS SEAD-3 boards"
>  	select LEGACY_BOARDS
> @@ -16,4 +18,14 @@ config LEGACY_BOARD_SEAD3
>  	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
>  	  development boards, which boot using a legacy boot protocol.
> =20
> +comment "FIT/UHI Boards"
> +
> +config FIT_IMAGE_FDT_BOSTON
> +	bool "Include FDT for MIPS Boston boards"
> +	help
> +	  Enable this to include the FDT for the MIPS Boston development board
> +	  from Imagination Technologies in the FIT kernel image. You should
> +	  enable this if you wish to boot on a MIPS Boston board, as it is
> +	  expected by the bootloader.
> +
>  endif
> diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.=
its.S
> index f67fbf1c8541..3390e2f80b80 100644
> --- a/arch/mips/generic/vmlinux.its.S
> +++ b/arch/mips/generic/vmlinux.its.S
> @@ -29,3 +29,28 @@
>  		};
>  	};
>  };
> +
> +#ifdef CONFIG_FIT_IMAGE_FDT_BOSTON
> +/ {
> +	images {
> +		fdt@boston {
> +			description =3D "img,boston Device Tree";
> +			data =3D /incbin/("boot/dts/img/boston.dtb");
> +			type =3D "flat_dt";
> +			arch =3D "mips";
> +			compression =3D "none";
> +			hash@0 {
> +				algo =3D "sha1";
> +			};
> +		};
> +	};
> +
> +	configurations {
> +		conf@boston {
> +			description =3D "Boston Linux kernel";
> +			kernel =3D "kernel@0";
> +			fdt =3D "fdt@boston";
> +		};
> +	};
> +};
> +#endif /* CONFIG_FIT_IMAGE_FDT_BOSTON */
> --=20
> 2.13.1
>=20
>=20

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllNlhYACgkQbAtpk944
dnom4w//em9QGXZgvEarnXMO8kwiyMTR8BjBAeAIFMsvUB7StCJPRtU7pIh0iooA
t/OPqSBcO3r+S9LeE6Mebcz1m+9EfuTgsW4QdFSN+NB9GMRc8wdrl/vwXrGSVdsu
ka6OKdHktVvzauFLUBpqZwG3cIWUE0VqdwFvRzYJXYyQyNkp/dK82eLBp0JRARRQ
p6IDvIurSbyCQxBFH0wPtLiHxa0Sj/0UQboCSefwmO5YtR6PIZ+aOZ8s4LR7SWuy
H634lZ8Eqz4ahnIMkLigQsT/9c5oa7yMtYGY0lPlD3cmUpaQcVpz4TPBJIluavRC
cc4iRgIlnoqhfYkrN/StmUkqKmPQcLJgRA9U1+8AWFmpkRGRJzKPYbAdO9rFZeYv
1smjBf7rU+VFvCa1V/wbRvKCUj6UVv2wQ/d/AdSZPcnTLbqejGt5Gx+rHZr/pWCH
RVynrbiSr/xlcx/KcDjLmpqEHPb3qTKnmprOxP1Gq0oj1BMhcqtNRAAw+eWsFexa
fpV+edR5LS1OB1J4+Kt8SE5UCTmLEIbAyklJMqbS8toEMqwifIFOiAGDdn36dHD5
nOR74w2O9ZEBSlL821saOKVF+9jafLaMov+sV2Jm6KxKcxLwRtcV7jnHxQ0dIpB+
kejXo7nAPo4hV6vTXWiujBVqT9ysJm8/Um0Si9d6N339/cp6D+k=
=JYUN
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
