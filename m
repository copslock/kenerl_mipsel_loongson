Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 11:43:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40639 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991058AbdHRJm71cmdG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 11:42:59 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1B8A826CEB99E;
        Fri, 18 Aug 2017 10:42:50 +0100 (IST)
Received: from [192.168.154.107] (192.168.154.107) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 18 Aug
 2017 10:42:52 +0100
Subject: Re: [PATCH] MIPS: dts: ralink: Add Mediatek MT7628A SoC
To:     Rob Herring <robh@kernel.org>
CC:     <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <ralf@linux-mips.org>, John Crispin <john@phrozen.org>,
        <linux-mips@linux-mips.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
References: <1502814530-40604-1-git-send-email-harvey.hunt@imgtec.com>
 <20170817213426.34shgxwnjowcg4sk@rob-hp-laptop>
From:   Harvey Hunt <Harvey.Hunt@imgtec.com>
Message-ID: <97c83648-3710-cb9a-a065-9fbe8dd1b734@imgtec.com>
Date:   Fri, 18 Aug 2017 10:42:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170817213426.34shgxwnjowcg4sk@rob-hp-laptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.107]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Harvey.Hunt@imgtec.com
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

Thanks for the review.

On 17/08/17 22:34, Rob Herring wrote:
> On Tue, Aug 15, 2017 at 05:28:50PM +0100, Harvey Hunt wrote:
>> The MT7628A is the successor to the MT7620 and pin compatible with the
>> MT7688A, although the latter supports only a 1T1R antenna rather than
>> a 2T2R antenna.
>>
>> This commit adds support for the following features:
>>
>> - UART
>> - USB PHY
>> - EHCI
>> - Interrupt controller
>> - System controller
>> - Memory controller
>> - Reset controller
>>
>> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
>> Cc: John Crispin <john@phrozen.org>
>> Cc: linux-mips@linux-mips.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mediatek@lists.infradead.org
>> ---
>>   Documentation/devicetree/bindings/mips/ralink.txt |   1 +
>>   arch/mips/boot/dts/ralink/mt7628a.dtsi            | 125 ++++++++++++++++++++++
>>   2 files changed, 126 insertions(+)
>>   create mode 100644 arch/mips/boot/dts/ralink/mt7628a.dtsi
>>
>> diff --git a/Documentation/devicetree/bindings/mips/ralink.txt b/Documentation/devicetree/bindings/mips/ralink.txt
>> index b35a8d0..a16e8d7 100644
>> --- a/Documentation/devicetree/bindings/mips/ralink.txt
>> +++ b/Documentation/devicetree/bindings/mips/ralink.txt
>> @@ -15,3 +15,4 @@ value must be one of the following values:
>>     ralink,rt5350-soc
>>     ralink,mt7620a-soc
>>     ralink,mt7620n-soc
>> +  ralink,mt7628a-soc
>> diff --git a/arch/mips/boot/dts/ralink/mt7628a.dtsi b/arch/mips/boot/dts/ralink/mt7628a.dtsi
>> new file mode 100644
>> index 0000000..8461fe9
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/ralink/mt7628a.dtsi
>> @@ -0,0 +1,125 @@
>> +/ {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	compatible = "ralink,mt7628a-soc";
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu@0 {
>> +			compatible = "mti,mips24KEc";
>> +			device_type = "cpu";
>> +			reg = <0>;
>> +		};
>> +	};
>> +
>> +	resetctrl: resetctrl {
> 
> reset-controller {

Done

> 
>> +		compatible = "ralink,rt2880-reset";
>> +		#reset-cells = <1>;
>> +	};
>> +
>> +	cpuintc: cpuintc {
> 
> interrupt-controller {

Done

> 
>> +		#address-cells = <0>;
>> +		#interrupt-cells = <1>;
>> +		interrupt-controller;
>> +		compatible = "mti,cpu-interrupt-controller";
>> +	};
>> +
>> +	palmbus@10000000 {
>> +		compatible = "palmbus";
>> +		reg = <0x10000000 0x200000>;
>> +		ranges = <0x0 0x10000000 0x1FFFFF>;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		sysc@0 {
> 
> system-controller@0

Done

> 
>> +			compatible = "ralink,mt7620a-sysc";
>> +			reg = <0x0 0x100>;
>> +		};
>> +
>> +		intc: intc@200 {
> 
> interrupt-controller@200

Done

> 
>> +			compatible = "ralink,rt2880-intc";
>> +			reg = <0x200 0x100>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <1>;
>> +
>> +			resets = <&resetctrl 9>;
>> +			reset-names = "intc";
>> +
>> +			interrupt-parent = <&cpuintc>;
>> +			interrupts = <2>;
>> +
>> +			ralink,intc-registers = <0x9c 0xa0
>> +						 0x6c 0xa4
>> +						 0x80 0x78>;
>> +		};
>> +
>> +		memc@300 {
> 
> memory-controller@300

Done

> 
>> +			compatible = "ralink,mt7620a-memc";
>> +			reg = <0x300 0x100>;
>> +		};
>> +
>> +		uartlite@c00 {
> 
> serial@c00
> 
> And so on. IOW, use standard, generic node names as defined in the DT
> spec.


The clocks for the UARTs are using the device names "uartlite", "uart1" 
and "uart2" (as defined in arch/mips/ralink/mt7620.c).

Changing the name of the DT nodes causes the serial driver to bail as it 
can't find the clock for the device.

arch/mips/boot/dts/ralink/mt7620a.dtsi is already using the uartlite 
name, although it hasn't been documented...

Thanks,

Harvey

> 
>> +			compatible = "ns16550a";
>> +			reg = <0xc00 0x100>;
>> +
>> +			resets = <&resetctrl 12>;
>> +			reset-names = "uart0";
>> +
>> +			interrupt-parent = <&intc>;
>> +			interrupts = <20>;
>> +
>> +			reg-shift = <2>;
>> +		};
>> +
>> +		uart1@d00 {
>> +			compatible = "ns16550a";
>> +			reg = <0xd00 0x100>;
>> +
>> +			resets = <&resetctrl 19>;
>> +			reset-names = "uart1";
>> +
>> +			interrupt-parent = <&intc>;
>> +			interrupts = <21>;
>> +
>> +			reg-shift = <2>;
>> +		};
>> +
>> +		uart2@e00 {
>> +			compatible = "ns16550a";
>> +			reg = <0xe00 0x100>;
>> +
>> +			resets = <&resetctrl 20>;
>> +			reset-names = "uart2";
>> +
>> +			interrupt-parent = <&intc>;
>> +			interrupts = <22>;
>> +
>> +			reg-shift = <2>;
>> +		};
>> +	};
>> +
>> +	usbphy: uphy@10120000 {
>> +		compatible = "mediatek,mt7628-usbphy";
>> +		reg = <0x10120000 0x1000>;
>> +
>> +		#phy-cells = <0>;
>> +
>> +		resets = <&resetctrl 22 &resetctrl 25>;
>> +		reset-names = "host", "device";
>> +	};
>> +
>> +	ehci@101c0000 {
>> +		compatible = "generic-ehci";
>> +		reg = <0x101c0000 0x1000>;
>> +
>> +		phys = <&usbphy>;
>> +		phy-names = "usb";
>> +
>> +		interrupt-parent = <&intc>;
>> +		interrupts = <18>;
>> +	};
>> +};
>> -- 
>> 2.7.4
>>
