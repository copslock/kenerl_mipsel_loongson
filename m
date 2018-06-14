Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2018 08:38:22 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:42446 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992720AbeFNGiNh0Rq1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Jun 2018 08:38:13 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 23:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="237338374"
Received: from songjunw-mobl1.ger.corp.intel.com (HELO [10.226.39.15]) ([10.226.39.15])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2018 23:38:07 -0700
Subject: Re: [PATCH 7/7] tty: serial: lantiq: Add CCF support
To:     Rob Herring <robh@kernel.org>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, linux-mips@linux-mips.org,
        qi-ming.wu@intel.com, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-8-songjun.wu@linux.intel.com>
 <20180612223953.GA21621@rob-hp-laptop>
From:   "Wu, Songjun" <songjun.wu@linux.intel.com>
Message-ID: <0c62efdb-9a23-3514-352c-a9689aacc1a5@linux.intel.com>
Date:   Thu, 14 Jun 2018 14:38:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180612223953.GA21621@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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



On 6/13/2018 6:39 AM, Rob Herring wrote:
> On Tue, Jun 12, 2018 at 01:40:34PM +0800, Songjun Wu wrote:
>> Previous implementation uses platform-dependent API to get the clock.
>> Those functions are not available for other SoC which uses the same IP.
>> The CCF (Common Clock Framework) have an abstraction based APIs
>> for clock.
>> Change to use CCF APIs to get clock and rate.
>> So that different SoCs can use the same driver.
>> Clocks and clock-names are updated in device tree binding.
>>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>>
>> ---
>>
>>   .../devicetree/bindings/serial/lantiq_asc.txt      |  15 +++
> Please split bindings to separate patch.
Thanks.
It will be split to two separate patches, one for bindings, the other 
for code.
>>   drivers/tty/serial/Kconfig                         |   2 +-
>>   drivers/tty/serial/lantiq.c                        | 101 +++++++++++++++++----
>>   3 files changed, 98 insertions(+), 20 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.txt b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
>> index 3acbd309ab9d..608f0c87a4af 100644
>> --- a/Documentation/devicetree/bindings/serial/lantiq_asc.txt
>> +++ b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
>> @@ -6,6 +6,10 @@ Required properties:
>>   - interrupts: the 3 (tx rx err) interrupt numbers. The interrupt specifier
>>     depends on the interrupt-parent interrupt controller.
>>   
>> +Optional properties:
>> +- clocks: Should contain frequency clock and gate clock
>> +- clock-names: Should be "freq" and "asc"
>> +
>>   Example:
>>   
>>   asc1: serial@e100c00 {
>> @@ -14,3 +18,14 @@ asc1: serial@e100c00 {
>>   	interrupt-parent = <&icu0>;
>>   	interrupts = <112 113 114>;
>>   };
>> +
>> +asc0: serial@600000 {
>> +	compatible = "lantiq,asc";
>> +	reg = <0x600000 0x100000>;
> 1MB of address space? That wastes a lot of virtual space on 32-bit
> systems. Just make the size the actual used range.
The size of address space will be updated to the actual used range.
>> +	interrupt-parent = <&gic>;
>> +	interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
>> +	<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
>> +	<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
>> +	clocks = <&pll0aclk SSX4_CLK>, <&clkgate1 GATE_URT_CLK>;
>> +	clock-names = "freq", "asc";
>> +};
