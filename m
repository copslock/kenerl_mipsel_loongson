Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2018 04:52:21 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:31276 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992735AbeHHCwRwXdvN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Aug 2018 04:52:17 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 19:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="79454475"
Received: from zhuyixin-mobl1.gar.corp.intel.com (HELO [10.226.38.39]) ([10.226.38.39])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2018 19:51:52 -0700
Subject: Re: [PATCH v2 02/18] clk: intel: Add clock driver for Intel MIPS SoCs
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
 <20180803030237.3366-3-songjun.wu@linux.intel.com>
 <CAL_JsqK5pFNKyAhTTmNpaSnKa_beY3kS8FGtYim8oTgw6oO9Rw@mail.gmail.com>
From:   yixin zhu <yixin.zhu@linux.intel.com>
Message-ID: <57bea045-628b-2dad-2492-dadd9947cbe9@linux.intel.com>
Date:   Wed, 8 Aug 2018 10:51:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK5pFNKyAhTTmNpaSnKa_beY3kS8FGtYim8oTgw6oO9Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <yixin.zhu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65470
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



On 8/6/2018 11:19 PM, Rob Herring wrote:
> On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>> From: Yixin Zhu <yixin.zhu@linux.intel.com>
>>
>> This driver provides PLL clock registration as well as various clock
>> branches, e.g. MUX clock, gate clock, divider clock and so on.
>>
>> PLLs that provide clock to DDR, CPU and peripherals are shown below:
>>
>>                   +---------+
>>              |--->| LCPLL3 0|--PCIe clk-->
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
>> Signed-off-by: Yixin Zhu <yixin.zhu@linux.intel.com>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
>>
>> Changes in v2:
>> - Rewrite clock driver, add platform clock description details in
>>    clock driver.
>>
>>   drivers/clk/Kconfig                          |   1 +
>>   drivers/clk/Makefile                         |   3 +
>>   drivers/clk/intel/Kconfig                    |  20 ++
>>   drivers/clk/intel/Makefile                   |   7 +
>>   drivers/clk/intel/clk-cgu-pll.c              | 166 ++++++++++
>>   drivers/clk/intel/clk-cgu-pll.h              |  34 ++
>>   drivers/clk/intel/clk-cgu.c                  | 470 +++++++++++++++++++++++++++
>>   drivers/clk/intel/clk-cgu.h                  | 259 +++++++++++++++
>>   drivers/clk/intel/clk-grx500.c               | 168 ++++++++++
>>   include/dt-bindings/clock/intel,grx500-clk.h |  69 ++++
> This belongs with the clk binding patch.
>
> Rob
Thanks for review.
Will move it to clock binding patch.

>
