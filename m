Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 12:48:01 +0200 (CEST)
Received: from mga18.intel.com ([134.134.136.126]:13207 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991063AbeICKrzq0Aqf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Sep 2018 12:47:55 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 03:47:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,324,1531810800"; 
   d="scan'208";a="82551486"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2018 03:47:44 -0700
Received: from [10.226.39.0] (zhuyixin-mobl.gar.corp.intel.com [10.226.39.0])
        by linux.intel.com (Postfix) with ESMTP id 49527580372;
        Mon,  3 Sep 2018 03:47:43 -0700 (PDT)
Subject: Re: [PATCH v2 02/18] clk: intel: Add clock driver for Intel MIPS SoCs
To:     Stephen Boyd <sboyd@kernel.org>,
        Songjun Wu <songjun.wu@linux.intel.com>,
        chuanhua.lei@linux.intel.com, hua.ma@linux.intel.com,
        qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-3-songjun.wu@linux.intel.com>
 <153370742214.220756.2039365625963765922@swboyd.mtv.corp.google.com>
 <571d2d40-8728-fa7c-5d89-73d2a7b6293b@linux.intel.com>
 <153539697928.129321.2605078315090527674@swboyd.mtv.corp.google.com>
 <75f8313b-42e6-e741-196d-af27ad1e4f9b@linux.intel.com>
 <153573545028.93865.1832322708533849519@swboyd.mtv.corp.google.com>
From:   "Zhu, Yi Xin" <yixin.zhu@linux.intel.com>
Message-ID: <cb3a0dcd-c9b4-136a-abff-200299186113@linux.intel.com>
Date:   Mon, 3 Sep 2018 18:47:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <153573545028.93865.1832322708533849519@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <yixin.zhu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65880
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


On 9/1/2018 1:10 AM, Stephen Boyd wrote:
> Quoting Zhu, Yi Xin (2018-08-28 23:56:22)
>> On 8/28/2018 3:09 AM, Stephen Boyd wrote:
>>> Quoting yixin zhu (2018-08-08 01:52:20)
>>>> On 8/8/2018 1:50 PM, Stephen Boyd wrote:
>>>>>> +/* clock flags definition */
>>>>>> +#define CLOCK_FLAG_VAL_INIT    BIT(16)
>>>>>> +#define GATE_CLK_HW            BIT(17)
>>>>>> +#define GATE_CLK_SW            BIT(18)
>>>>>> +#define GATE_CLK_VT            BIT(19)
>>>>> What does VT mean? Virtual?
>>>> Yes. VT means virtual here.
>>>> Will change to GATE_CLK_VIRT.
>>>>
>>> Is it a hardware concept? Or virtualization with hypervisor?
>> Some peripheral drivers want to use same code cross platforms.
>>
>> But not all platforms provide HW gate clock.  So in this case, clock
>> driver creates
>>
>> a virtual gate clock to make it work if no HW gate clock in the SoC.
> That's not how things are supposed to work. If a clk isn't there in the
> hardware we don't make them up in software so that the consumer software
> drivers can keep requesting clks on different platforms. On a different
> platform, the driver needs to know that the clks aren't there with a
> different compatible string.

OK. Will remove virtual gate clock.


>>
>>>>>> +}
>>>>>> +
>>>>>> +CLK_OF_DECLARE(intel_grx500_cgu, "intel,grx500-cgu", grx500_clk_init);
>>>>> Any reason a platform driver can't be used instead of CLK_OF_DECLARE()?
>>>> It provides CPU clock which is used in early boot stage.
>>>>
>>> Ok. What is the CPU clock doing in early boot stage? Some sort of timer
>>> frequency? If the driver can be split into two pieces, one to handle the
>>> really early stuff that must be in place to get timers up and running
>>> and the other to register the rest of the clks that aren't critical from
>>> a regular platform driver it would be good. That's preferred model if
>>> something is super critical.
>> Yes, CPU clock is providing CPU frequency in the early boot stage.
>>
>> Will put the non-critical clocks in the platform driver.
>>
>>
> Sure the CPU clock is handling frequency, but does that matter for early
> boot to get going? If timers aren't involved here then it doesn't sound
> like this needs CLK_OF_DECLARE.

Yes, timer is involved here.

CPU frequency get by early stage platform code used in clockevent 
registration.


>
