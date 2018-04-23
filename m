Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 15:41:26 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:53656 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993124AbeDWNlMXeVhq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 15:41:12 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Mon, 23 Apr 2018 13:40:32 +0000
Received: from [192.168.155.41] (192.168.155.41) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Mon, 23
 Apr 2018 06:40:49 -0700
Subject: Re: [PATCH v3 0/7] MIPS: perf: MT fixes and improvements
To:     Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Peter Zijlstra <peterz@infradead.org>,
        <oprofile-list@lists.sf.net>, Huacai Chen <chenhc@lemote.com>,
        <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>,
        Robert Richter <rric@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
 <c3ee1ba4-3458-33a7-4c1f-700936a57bfa@gmail.com>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <619f68fd-84f8-58c2-d474-1dda8b371c2a@mips.com>
Date:   Mon, 23 Apr 2018 14:40:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c3ee1ba4-3458-33a7-4c1f-700936a57bfa@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1524490832-637139-30707-96871-1
X-BESS-VER: 2018.5-r1804181636
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192287
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
X-archive-position: 63700
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



On 20/04/18 23:51, Florian Fainelli wrote:
> On 04/20/2018 03:23 AM, Matt Redfearn wrote:
>> This series addresses a few issues with how the MIPS performance
>> counters code supports the hardware multithreading MT ASE.
>>
>> Firstly, implementations of the MT ASE may implement performance
>> counters
>> per core or per thread(TC). MIPS Techologies implementations signal this
>> via a bit in the implmentation specific CONFIG7 register. Since this
>> register is implementation specific, checking it should be guarded by a
>> PRID check. This also replaces a bit defined by a magic number.
>>
>> Secondly, the code currently uses vpe_id(), defined as
>> smp_processor_id(), divided by 2, to share core performance counters
>> between VPEs. This relies on a couple of assumptions of the hardware
>> implementation to function correctly (always 2 VPEs per core, and the
>> hardware reading only the least significant bit).
>>
>> Finally, the method of sharing core performance counters between VPEs is
>> suboptimal since it does not allow one process running on a VPE to use
>> all of the performance counters available to it, because the kernel will
>> reserve half of the coutners for the other VPE even if it may never use
>> them. This reservation at counter probe is replaced with an allocation
>> on use strategy.
>>
>> Tested on a MIPS Creator CI40 (2C2T MIPS InterAptiv with per-TC
>> counters, though for the purposes of testing the per-TC availability was
>> hardcoded to allow testing both paths).
>>
>> Series applies to v4.16
> 
> Sorry it took so long to get that tested.

Hi Florian,

Thanks for testing!

> 
> Sounds like you need to build test this on a BMIPS5000 configuration
> (bmips_stb_defconfig should provide that):
> 
> In file included from ./arch/mips/include/asm/mach-generic/spaces.h:15:0,
>                   from ./arch/mips/include/asm/mach-bmips/spaces.h:16,
>                   from ./arch/mips/include/asm/addrspace.h:13,
>                   from ./arch/mips/include/asm/barrier.h:11,
>                   from ./include/linux/compiler.h:245,
>                   from ./include/linux/kernel.h:10,
>                   from ./include/linux/cpumask.h:10,
>                   from arch/mips/kernel/perf_event_mipsxx.c:18:
> arch/mips/kernel/perf_event_mipsxx.c: In function 'mipsxx_pmu_enable_event':
> ./arch/mips/include/asm/mipsregs.h:738:52: error: suggest parentheses
> around '+' in operand of '&' [-Werror=parentheses]
>   #define BRCM_PERFCTRL_VPEID(v) (_ULCAST_(1) << (12 + v))
> 
> arch/mips/kernel/perf_event_mipsxx.c:385:10: note: in expansion of macro
> 'BRCM_PERFCTRL_VPEID'
>     ctrl = BRCM_PERFCTRL_VPEID(cpu & MIPS_CPUID_TO_COUNTER_MASK);
>            ^~~~~~~~~~~~~~~~~~~
>    CC      drivers/of/fdt_addres

Good spot - I've updated the patch to

+#define BRCM_PERFCTRL_VPEID(v) (_ULCAST_(1) << (12 + (v)))

to fix that.

> 
> after fixing that, I tried the following to see whether this would be a
> good test case to exercise against:
> 
> perf record -a -C 0 taskset -c 1 /bin/true
> perf record -a -C 1 taskset -c 0 /bin/true
> 
> and would not see anything related to /bin/true running in either case,
> which seems like it does the right thing?

I've generally been testing using this code:

perf_test.S:

#include <asm/unistd.h>

#define ITERATIONS 10000


.text
.global __start
.type	__start, @function;
__start:
	.set	noreorder
	li      $2, ITERATIONS

1:
	addiu   $2,$2,-1
	bnez    $2, 1b
	 nop

	li	$2, __NR_exit
	syscall


Makefile:
$(CC) $(ISA_FLAG) $(ABI_FLAG) $(ENDIAN_FLAG) -static -nostartfiles -O2 
-o perf_test perf_test.S

Then running perf which should report the right counts:

taskset 1 perf stat -e instructions:u,branches:u ./perf_test
  Performance counter stats for './perf_test':

              30002      instructions:u
              10000      branches:u

        0.005179467 seconds time elapsed


System mode should also work:

# perf stat -e instructions:u,branches:u -a -C 2
^C

  Performance counter stats for 'system wide':

               1416      instructions:u 

                198      branches:u 


        4.454874812 seconds time elapsed

> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

> 
> BTW, for some reason not specifying -a -C <cpu> does lead to lockups,
> consistently and for pretty much any perf command, this could be BMIPS
> specific, did not get a chance to cross test on a different machine.

Interesting.... FWIW I don't get lockups on ci40 (MIPS InterAptiv). Is 
this a regression with this series applied or an existing problem?

Thanks,
Matt

> 
>>
>>
>> Changes in v3:
>> New patch to detect feature presence in cpu-probe.c
>> Use flag in cpu_data set by cpu_probe.c to indicate feature presence.
>> - rebase on new feature detection
>>
>> Changes in v2:
>> Fix mipsxx_pmu_enable_event for !#ifdef CONFIG_MIPS_MT_SMP
>> - Fix !#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS build
>> - re-use cpuc variable in mipsxx_pmu_alloc_counter,
>>    mipsxx_pmu_free_counter rather than having sibling_ version.
>> Since BMIPS5000 does not implement per TC counters, we can remove the
>> check on cpu_has_mipsmt_pertccounters.
>> New patch to fix BMIPS5000 system mode perf.
>>
>> Matt Redfearn (7):
>>    MIPS: Probe for MIPS MT perf counters per TC
>>    MIPS: perf: More robustly probe for the presence of per-tc counters
>>    MIPS: perf: Use correct VPE ID when setting up VPE tracing
>>    MIPS: perf: Fix perf with MT counting other threads
>>    MIPS: perf: Allocate per-core counters on demand
>>    MIPS: perf: Fold vpe_id() macro into it's one last usage
>>    MIPS: perf: Fix BMIPS5000 system mode counting
>>
>>   arch/mips/include/asm/cpu-features.h |   7 ++
>>   arch/mips/include/asm/cpu.h          |   2 +
>>   arch/mips/include/asm/mipsregs.h     |   6 +
>>   arch/mips/kernel/cpu-probe.c         |  12 ++
>>   arch/mips/kernel/perf_event_mipsxx.c | 232 +++++++++++++++++++----------------
>>   arch/mips/oprofile/op_model_mipsxx.c |   2 -
>>   6 files changed, 150 insertions(+), 111 deletions(-)
>>
> 
> 
