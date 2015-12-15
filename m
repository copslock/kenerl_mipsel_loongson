Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Dec 2015 20:59:05 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:46605 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013855AbbLOT7Bz81Dw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Dec 2015 20:59:01 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 965BB203A9;
        Tue, 15 Dec 2015 19:58:58 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A4DE203B0;
        Tue, 15 Dec 2015 19:58:56 +0000 (UTC)
Date:   Tue, 15 Dec 2015 13:58:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/14] DEVICETREE: Add bindings for PIC32 pin control
 and GPIO
Message-ID: <20151215195849.GA5008@rob-hp-laptop>
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
 <1450133093-7053-8-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450133093-7053-8-git-send-email-joshua.henderson@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50631
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

On Mon, Dec 14, 2015 at 03:42:09PM -0700, Joshua Henderson wrote:
> Document the devicetree bindings for PINCTRL and GPIO found on Microchip
> PIC32 class devices.
> 
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../bindings/gpio/microchip,pic32-gpio.txt         |   49 ++++++++++++++++
>  .../bindings/pinctrl/microchip,pic32-pinctrl.txt   |   60 ++++++++++++++++++++
>  2 files changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt b/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
> new file mode 100644
> index 0000000..ef37528
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
> @@ -0,0 +1,49 @@
> +* Microchip PIC32 GPIO devices (PIO).
> +
> +Required properties:
> + - compatible: "microchip,pic32mzda-gpio"
> + - reg: Base address and length for the device.
> + - interrupts: The port interrupt shared by all pins.
> + - gpio-controller: Marks the port as GPIO controller.
> + - #gpio-cells: Two. The first cell is the pin number and
> +   the second cell is used to specify the gpio polarity as defined in
> +   defined in <dt-bindings/gpio/gpio.h>:
> +      0 = GPIO_ACTIVE_HIGH
> +      1 = GPIO_ACTIVE_LOW
> +      2 = GPIO_OPEN_DRAIN
> + - interrupt-controller: Marks the device node as an interrupt controller.
> + - #interrupt-cells: Two. The first cell is the GPIO number and second cell
> +   is used to specify the trigger type as defined in
> +   <dt-bindings/interrupt-controller/irq.h>:
> +      IRQ_TYPE_EDGE_RISING
> +      IRQ_TYPE_EDGE_FALLING
> +      IRQ_TYPE_EDGE_BOTH
> + - clocks: Clock specifier (see clock bindings for details).
> + - microchip,gpio-bank: Specifies which bank a controller owns.
> + - gpio-ranges: Interaction with the PINCTRL subsystem.
> +
> +Example:
> +
> +/* PORTA */
> +gpio0: gpio0@1f860000 {
> +	compatible = "microchip,pic32mzda-gpio";
> +	reg = <0x1f860000 0x100>;
> +	interrupts = <118 IRQ_TYPE_LEVEL_HIGH>;
> +	#gpio-cells = <2>;
> +	gpio-controller;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	clocks = <&PBCLK4>;
> +	microchip,gpio-bank = <0>;
> +	gpio-ranges = <&pic32_pinctrl 0 0 16>;
> +};
> +
> +keys {
> +	...
> +
> +	button@sw1 {
> +		label = "ESC";
> +		linux,code = <1>;
> +		gpios = <&gpio0 12 0>;
> +	};
> +};
> diff --git a/Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.txt
> new file mode 100644
> index 0000000..4b5efa5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.txt
> @@ -0,0 +1,60 @@
> +* Microchip PIC32 Pin Controller
> +
> +Please refer to pinctrl-bindings.txt, ../gpio/gpio.txt, and
> +../interrupt-controller/interrupts.txt for generic information regarding
> +pin controller, GPIO, and interrupt bindings.
> +
> +PIC32 'pin configuration node' is a node of a group of pins which can be
> +used for a specific device or function. This node represents configuraions of
> +pins, optional function, and optional mux related configuration.
> +
> +Required properties for pin controller node:
> + - compatible: "microchip,pic32mada-pinctrl"
> + - reg: Address range of the pinctrl registers.
> + - clocks: Clock specifier (see clock bindings for details)
> +
> +Required properties for pin configuration sub-nodes:
> + - pins: List of pins to which the configuration applies.
> +
> +Optional properties for pin configuration sub-nodes:
> +----------------------------------------------------
> + - function: Mux function for the specified pins.
> + - bias-pull-up: Enable weak pull-up.
> + - bias-pull-down: Enable weak pull-down.
> + - input-enable: Set the pin as an input.
> + - output-low: Set the pin as an output level low.
> + - output-high: Set the pin as an output level high.
> + - microchip,digital: Enable digital I/O.
> + - microchip,analog: Enable analog I/O.
> +
> +Example:
> +
> +pic32_pinctrl: pinctrl@1f801400{
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "microchip,pic32mzda-pinctrl";
> +	reg = <0x1f801400 0x400>;
> +	clocks = <&PBCLK1>;
> +
> +	pinctrl_uart2: pinctrl_uart2 {
> +		uart2-tx {
> +			pins = "G9";
> +			function = "U2TX";
> +			microchip,digital;
> +			output-low;
> +		};
> +		uart2-rx {
> +			pins = "B0";
> +			function = "U2RX";
> +			microchip,digital;
> +			input-enable;
> +		};
> +	};
> +};
> +
> +uart2: serial@1f822200 {
> +	compatible = "microchip,pic32mzda-uart";
> +	reg = <0x1f822200 0x50>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +};
> -- 
> 1.7.9.5
> 
