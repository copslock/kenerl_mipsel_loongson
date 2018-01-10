Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 23:43:59 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:55214 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeAJWnvX0btI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 23:43:51 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 10 Jan 2018 22:43:29 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 10 Jan
 2018 14:42:36 -0800
Date:   Wed, 10 Jan 2018 22:42:34 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v6 11/15] MIPS: ingenic: Initial JZ4770 support
Message-ID: <20180110224233.GV27409@jhogan-linux.mipstec.com>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180105182513.16248-1-paul@crapouillou.net>
 <20180105182513.16248-12-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bn6XL8m8Y51x7rzV"
Content-Disposition: inline
In-Reply-To: <20180105182513.16248-12-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1515624208-298555-2578-1082-6
X-BESS-VER: 2017.17-r1801091856
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188374
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--bn6XL8m8Y51x7rzV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2018 at 07:25:09PM +0100, Paul Cercueil wrote:
> Provide just enough bits (clocks, clocksource, uart) to allow a kernel
> to boot on the JZ4770 SoC to a initramfs userspace.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---
>  arch/mips/boot/dts/ingenic/jz4770.dtsi | 212 +++++++++++++++++++++++++++=
++++++
>  arch/mips/jz4740/Kconfig               |   6 +
>  arch/mips/jz4740/time.c                |   2 +-
>  3 files changed, 219 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/boot/dts/ingenic/jz4770.dtsi

We should probably have a MAINTAINERS entry including this file. Same
goes for the GC0 files added in the last patch.

Cheers
James

>=20
>  v2: No change
>  v3: No change
>  v4: No change
>  v5: Use SPDX license identifier
>  v6: No change
>=20
> diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/=
ingenic/jz4770.dtsi
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
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	compatible =3D "ingenic,jz4770";
> +
> +	cpuintc: interrupt-controller {
> +		#address-cells =3D <0>;
> +		#interrupt-cells =3D <1>;
> +		interrupt-controller;
> +		compatible =3D "mti,cpu-interrupt-controller";
> +	};
> +
> +	intc: interrupt-controller@10001000 {
> +		compatible =3D "ingenic,jz4770-intc";
> +		reg =3D <0x10001000 0x40>;
> +
> +		interrupt-controller;
> +		#interrupt-cells =3D <1>;
> +
> +		interrupt-parent =3D <&cpuintc>;
> +		interrupts =3D <2>;
> +	};
> +
> +	ext: ext {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +	};
> +
> +	osc32k: osc32k {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <32768>;
> +	};
> +
> +	cgu: jz4770-cgu@10000000 {
> +		compatible =3D "ingenic,jz4770-cgu";
> +		reg =3D <0x10000000 0x100>;
> +
> +		clocks =3D <&ext>, <&osc32k>;
> +		clock-names =3D "ext", "osc32k";
> +
> +		#clock-cells =3D <1>;
> +	};
> +
> +	pinctrl: pin-controller@10010000 {
> +		compatible =3D "ingenic,jz4770-pinctrl";
> +		reg =3D <0x10010000 0x600>;
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		gpa: gpio@0 {
> +			compatible =3D "ingenic,jz4770-gpio";
> +			reg =3D <0>;
> +
> +			gpio-controller;
> +			gpio-ranges =3D <&pinctrl 0 0 32>;
> +			#gpio-cells =3D <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +
> +			interrupt-parent =3D <&intc>;
> +			interrupts =3D <17>;
> +		};
> +
> +		gpb: gpio@1 {
> +			compatible =3D "ingenic,jz4770-gpio";
> +			reg =3D <1>;
> +
> +			gpio-controller;
> +			gpio-ranges =3D <&pinctrl 0 32 32>;
> +			#gpio-cells =3D <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +
> +			interrupt-parent =3D <&intc>;
> +			interrupts =3D <16>;
> +		};
> +
> +		gpc: gpio@2 {
> +			compatible =3D "ingenic,jz4770-gpio";
> +			reg =3D <2>;
> +
> +			gpio-controller;
> +			gpio-ranges =3D <&pinctrl 0 64 32>;
> +			#gpio-cells =3D <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +
> +			interrupt-parent =3D <&intc>;
> +			interrupts =3D <15>;
> +		};
> +
> +		gpd: gpio@3 {
> +			compatible =3D "ingenic,jz4770-gpio";
> +			reg =3D <3>;
> +
> +			gpio-controller;
> +			gpio-ranges =3D <&pinctrl 0 96 32>;
> +			#gpio-cells =3D <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +
> +			interrupt-parent =3D <&intc>;
> +			interrupts =3D <14>;
> +		};
> +
> +		gpe: gpio@4 {
> +			compatible =3D "ingenic,jz4770-gpio";
> +			reg =3D <4>;
> +
> +			gpio-controller;
> +			gpio-ranges =3D <&pinctrl 0 128 32>;
> +			#gpio-cells =3D <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +
> +			interrupt-parent =3D <&intc>;
> +			interrupts =3D <13>;
> +		};
> +
> +		gpf: gpio@5 {
> +			compatible =3D "ingenic,jz4770-gpio";
> +			reg =3D <5>;
> +
> +			gpio-controller;
> +			gpio-ranges =3D <&pinctrl 0 160 32>;
> +			#gpio-cells =3D <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +
> +			interrupt-parent =3D <&intc>;
> +			interrupts =3D <12>;
> +		};
> +	};
> +
> +	uart0: serial@10030000 {
> +		compatible =3D "ingenic,jz4770-uart";
> +		reg =3D <0x10030000 0x100>;
> +
> +		clocks =3D <&ext>, <&cgu JZ4770_CLK_UART0>;
> +		clock-names =3D "baud", "module";
> +
> +		interrupt-parent =3D <&intc>;
> +		interrupts =3D <5>;
> +
> +		status =3D "disabled";
> +	};
> +
> +	uart1: serial@10031000 {
> +		compatible =3D "ingenic,jz4770-uart";
> +		reg =3D <0x10031000 0x100>;
> +
> +		clocks =3D <&ext>, <&cgu JZ4770_CLK_UART1>;
> +		clock-names =3D "baud", "module";
> +
> +		interrupt-parent =3D <&intc>;
> +		interrupts =3D <4>;
> +
> +		status =3D "disabled";
> +	};
> +
> +	uart2: serial@10032000 {
> +		compatible =3D "ingenic,jz4770-uart";
> +		reg =3D <0x10032000 0x100>;
> +
> +		clocks =3D <&ext>, <&cgu JZ4770_CLK_UART2>;
> +		clock-names =3D "baud", "module";
> +
> +		interrupt-parent =3D <&intc>;
> +		interrupts =3D <3>;
> +
> +		status =3D "disabled";
> +	};
> +
> +	uart3: serial@10033000 {
> +		compatible =3D "ingenic,jz4770-uart";
> +		reg =3D <0x10033000 0x100>;
> +
> +		clocks =3D <&ext>, <&cgu JZ4770_CLK_UART3>;
> +		clock-names =3D "baud", "module";
> +
> +		interrupt-parent =3D <&intc>;
> +		interrupts =3D <2>;
> +
> +		status =3D "disabled";
> +	};
> +
> +	uhc: uhc@13430000 {
> +		compatible =3D "generic-ohci";
> +		reg =3D <0x13430000 0x1000>;
> +
> +		clocks =3D <&cgu JZ4770_CLK_UHC>, <&cgu JZ4770_CLK_UHC_PHY>;
> +		assigned-clocks =3D <&cgu JZ4770_CLK_UHC>;
> +		assigned-clock-rates =3D <48000000>;
> +
> +		interrupt-parent =3D <&intc>;
> +		interrupts =3D <20>;
> +
> +		status =3D "disabled";
> +	};
> +};
> diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
> index 643af2012e14..29a9361a2b77 100644
> --- a/arch/mips/jz4740/Kconfig
> +++ b/arch/mips/jz4740/Kconfig
> @@ -18,6 +18,12 @@ config MACH_JZ4740
>  	bool
>  	select SYS_HAS_CPU_MIPS32_R1
> =20
> +config MACH_JZ4770
> +	bool
> +	select MIPS_CPU_SCACHE
> +	select SYS_HAS_CPU_MIPS32_R2
> +	select SYS_SUPPORTS_HIGHMEM
> +
>  config MACH_JZ4780
>  	bool
>  	select MIPS_CPU_SCACHE
> diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
> index bb1ad5119da4..2ca9160f642a 100644
> --- a/arch/mips/jz4740/time.c
> +++ b/arch/mips/jz4740/time.c
> @@ -113,7 +113,7 @@ static struct clock_event_device jz4740_clockevent =
=3D {
>  #ifdef CONFIG_MACH_JZ4740
>  	.irq =3D JZ4740_IRQ_TCU0,
>  #endif
> -#ifdef CONFIG_MACH_JZ4780
> +#if defined(CONFIG_MACH_JZ4770) || defined(CONFIG_MACH_JZ4780)
>  	.irq =3D JZ4780_IRQ_TCU2,
>  #endif
>  };
> --=20
> 2.11.0
>=20
>=20

--bn6XL8m8Y51x7rzV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpWltkACgkQbAtpk944
dnrZoQ/+KvIvwnnXkdIHne9Syw20uMLCkS0ZKvIKJg5gxSNHwcUZUrGTYYy/3Dwc
GKNL7g+uq4xvzeN2jcknXut41Pwt7fkDhHgPPcPoDLzibL63+vlLTrZvJ32IQvgI
y6xAz5lnHfDlUl6bkW6oe/fZS/MffTcZlsQFdiNapiqqSs5bh9/G3kgstSyGn+Qe
CPb4yiMMArfxYNlRG1pmvm1VIKcHwI0dh5mQL8UeEj30VnA5Rm6Yoba8+VXv7GHt
i4AV/BnQ7aqBg62RQus+K5EU73Fxfb9xFYhAbxpmKbUPtjzk3iKbpj2MA8IHWLO4
RW2d4DhS/O0T5B9Fn4q+MPpYTzuy934rVSsRBLButLeDzsP6w/WgT7J3QDSq2ow8
P+yNZP8zTIBzoPo5Xy9gG5Ly6C9f0/HkKNPfIaMsyE/09esgUZ4neNk9KknsgQFv
tcqHTV9/uMLHpW/rKTtvJManxPaX4UgV1nSmdm1X2HeLH9EmiwgeMxRUZegEHfNE
Xj09Mzthv2VN2BXEGUt98bhKBdGBPszpFsPcKUFUm5JqZU1Fhb6HGm1kHJKjewaB
692J7ySaD/BXCbh90s4Gw5DK8r2L1ZAj1AsoV0Wppa9NYCu9ciDFSGCNYgsNZcBb
DBLUCXjsKZDXhAGAl/iNx5/2cBTzl12GWUuF0ZBRj3GqOCqUTj8=
=Qtfk
-----END PGP SIGNATURE-----

--bn6XL8m8Y51x7rzV--
