Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2011 18:49:08 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15058 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491773Ab1ATRtC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jan 2011 18:49:02 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3875bb0000>; Thu, 20 Jan 2011 09:49:47 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 20 Jan 2011 09:48:58 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 20 Jan 2011 09:48:58 -0800
Message-ID: <4D387585.8020705@caviumnetworks.com>
Date:   Thu, 20 Jan 2011 09:48:53 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 5/6] MIPS: perf: Add support for 64-bit perf counters.
References: <1294367707-2593-1-git-send-email-ddaney@caviumnetworks.com>        <1294367707-2593-6-git-send-email-ddaney@caviumnetworks.com> <AANLkTi=8NndFv6czWy1q_iDvJRHhCYYu06fhyBL9ByE=@mail.gmail.com>
In-Reply-To: <AANLkTi=8NndFv6czWy1q_iDvJRHhCYYu06fhyBL9ByE=@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jan 2011 17:48:58.0419 (UTC) FILETIME=[50881030:01CBB8CA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 01/20/2011 02:06 AM, Deng-Cheng Zhu wrote:
> 2011/1/7 David Daney<ddaney@caviumnetworks.com>:
>> @@ -294,14 +519,29 @@ static void mipspmu_read(struct perf_event *event)
>>
>>   static void mipspmu_enable(struct pmu *pmu)
>>   {
>> -       if (mipspmu)
>> -               mipspmu->start();
>> +#ifdef CONFIG_MIPS_MT_SMP
>> +       write_unlock(&pmuint_rwlock);
>> +#endif
>> +       resume_local_counters();
>>   }
>
> When working with CONFIG_MIPS_MT_SMP, the compiler says 'pmuint_rwlock
> undeclared' because of its improper place of definition.
>

OK, I will try to fix it.


>
>> @@ -1550,10 +1462,30 @@ init_hw_perf_events(void)
>>                 return -ENODEV;
>>         }
>>
>> -       if (mipspmu)
>> -               pr_cont("%s PMU enabled, %d counters available to each "
>> -                       "CPU, irq %d%s\n", mipspmu->name, counters, irq,
>> -                       irq<  0 ? " (share with timer interrupt)" : "");
>> +       mipspmu.num_counters = counters;
>> +       mipspmu.irq = irq;
>> +
>> +       if (read_c0_perfctrl0()&  M_PERFCTL_WIDE) {
>> +               mipspmu.max_period = (1ULL<<  63) - 1;
>> +               mipspmu.valid_count = (1ULL<<  63) - 1;
>> +               mipspmu.overflow = 1ULL<<  63;
>> +               mipspmu.read_counter = mipsxx_pmu_read_counter_64;
>> +               mipspmu.write_counter = mipsxx_pmu_write_counter_64;
>> +               counter_bits = 64;
>> +       } else {
>> +               mipspmu.max_period = (1ULL<<  32) - 1;
>> +               mipspmu.valid_count = (1ULL<<  31) - 1;
>> +               mipspmu.overflow = 1ULL<<  31;
>> +               mipspmu.read_counter = mipsxx_pmu_read_counter;
>> +               mipspmu.write_counter = mipsxx_pmu_write_counter;
>> +               counter_bits = 32;
>> +       }
>> +
>> +       on_each_cpu(reset_counters, (void *)(long)counters, 1);
>> +
>> +       pr_cont("%s PMU enabled, %d %d-bit counters available to each "
>> +               "CPU, irq %d%s\n", mipspmu.name, counters, counter_bits, irq,
>> +               irq<  0 ? " (share with timer interrupt)" : "");
>>
>>         perf_pmu_register(&pmu);
>>
>
> perf_pmu_register(&pmu) should be now changed to perf_pmu_register(&pmu,
> "cpu", PERF_TYPE_RAW).

Yes, I already have that locally.

David Daney
