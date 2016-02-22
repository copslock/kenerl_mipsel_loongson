Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 20:09:17 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:51766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011154AbcBVTJOMUg3N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Feb 2016 20:09:14 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 69E4A205BC;
        Mon, 22 Feb 2016 19:09:11 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEDA42058E;
        Mon, 22 Feb 2016 19:09:09 +0000 (UTC)
Date:   Mon, 22 Feb 2016 13:09:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com
Subject: Re: [PATCH v2 2/2] bmips: add device tree example for BCM6358
Message-ID: <20160222190907.GA8409@rob-hp-laptop>
References: <1456054881-26787-2-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1456054881-26787-2-git-send-email-noltari@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52160
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

On Sun, Feb 21, 2016 at 12:41:21PM +0100, Álvaro Fernández Rojas wrote:
> This adds a device tree example for SFR Neufbox4 (Sercomm version), which
> also serves as a real example for brcm,bcm6358-leds.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v2: Remove led0 alias and use stdout-path only
> 
>  .../devicetree/bindings/mips/brcm/soc.txt          |   2 +-
>  arch/mips/bmips/Kconfig                            |   4 +
>  arch/mips/boot/dts/brcm/Makefile                   |   2 +
>  arch/mips/boot/dts/brcm/bcm6358.dtsi               | 111 +++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm96358nb4ser.dts         |  46 +++++++++
>  5 files changed, 164 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/boot/dts/brcm/bcm6358.dtsi
>  create mode 100644 arch/mips/boot/dts/brcm/bcm96358nb4ser.dts

A couple of minor things, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
> index 7bab90c..e58a4f6 100644
> --- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
> +++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
> @@ -4,7 +4,7 @@ Required properties:
>  
>  - compatible: "brcm,bcm3384", "brcm,bcm33843"
>                "brcm,bcm3384-viper", "brcm,bcm33843-viper"
> -              "brcm,bcm6328", "brcm,bcm6368",
> +              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
>                "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
>                "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"
>  
> diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
> index e2c4fd6..264328d 100644
> --- a/arch/mips/bmips/Kconfig
> +++ b/arch/mips/bmips/Kconfig
> @@ -21,6 +21,10 @@ config DT_BCM93384WVG_VIPER
>  	bool "BCM93384WVG Viper CPU (EXPERIMENTAL)"
>  	select BUILTIN_DTB
>  
> +config DT_BCM96358NB4SER
> +	bool "BCM96358NB4SER"
> +	select BUILTIN_DTB
> +
>  config DT_BCM96368MVWG
>  	bool "BCM96368MVWG"
>  	select BUILTIN_DTB
> diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
> index eabeb60..fda9d38 100644
> --- a/arch/mips/boot/dts/brcm/Makefile
> +++ b/arch/mips/boot/dts/brcm/Makefile
> @@ -1,5 +1,6 @@
>  dtb-$(CONFIG_DT_BCM93384WVG)		+= bcm93384wvg.dtb
>  dtb-$(CONFIG_DT_BCM93384WVG_VIPER)	+= bcm93384wvg_viper.dtb
> +dtb-$(CONFIG_DT_BCM96358NB4SER)		+= bcm96358nb4ser.dtb
>  dtb-$(CONFIG_DT_BCM96368MVWG)		+= bcm96368mvwg.dtb
>  dtb-$(CONFIG_DT_BCM9EJTAGPRB)		+= bcm9ejtagprb.dtb
>  dtb-$(CONFIG_DT_BCM97125CBMB)		+= bcm97125cbmb.dtb
> @@ -14,6 +15,7 @@ dtb-$(CONFIG_DT_BCM97435SVMB)		+= bcm97435svmb.dtb
>  dtb-$(CONFIG_DT_NONE)			+= \
>  						bcm93384wvg.dtb		\
>  						bcm93384wvg_viper.dtb	\
> +						bcm96358nb4ser.dtb	\
>  						bcm96368mvwg.dtb	\
>  						bcm9ejtagprb.dtb	\
>  						bcm97125cbmb.dtb	\
> diff --git a/arch/mips/boot/dts/brcm/bcm6358.dtsi b/arch/mips/boot/dts/brcm/bcm6358.dtsi
> new file mode 100644
> index 0000000..4da824f
> --- /dev/null
> +++ b/arch/mips/boot/dts/brcm/bcm6358.dtsi
> @@ -0,0 +1,111 @@
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "brcm,bcm6358";
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		mips-hpt-frequency = <150000000>;
> +
> +		cpu@0 {
> +			compatible = "brcm,bmips4350";
> +			device_type = "cpu";
> +			reg = <0>;
> +		};
> +
> +		cpu@1 {
> +			compatible = "brcm,bmips4350";
> +			device_type = "cpu";
> +			reg = <1>;
> +		};
> +	};
> +
> +	clocks {
> +		periph_clk: periph_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <50000000>;
> +		};
> +	};
> +
> +	aliases {
> +		uart0 = &uart0;
> +		uart1 = &uart1;
> +	};
> +
> +	cpu_intc: cpu_intc {
> +		#address-cells = <0>;
> +		compatible = "mti,cpu-interrupt-controller";
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +	};
> +
> +	ubus {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		periph_cntl: syscon@fffe0000 {
> +			compatible = "syscon";
> +			reg = <0xfffe0000 0xc>;
> +			little-endian;
> +		};
> +
> +		reboot: syscon-reboot@fffe0008 {
> +			compatible = "syscon-reboot";
> +			regmap = <&periph_cntl>;
> +			offset = <0x8>;
> +			mask = <0x1>;
> +		};
> +
> +		periph_intc: periph_intc@fffe000c {

interrupt-controller@...

> +			compatible = "brcm,bcm3380-l2-intc";
> +			reg = <0xfffe0010 0x4 0xfffe000c 0x4>,
> +			      <0xfffe003c 0x4 0xfffe0038 0x4>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			interrupt-parent = <&cpu_intc>;
> +			interrupts = <2>;
> +		};
> +
> +		leds0: led-controller@fffe00d0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "brcm,bcm6358-leds";
> +			reg = <0xfffe00d0 0x8>;
> +
> +			status = "disabled";
> +		};
> +
> +		uart0: serial@fffe0100 {
> +			compatible = "brcm,bcm6345-uart";
> +			reg = <0xfffe0100 0x18>;
> +
> +			interrupt-parent = <&periph_intc>;
> +			interrupts = <2>;
> +
> +			clocks = <&periph_clk>;
> +
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@fffe0120 {
> +			compatible = "brcm,bcm6345-uart";
> +			reg = <0xfffe0120 0x18>;
> +
> +			interrupt-parent = <&periph_intc>;
> +			interrupts = <3>;
> +
> +			clocks = <&periph_clk>;
> +
> +			status = "disabled";
> +		};
> +	};
> +};
> diff --git a/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
> new file mode 100644
> index 0000000..c313e2c
> --- /dev/null
> +++ b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
> @@ -0,0 +1,46 @@
> +/dts-v1/;
> +
> +/include/ "bcm6358.dtsi"
> +
> +/ {
> +	compatible = "sfr,nb4-ser", "brcm,bcm6358";
> +	model = "SFR Neufbox 4 (Sercomm)";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x02000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart0;
> +	};
> +};
> +
> +&leds0 {
> +	status = "ok";
> +
> +	alarm_white@0 {

led@0

> +		reg = <0>;
> +		active-low;
> +		label = "nb4-ser:white:alarm";
> +	};
> +	tv_white@2 {

led@2 and so on.

> +		reg = <2>;
> +		active-low;
> +		label = "nb4-ser:white:tv";
> +	};
> +	tel_white@3 {
> +		reg = <3>;
> +		active-low;
> +		label = "nb4-ser:white:tel";
> +	};
> +	adsl_white@4 {
> +		reg = <4>;
> +		active-low;
> +		label = "nb4-ser:white:adsl";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
