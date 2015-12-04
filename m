Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 14:02:35 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:19173 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012517AbbLDNCcZot5v convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Dec 2015 14:02:32 +0100
Received: from CHN-SV-EXMX03.mchp-main.com ([fe80::58f5:b949:4b1:3df4]) by
 chn-sv-exch03.mchp-main.com ([fe80::9916:1afa:df82:7a64%14]) with mapi id
 14.03.0181.006; Fri, 4 Dec 2015 06:02:23 -0700
From:   <Andrei.Pistirica@microchip.com>
To:     <robh@kernel.org>, <Joshua.Henderson@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>
Subject: RE: [PATCH 07/14] DEVICETREE: Add bindings for PIC32 pin control
 and GPIO
Thread-Topic: [PATCH 07/14] DEVICETREE: Add bindings for PIC32 pin control
 and GPIO
Thread-Index: AQHRI/HYBajJGeZpTk+DwF0+j0BiGJ6pDBYAgBHRN/A=
Date:   Fri, 4 Dec 2015 13:02:22 +0000
Message-ID: <07C910AB6AC6C345A093D5A08F5AF568533C0BCC@CHN-SV-EXMX03.mchp-main.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-8-git-send-email-joshua.henderson@microchip.com>
 <20151122214700.GA26203@rob-hp-laptop>
In-Reply-To: <20151122214700.GA26203@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.76.4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Andrei.Pistirica@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Pistirica@microchip.com
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

Hi Rob,

Thank you for feedback. All the comments will be address in the next driver version.
We are currently working for a solution to use the standard bindings for pinctrl.

Regards,
Andrei

-----Original Message-----
From: Rob Herring [mailto:robh@kernel.org] 
Sent: Sunday, November 22, 2015 11:47 PM
To: Joshua Henderson - C16205
Cc: linux-kernel@vger.kernel.org; linux-mips@linux-mips.org; Andrei Pistirica - M16132; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala; devicetree@vger.kernel.org
Subject: Re: [PATCH 07/14] DEVICETREE: Add bindings for PIC32 pin control and GPIO

On Fri, Nov 20, 2015 at 05:17:19PM -0700, Joshua Henderson wrote:
> From: Andrei Pistirica <andrei.pistirica@microchip.com>
> 
> Document the devicetree bindings for PINCTRL and GPIO found on 
> Microchip
> PIC32 class devices. This also adds a header defining related port and 
> peripheral pin select functionality.
> 
> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> ---
>  .../bindings/gpio/microchip,pic32-gpio.txt         |   33 ++
>  .../bindings/pinctrl/microchip,pic32-pinctrl.txt   |  100 +++++
>  include/dt-bindings/pinctrl/pic32mzda.h            |  404 ++++++++++++++++++++
>  3 files changed, 537 insertions(+)
>  create mode 100644 
> Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
>  create mode 100644 
> Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.txt
>  create mode 100644 include/dt-bindings/pinctrl/pic32mzda.h
> 
> diff --git 
> a/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt 
> b/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
> new file mode 100644
> index 0000000..f6eeb2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
> @@ -0,0 +1,33 @@
> +* Microchip PIC32 GPIO devices (PIO).
> +
> +Required properties:
> + - compatible: "microchip,pic32-gpio"

This should have a chip specific compatible string.

> + - reg: Base address and length for the device.
> + - interrupts: The port interrupt shared be all pins.
> + - gpio-controller: Marks the port as GPIO controller.
> + - #gpio-cells: Two. The first cell is the pin number and
> +   the second cell is unused.
> + - interrupt-controller: Marks the device node as an interrupt controller.
> + - #interrupt-cells: Two. The first cell is the GPIO number and second cell
> +   is used to specify the trigger type:
> +	PIC32_PIN_CN_RISING	: low-to-high edge triggered.
> +	PIC32_PIN_CN_FALLING	: high-to-low edge triggered.
> +	PIC32_PIN_CN_BOTH	: low-to-high and high-to-low edges triggered.

Can't you use the standard flags?

> +
> +Note:
> + - If gpio-ranges is missing, then all the pins (32) related to the gpio bank
> +   are enabled.
> +
> +Example:
> +	pioA: gpio@1f860000 {
> +		compatible = "microchip,pic32-gpio";
> +		reg = <0x1f860000 0x24>;
> +		interrupts = <PORTA_INPUT_CHANGE_INTERRUPT
> +				DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		gpio-ranges = <&pic32_pinctrl 0 0 32>;
> +		clocks = <&PBCLK4>;
> +	};
> diff --git 
> a/Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.tx
> t 
> b/Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.tx
> t
> new file mode 100644
> index 0000000..7cf4167
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctr
> +++ l.txt
> @@ -0,0 +1,100 @@
> +* Microchip PIC32 Pinmux device.
> +
> +Please refer to pinctrl-bindings.txt for details of the pinctrl 
> +properties and common bindings.
> +
> +PIC32 'pin configuration node' is a node of a group of pins which can 
> +be used for a specific device or function. This node represents 
> +configuraions of single pins or a pairs of mux and related configuration.
> +
> +Required properties for pic32 device:
> + - compatible: "microchip,pic32-pinctrl", "microchip,pic32mz-pinctrl"

Is this both or either one. For both, it should be most specific first.


> + - reg: Base address and length for pps:in and pps:out registers.
> +
> +Properties for 'pin configuration node':
> + - pic32,pins: each entry consists of 3 intergers and represents the mux and
> +   config settings for one pin. The first integer represent the remappable pin,
> +   the second represent the peripheral pin and the last the configuration.
> +   The format is pic32,pins = <PIC32_RP_'dir'_'pin'
> +   PIC32_PP_'dir'_'peripherl-pin' PIC32_PIN_CONF_'config'>. The configurations
> +   are divided in 2 classes: IN and OUT and each in 4 buckets. Each entry must
> +   contains items from the same class and bucket, otherwise the driver will
> +   notify an error and the initialization will fail.
> + - pic32,single-pins: each entry consists of 3 intergers and represents a pin
> +   (that is not remappable) and related configuraion. The format is
> +   pic32,single-pins = <PORT_'x' 'pin' PIC32_PIN_CONF_'config'>. Each port has
> +   32 pins and please refer to chip documentation for details of remappable
> +   pins.
> +
> +Available pin configurations (refer to dt-bindings/pinctrl/pic32.h):
> +	PIC32_PIN_CONF_NONE	: no configuration (default).
> +	PIC32_PIN_CONF_OD	: indicate this pin need a open-drain (no direction).
> +	PIC32_PIN_CONF_OD_OUT	: indicate this pin need a open-drain out.
> +	PIC32_PIN_CONF_PU	: indicate this pin need a pull up (no direction).
> +	PIC32_PIN_CONF_PU_IN	: indicate this pin need a pull up in.
> +	PIC32_PIN_CONF_PD	: indicate this pin need a pull down (no direction).
> +	PIC32_PIN_CONF_PD_IN	: indicate this pin need a pull down input.
> +	PIC32_PIN_CONF_AN	: indicate this pin as analogic (no direction).
> +	PIC32_PIN_CONF_AN_IN	: indicate this pin as analogic input.
> +	PIC32_PIN_CONF_DG	: indicate this pin as digital (no direction).
> +	PIC32_PIN_CONF_DG_IN	: indicate this pin as digital input.
> +	PIC32_PIN_CONF_DG_OUT	: indicate this pin as digital output.
> +
> +NOTEs:
> +1. The pins functions nods are defined under pic32 pinctrl node. The function's
> +   pin groups are defined under functions node.
> +2. Each pin group can have both pic32,pins and pic32,single-pins properties to
> +   specify re-mappable or non-remappable pins with related mux and configs or
> +   at least one.
> +3. Each pin configuration node can have a phandle and devices can set pins
> +   configurations by referring to the phandle of that pin configuration node.
> +4. The pinctrl bindings are listed in dt-bindings/pinctrl/pic32.h.
> +5. The gpio controller must be described in the pinctrl simple-bus.
> +
> +Example:
> +pinctrl@1f800000{
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "microchip,pic32-pinctrl", "simple-bus";
> +	ranges;
> +	reg = <0x1f801404 0x3c>, /* in  */
> +	      <0x1f801538 0x57>; /* out */
> +
> +	pioA: gpio@1f860000 {
> +		compatible = "microchip,pic32-gpio";

The gpio controller is a sub-function of the pinctrl? That doesn't really seem to be the case based on the addresses.

> +		reg = <0x1f860000 0x24>;
> +		gpio-controller;
> +	};
> +
> +	/* functions */
> +	sw1 {
> +		pinctrl_sw1: sw1-0 {
> +			pic32,single-pins = <PORT_B 12 PIC32_PIN_CONF_PULLUP>;

Why isn't this using standard pinctrl properties?

> +		};
> +	};
> +
> +	uart1 {
> +		pinctrl_uart1: uart1-0 {
> +			pic32,pins =
> +				<PIC32_RP_OUT_RPG7 PIC32_PP_OUT_U1TX PIC32_PIN_CONF_NONE
> +				 PIC32_RP_IN_RPG8 PIC32_PP_IN_U1RX PIC32_PIN_CONF_NONE>;
> +		};
> +	};
> +};
