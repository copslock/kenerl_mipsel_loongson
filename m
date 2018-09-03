Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 12:52:33 +0200 (CEST)
Received: from mga03.intel.com ([134.134.136.65]:23431 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991063AbeICKwaAgchf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Sep 2018 12:52:30 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 03:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,324,1531810800"; 
   d="scan'208";a="71208172"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 03 Sep 2018 03:52:27 -0700
Received: from [10.226.39.0] (zhuyixin-mobl.gar.corp.intel.com [10.226.39.0])
        by linux.intel.com (Postfix) with ESMTP id C5DE35801AB;
        Mon,  3 Sep 2018 03:52:24 -0700 (PDT)
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
 <65a8518b-8fd8-847b-f952-0370be3d786a@linux.intel.com>
 <153573558557.93865.3835503209987304514@swboyd.mtv.corp.google.com>
From:   "Zhu, Yi Xin" <yixin.zhu@linux.intel.com>
Message-ID: <3fcc4615-eea8-8cb7-987f-c58ab9683e0c@linux.intel.com>
Date:   Mon, 3 Sep 2018 18:52:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <153573558557.93865.3835503209987304514@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <yixin.zhu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65881
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


On 9/1/2018 1:13 AM, Stephen Boyd wrote:
> Quoting Zhu, Yi Xin (2018-08-29 03:34:26)
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
>>>
>> Just to make sure my approach is same as you think.
>>
>> In the driver, there's two clock registrations.
>>
>> - One through CLK_OF_DECLARE for early stage clocks.
>>
>> - The other via platform driver for the non-critical clocks.
> You can use the same DT node for both parts, no need to split the node
> into two and use syscon here.
>
Thank you.

Will use CLK_OF_DECLARE_DRIVER to use the same DT node.
