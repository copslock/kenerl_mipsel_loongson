Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Dec 2015 12:50:58 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:35279 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008205AbbLSLuyphGne (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Dec 2015 12:50:54 +0100
Received: from [10.41.20.11] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Sat, 19 Dec 2015
 04:50:45 -0700
Subject: Re: [PATCH v2 03/14] DEVICETREE: Add PIC32 clock binding
 documentation
To:     Rob Herring <robh@kernel.org>
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
 <1450133093-7053-4-git-send-email-joshua.henderson@microchip.com>
 <20151218154444.GA27288@rob-hp-laptop>
CC:     Joshua Henderson <joshua.henderson@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
Message-ID: <56754427.8050704@microchip.com>
Date:   Sat, 19 Dec 2015 17:18:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151218154444.GA27288@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
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

On 12/18/2015 09:14 PM, Rob Herring wrote:
> On Mon, Dec 14, 2015 at 03:42:05PM -0700, Joshua Henderson wrote:
>> From: Purna Chandra Mandal <purna.mandal@microchip.com>
>>
>> Document the devicetree bindings for the clock driver found on Microchip
>> PIC32 class devices.
>>
>> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
> A couple of nits on the example, otherwise:
>
> Acked-by: Rob Herring <robh@kernel.org>
>
>> ---
>>  .../devicetree/bindings/clock/microchip,pic32.txt  |  256 ++++++++++++++++++++
>>  1 file changed, 256 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/microchip,pic32.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/microchip,pic32.txt b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
>> new file mode 100644
>> index 0000000..f50c653
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
>> @@ -0,0 +1,256 @@
>> +Binding for a Clock hardware block found on
>> +certain Microchip PIC32 MCU devices.
>> +
>> +Microchip SoC clocks-node consists of few oscillators, PLL, multiplexer
>> +and few divider nodes.
>> +
>> +We will find only the base address of the clock tree, this base
>> +address is common for some of the subnodes, not all. If no address is
>> +specified for any of subnode base address of the clock tree will be
>> +treated as its base. Each of subnodes follow the same common clock
>> +binding with some additional optional properties.
>> +
>> +	clocks_node {
>> +		reg = <>;
>> +
>> +		spll_node {
>> +			...
>> +		};
>> +
>> +		frcdiv_node {
>> +			...
>> +		};
>> +
>> +		sysclk_mux_node {
>> +			...
>> +		};
>> +
>> +		pbdiv_node {
>> +			...
>> +		};
>> +
>> +		refoclk_node {
>> +			...
>> +		};
>> +		...
>> +	};
>> +
>> +This binding uses the common clock binding[1].
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Required properties:
>> +- compatible : should be one of "microchip,pic32mzda-clk",
>> +    "microchip,pic32mzda-sosc", "microchip,pic32mzda-frcdivclk",
>> +    "microchip,pic32mzda-syspll", "microchip,pic32mzda-sysclk-v2",
>> +    "microchip,pic32mzda-pbclk", "microchip,pic32mzda-refoclk".
>> +- reg : A Base address and length of the register set.
>> +- interrupts : source of interrupt.
>> +
>> +Optional properties (for subnodes):
>> +- #clock-cells: From common clock binding, should be 0.
>> +- microchip,clock-indices: in multiplexer node clock sources always aren't linear
>> +    and contiguous. This property helps define clock-sources with respect to
>> +    the mux clock node.
>> +- microchip,ignore-unused : ignore gate request even if the gated clock is unused.
>> +- microchip,status-bit-mask: bitmask for status check. This will be used to confirm
>> +    particular operation by clock sub-node is completed. It is dependent sub-node.
>> +- microchip,bit-mask: enable mask, similar to microchip,status-bit-mask.
>> +- microchip,slew-step: enable frequency slewing(stepping) during rate change;
>> +    applicable only to sys-clock subnode.
>> +
>> +Example:
>> +
>> +/* PIC32 specific clks */
>> +pic32_clktree {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	reg = <0x1f801200 0x200>;
>> +	compatible = "microchip,pic32mzda-clk";
>> +	ranges = <0 0x1f801200 0x200>;
>> +
>> +	/* secondary oscillator; external input on SOSCI pin */
>> +	SOSC:sosc_clk {
> For the ones with reg property, do clock@0 instead of sosc_clk.

ack. Will update.

>> +		#clock-cells = <0>;
>> +		compatible = "microchip,pic32mzda-sosc";
>> +		clock-frequency = <32768>;
>> +		reg = <0x000 0x10>, /* enable reg */
>> +		      <0x1d0 0x10>; /* status reg */
>> +		microchip,bit-mask = <0x02>; /* enable mask */
>> +		microchip,status-bit-mask = <0x10>; /* status-mask*/
>> +	};
>> +
>> +	FRCDIV:frcdiv_clk {
>> +		#clock-cells = <0>;
>> +		compatible = "microchip,pic32mzda-frcdivclk";
>> +		clocks = <&FRC>;
>> +		clock-output-names = "frcdiv_clk";
>> +	};
>> +
>> +	/* System PLL clock */
>> +	SYSPLL:spll_clk {
>> +		#clock-cells = <0>;
>> +		compatible = "microchip,pic32mzda-syspll";
>> +		reg = <0x020 0x10>, /* SPLL register */
>> +		      <0x1d0 0x10>; /* CLKSTAT register */
>> +		clocks = <&POSC>, <&FRC>;
>> +		clock-output-names = "sys_pll";
>> +		microchip,status-bit-mask = <0x80>; /* SPLLRDY */
>> +	};
>> +
>> +	/* system clock; mux with postdiv & slew */
>> +	SYSCLK:sys_clk {
>> +		#clock-cells = <0>;
>> +		compatible = "microchip,pic32mzda-sysclk-v2";
>> +		reg = <0x1c0 0x04>; /* SLEWCON */
>> +		clocks = <&FRCDIV>, <&SYSPLL>, <&POSC>, <&SOSC>,
>> +				<&LPRC>, <&FRCDIV>;
>> +		microchip,clock-indices = <0>, <1>, <2>, <4>, <5>, <7>;
>> +		clock-output-names = "sys_clk";
>> +	};
>> +
>> +	/* UPLL is integral part of USB PHY; UTMI clk for USBCORE */
>> +	UPLL:usb_phy_clk {
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clocks";
>> +		clock-frequency = <24000000>;
>> +		clock-output-names = "usbphy_clk";
>> +	};
>> +
>> +	/* Peripheral bus1 clock */
>> +	PBCLK1:pb1_clk {
>> +		reg = <0x140 0x10>;
>> +		#clock-cells = <0>;
>> +		compatible = "microchip,pic32mzda-pbclk";
>> +		clocks = <&SYSCLK>;
>> +		clock-output-names = "pb1_clk";
>> +		/* used by system modules, not gateable */
>> +		microchip,ignore-unused;
>> +	};
>> +
>> +	/* Peripheral bus2 clock */
>> +	PBCLK2:pb2_clk {
>> +		reg = <0x150 0x10>;
>> +		#clock-cells = <0>;
>> +		compatible = "microchip,pic32mzda-pbclk";
>> +		clocks = <&SYSCLK>;
>> +		clock-output-names = "pb2_clk";
>> +		/* avoid gating even if unused */
>> +		microchip,ignore-unused;
>> +	};
>> +
>> +	/* Peripheral bus3 clock */
>> +	PBCLK3:pb3_clk {
>> +		reg = <0x160 0x10>;
>> +		#clock-cells = <0>;
>> +		compatible = "microchip,pic32mzda-pbclk";
>> +		clocks = <&SYSCLK>;
>> +		clock-output-names = "pb3_clk";
>> +	};
>> +
>> +	/* Peripheral bus4 clock(I/O ports, GPIO) */
>> +	PBCLK4:pb4_clk {
>> +		reg = <0x170 0x10>;
>> +		#clock-cells = <0>;
>> +		compatible = "microchip,pic32mzda-pbclk";
>> +		clocks = <&SYSCLK>;
>> +		clock-output-names = "pb4_clk";
>> +	};
>> +
>> +	/* Peripheral bus clock */
>> +	PBCLK5:pb5_clk {
>> +		reg = <0x180 0x10>;
>> +		#clock-cells = <0>;
>> +		compatible = "microchip,pic32mzda-pbclk";
>> +		clocks = <&SYSCLK>;
>> +		clock-output-names = "pb5_clk";
>> +	};
>> +
>> +	/* Peripheral Bus6 clock; */
>> +	PBCLK6:pb6_clk {
>> +		reg = <0x190 0x10>;
>> +		compatible = "microchip,pic32mzda-pbclk";
>> +		clocks = <&SYSCLK>;
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	/* Peripheral bus7 clock */
>> +	PBCLK7:pb7_clk {
>> +		reg = <0x1A0 0x10>;
> lower case

ack.

>> +		#clock-cells = <0>;
>> +		compatible = "microchip,pic32mzda-pbclk";
>> +		/* CPU is driven by this clock; so named */
>> +		clock-output-names = "cpu_clk";
>> +		clocks = <&SYSCLK>;
>> +	};
>> +
>> +	/* Reference Oscillator clock for SPI/I2S */
>> +	REFCLKO1:refo1_clk {
>> +		reg = <0x080 0x20>;
>> +		#clock-cells = <0>;
>> +		compatible = "microchip,pic32mzda-refoclk";
>> +		clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
>> +			<&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
>> +		microchip,clock-indices = <0>, <1>, <2>, <3>, <4>, <5>,
>> +						<7>, <8>, <9>;
>> +		clock-output-names = "refo1_clk";
>> +	};
>> +
>> +	/* Reference Oscillator clock for SQI */
>> +	REFCLKO2:refo2_clk {
>> +		reg = <0x0A0 0x20>;
> lower case

ack.

>> +		#clock-cells = <0>;
>> +		compatible = "microchip,pic32mzda-refoclk";
>> +		clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
>> +			<&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
>> +		microchip,clock-indices = <0>, <1>, <2>, <3>, <4>, <5>,
>> +						<7>, <8>, <9>;
>> +		clock-output-names = "refo2_clk";
>> +	};
>> +
>> +	/* Reference Oscillator clock, ADC */
>> +	REFCLKO3:refo3_clk {
>> +		reg = <0x0C0 0x20>;
> lower case

ack.

>> +		compatible = "microchip,pic32mzda-refoclk";
>> +		clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
>> +			<&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
>> +		microchip,clock-indices = <0>, <1>, <2>, <3>, <4>, <5>,
>> +						<7>, <8>, <9>;
>> +		#clock-cells = <0>;
>> +		clock-output-names = "refo3_clk";
>> +	};
>> +
>> +	/* Reference Oscillator clock */
>> +	REFCLKO4:refo4_clk {
>> +		reg = <0x0E0 0x20>;
>> +		compatible = "microchip,pic32mzda-refoclk";
>> +		clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
>> +				<&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
>> +		microchip,clock-indices = <0>,<1>,<2>,<3>,<4>,<5>,<7>,
>> +						<8>,<9>;
>> +		#clock-cells = <0>;
>> +		clock-output-names = "refo4_clk";
>> +	};
>> +
>> +	/* Reference Oscillator clock, LCD */
>> +	REFCLKO5:refo5_clk {
>> +		reg = <0x100 0x20>;
>> +		compatible = "microchip,pic32mzda-refoclk";
>> +		clocks = <&SYSCLK>,<&PBCLK1>,<&POSC>,<&FRC>,<&LPRC>,
>> +			<&SOSC>,<&SYSPLL>,<&REFIx>,<&BFRC>;
>> +		microchip,clock-indices = <0>, <1>, <2>, <3>, <4>, <5>,
>> +					<7>, <8>,<9>;
>> +		#clock-cells = <0>;
>> +		clock-output-names = "refo5_clk";
>> +	};
>> +};
>> +
>> +The clock consumer should specify the desired clock by having the clocks in its
>> +"clock" phandle cell. For example for UART:
>> +
>> +uart2: serial@<> {
>> +	compatible = "microchip,pic32mzda-uart";
>> +	reg = <>;
>> +	interrupts = <>;
>> +	clocks = <&PBCLK2>;
>> +}
>> -- 
>> 1.7.9.5
>>
