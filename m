Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2018 10:40:37 +0200 (CEST)
Received: from mga05.intel.com ([192.55.52.43]:43123 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993016AbeFNIkaAclNT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Jun 2018 10:40:30 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 01:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="49265829"
Received: from zhuyixin-mobl1.gar.corp.intel.com (HELO [10.226.38.83]) ([10.226.38.83])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2018 01:40:23 -0700
Subject: Re: [PATCH 2/7] clk: intel: Add clock driver for GRX500 SoC
To:     Rob Herring <robh@kernel.org>,
        Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, chuanhua.lei@linux.intel.com,
        linux-mips@linux-mips.org, qi-ming.wu@intel.com,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-3-songjun.wu@linux.intel.com>
 <20180612223725.GC2197@rob-hp-laptop>
From:   yixin zhu <yixin.zhu@linux.intel.com>
Message-ID: <41163f48-ce5c-efae-2b6d-b93d75e422e5@linux.intel.com>
Date:   Thu, 14 Jun 2018 16:40:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180612223725.GC2197@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <yixin.zhu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64263
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



On 6/13/2018 6:37 AM, Rob Herring wrote:
> On Tue, Jun 12, 2018 at 01:40:29PM +0800, Songjun Wu wrote:
>> From: Yixin Zhu <yixin.zhu@linux.intel.com>
>>
>> PLL of GRX500 provide clock to DDR, CPU, and peripherals as show below
>>
>>                   +---------+
>> 	    |--->| LCPLL3 0|--PCIe clk-->
>>     XO       |    +---------+
>> +-----------|
>>              |    +---------+
>>              |    |        3|--PAE clk-->
>>              |--->| PLL0B  2|--GSWIP clk-->
>>              |    |        1|--DDR clk-->DDR PHY clk-->
>>              |    |        0|--CPU1 clk--+   +-----+
>>              |    +---------+            |--->0    |
>>              |                               | MUX |--CPU clk-->
>>              |    +---------+            |--->1    |
>>              |    |        0|--CPU0 clk--+   +-----+
>>              |--->| PLLOA  1|--SSX4 clk-->
>>                   |        2|--NGI clk-->
>>                   |        3|--CBM clk-->
>>                   +---------+
>>
>> VCO of all PLLs of GRX500 is not supposed to be reprogrammed.
>> DDR PHY clock is created to show correct clock rate in software
>> point of view.
>> CPU clock of 1Ghz from PLL0B otherwise from PLL0A.
>> Signed-off-by: Yixin Zhu <yixin.zhu@linux.intel.com>
>>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> 
> Need a blank line before the SoB's and not one in the middle.
Thanks.
Blank line in the middle of sign-off will be removed.
A new blank line will be added before SoB's.

> 
>> ---
>>
>>   .../devicetree/bindings/clock/intel,grx500-clk.txt |  46 ++
> 
> Please split bindings to separate patch.
> 
>>   drivers/clk/Kconfig                                |   1 +
>>   drivers/clk/Makefile                               |   1 +
>>   drivers/clk/intel/Kconfig                          |  21 +
>>   drivers/clk/intel/Makefile                         |   7 +
>>   drivers/clk/intel/clk-cgu-api.c                    | 676 +++++++++++++++++++++
>>   drivers/clk/intel/clk-cgu-api.h                    | 120 ++++
>>   drivers/clk/intel/clk-grx500.c                     | 236 +++++++
>>   include/dt-bindings/clock/intel,grx500-clk.h       |  61 ++
>>   9 files changed, 1169 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
>>   create mode 100644 drivers/clk/intel/Kconfig
>>   create mode 100644 drivers/clk/intel/Makefile
>>   create mode 100644 drivers/clk/intel/clk-cgu-api.c
>>   create mode 100644 drivers/clk/intel/clk-cgu-api.h
>>   create mode 100644 drivers/clk/intel/clk-grx500.c
>>   create mode 100644 include/dt-bindings/clock/intel,grx500-clk.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
>> new file mode 100644
>> index 000000000000..dd761d900dc9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
>> @@ -0,0 +1,46 @@
>> +Device Tree Clock bindings for GRX500 PLL controller.
>> +
>> +This binding uses the common clock binding:
>> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +This GRX500 PLL controller provides the 5 main clock domain of the SoC: CPU/DDR, XBAR,
>> +Voice, WLAN, PCIe and gate clocks for HW modules.
>> +
>> +Required properties for osc clock node
>> +- compatible: Should be intel,grx500-xxx-clk
> 
> These would need to be enumerated with all possible values. However, see
> below.
All possible values will be listed.

> 
>> +- reg: offset address of the controller memory area.
>> +- clocks: phandle of the external reference clock
>> +- #clock-cells: can be one or zero.
>> +- clock-output-names: Names of the output clocks.
>> +
>> +Example:
>> +	pll0aclk: pll0aclk {
>> +		#clock-cells = <1>;
>> +		compatible = "intel,grx500-pll0a-clk";
>> +		clocks = <&pll0a>;
>> +		reg = <0x8>;
>> +		clock-output-names = "cbmclk", "ngiclk", "ssx4clk", "cpu0clk";
>> +	};
>> +
>> +	cpuclk: cpuclk {
>> +		#clock-cells = <0>;
>> +		compatible = "intel,grx500-cpu-clk";
>> +		clocks = <&pll0aclk CPU0_CLK>, <&pll0bclk CPU1_CLK>;
>> +		reg = <0x8>;
>> +		clock-output-names = "cpu";
>> +	};
>> +
>> +Required properties for gate node:
>> +- compatible: Should be intel,grx500-gatex-clk
>> +- reg: offset address of the controller memory area.
>> +- #clock-cells: Should be <1>
>> +- clock-output-names: Names of the output clocks.
>> +
>> +Example:
>> +	clkgate0: clkgate0 {
>> +		#clock-cells = <1>;
>> +		compatible = "intel,grx500-gate0-clk";
>> +		reg = <0x114>;
>> +		clock-output-names = "gate_xbar0", "gate_xbar1", "gate_xbar2",
>> +		"gate_xbar3", "gate_xbar6", "gate_xbar7";
>> +	};
> 
> We generally don't do a clock node per clock or few clocks but rather 1
> clock node per clock controller block. See any recent clock bindings.
> 
> Rob
Do you mean only one example is needed per clock controller block?
cpuclk is not needed in the document?
