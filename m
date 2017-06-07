Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 00:02:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38578 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990508AbdFGWCLrq0we (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 00:02:11 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id A351841F8D1C;
        Thu,  8 Jun 2017 00:11:12 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 08 Jun 2017 00:11:12 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 08 Jun 2017 00:11:12 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 51DAE10AD74D4;
        Wed,  7 Jun 2017 23:02:01 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 7 Jun 2017 23:02:06 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 7 Jun
 2017 23:02:05 +0100
Received: from np-p-burton.localnet (10.20.1.33) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 7 Jun 2017
 15:02:03 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Nathan Sullivan <nathan.sullivan@ni.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] MIPS: NI 169445 board support
Date:   Wed, 7 Jun 2017 15:01:58 -0700
Message-ID: <1663401.DU57P1IPDA@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <1496259237-9524-1-git-send-email-nathan.sullivan@ni.com>
References: <1496259237-9524-1-git-send-email-nathan.sullivan@ni.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8755697.gCJLJ9ZGZ5";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.33]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58291
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

--nextPart8755697.gCJLJ9ZGZ5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Nathan,

On Wednesday, 31 May 2017 12:33:57 PDT Nathan Sullivan wrote:
> Support the National Instruments 169445 board.
> 
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> ---
> 
> Changes from v4:
> 
> - Address Rob Herring's device tree feedback
> 
> I'm still unclear on the vmlinux.its.S changes.  The linux-mti tree has a
> config in the image tree for each board it supports, and I followed that
> pattern here.  Rob was concerned about how the configs would scale wrt
> the number of bootloaders around, but it's really just one per board/dt,
> right?

It is one per board/DT as you say - ie. it's about including multiple DTs into 
the FIT/.itb kernel image rather than about producing multiple image formats. 
What you've done does indeed match what I've been doing for our boards in the 
linux-mti downstream & in code submitted upstream.

I guess it might be nice at some point to break apart the entries in 
vmlinux.its.S to a file per board or something, and it'd also be nice if we 
had a way to automatically only include boards that make sense for a targeted 
ISA - eg. if a board has a little endian MIPS32r2 CPU there's no point 
including drivers or DT for it in big endian, MIPS64 or MIPSr6 kernels. Right 
now that can only be done manually by specifying BOARDS= when configuring the 
kernel.

Still, it's great to see a board support patch like this one rather than the 
"copy arch/mips/mti-malta & bodge it" style patches that many have produced 
before - so thanks & nice work :)

Thanks,
    Paul

> 
> ---
>  Documentation/devicetree/bindings/mips/ni.txt   |   7 ++
>  MAINTAINERS                                     |   8 ++
>  arch/mips/boot/dts/Makefile                     |   1 +
>  arch/mips/boot/dts/ni/169445.dts                | 100
> ++++++++++++++++++++++++ arch/mips/boot/dts/ni/Makefile                  | 
>  7 ++
>  arch/mips/configs/generic/board-ni169445.config |  27 +++++++
>  arch/mips/generic/Kconfig                       |   6 ++
>  arch/mips/generic/vmlinux.its.S                 |  25 ++++++
>  8 files changed, 181 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/ni.txt
>  create mode 100644 arch/mips/boot/dts/ni/169445.dts
>  create mode 100644 arch/mips/boot/dts/ni/Makefile
>  create mode 100644 arch/mips/configs/generic/board-ni169445.config
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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 053c3bd..e6662d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9047,6 +9047,14 @@ F:	include/linux/sunrpc/
>  F:	include/uapi/linux/nfs*
>  F:	include/uapi/linux/sunrpc/
> 
> +NI169445 MIPS ARCHITECTURE
> +M:	Nathan Sullivan <nathan.sullivan@ni.com>
> +L:	linux-mips@linux-mips.org
> +S:	Maintained
> +F:	arch/mips/boot/dts/ni/
> +F:	arch/mips/configs/generic/board-ni169445.config
> +F:	Documentation/devicetree/bindings/mips/ni.txt
> +
>  NILFS2 FILESYSTEM
>  M:	Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
>  L:	linux-nilfs@vger.kernel.org
> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index b9db492..27b0f37 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -4,6 +4,7 @@ dts-dirs	+= img
>  dts-dirs	+= ingenic
>  dts-dirs	+= lantiq
>  dts-dirs	+= mti
> +dts-dirs	+= ni
>  dts-dirs	+= netlogic
>  dts-dirs	+= pic32
>  dts-dirs	+= qca
> diff --git a/arch/mips/boot/dts/ni/169445.dts
> b/arch/mips/boot/dts/ni/169445.dts new file mode 100644
> index 0000000..6a20036
> --- /dev/null
> +++ b/arch/mips/boot/dts/ni/169445.dts
> @@ -0,0 +1,100 @@
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "ni,169445";
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "mti,mips14KEc";
> +			clocks = <&baseclk>;
> +			reg = <0>;
> +		};
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x10000000>;
> +	};
> +
> +	baseclk: baseclock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <50000000>;
> +	};
> +
> +	cpu_intc: interrupt-controller {
> +		#address-cells = <0>;
> +		compatible = "mti,cpu-interrupt-controller";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +	};
> +
> +	ahb@1f300000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x1f300000 0x80FFF>;
> +
> +		gpio1: gpio@1f300010 {
> +			compatible = "ni,169445-nand-gpio";
> +			reg = <0x10 0x4>;
> +			reg-names = "dat";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
> +		gpio2: gpio@1f300014 {
> +			compatible = "ni,169445-nand-gpio";
> +			reg = <0x14 0x4>;
> +			reg-names = "dat";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			no-output;
> +		};
> +
> +		nand@1f300000 {
> +			compatible = "gpio-control-nand";
> +			nand-on-flash-bbt;
> +			nand-ecc-mode = "soft_bch";
> +			nand-ecc-step-size = <512>;
> +			nand-ecc-strength = <4>;
> +			reg = <0x0 4>;
> +			gpios = <&gpio2 0 0>, /* rdy */
> +				<&gpio1 1 0>, /* nce */
> +				<&gpio1 2 0>, /* ale */
> +				<&gpio1 3 0>, /* cle */
> +				<&gpio1 4 0>; /* nwp */
> +		};
> +
> +		serial@1f380000 {
> +			compatible = "ns16550a";
> +			reg = <0x80000 0x1000>;
> +			interrupt-parent = <&cpu_intc>;
> +			interrupts = <6>;
> +			clocks = <&baseclk>;
> +			reg-shift = <0>;
> +		};
> +
> +		ethernet@1f340000 {
> +			compatible = "snps,dwmac-4.10a";
> +			interrupt-parent = <&cpu_intc>;
> +			interrupts = <5>;
> +			interrupt-names = "macirq";
> +			reg = <0x40000 0x2000>;
> +			clock-names = "stmmaceth", "pclk";
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
> index 0000000..66cfdff
> --- /dev/null
> +++ b/arch/mips/boot/dts/ni/Makefile
> @@ -0,0 +1,7 @@
> +dtb-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= 169445.dtb
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-					+= dummy.o
> +
> +always					:= $(dtb-y)
> +clean-files				:= *.dtb *.dtb.S
> diff --git a/arch/mips/configs/generic/board-ni169445.config
> b/arch/mips/configs/generic/board-ni169445.config new file mode 100644
> index 0000000..0bae1f8
> --- /dev/null
> +++ b/arch/mips/configs/generic/board-ni169445.config
> @@ -0,0 +1,27 @@
> +CONFIG_FIT_IMAGE_FDT_NI169445=y
> +
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +
> +CONFIG_GPIOLIB=y
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_GPIO_GENERIC_PLATFORM=y
> +
> +CONFIG_MTD=y
> +CONFIG_MTD_BLOCK=y
> +CONFIG_MTD_CMDLINE_PARTS=y
> +
> +CONFIG_MTD_NAND_ECC=y
> +CONFIG_MTD_NAND_ECC_BCH=y
> +CONFIG_MTD_NAND=y
> +CONFIG_MTD_NAND_GPIO=y
> +CONFIG_MTD_NAND_IDS=y
> +
> +CONFIG_MTD_UBI=y
> +CONFIG_MTD_UBI_BLOCK=y
> +
> +CONFIG_NETDEVICES=y
> +CONFIG_STMMAC_ETH=y
> +CONFIG_STMMAC_PLATFORM=y
> +CONFIG_DWMAC_GENERIC=y
> diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> index a606b3f..fbf0813 100644
> --- a/arch/mips/generic/Kconfig
> +++ b/arch/mips/generic/Kconfig
> @@ -16,4 +16,10 @@ config LEGACY_BOARD_SEAD3
>  	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
>  	  development boards, which boot using a legacy boot protocol.
> 
> +config FIT_IMAGE_FDT_NI169445
> +	bool "Include FDT for NI 169445"
> +	help
> +	  Enable this to include the FDT for the 169445 platform from
> +	  National Instruments in the FIT kernel image.
> +
>  endif
> diff --git a/arch/mips/generic/vmlinux.its.S
> b/arch/mips/generic/vmlinux.its.S index f67fbf1..de851f7 100644
> --- a/arch/mips/generic/vmlinux.its.S
> +++ b/arch/mips/generic/vmlinux.its.S
> @@ -29,3 +29,28 @@
>  		};
>  	};
>  };
> +
> +#ifdef CONFIG_FIT_IMAGE_FDT_NI169445
> +/ {
> +	images {
> +		fdt@ni169445 {
> +			description = "NI 169445 device tree";
> +			data = /incbin/("boot/dts/ni/169445.dtb");
> +			type = "flat_dt";
> +			arch = "mips";
> +			compression = "none";
> +			hash@0 {
> +				algo = "sha1";
> +			};
> +		};
> +	};
> +
> +	configurations {
> +		conf@ni169445 {
> +			description = "NI 169445 Linux Kernel";
> +			kernel = "kernel@0";
> +			fdt = "fdt@ni169445";
> +		};
> +	};
> +};
> +#endif


--nextPart8755697.gCJLJ9ZGZ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlk4d9YACgkQgiDZ+mk8
HGXAIw/+OcfzKwrSsDt1zuJCValadYO6bolhX1lVk+MaypMfKNwyRkCkn8q15/md
WaQSRpIJIyke+RT9nGgPDb1yqbW3GWh3UOOMbQ1TcpBlaT4JWq7R78SAoLfZVQrq
qwdPVIPfeNC/FXia926xr77hsjUY48yGaGcbjj5P7FnvqYnOqMdp1nCS2Ig6JR6Q
f4ptjew3qRKktQkz3cVPW3o0syfMljgSGvRoLoy2MnEK+WwQ+bDjS+ng4MlSXNua
H4Ut71Sxz98WvNBuduF9Zozg77y4ekrRVh7qCA83zzS1G1ExH8LCpiH8jKW4RkVm
1Cv0qAq2tRLpoY41bBOazGFQwLsXO2CvsawZ+N3O53jRBgbWMQBShDv74l+sLrI6
GkCypk8e4Rl813lioUXokQRfXd1m/0ogPw/yyZV9Yjyrik+GTE2ZP5ayykHPRZtW
eXNzgFD4dM5m7VqRMNpub5kIXTA8IxQghhogj2N+pR7tNMI5O03e3D/DuGkIpOaT
qUjNSWrUsIBU3VMe4n/gx6WlQ5ZwYHiX/x0pxdriBIG2xMWqCfdQB3qGbqexQthQ
jOShTZcTbkqtBK2W7NDLjcTgOQbEXzC/4lXWOGiXQE22xxrSoDqRNlp2nF0Ez3NX
D0OM1L1CHf/c18/eD/FKgHSa+ukw7zxshyEtwOZA+wZij8eodr0=
=ghkZ
-----END PGP SIGNATURE-----

--nextPart8755697.gCJLJ9ZGZ5--
