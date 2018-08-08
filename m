Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2018 05:09:01 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:50777 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992735AbeHHDI4oQqnN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Aug 2018 05:08:56 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 20:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="79457375"
Received: from zhuyixin-mobl1.gar.corp.intel.com (HELO [10.226.38.39]) ([10.226.38.39])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2018 20:08:49 -0700
Subject: Re: [PATCH v2 03/18] dt-bindings: clk: Add documentation of grx500
 clock controller
To:     Rob Herring <robh+dt@kernel.org>,
        Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-4-songjun.wu@linux.intel.com>
 <CAL_JsqKLa1e3X+ddAoVdEwBQFd6tsL=RjOLcTLdfoc6mpKuefQ@mail.gmail.com>
From:   yixin zhu <yixin.zhu@linux.intel.com>
Message-ID: <9c0cbdfa-8109-be0d-8e14-7d303c764f5c@linux.intel.com>
Date:   Wed, 8 Aug 2018 11:08:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKLa1e3X+ddAoVdEwBQFd6tsL=RjOLcTLdfoc6mpKuefQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <yixin.zhu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yixin.zhu@linux.intel.com
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



On 8/6/2018 11:18 PM, Rob Herring wrote:
> On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>> From: Yixin Zhu <yixin.zhu@linux.intel.com>
>>
>> This patch adds binding documentation for grx500 clock controller.
>>
>> Signed-off-by: YiXin Zhu <yixin.zhu@linux.intel.com>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
>>
>> Changes in v2:
>> - Rewrite clock driver's dt-binding document according to Rob Herring's
>>    comments.
>> - Simplify device tree docoment, remove some clock description.
>>
>>   .../devicetree/bindings/clock/intel,grx500-clk.txt | 39 ++++++++++++++++++++++
> Please match the compatible string: intel,grx500-cgu.txt
Will update to use same name.

>
>>   1 file changed, 39 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
>> new file mode 100644
>> index 000000000000..e54e1dad9196
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
>> @@ -0,0 +1,39 @@
>> +Device Tree Clock bindings for grx500 PLL controller.
>> +
>> +This binding uses the common clock binding:
>> +       Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +The grx500 clock controller supplies clock to various controllers within the
>> +SoC.
>> +
>> +Required properties for clock node
>> +- compatible: Should be "intel,grx500-cgu".
>> +- reg: physical base address of the controller and length of memory range.
>> +- #clock-cells: should be 1.
>> +
>> +Optional Propteries:
>> +- intel,osc-frequency: frequency of the osc clock.
>> +if missing, driver will use clock rate defined in the driver.
> This should use a fixed-clock node instead.
Yes, This is a fixed clock node registered in driver code.
The frequency of the fixed clock is designed to be overwritten by device 
tree in case some one verify
clock driver in the emulation platform or in some cases frequency other 
than driver defined one is preferred.
These kinds of cases are very rare. But I feel it would be better to 
have a way to use customized frequency.
The frequency defined in device tree will overwritten driver defined 
frequency before registering fixed-clock node.

>> +
>> +Example: Clock controller node:
>> +
>> +       cgu: cgu@16200000 {
>> +                compatible = "intel,grx500-cgu", "syscon";
>> +               reg = <0x16200000 0x200>;
>> +               #clock-cells = <1>;
>> +       };
>> +
>> +
>> +Example: UART controller node that consumes the clock generated by clock
>> +       controller.
>> +
>> +       asc0: serial@16600000 {
>> +               compatible = "lantiq,asc";
>> +               reg = <0x16600000 0x100000>;
>> +               interrupt-parent = <&gic>;
>> +               interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
>> +                       <GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
>> +                       <GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
>> +               clocks = <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
>> +               clock-names = "freq", "asc";
>> +       };
>> --
>> 2.11.0
>>
