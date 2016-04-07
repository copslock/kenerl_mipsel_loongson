Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2016 19:57:29 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:56543 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026232AbcDGR5ZecihQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Apr 2016 19:57:25 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id B672E20256;
        Thu,  7 Apr 2016 17:57:22 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D9D20251;
        Thu,  7 Apr 2016 17:57:21 +0000 (UTC)
Date:   Thu, 7 Apr 2016 12:57:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, jogo@openwrt.org,
        cernekee@gmail.com
Subject: Re: [PATCH v4 2/2] bmips: add device tree example for BCM6358
Message-ID: <20160407175719.GE32257@rob-hp-laptop>
References: <1459677376-10449-1-git-send-email-noltari@gmail.com>
 <1459757353-14683-1-git-send-email-noltari@gmail.com>
 <1459757353-14683-2-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1459757353-14683-2-git-send-email-noltari@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52926
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

On Mon, Apr 04, 2016 at 10:09:13AM +0200, Álvaro Fernández Rojas wrote:
> This adds a device tree example for SFR Neufbox4 (Sercomm version), which
> also serves as a real example for brcm,bcm6358-leds.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v4: Device tree improvements:
>   - Switch to native-endian for syscon.
>   - Switch to bcm6345-l1-intc interrupt controller.
>   - Add ehci and ohci nodes.
>  v3: Device tree fixes
>   - Use interrupt-controller instead of periph_intc.
>   - Use led@# instead of naming the LEDs.
>  v2: Remove led0 alias and use stdout-path only
> 
>  .../devicetree/bindings/mips/brcm/soc.txt          |   2 +-
>  arch/mips/bmips/Kconfig                            |   4 +
>  arch/mips/boot/dts/brcm/Makefile                   |   2 +
>  arch/mips/boot/dts/brcm/bcm6358.dtsi               | 130 +++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm96358nb4ser.dts         |  46 ++++++++
>  5 files changed, 183 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/boot/dts/brcm/bcm6358.dtsi
>  create mode 100644 arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
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
> index 0000000..5dc8432
> --- /dev/null
> +++ b/arch/mips/boot/dts/brcm/bcm6358.dtsi
> @@ -0,0 +1,130 @@
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

I guess this is already defined for MIPS, but there is a generic timer 
freq property defined in ePAPR.

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

No underscores in node names.

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <50000000>;
> +		};
> +	};
> +
> +	aliases {
> +		uart0 = &uart0;
> +		uart1 = &uart1;

Alias names should be serialN.

> +	};
> +
> +	cpu_intc: cpu_intc {

This should also be "interrupt-controller".

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

Would be preferred to limit this to 0xfffe0000 (or appropriate range) if 
in fact all peripherals fall within this range.

> +
> +		periph_cntl: syscon@fffe0000 {
> +			compatible = "syscon";
> +			reg = <0xfffe0000 0xc>;
> +			native-endian;
> +		};
> +
> +		reboot: syscon-reboot@fffe0008 {
> +			compatible = "syscon-reboot";
> +			regmap = <&periph_cntl>;
> +			offset = <0x8>;
> +			mask = <0x1>;
> +		};
> +
> +		periph_intc: interrupt-controller@fffe000c {
> +			compatible = "brcm,bcm6345-l1-intc";
> +			reg = <0xfffe000c 0x8>,
> +			      <0xfffe0038 0x8>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			interrupt-parent = <&cpu_intc>;
> +			interrupts = <2>, <3>;
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
> +
> +		ehci0: usb@fffe1300 {

Why the numbering? Is there more than 1 EHCI?

> +			compatible = "brcm,bcm6358-ehci", "generic-ehci";

Is this documented?

> +			reg = <0xfffe1300 0x100>;
> +			big-endian;
> +			interrupt-parent = <&periph_intc>;
> +			interrupts = <10>;
> +			status = "disabled";
> +		};
> +
> +		ohci0: usb@fffe1400 {

More than 1 OHCI?

> +			compatible = "brcm,bcm6358-ohci", "generic-ohci";

Is this documented?

> +			reg = <0xfffe1400 0x100>;
> +			big-endian;
> +			no-big-frame-no;
> +			interrupt-parent = <&periph_intc>;
> +			interrupts = <5>;
> +			status = "disabled";
> +		};
> +	};
> +};
> diff --git a/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
> new file mode 100644
> index 0000000..f412117
> --- /dev/null
> +++ b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
> @@ -0,0 +1,46 @@
> +/dts-v1/;
> +
> +/include/ "bcm6358.dtsi"
> +
> +/ {
> +	compatible = "sfr,nb4-ser", "brcm,bcm6358";

Is sfr,nb4-ser documented?

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
> +	led@0 {
> +		reg = <0>;
> +		active-low;
> +		label = "nb4-ser:white:alarm";
> +	};
> +	led@2 {
> +		reg = <2>;
> +		active-low;
> +		label = "nb4-ser:white:tv";
> +	};
> +	led@3 {
> +		reg = <3>;
> +		active-low;
> +		label = "nb4-ser:white:tel";
> +	};
> +	led@4 {
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
> 2.1.4
> 
