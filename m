Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Oct 2016 16:22:08 +0200 (CEST)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33703 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992009AbcJJOWAoR4ID (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Oct 2016 16:22:00 +0200
Received: by mail-oi0-f66.google.com with SMTP id i127so6731471oia.0;
        Mon, 10 Oct 2016 07:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QN6m7Mp4IbD6ex+nW9D6meZshOCI9pb0yj4pzE7bVQE=;
        b=BqzXfWS5x+Z6Ffl8PDEWRduacXc1bdFB1HBspfRcGjyqUoDvkjlmejScZ2AH5n/dr+
         GyYhnWZLoAro87IcL6jbHJekQeOWNzRLDe8kfjm43q1GpTKSb5o4leOGFAY3QJs/1W2Q
         8VnApfrBuAyilw0uT8Ijqvb1iiT93GLHBp2LBgDcN1kl42ZAQksl97mjyvdqcFaFYLZo
         OKoItrOVzQoBN6g8ChahWctpis5Kaw74l9ur92KU6MioibPSO9rPJmxVounh0uvZ3/R6
         A+Vq3zsQZLtuzb4gDUsmHzvj3OgalprFILJ7Ugs0aw7x5muJUxrk9+P7ulBJfKcCwVF/
         BNKA==
X-Gm-Message-State: AA6/9RmSkZ/dBJ/i0HuszDUbnL7dcso72ofzFzUKn2yzwFC6t6htcNUN2lDevFu+LYcYFA==
X-Received: by 10.157.29.143 with SMTP id y15mr18326280otd.27.1476109314664;
        Mon, 10 Oct 2016 07:21:54 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id i57sm10955990otb.35.2016.10.10.07.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Oct 2016 07:21:54 -0700 (PDT)
Date:   Mon, 10 Oct 2016 09:21:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rahul Bedarkar <rahul.bedarkar@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Hartley <james.hartley@imgtec.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: DTS: img: add device tree for Marduk board
Message-ID: <20161010142152.GA7920@rob-hp-laptop>
References: <1475757094-31089-1-git-send-email-rahul.bedarkar@imgtec.com>
 <1475757094-31089-2-git-send-email-rahul.bedarkar@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475757094-31089-2-git-send-email-rahul.bedarkar@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55378
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

On Thu, Oct 06, 2016 at 06:01:34PM +0530, Rahul Bedarkar wrote:
> Add support for Imagination Technologies' Marduk board which is based
> on Pistachio SoC. It is also known as Creator Ci40. Marduk is legacy
> name and will be there for decades.
> 
> Documentation for this board can be found on
> https://docs.creatordev.io/ci40/
> 
> This patch adds initial support for board with following peripherals:
> 
> * PWM based heartbeat LED
> * GPIO based buttons
> * SPI NOR flash on SPI1
> * UART0 and UART1
> * SD card
> * Ethernet
> * USB
> * PWM
> * ADC
> * I2C
> 
> Signed-off-by: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
> ---
>  .../bindings/mips/img/pistachio-marduk.txt         |  10 ++
>  MAINTAINERS                                        |   6 +
>  arch/mips/boot/dts/img/Makefile                    |   9 ++
>  arch/mips/boot/dts/img/pistachio_marduk.dts        | 163 +++++++++++++++++++++
>  4 files changed, 188 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/img/pistachio-marduk.txt
>  create mode 100644 arch/mips/boot/dts/img/Makefile
>  create mode 100644 arch/mips/boot/dts/img/pistachio_marduk.dts
> 
> diff --git a/Documentation/devicetree/bindings/mips/img/pistachio-marduk.txt b/Documentation/devicetree/bindings/mips/img/pistachio-marduk.txt
> new file mode 100644
> index 0000000..2d5126d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/img/pistachio-marduk.txt
> @@ -0,0 +1,10 @@
> +Imagination Technologies' Pistachio SoC based Marduk Board
> +==========================================================
> +
> +Compatible string must be "img,pistachio-marduk", "img,pistachio"
> +
> +Hardware and other related documentation is available at
> +https://docs.creatordev.io/ci40/
> +
> +It is also known as Creator Ci40. Marduk is legacy name and will
> +be there for decades.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 98bcf06..8e6c962b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7515,6 +7515,12 @@ W:	http://www.kernel.org/doc/man-pages
>  L:	linux-man@vger.kernel.org
>  S:	Maintained
>  
> +MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
> +M:	Rahul Bedarkar <rahul.bedarkar@imgtec.com>
> +L:	linux-mips@linux-mips.org
> +S:	Maintained
> +F:	arch/mips/boot/dts/img/pistachio_marduk.dts
> +
>  MARVELL 88E6XXX ETHERNET SWITCH FABRIC DRIVER
>  M:	Andrew Lunn <andrew@lunn.ch>
>  M:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> diff --git a/arch/mips/boot/dts/img/Makefile b/arch/mips/boot/dts/img/Makefile
> new file mode 100644
> index 0000000..69a65f0
> --- /dev/null
> +++ b/arch/mips/boot/dts/img/Makefile
> @@ -0,0 +1,9 @@
> +dtb-$(CONFIG_MACH_PISTACHIO)	+= pistachio_marduk.dtb
> +
> +obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-				+= dummy.o
> +
> +always				:= $(dtb-y)
> +clean-files			:= *.dtb *.dtb.S
> diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts b/arch/mips/boot/dts/img/pistachio_marduk.dts
> new file mode 100644
> index 0000000..378381e
> --- /dev/null
> +++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
> @@ -0,0 +1,163 @@
> +/*
> + * Copyright (C) 2015, 2016 Imagination Technologies Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * IMG Marduk board is also known as Creator Ci40.
> + */
> +
> +/dts-v1/;
> +
> +#include "pistachio.dtsi"
> +
> +/ {
> +	model = "IMG Marduk (Creator Ci40)";
> +	compatible = "img,pistachio-marduk", "img,pistachio";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		ethernet0 = &enet;
> +		spi0 = &spfi0;
> +		spi1 = &spfi1;
> +	};
> +
> +	chosen {
> +		bootargs = "root=/dev/sda1 rootwait ro lpj=723968";
> +		stdout-path = "serial1:115200";
> +	};
> +
> +	memory {

Is 0 the actual base, or that gets filled in by bootloader? If the 
formet, add unit address.

> +		device_type = "memory";
> +		reg =  <0x00000000 0x08000000>;
> +	};
> +
> +	reg_1v8: fixed-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "aux_adc_vref";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +	};
> +
> +	internal_dac_supply: internal_dac_supply {

Don't use '_' in node names.

> +		compatible = "regulator-fixed";
> +		regulator-name = "internal_dac_supply";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	pwm_leds {

Just 'leds'.

> +		compatible = "pwm-leds";
> +		heartbeat {
> +			label = "marduk:red:heartbeat";
> +			pwms = <&pwm 3 300000>;
> +			max-brightness = <255>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	gpio_keys {

keys {

> +		compatible = "gpio-keys";
> +		button@1 {
> +			label = "Button 1";
> +			linux,code = <0x101>; /* BTN_1 */
> +			gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
> +		};
> +		button@2 {
> +			label = "Button 2";
> +			linux,code = <0x102>; /* BTN_2 */
> +			gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&internal_dac {
> +	VDD-supply = <&internal_dac_supply>;
> +};
> +
> +&spfi1 {
> +	status = "okay";
> +
> +	pinctrl-0 = <&spim1_pins>, <&spim1_quad_pins>, <&spim1_cs0_pin>,
> +		    <&spim1_cs1_pin>;
> +	pinctrl-names = "default";
> +	cs-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>, <&gpio0 1 GPIO_ACTIVE_HIGH>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";

This should have the specific part too.

> +		reg = <0>;
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +	assigned-clock-rates = <114278400>, <1843200>;
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&usb {
> +	status = "okay";
> +};
> +
> +&enet {
> +	status = "okay";
> +};
> +
> +&pin_enet {
> +	drive-strength = <2>;
> +};
> +
> +&pin_enet_phy_clk {
> +	drive-strength = <2>;
> +};
> +
> +&sdhost {
> +	status = "okay";
> +	bus-width = <4>;
> +	disable-wp;
> +};
> +
> +&pin_sdhost_cmd {
> +	drive-strength = <2>;
> +};
> +
> +&pin_sdhost_data {
> +	drive-strength = <2>;
> +};
> +
> +&pwm {
> +	status = "okay";
> +
> +	pinctrl-0 = <&pwmpdm0_pin>, <&pwmpdm1_pin>, <&pwmpdm2_pin>,
> +		    <&pwmpdm3_pin>;
> +	pinctrl-names = "default";
> +};
> +
> +&adc {
> +	status = "okay";
> +	vref-supply = <&reg_1v8>;
> +	adc-reserved-channels = <0x10>;
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	tpm@20 {
> +		compatible = "infineon,slb9645tt";
> +		reg = <0x20>;
> +	};
> +
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +};
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
