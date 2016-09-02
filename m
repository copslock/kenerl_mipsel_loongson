Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 15:33:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34479 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990522AbcIBNdwBNdC4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 15:33:52 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4B08EDBF8CD5B;
        Fri,  2 Sep 2016 14:33:32 +0100 (IST)
Received: from [127.0.0.1] (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 14:33:35 +0100
Subject: Re: [PATCH 24/26] dt-bindings: Document img,boston-clock binding
To:     Rob Herring <robh@kernel.org>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
 <20160826153725.11629-25-paul.burton@imgtec.com>
 <20160826174446.GX19826@codeaurora.org>
 <f0633969-1df4-64c9-a003-8745ad331bc8@imgtec.com>
 <20160902125433.GA4066@rob-hp-laptop>
CC:     Stephen Boyd <sboyd@codeaurora.org>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-clk@vger.kernel.org>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <4646ff43-93bf-57d7-d01e-aa6132ba9fb0@imgtec.com>
Date:   Fri, 2 Sep 2016 14:33:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160902125433.GA4066@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54996
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

On 02/09/16 13:54, Rob Herring wrote:
> On Tue, Aug 30, 2016 at 04:53:01PM +0100, Paul Burton wrote:
>> On 26/08/16 18:44, Stephen Boyd wrote:
>>> On 08/26, Paul Burton wrote:
>>>> diff --git a/Documentation/devicetree/bindings/clock/img,boston-clock.txt b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
>>>> new file mode 100644
>>>> index 0000000..c01ea60
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
>>>> @@ -0,0 +1,27 @@
>>>> +Binding for Imagination Technologies MIPS Boston clock sources.
>>>> +
>>>> +This binding uses the common clock binding[1].
>>>> +
>>>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>>>> +
>>>> +Required properties:
>>>> +- compatible : Should be "img,boston-clock".
>>>> +- #clock-cells : Should be set to 1.
>>>> +  Values available for clock consumers can be found in the header file:
>>>> +    <dt-bindings/clock/boston-clock.h>
>>>> +- regmap : Phandle to the Boston platform register system controller.
>>>> +  This should contain a phandle to the system controller node covering the
>>>> +  platform registers provided by the Boston board.
>>>> +
>>>> +Example:
>>>> +
>>>> +	clk_boston: clock {
>>>> +		compatible = "img,boston-clock";
>>>> +		#clock-cells = <1>;
>>>> +		regmap = <&plat_regs>;
>>>
>>> Isn't syscon more standard than regmap as the property name? Is
>>> there a binding for the plat_regs device? Is there any reason the
>>> clks can't be populated in that syscon driver?
>>
>> Hi Stephen,
>>
>> The plat_regs device doesn't have a custom driver, it simply makes use
>> of the generic "syscon" driver which can provide a regmap.
>>
>> It would be possible to register the clocks from a register for the
>> plat_regs device, but I don't think it would make much sense. The
>> platform registers in question are essentially just a convenient place
>> where various bits of information about the system are exposed,
>> including the clock frequencies but also other bits & pieces like
>> connectivity of PCIe controllers or I/O coherence units, the RTL
>> revision of the CPU or the wrapper RTL that runs on this FPGA-based
>> board, a register that allows for resetting the board, etc. It's not a
>> single piece of hardware, more a dumping ground for miscellanea. So in
>> my opinion using the syscon approach works best here, and drivers for
>> well defined pieces of hardware or functionality can reference that
>> syscon to retrieve the regmap.
> 
> That is all quite common for any SoC. Whether it's 2 nodes or 2 drivers 
> are independent questions. You can easily have 1 node and 2 drivers. The 
> decision factor is really how many registers we're dealing with. We 
> don't want to end up with a node per register or register field. That's 
> too fine grained.

Absolutely, I don't think we disagree there.

>> As for whether "syscon" is a more standard property name than "regmap",
>> both seem to be used based on a grep of
>> Documentation/devicetree/bindings/. I believe I picked up use of
>> "regmap" from the generic syscon-poweroff & syscon-reboot drivers, which
>> both use "regmap" as a property name.
> 
> syscon is much more common.
> 
> Avoid the phandle altogether and make this a child node.

I could do that, but it would feel rather odd to describe the clock
hardware as a child of a bunch of miscellaneous registers that happen to
expose some information about those clocks. Is that really what you
prefer? I think as-is the DT is a better description of the hardware.

Thanks,
    Paul

> 
> Rob
> 
