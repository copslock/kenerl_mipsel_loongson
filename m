Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 18:26:28 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18279 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491087Ab1BQR0X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 18:26:23 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d5d5a6e0000>; Thu, 17 Feb 2011 09:27:10 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 09:26:18 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 09:26:18 -0800
Message-ID: <4D5D5A39.5040905@caviumnetworks.com>
Date:   Thu, 17 Feb 2011 09:26:17 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 4/4] MIPS: perf: Add support for 64-bit perf counters.
References: <1295650776-28444-1-git-send-email-ddaney@caviumnetworks.com>       <1295650776-28444-5-git-send-email-ddaney@caviumnetworks.com>   <AANLkTimFnBJeU7BT6ARM=+KSod0UB-XFZTxgWWh1N=i2@mail.gmail.com>  <4D3F68BE.5080803@caviumnetworks.com>   <AANLkTim54xV64utR0GdS1r4_LBoAjEOHH9_=TYSLSqMF@mail.gmail.com>  <4D41BC6B.8010408@caviumnetworks.com>   <AANLkTi=R86zBH8ZY+CdGyeXsSd0-yHdRVVx0ZWTJf4qe@mail.gmail.com> <AANLkTikTV-=A8H=h_F+025VB37tHSmxpsNCGndi_dAFW@mail.gmail.com>
In-Reply-To: <AANLkTikTV-=A8H=h_F+025VB37tHSmxpsNCGndi_dAFW@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2011 17:26:18.0026 (UTC) FILETIME=[C93D90A0:01CBCEC7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/17/2011 02:46 AM, Deng-Cheng Zhu wrote:
> Hi, David
>
>
> The reason of the perf-record failure on 32bit platforms is that the 32bit
> counter read function mipsxx_pmu_read_counter() returns wrong 64bit values.
> For example, the counter value 0x12345678 will be returned as
> 0xffffffff12345678. So in mipspmu_event_update(), the delta will be wrong.
> So here's a possible fix for your reference:
>

Thanks for the excellent detective work.  I will generate a fixed patch 
set.  I think we are getting close to something that will work here.

David Daney



> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -184,19 +184,21 @@ static unsigned int
> mipsxx_pmu_swizzle_perf_idx(unsigned int idx)
>          return idx;
>   }
>
> +#define U32_MASK 0xffffffff
> +
>   static u64 mipsxx_pmu_read_counter(unsigned int idx)
>   {
>          idx = mipsxx_pmu_swizzle_perf_idx(idx);
>
>          switch (idx) {
>          case 0:
> -               return read_c0_perfcntr0();
> +               return read_c0_perfcntr0()&  U32_MASK;
>          case 1:
> -               return read_c0_perfcntr1();
> +               return read_c0_perfcntr1()&  U32_MASK;
>          case 2:
> -               return read_c0_perfcntr2();
> +               return read_c0_perfcntr2()&  U32_MASK;
>          case 3:
> -               return read_c0_perfcntr3();
> +               return read_c0_perfcntr3()&  U32_MASK;
>          default:
>                  WARN_ONCE(1, "Invalid performance counter number (%d)\n", idx);
>                  return 0;
>
> In addition, since you removed the use of cpuc->msbs, some code relative to
> this logic can be removed:
>
> @@ -370,7 +372,6 @@ static int mipspmu_event_set_period(struct
> perf_event *event,
>          u64 left = local64_read(&hwc->period_left);
>          u64 period = hwc->sample_period;
>          int ret = 0;
> -       unsigned long flags;
>
>          if (unlikely((left + period)&  (1ULL<<  63))) {
>                  /* left underflowed by more than period. */
> @@ -393,9 +394,7 @@ static int mipspmu_event_set_period(struct
> perf_event *event,
>
>          local64_set(&hwc->prev_count, mipspmu.overflow - left);
>
> -       local_irq_save(flags);
>          mipspmu.write_counter(idx, mipspmu.overflow - left);
> -       local_irq_restore(flags);
>
>          perf_event_update_userpage(event);
>
> @@ -406,16 +405,12 @@ static void mipspmu_event_update(struct perf_event *event,
>                                   struct hw_perf_event *hwc,
>                                   int idx)
>   {
> -       unsigned long flags;
>          u64 prev_raw_count, new_raw_count;
>          u64 delta;
>
>   again:
>          prev_raw_count = local64_read(&hwc->prev_count);
> -       local_irq_save(flags);
> -       /* Make the counter value be a "real" one. */
>          new_raw_count = mipspmu.read_counter(idx);
> -       local_irq_restore(flags);
>
>          if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
>                                  new_raw_count) != prev_raw_count)
>
> And here's a general comment: You are putting the majority of the
> implementation in perf_event_mipsxx.c. This will require other CPUs like
> Loongson2 to replicate quite a lot code in their corresponding files. I
> personally think the original "skeleton + #include perf_event_$cpu.c" is a
> better choice. I understand you prefer not using code like
> "#if defined(CONFIG_CPU_MIPS32)" on the top of perf_event_$cpu.c, but that
> is what other architectures (X86/ARM etc) are doing.
>
>
> Deng-Cheng
>
>
> 2011/1/28 Deng-Cheng Zhu<dengcheng.zhu@gmail.com>:
>> OK. I'll try to use tracing when needed.
>>
>> The hardware I was using for the test was Malta-R with 34K bitfile
>> programed into the FPGA. The CPU frequency is 50MHz.
>>
>>
>> Deng-Cheng
>>
>>
>> 2011/1/28 David Daney<ddaney@caviumnetworks.com>:
>>> On 01/26/2011 10:24 PM, Deng-Cheng Zhu wrote:
>>>>
>>>> Using your attached patch, I experimented -c and -F by 'ls /'. The numbers
>>>> I used are 10, 1000 and 100000 for both -c and -F.
>>>>
>>>> The number of samples I got was 24 all the way. That means the event
>>>> period
>>>> to sample and the profiling frequency do not affect the results on MIPS32
>>>> platform. While working on the old code, the system had the following
>>>> results:
>>>>
>>>> -c 10: The system seems busy dealing with interrupts. And the following
>>>> log
>>>>         was printed out:
>>>>         ================================================
>>>>         hda: ide_dma_sff_timer_expiry: DMA status (0x24)
>>>>         hda: DMA interrupt recovery
>>>>         hda: lost interrupt
>>>>         ================================================
>>>>         This does need to be fixed later on.
>>>> -c 1000: ~11085 samples
>>>> -c 100000: ~48 samples ('perf report' still showed some data.)
>>>> -F 10: ~118 samples
>>>> -F 1000: ~352 samples
>>>> -F 100000: ~379 samples
>>>>
>>>> I'll try to take time to look into the patch to see if anything can be
>>>> changed.
>>>>
>>>
>>> I have found it useful to enable tracing, and then placing trace_printk() in
>>> mipspmu_event_set_period() to look at the values of:
>>>
>>> sample_period, period_left that are being used.
>>>
>>> Also you could use a trace_printk() in mipsxx_pmu_write_counter() to check
>>> the value being written to the register.
>>>
>>> What hardware are you using to test this?  I wonder if there is a board with
>>> a 32-bit CPU that I could get access to.
>>>
>>> David Daney
>>>
>>>
>>>>
>>>> Deng-Cheng
>>>>
>>>>
>>>> 2011/1/26 David Daney<ddaney@caviumnetworks.com>:
>>>>>
>>>>> On 01/24/2011 07:42 PM, Deng-Cheng Zhu wrote:
>>>>>>
>>>>>> Hi, David
>>>>>>
>>>>>>
>>>>>> This version does fix the problem with 'perf stat'. However, when
>>>>>> working
>>>>>> with 'perf record', the following happened:
>>>>>>
>>>>>> -sh-4.0# perf record -f -e cycles -e instructions -e branches \
>>>>>>>
>>>>>>> -e branch-misses -e r12 find / -name "*sys*">/dev/null
>>>>>>
>>>>>> [ perf record: Woken up 1 times to write data ]
>>>>>> [ perf record: Captured and wrote 0.001 MB perf.data (~53 samples) ]
>>>>>
>>>>>
>>>>> I get the same thing.  What happens if you supply either '-c xxx' or '-f
>>>>> xxx'?
>>>>>
>>>>> I get:octeon:~/linux/tools/perf# ./perf record -e cycles /bin/ls -l /
>>>>> total 100
>>>>> drwxr-xr-x   2 root root  4096 2010-11-12 11:39 bin
>>>>> [...]
>>>>> drwxr-xr-x  13 root root  4096 2007-05-25 12:28 var
>>>>> [ perf record: Woken up 1 times to write data ]
>>>>> [ perf record: Captured and wrote 0.002 MB perf.data (~82 samples) ]
>>>>>
>>>>> Almost no samples as you got.
>>>>>
>>>>> But if I do:
>>>>>
>>>>> octeon:~/linux/tools/perf# ./perf record -F 100000 -e cycles /bin/ls -l /
>>>>> total 100
>>>>> drwxr-xr-x   2 root root  4096 2010-11-12 11:39 bin
>>>>> [...]
>>>>> drwxr-xr-x  13 root root  4096 2007-05-25 12:28 var
>>>>> [ perf record: Woken up 1 times to write data ]
>>>>> [ perf record: Captured and wrote 0.404 MB perf.data (~17653 samples) ]
>>>>>
>>>>> Look many more samples!
>>>>>
>>>>> The question is, what is it supposed to do?
>>>>>
>>>>> If you can get a reasonable number of samples out if you supply -c or
>>>>> -F, then I would argue that it is working and the default settings for
>>>>> -F are not a good fit for your test case.
>>>>>
>>>>> I have slightly changed the patch.  You could try the attached version
>>>>> instead and tell me the results.
>>>>>
>>>>>
>>>>> David Daney
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
>
