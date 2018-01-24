Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 10:48:37 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:34862 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbeAXJs3ZF3YV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 10:48:29 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 24 Jan 2018 09:46:22 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Jan
 2018 01:46:12 -0800
Subject: Re: [PATCH 11/14] MIPS: memblock: Print out kernel virtual mem layout
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Florian Fainelli <f.fainelli@gmail.com>, <ralf@linux-mips.org>,
        <miodrag.dinic@mips.com>, <jhogan@kernel.org>,
        <goran.ferenc@mips.com>, <david.daney@cavium.com>,
        <paul.gortmaker@windriver.com>, <paul.burton@mips.com>,
        <alex.belits@cavium.com>, <Steven.Hill@cavium.com>,
        <alexander.sverdlin@nokia.com>, <kumba@gentoo.org>,
        <marcin.nowakowski@mips.com>, <James.hogan@mips.com>,
        <Peter.Wotton@mips.com>, <Sergey.Semin@t-platforms.ru>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-12-fancer.lancer@gmail.com>
 <cce36f73-4381-f830-3422-1cef8ad9e622@gmail.com>
 <20180118201856.GA996@mobilestation>
 <b2797958-d217-9c8d-10ca-b9bc43ae585b@mips.com>
 <20180119142712.GA3101@mobilestation>
 <eef02082-c3b1-e42b-d5ff-1c0d5cb8d708@mips.com>
 <20180123191051.GA28147@mobilestation>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <e751ccda-ab57-dfe8-0a16-25bb5368337c@mips.com>
Date:   Wed, 24 Jan 2018 09:46:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180123191051.GA28147@mobilestation>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1516787182-452060-22891-56327-1
X-BESS-VER: 2017.17.1-r1801152154
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189306
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Hi Serge,

On 23/01/18 19:10, Serge Semin wrote:
> Hello Matt,
> 
> On Tue, Jan 23, 2018 at 03:35:14PM +0000, Matt Redfearn <matt.redfearn@mips.com> wrote:
>> Hi Serge,
>>
>> On 19/01/18 14:27, Serge Semin wrote:
>>> On Fri, Jan 19, 2018 at 07:59:43AM +0000, Matt Redfearn <matt.redfearn@mips.com> wrote:
>>>
>>> Hello Matt,
>>>
>>>> Hi Serge,
>>>>
>>>>
>>>>
>>>> On 18/01/18 20:18, Serge Semin wrote:
>>>>> On Thu, Jan 18, 2018 at 12:03:03PM -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>>> On 01/17/2018 02:23 PM, Serge Semin wrote:
>>>>>>> It is useful to have the kernel virtual memory layout printed
>>>>>>> at boot time so to have the full information about the booted
>>>>>>> kernel. In some cases it might be unsafe to have virtual
>>>>>>> addresses freely visible in logs, so the %pK format is used if
>>>>>>> one want to hide them.
>>>>>>>
>>>>>>> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
>>>>>>
>>>>>> I personally like having that information because that helps debug and
>>>>>> have a quick reference, but there appears to be a trend to remove this
>>>>>> in the name of security:
>>>>>>
>>>>>> https://patchwork.kernel.org/patch/10124007/
>>>>>>
>>>>>> maybe hide this behind a configuration option?
>>>>>
>>>>> Yeah, arm code was the place I picked the function up.) But in my case
>>>>> I've used %pK so the pointers would disappear from logging when
>>>>> kptr_restrict sysctl is 1 or 2.
>>>>> I agree, that we might need to make the printouts optional. If there is
>>>>> any kernel config, which for instance increases the kernel security we
>>>>> could also use it or anything else to discard the printouts at compile
>>>>> time.
>>>>
>>>>
>>>> Certainly, when KASLR is active it would be preferable to hide this
>>>> information, so you could use CONFIG_RELOCATABLE. The existing KASLR stuff
>>>> additionally hides this kind of information behind CONFIG_DEBUG_KERNEL, so
>>>> that only people actively debugging the kernel see it:
>>>>
>>>> http://elixir.free-electrons.com/linux/v4.15-rc8/source/arch/mips/kernel/setup.c#L604
>>>
>>> Ok. I'll hide the printouts behind both of that config macros in the next patchset
>>> version.
>>
>>
>> Another thing to note - since ad67b74d2469d ("printk: hash addresses printed
>> with %p") %pK at this time in the boot process is useless since the RNG is
>> not sufficiently initialised and all prints end up being "(ptrval)". Hence
>> after v4.15-rc2 we end up with output like:
>>
>> [    0.000000] Kernel virtual memory layout:
>> [    0.000000]     lowmem  : 0x(ptrval) - 0x(ptrval)  ( 256 MB)
>> [    0.000000]       .text : 0x(ptrval) - 0x(ptrval)  (7374 kB)
>> [    0.000000]       .data : 0x(ptrval) - 0x(ptrval)  (1901 kB)
>> [    0.000000]       .init : 0x(ptrval) - 0x(ptrval)  (1600 kB)
>> [    0.000000]       .bss  : 0x(ptrval) - 0x(ptrval)  ( 415 kB)
>> [    0.000000]     vmalloc : 0x(ptrval) - 0x(ptrval)  (1023 MB)
>> [    0.000000]     fixmap  : 0x(ptrval) - 0x(ptrval)  (  68 kB)
>>
> 
> It must be some bug in the algo. What point in the %pK then? According to
> the documentation the only way to see the pointers is when (kptr_restrict == 0).
> But if it is we don't get into the restricted_pointer() method at all:
> http://elixir.free-electrons.com/linux/v4.15-rc9/source/lib/vsprintf.c#L1934
> In this case the vsprintf() executes the method ptr_to_id(), which of course
> default to _not_ leak addresses, and hash it before printing.
> 
> Really %pK isn't supposed to be dependent from RNG at all since kptr_restrict
> doesn't do any value randomization.


That was true until v4.15-rc2. The behavior of %pK was changed without 
that being reflected in the documentation. A patch 
(https://patchwork.kernel.org/patch/10124413/) is in progress to update 
this.

> 
>>
>> The %px format specifier was added for cases such as this, where we really
>> want to print the unmodified address. And as long as this function is
>> suitably guarded to only do this when KASLR is deactivated /
>> CONFIG_DEBUG_KERNEL is activated, etc, then we are not unwittingly leaking
>> information - we are deliberately making it available.
>>
> 
> If %pK would work as it's stated by the kernel documentation:
> https://www.kernel.org/doc/Documentation/printk-formats.txt
> then the only change I'd suggest to have here is to close the kernel memory
> layout printout method by the CONFIG_DEBUG_KERNEL ifdef-macro. The kptr_restrict
> should default to 1/2 if the KASLR is activated:
> https://lwn.net/Articles/444556/

Yeah, again, the documentation is no longer correct, and %pK will always 
be hashed, and before the RNG is initialized it does not even hash it, 
just returning "(ptrval)".  So I'd recommend guarding with 
CONFIG_DEBUG_KERNEL and switching the format specifier to %px.

Thanks,
Matt

> 
> Regards,
> -Sergey
> 
>> Thanks,
>> Matt
>>
>>>
>>> Regards,
>>> -Sergey
>>>
>>>>
>>>> Thanks,
>>>> Matt
>>>>
>>>>>
>>>>>> -- 
>>>>>> Florian
