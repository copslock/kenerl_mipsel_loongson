Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 17:53:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58422 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991859AbcH3PxbMH0Gu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 17:53:31 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5EFB2191A8376;
        Tue, 30 Aug 2016 16:53:11 +0100 (IST)
Received: from [127.0.0.1] (10.100.200.118) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 16:53:14 +0100
Subject: Re: [PATCH 24/26] dt-bindings: Document img,boston-clock binding
To:     Stephen Boyd <sboyd@codeaurora.org>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
 <20160826153725.11629-25-paul.burton@imgtec.com>
 <20160826174446.GX19826@codeaurora.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-clk@vger.kernel.org>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <f0633969-1df4-64c9-a003-8745ad331bc8@imgtec.com>
Date:   Tue, 30 Aug 2016 16:53:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160826174446.GX19826@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.100.200.118]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On 26/08/16 18:44, Stephen Boyd wrote:
> On 08/26, Paul Burton wrote:
>> diff --git a/Documentation/devicetree/bindings/clock/img,boston-clock.txt b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
>> new file mode 100644
>> index 0000000..c01ea60
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
>> @@ -0,0 +1,27 @@
>> +Binding for Imagination Technologies MIPS Boston clock sources.
>> +
>> +This binding uses the common clock binding[1].
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Required properties:
>> +- compatible : Should be "img,boston-clock".
>> +- #clock-cells : Should be set to 1.
>> +  Values available for clock consumers can be found in the header file:
>> +    <dt-bindings/clock/boston-clock.h>
>> +- regmap : Phandle to the Boston platform register system controller.
>> +  This should contain a phandle to the system controller node covering the
>> +  platform registers provided by the Boston board.
>> +
>> +Example:
>> +
>> +	clk_boston: clock {
>> +		compatible = "img,boston-clock";
>> +		#clock-cells = <1>;
>> +		regmap = <&plat_regs>;
> 
> Isn't syscon more standard than regmap as the property name? Is
> there a binding for the plat_regs device? Is there any reason the
> clks can't be populated in that syscon driver?

Hi Stephen,

The plat_regs device doesn't have a custom driver, it simply makes use
of the generic "syscon" driver which can provide a regmap.

It would be possible to register the clocks from a register for the
plat_regs device, but I don't think it would make much sense. The
platform registers in question are essentially just a convenient place
where various bits of information about the system are exposed,
including the clock frequencies but also other bits & pieces like
connectivity of PCIe controllers or I/O coherence units, the RTL
revision of the CPU or the wrapper RTL that runs on this FPGA-based
board, a register that allows for resetting the board, etc. It's not a
single piece of hardware, more a dumping ground for miscellanea. So in
my opinion using the syscon approach works best here, and drivers for
well defined pieces of hardware or functionality can reference that
syscon to retrieve the regmap.

As for whether "syscon" is a more standard property name than "regmap",
both seem to be used based on a grep of
Documentation/devicetree/bindings/. I believe I picked up use of
"regmap" from the generic syscon-poweroff & syscon-reboot drivers, which
both use "regmap" as a property name.

Thanks,
    Paul

> 
>> +	};
>> +
>> +	uart0: uart@17ffe000 {
>> +		/* ... */
>> +		clocks = <&clk_boston BOSTON_CLK_SYS>;
>> +	};
> 
