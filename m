Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 00:02:07 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:42068 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993047AbeG3WCEFsHin convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jul 2018 00:02:04 +0200
Date:   Tue, 31 Jul 2018 00:01:01 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Message-Id: <1532988062.4702.2@smtp.crapouillou.net>
In-Reply-To: <20180725152105.GA6347@rob-hp-laptop>
References: <20180724231958.20659-1-paul@crapouillou.net>
        <20180724231958.20659-5-paul@crapouillou.net>
        <20180725152105.GA6347@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532988122; bh=uyOBqCzxDV0asKeRIufrDW3zREtdLhGsMYq2FKqiMPs=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=x90sFewPGlIVhTUgIkSeqK1P9k/Mlph8bBgG9P5tnqR5AyBdNzVsI/x65pNeNAM+CvQPnuorI8llfx30M9Tc094mL5t2Bho6tiS/oF3AN1puOSx4bTqXbc/qAD/pHDfEFS31+Ye11moFxrDxd9xdsU8lS3mSC0NgZb3gDU7rILs=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Le mer. 25 juil. 2018 à 17:21, Rob Herring <robh@kernel.org> a écrit :
> On Wed, Jul 25, 2018 at 01:19:41AM +0200, Paul Cercueil wrote:
>>  Add documentation about how to properly use the Ingenic TCU
>>  (Timer/Counter Unit) drivers from devicetree.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  24 +---
>>   .../devicetree/bindings/timer/ingenic,tcu.txt      | 147 
>> +++++++++++++++++++++
>>   .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 +--
>>   3 files changed, 151 insertions(+), 37 deletions(-)
>>   create mode 100644 
>> Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>> 
>>   v4: New patch in this series. Corresponds to V2 patches 3-4-5 with
>>       added content.
>> 
>>   v5: - Edited PWM/watchdog DT bindings documentation to point to 
>> the new
>>         document.
>>       - Moved main document to
>>         Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>       - Updated documentation to reflect the new devicetree bindings.
>> 
>>  diff --git 
>> a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt 
>> b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>>  index 7d9d3f90641b..a722cdde3aa7 100644
>>  --- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>>  +++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>>  @@ -1,25 +1,5 @@
>>   Ingenic JZ47xx PWM Controller
>>   =============================
>> 
>>  -Required properties:
>>  -- compatible: One of:
>>  -  * "ingenic,jz4740-pwm"
>>  -  * "ingenic,jz4770-pwm"
>>  -  * "ingenic,jz4780-pwm"
>>  -- #pwm-cells: Should be 3. See pwm.txt in this directory for a 
>> description
>>  -  of the cells format.
>>  -- clocks : phandle to the external clock.
>>  -- clock-names : Should be "ext".
>>  -
>>  -
>>  -Example:
>>  -
>>  -	pwm: pwm@10002000 {
>>  -		compatible = "ingenic,jz4740-pwm";
>>  -		reg = <0x10002000 0x1000>;
>>  -
>>  -		#pwm-cells = <3>;
>>  -
>>  -		clocks = <&ext>;
>>  -		clock-names = "ext";
>>  -	};
>>  +This documentation has moved; for a description of the devicetree 
>> bindings of
>>  +this driver, please refer to ../timer/ingenic,tcu.txt.
> 
> This should be evident from the git log. Just remove it.

Ok.

>>  diff --git 
>> a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt 
>> b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>  new file mode 100644
>>  index 000000000000..65d125b460aa
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>  @@ -0,0 +1,147 @@
>>  +Ingenic JZ47xx SoCs Timer/Counter Unit devicetree bindings
>>  +==========================================================
>>  +
>>  +For a description of the TCU hardware and drivers, have a look at
>>  +Documentation/mips/ingenic-tcu.txt.
>>  +
>>  +Required properties:
>>  +
>>  +- compatible: Must be one of:
>>  +  * ingenic,jz4740-tcu
>>  +  * ingenic,jz4725b-tcu
>>  +  * ingenic,jz4770-tcu
>>  +- reg: Should be the offset/length value corresponding to the TCU 
>> registers
> 
>>  +- #address-cells: Should be <1>;
>>  +- #size-cells: Should be <1>;
>>  +- ranges: Should be one range for the full TCU registers area
> 
> These can all be implied.

Ok.

>>  +- clocks: List of phandle & clock specifiers for clocks external 
>> to the TCU.
>>  +  The "pclk", "rtc", "ext" and "tcu" clocks should be provided.
>>  +- clock-names: List of name strings for the external clocks.
>>  +- #clock-cells: Should be <1>;
>>  +  Clock consumers specify this argument to identify a clock. The 
>> valid values
>>  +  may be found in <dt-bindings/clock/ingenic,tcu.h>.
>>  +- interrupt-controller : Identifies the node as an interrupt 
>> controller
>>  +- #interrupt-cells : Specifies the number of cells needed to 
>> encode an
>>  +  interrupt source. The value should be 1.
>>  +- interrupt-parent : phandle of the interrupt controller.
>>  +- interrupts : Specifies the interrupt the controller is connected 
>> to.
> 
> How many and what are they. The example shows there are 3.

They are 2 or 3, and they are all the same (three parent IRQs for one 
irqchip).
It's explained in the hardware doc, should I add it here as well?

>>  +
>>  +Optional properties:
>>  +
>>  +- ingenic,timer-channel: Specifies the TCU channel that should be 
>> used as
>>  +  system timer. If not provided, the TCU channel 0 is used for the 
>> system timer.
>>  +
>>  +- ingenic,clocksource-channel: Specifies the TCU channel that 
>> should be used
>>  +  as clocksource and sched_clock. It must be a different channel 
>> than the one
>>  +  used as system timer. If not provided, neither a clocksource nor 
>> a
>>  +  sched_clock is instantiated.
> 
> clocksource and sched_clock are Linux specific and don't belong in DT.
> You should define properties of the hardware or use existing 
> properties
> like interrupts or clocks to figure out which channel to use. For
> example, if some channels don't have an interrupt, then use them for
> clocksource and not a clockevent. Or you could have timers that run in
> low-power modes or not. If all the channels are identical, then it
> shouldn't matter which ones the OS picks.

We already talked about that. All the TCU channels can be used for PWM.
The problem is I cannot know from the driver's scope which channels will
be free and which channels will be requested for PWM. You suggested 
that I
parse the devicetree for clients, and I did that in the V3/V4 patchset. 
But
it only works for clients requesting through devicetree, not from 
platform
code or even sysfs.

One thing I can try is to dynamically change the channels the system 
timer
and clocksource are using when the current ones are requested for PWM. 
But
that sounds hardcore...

>>  +
>>  +
>>  +Children nodes
>>  +==========================================================
>>  +
>>  +
>>  +PWM node:
>>  +---------
>>  +
>>  +Required properties:
>>  +
>>  +- compatible: Must be one of:
>>  +  * ingenic,jz4740-pwm
>>  +  * ingenic,jz4725b-pwm
>>  +- #pwm-cells: Should be 3. See ../pwm/pwm.txt for a description of 
>> the cell
>>  +  format.
>>  +- clocks: List of phandle & clock specifiers for the TCU clocks.
>>  +- clock-names: List of name strings for the TCU clocks.
>>  +
>>  +
>>  +Watchdog node:
>>  +--------------
>>  +
>>  +Required properties:
>>  +
>>  +- compatible: Must be one of:
>>  +  * ingenic,jz4740-watchdog
>>  +  * ingenic,jz4780-watchdog
>>  +- clocks: phandle to the RTC clock
>>  +- clock-names: should be "rtc"
>>  +
>>  +
>>  +OST node:
>>  +---------
>>  +
>>  +Required properties:
>>  +
>>  +- compatible: Must be one of:
>>  +  * ingenic,jz4725b-ost
>>  +  * ingenic,jz4770-ost
>>  +- clocks: phandle to the OST clock
>>  +- clock-names: should be "ost"
>>  +- interrupts : Specifies the interrupt the OST is connected to.
>>  +
>>  +
>>  +Example
>>  +==========================================================
>>  +
>>  +#include <dt-bindings/clock/jz4770-cgu.h>
>>  +#include <dt-bindings/clock/ingenic,tcu.h>
>>  +
>>  +/ {
>>  +	tcu: timer@10002000 {
>>  +		compatible = "ingenic,jz4770-tcu";
>>  +		reg = <0x10002000 0x1000>;
>>  +		#address-cells = <1>;
>>  +		#size-cells = <1>;
>>  +		ranges = <0x0 0x10002000 0x1000>;
>>  +
>>  +		#clock-cells = <1>;
>>  +
>>  +		clocks = <&cgu JZ4770_CLK_RTC
>>  +			  &cgu JZ4770_CLK_EXT
>>  +			  &cgu JZ4770_CLK_PCLK
>>  +			  &cgu JZ4770_CLK_EXT>;
>>  +		clock-names = "rtc", "ext", "pclk", "tcu";
>>  +
>>  +		interrupt-controller;
>>  +		#interrupt-cells = <1>;
>>  +
>>  +		interrupt-parent = <&intc>;
>>  +		interrupts = <27 26 25>;
>>  +
>>  +		watchdog: watchdog@0 {
>>  +			compatible = "ingenic,jz4740-watchdog";
>>  +			reg = <0x0 0x10>;
>>  +
>>  +			clocks = <&tcu TCU_CLK_WDT>;
>>  +			clock-names = "wdt";
>>  +		};
>>  +
>>  +		pwm: pwm@10 {
>>  +			compatible = "ingenic,jz4740-pwm";
>>  +			reg = <0x10 0xff0>;
>>  +
>>  +			#pwm-cells = <3>;
>>  +
>>  +			clocks = <&tcu TCU_CLK_TIMER0
>>  +				  &tcu TCU_CLK_TIMER1
>>  +				  &tcu TCU_CLK_TIMER2
>>  +				  &tcu TCU_CLK_TIMER3
>>  +				  &tcu TCU_CLK_TIMER4
>>  +				  &tcu TCU_CLK_TIMER5
>>  +				  &tcu TCU_CLK_TIMER6
>>  +				  &tcu TCU_CLK_TIMER7>;
>>  +			clock-names = "timer0", "timer1", "timer2", "timer3",
>>  +				      "timer4", "timer5", "timer6", "timer7";
>>  +		};
>>  +
>>  +		ost: timer@e0 {
>>  +			compatible = "ingenic,jz4770-ost";
>>  +			reg = <0xe0 0x20>;
> 
> This is creating an overlapping region with PWM which should be 
> avoided.
> Are timers and PWM the same h/w? Then there should be one node (or 
> maybe
> you can do 1 node per channel if each channel is independent (has its
> own register range, clocks, interrupts, etc.
> 
> Or the PWM node needs to exclude this region (by having 2 reg 
> regions).

I will use two regions then.

>> 
>  +};
>> 
>  +	};
>>  +
>>  +			clocks = <&tcu TCU_CLK_OST>;
>>  +			clock-names = "ost";
>>  +
>>  +			interrupts = <15>;
>>  +		};

Thanks,
-Paul Cercueil
