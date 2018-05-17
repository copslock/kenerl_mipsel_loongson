Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2018 12:36:17 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:45498 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993514AbeEQKgKJi7Z4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2018 12:36:10 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 17 May 2018 10:34:52 +0000
Received: from [192.168.155.41] (192.168.155.41) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 17
 May 2018 03:35:19 -0700
Subject: Re: [PATCH v3 4/7] MIPS: perf: Fix perf with MT counting other
 threads
To:     James Hogan <jhogan@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <linux-mips@linux-mips.org>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
 <1524219789-31241-5-git-send-email-matt.redfearn@mips.com>
 <20180516175916.GA12837@jamesdev>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <63a1ca19-6ded-149a-5a61-7464609c691b@mips.com>
Date:   Thu, 17 May 2018 11:35:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180516175916.GA12837@jamesdev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526553291-637139-24085-42046-1
X-BESS-VER: 2018.6-r1805161801
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193074
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
X-archive-position: 63983
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

Hi James,

On 16/05/18 18:59, James Hogan wrote:
> On Fri, Apr 20, 2018 at 11:23:06AM +0100, Matt Redfearn wrote:
>> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
>> index 7e2b7d38a774..fe50986e83c6 100644
>> --- a/arch/mips/kernel/perf_event_mipsxx.c
>> +++ b/arch/mips/kernel/perf_event_mipsxx.c
>> @@ -323,7 +323,11 @@ static int mipsxx_pmu_alloc_counter(struct cpu_hw_events *cpuc,
>>   
>>   static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
>>   {
>> +	struct perf_event *event = container_of(evt, struct perf_event, hw);
>>   	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +#ifdef CONFIG_MIPS_MT_SMP
>> +	unsigned int range = evt->event_base >> 24;
>> +#endif /* CONFIG_MIPS_MT_SMP */
>>   
>>   	WARN_ON(idx < 0 || idx >= mipspmu.num_counters);
>>   
>> @@ -331,11 +335,37 @@ static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
>>   		(evt->config_base & M_PERFCTL_CONFIG_MASK) |
>>   		/* Make sure interrupt enabled. */
>>   		MIPS_PERFCTRL_IE;
>> -	if (IS_ENABLED(CONFIG_CPU_BMIPS5000))
>> +
>> +#ifdef CONFIG_CPU_BMIPS5000
>> +	{
>>   		/* enable the counter for the calling thread */
>>   		cpuc->saved_ctrl[idx] |=
>>   			(1 << (12 + vpe_id())) | BRCM_PERFCTRL_TC;
>> +	}
>> +#else
>> +#ifdef CONFIG_MIPS_MT_SMP
>> +	if (range > V) {
>> +		/* The counter is processor wide. Set it up to count all TCs. */
>> +		pr_debug("Enabling perf counter for all TCs\n");
>> +		cpuc->saved_ctrl[idx] |= M_TC_EN_ALL;
>> +	} else
>> +#endif /* CONFIG_MIPS_MT_SMP */
>> +	{
>> +		unsigned int cpu, ctrl;
>>   
>> +		/*
>> +		 * Set up the counter for a particular CPU when event->cpu is
>> +		 * a valid CPU number. Otherwise set up the counter for the CPU
>> +		 * scheduling this thread.
>> +		 */
>> +		cpu = (event->cpu >= 0) ? event->cpu : smp_processor_id();
>> +
>> +		ctrl = M_PERFCTL_VPEID(cpu_vpe_id(&cpu_data[cpu]));
>> +		ctrl |= M_TC_EN_VPE;
>> +		cpuc->saved_ctrl[idx] |= ctrl;
>> +		pr_debug("Enabling perf counter for CPU%d\n", cpu);
>> +	}
>> +#endif /* CONFIG_CPU_BMIPS5000 */
> 
> I'm not a huge fan of the ifdefery tbh, I don't think it makes it very
> easy to read having a combination of ifs and #ifdefs. I reckon
> IF_ENABLED would be better, perhaps with having the BMIPS5000 case
> return to avoid too much nesting.

OK, I'll try and tidy it up.

Thanks,
Matt

> 
> Otherwise the patch looks okay to me.
> 
> Thanks
> James
> 
