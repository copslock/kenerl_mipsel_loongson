Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jun 2015 17:04:54 +0200 (CEST)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36531 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008806AbbFVPEx1K08K convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Jun 2015 17:04:53 +0200
Received: by lbbpo10 with SMTP id po10so10974256lbb.3;
        Mon, 22 Jun 2015 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KctTFfRwq+5vKP5eovs8ZESos6XrWqWpbII6LCxhJo0=;
        b=mBJVlr03ZscsG4wtUx4JAYY47WA3VUv5yFTH1GTeLMcOxwgYaiSe8jNo0iB2qzbF19
         NlkaAC95utkSw3603Ne2yPTLDhi5UPqJ8TSHyTvrZy3io9cBDYZ0/hqxlf5WZKcblGKs
         8SD4dGe5QuES8Sj+PvwSfud6fB0ICCnkaX+IpDS7C9DRcxT9lgI203yPjRw/sxR21+6O
         2GtHTo2XwjKlQ7ibxqrAvFp52LcTQ2MN9bY2RsNpLZ+oDQiDeqQdG7Ldh3L4lNgnZnS6
         xQBeEn76aKY1a0yjDUoKleiJOTl4gaTcg4P8PnWrwEKxsAlltXNLMdZy34NtcQCNC3Xr
         YfVg==
X-Received: by 10.112.222.133 with SMTP id qm5mr30656541lbc.86.1434985487992;
        Mon, 22 Jun 2015 08:04:47 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by mx.google.com with ESMTPSA id o5sm4713163lag.9.2015.06.22.08.04.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2015 08:04:47 -0700 (PDT)
Date:   Mon, 22 Jun 2015 18:11:12 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/12] MIPS: Add basic support for the TL-WR1043ND
 version 1
Message-Id: <20150622181112.ab7a4c6764b0aa2236e43ab4@gmail.com>
In-Reply-To: <1433031506-7984-5-git-send-email-albeu@free.fr>
References: <1433029955-7346-1-git-send-email-albeu@free.fr>
        <1433031506-7984-5-git-send-email-albeu@free.fr>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Sun, 31 May 2015 02:18:26 +0200
Alban Bedel <albeu@free.fr> wrote:

> Add a DTS for TL-WR1043ND version 1 and allow to have it built in the
> kernel to circumvent the broken u-boot found on these boards.
> Currently only the UART, LEDs and buttons are supported.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
> v2: * Rebased for the new vendor directory structure
>     * Merged the 2 separate patch for SoC dtsi and board DTS in a
>       single one
>     * Fixed the node names to use ePAPR standardized names
> v3: * Moved adding the Kconfig Builtin devicetree menu to this patch
>     * Set the Kconfig builtin DTB menu as optional, removed config
>       DTB_ATH79_NONE and slightly improved the menu name and help
>       message.
> v4: * Always build the DTB to improve testing coverage
>     * Added the SPI controller as the binding has been accepted in
>       the SPI tree.
> ---
>  arch/mips/ath79/Kconfig                          |  12 ++
>  arch/mips/boot/dts/Makefile                      |   1 +
>  arch/mips/boot/dts/qca/Makefile                  |  11 ++
>  arch/mips/boot/dts/qca/ar9132.dtsi               | 133 +++++++++++++++++++++++
>  arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 112 +++++++++++++++++++
>  5 files changed, 269 insertions(+)
>  create mode 100644 arch/mips/boot/dts/qca/Makefile
>  create mode 100644 arch/mips/boot/dts/qca/ar9132.dtsi
>  create mode 100644 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> 
> diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
> index dfc6020..13c04cf 100644
> --- a/arch/mips/ath79/Kconfig
> +++ b/arch/mips/ath79/Kconfig
> @@ -71,6 +71,18 @@ config ATH79_MACH_UBNT_XM
>  	  Say 'Y' here if you want your kernel to support the
>  	  Ubiquiti Networks XM (rev 1.0) board.
>  
> +choice
> +	prompt "Build a DTB in the kernel"
> +	optional
> +	help
> +	  Select a devicetree that should be built into the kernel.
> +
> +	config DTB_TL_WR1043ND_V1
> +		bool "TL-WR1043ND Version 1"
> +		select BUILTIN_DTB
> +		select SOC_AR913X
> +endchoice
> +
>  endmenu
>  
>  config SOC_AR71XX
> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index 5d95e4b..9975485 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -3,6 +3,7 @@ dts-dirs	+= cavium-octeon
>  dts-dirs	+= lantiq
>  dts-dirs	+= mti
>  dts-dirs	+= netlogic
> +dts-dirs	+= qca
>  dts-dirs	+= ralink
>  
>  obj-y		:= $(addsuffix /, $(dts-dirs))
> diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
> new file mode 100644
> index 0000000..2d61455d
> --- /dev/null
> +++ b/arch/mips/boot/dts/qca/Makefile
> @@ -0,0 +1,11 @@
> +# All DTBs
> +dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
> +
> +# Select a DTB to build in the kernel
> +obj-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb.o
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-				+= dummy.o
> +
> +always				:= $(dtb-y)
> +clean-files			:= *.dtb *.dtb.S
> diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
> new file mode 100644
> index 0000000..4759cff
> --- /dev/null
> +++ b/arch/mips/boot/dts/qca/ar9132.dtsi
> @@ -0,0 +1,133 @@
> +/ {
> +	compatible = "qca,ar9132";
> +
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "mips,mips24Kc";
> +			reg = <0>;
> +		};
> +	};
> +
> +	cpuintc: interrupt-controller {
> +		compatible = "qca,ar9132-cpu-intc", "qca,ar7100-cpu-intc";
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		qca,ddr-wb-channel-interrupts = <2>, <3>, <4>, <5>;
> +		qca,ddr-wb-channels = <&ddr_ctrl 3>, <&ddr_ctrl 2>,
> +					<&ddr_ctrl 0>, <&ddr_ctrl 1>;
> +	};
> +
> +	ahb {
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		interrupt-parent = <&cpuintc>;
> +
> +		apb {
> +			compatible = "simple-bus";
> +			ranges;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			interrupt-parent = <&miscintc>;
> +
> +			ddr_ctrl: memory-controller@18000000 {
> +				compatible = "qca,ar9132-ddr-controller",
> +						"qca,ar7240-ddr-controller";
> +				reg = <0x18000000 0x100>;
> +
> +				#qca,ddr-wb-channel-cells = <1>;
> +			};
> +
> +			uart@18020000 {
> +				compatible = "ns8250";
> +				reg = <0x18020000 0x20>;
> +				interrupts = <3>;
> +
> +				clocks = <&pll 2>;
> +				clock-names = "uart";
> +
> +				reg-io-width = <4>;
> +				reg-shift = <2>;
> +				no-loopback-test;
> +
> +				status = "disabled";
> +			};
> +
> +			gpio: gpio@18040000 {
> +				compatible = "qca,ar9132-gpio",
> +						"qca,ar7100-gpio";
> +				reg = <0x18040000 0x30>;
> +				interrupts = <2>;
> +
> +				ngpios = <22>;
> +
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			pll: pll-controller@18050000 {
> +				compatible = "qca,ar9132-ppl",
> +						"qca,ar9130-pll";
> +				reg = <0x18050000 0x20>;
> +
> +				clock-names = "ref";
> +				/* The board must provides the ref clock */
> +
> +				#clock-cells = <1>;
> +				clock-output-names = "cpu", "ddr", "ahb";
> +			};
> +
> +			wdt@18060008 {
> +				compatible = "qca,ar7130-wdt";
> +				reg = <0x18060008 0x8>;
> +
> +				interrupts = <4>;
> +
> +				clocks = <&pll 2>;
> +				clock-names = "wdt";
> +			};
> +
> +			miscintc: interrupt-controller@18060010 {
> +				compatible = "qca,ar9132-misc-intc",
> +					   "qca,ar7100-misc-intc";
> +				reg = <0x18060010 0x4>;
> +
> +				interrupt-parent = <&cpuintc>;
> +				interrupts = <6>;
> +
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		spi@1f000000 {

Could we add an alias here? E.g.

		spi: spi@1f000000 {

So we can use the alias in the board dts file with zero indent. E.g 

&spi {
	status = "okay";
	num-cs = <1>;

	flash@0 {
...


Just the same change can be used with uart@18020000.

> diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> new file mode 100644
> index 0000000..003015a
> --- /dev/null
> +++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> @@ -0,0 +1,112 @@
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +#include "ar9132.dtsi"
> +
> +/ {
> +	compatible = "tplink,tl-wr1043nd-v1", "qca,ar9132";
> +	model = "TP-Link TL-WR1043ND Version 1";
> +
> +	alias {
> +		serial0 = "/ahb/apb/uart@18020000";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x2000000>;
> +	};
> +
> +	extosc: oscillator {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <40000000>;
> +	};
> +
> +	ahb {
> +		apb {
> +			uart@18020000 {
> +				status = "okay";
> +			};
> +
> +			pll-controller@18050000 {
> +				clocks = <&extosc>;
> +			};
> +		};
> +
> +		spi@1f000000 {
> +			status = "okay";
> +			num-cs = <1>;
> +
> +			flash@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "s25sl064a";
> +				reg = <0>;
> +				spi-max-frequency = <25000000>;
> +
> +				partition@0 {
> +					label = "u-boot";
> +					reg = <0x000000 0x020000>;
> +				};
> +
> +				partition@1 {
> +					label = "firmware";
> +					reg = <0x020000 0x7D0000>;
> +				};
> +
> +				partition@2 {
> +					label = "art";
> +					reg = <0x7F0000 0x010000>;
> +					read-only;
> +				};
> +			};
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys-polled";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		poll-interval = <20>;
> +		button@0 {
> +			label = "reset";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <60>;
> +		};
> +
> +		button@1 {
> +			label = "qss";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&gpio 7 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <60>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led@0 {
> +			label = "tp-link:green:usb";
> +			gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led@1 {
> +			label = "tp-link:green:system";
> +			gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led@2 {
> +			label = "tp-link:green:qss";
> +			gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led@3 {
> +			label = "tp-link:green:wlan";
> +			gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> -- 
> 2.0.0
> 
> 


-- 
-- 
Best regards,
  Antony Pavlov
