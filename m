Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2018 09:15:30 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:8015 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990418AbeHFHPYpcfOJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Aug 2018 09:15:24 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 00:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,451,1526367600"; 
   d="scan'208";a="70476079"
Received: from songjunw-mobl1.ger.corp.intel.com (HELO [10.226.39.42]) ([10.226.39.42])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Aug 2018 00:05:28 -0700
Subject: Re: [PATCH v2 14/18] serial: intel: Add CCF support
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, hua.ma@linux.intel.com,
        yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-15-songjun.wu@linux.intel.com>
 <20180803055640.GA32226@kroah.com>
 <763bba56-3701-7fe9-9b31-4710594b40d5@linux.intel.com>
 <20180803103023.GA6557@kroah.com>
 <3360edd2-f3d8-b860-13fa-ce680edbfd0a@hauke-m.de>
 <20180804124309.GB4920@kroah.com>
 <CAK8P3a3qs34LuhPeaef2wPHYEWbYO5N-4n7763BcaDyppiJ6DA@mail.gmail.com>
From:   "Wu, Songjun" <songjun.wu@linux.intel.com>
Message-ID: <acd28f40-4342-7f67-8468-7d4578f614a1@linux.intel.com>
Date:   Mon, 6 Aug 2018 15:05:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3qs34LuhPeaef2wPHYEWbYO5N-4n7763BcaDyppiJ6DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65399
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



On 8/5/2018 5:03 AM, Arnd Bergmann wrote:
> On Sat, Aug 4, 2018 at 2:43 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Sat, Aug 04, 2018 at 12:54:22PM +0200, Hauke Mehrtens wrote:
>>> On 08/03/2018 12:30 PM, Greg Kroah-Hartman wrote:
>>>> On Fri, Aug 03, 2018 at 03:33:38PM +0800, Wu, Songjun wrote:
>>> This patch makes it possible to use it with the legacy lantiq code and
>>> also with the common clock framework. I see multiple options to fix this
>>> problem.
>>>
>>> 1. The current approach to have it as a compile variant for a) legacy
>>> lantiq arch code without common clock framework and b) support for SoCs
>>> using the common clock framework.
>>> 2. Convert the lantiq arch code to the common clock framework. This
>>> would be a good approach, but it need some efforts.
>>> 3. Remove the arch/mips/lantiq code. There are still users of this code.
>>> 4. Use the old APIs also for the new xRX500 SoC, I do not like this
>>> approach.
>>> 5. Move lantiq_soc.h to somewhere in include/linux/ so it is globally
>>> available and provide some better wrapper code.
>> I don't really care what you do at this point in time, but you all
>> should know better than the crazy #ifdef is not allowed to try to
>> prevent/allow the inclusion of a .h file.  Checkpatch might have even
>> warned you about it, right?
>>
>> So do it correctly, odds are #5 is correct, as that makes it work like
>> any other device in the kernel.  You are not unique here.
> The best approach here would clearly be 2. We don't want platform
> specific header files for doing things that should be completely generic.
>
> Converting lantiq to the common-clk framework obviously requires
> some work, but then again the whole arch/mips/lantiq/clk.c file
> is fairly short and maybe not that hard to convert.
>
> >From looking at arch/mips/lantiq/xway/sysctrl.c, it appears that you
> already use the clkdev lookup mechanism for some devices without
> using COMMON_CLK, so I would assume that you can also use those
> for the remaining clks, which would be much simpler. It registers
> one anonymous clk there as
>
>          clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);
>
> so why not add replace that with two named clocks and just use
> the same names in the DT for the newer chip?
>
>        Arnd
We discussed internally and have another solution for this issue.
Add one lantiq.h in the serial folder, and use "#ifdef preprocessor" in 
lantiq.h,
also providing no-op stub functions in the #else case, then call those 
functions
unconditionally from lantiq.c to avoid #ifdef in C file.

To support CCF in legacy product is another topic, is not included in 
this patch.

The implementation is as following：
#ifdef CONFIG_LANTIQ
#include <lantiq_soc.h>
#else
#define LTQ_EARLY_ASC 0
#define CPHYSADDR(_val) 0

static inline struct clk *clk_get_fpi(void)
{
     return NULL;
}
#endif
