Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 11:46:49 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:35352 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491075Ab1BQKqp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Feb 2011 11:46:45 +0100
Received: by yxd30 with SMTP id 30so1031536yxd.36
        for <multiple recipients>; Thu, 17 Feb 2011 02:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7+Iv33eDGIqd56LY4t8zINVZHptzazasEyezLvA7ghs=;
        b=Lcl2fwL32sDNLfczZl/EAaoEXFqtZ1sfdhQ3FH2zomBp+hfdvNyshnuWHnZrDRNtqP
         PiYv26oqaS3biEnqjysx4fohBYRvts3KxRdHFKlca9TtQguTxEnoEHNwHIh4Eps1R8u+
         zGUgzyel/ra2KG460Z59459kYtOSoDC6ann4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DjFcniCO7jiAQGiubJbJO6lnUULqPHFwF6oKOML7aA4EYw/d83vpS7UpH2KgDI2OeF
         5W60pfOCb/oULy4zwIM+HeM3578dVMVqYVJ2OG/w6m4Lc4pOqOgoPd3t4z24ZrqJjRGZ
         gmeJX7MEU78dG9CR5He4lKkNOW+dmeltJotjs=
MIME-Version: 1.0
Received: by 10.151.149.8 with SMTP id b8mr2161116ybo.300.1297939599158; Thu,
 17 Feb 2011 02:46:39 -0800 (PST)
Received: by 10.147.41.7 with HTTP; Thu, 17 Feb 2011 02:46:39 -0800 (PST)
In-Reply-To: <AANLkTi=R86zBH8ZY+CdGyeXsSd0-yHdRVVx0ZWTJf4qe@mail.gmail.com>
References: <1295650776-28444-1-git-send-email-ddaney@caviumnetworks.com>
        <1295650776-28444-5-git-send-email-ddaney@caviumnetworks.com>
        <AANLkTimFnBJeU7BT6ARM=+KSod0UB-XFZTxgWWh1N=i2@mail.gmail.com>
        <4D3F68BE.5080803@caviumnetworks.com>
        <AANLkTim54xV64utR0GdS1r4_LBoAjEOHH9_=TYSLSqMF@mail.gmail.com>
        <4D41BC6B.8010408@caviumnetworks.com>
        <AANLkTi=R86zBH8ZY+CdGyeXsSd0-yHdRVVx0ZWTJf4qe@mail.gmail.com>
Date:   Thu, 17 Feb 2011 18:46:39 +0800
Message-ID: <AANLkTikTV-=A8H=h_F+025VB37tHSmxpsNCGndi_dAFW@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] MIPS: perf: Add support for 64-bit perf counters.
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, David


The reason of the perf-record failure on 32bit platforms is that the 32bit
counter read function mipsxx_pmu_read_counter() returns wrong 64bit values.
For example, the counter value 0x12345678 will be returned as
0xffffffff12345678. So in mipspmu_event_update(), the delta will be wrong.
So here's a possible fix for your reference:

--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -184,19 +184,21 @@ static unsigned int
mipsxx_pmu_swizzle_perf_idx(unsigned int idx)
        return idx;
 }

+#define U32_MASK 0xffffffff
+
 static u64 mipsxx_pmu_read_counter(unsigned int idx)
 {
        idx = mipsxx_pmu_swizzle_perf_idx(idx);

        switch (idx) {
        case 0:
-               return read_c0_perfcntr0();
+               return read_c0_perfcntr0() & U32_MASK;
        case 1:
-               return read_c0_perfcntr1();
+               return read_c0_perfcntr1() & U32_MASK;
        case 2:
-               return read_c0_perfcntr2();
+               return read_c0_perfcntr2() & U32_MASK;
        case 3:
-               return read_c0_perfcntr3();
+               return read_c0_perfcntr3() & U32_MASK;
        default:
                WARN_ONCE(1, "Invalid performance counter number (%d)\n", idx);
                return 0;

In addition, since you removed the use of cpuc->msbs, some code relative to
this logic can be removed:

@@ -370,7 +372,6 @@ static int mipspmu_event_set_period(struct
perf_event *event,
        u64 left = local64_read(&hwc->period_left);
        u64 period = hwc->sample_period;
        int ret = 0;
-       unsigned long flags;

        if (unlikely((left + period) & (1ULL << 63))) {
                /* left underflowed by more than period. */
@@ -393,9 +394,7 @@ static int mipspmu_event_set_period(struct
perf_event *event,

        local64_set(&hwc->prev_count, mipspmu.overflow - left);

-       local_irq_save(flags);
        mipspmu.write_counter(idx, mipspmu.overflow - left);
-       local_irq_restore(flags);

        perf_event_update_userpage(event);

@@ -406,16 +405,12 @@ static void mipspmu_event_update(struct perf_event *event,
                                 struct hw_perf_event *hwc,
                                 int idx)
 {
-       unsigned long flags;
        u64 prev_raw_count, new_raw_count;
        u64 delta;

 again:
        prev_raw_count = local64_read(&hwc->prev_count);
-       local_irq_save(flags);
-       /* Make the counter value be a "real" one. */
        new_raw_count = mipspmu.read_counter(idx);
-       local_irq_restore(flags);

        if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
                                new_raw_count) != prev_raw_count)

And here's a general comment: You are putting the majority of the
implementation in perf_event_mipsxx.c. This will require other CPUs like
Loongson2 to replicate quite a lot code in their corresponding files. I
personally think the original "skeleton + #include perf_event_$cpu.c" is a
better choice. I understand you prefer not using code like
"#if defined(CONFIG_CPU_MIPS32)" on the top of perf_event_$cpu.c, but that
is what other architectures (X86/ARM etc) are doing.


Deng-Cheng


2011/1/28 Deng-Cheng Zhu <dengcheng.zhu@gmail.com>:
> OK. I'll try to use tracing when needed.
>
> The hardware I was using for the test was Malta-R with 34K bitfile
> programed into the FPGA. The CPU frequency is 50MHz.
>
>
> Deng-Cheng
>
>
> 2011/1/28 David Daney <ddaney@caviumnetworks.com>:
>> On 01/26/2011 10:24 PM, Deng-Cheng Zhu wrote:
>>>
>>> Using your attached patch, I experimented -c and -F by 'ls /'. The numbers
>>> I used are 10, 1000 and 100000 for both -c and -F.
>>>
>>> The number of samples I got was 24 all the way. That means the event
>>> period
>>> to sample and the profiling frequency do not affect the results on MIPS32
>>> platform. While working on the old code, the system had the following
>>> results:
>>>
>>> -c 10: The system seems busy dealing with interrupts. And the following
>>> log
>>>        was printed out:
>>>        ================================================
>>>        hda: ide_dma_sff_timer_expiry: DMA status (0x24)
>>>        hda: DMA interrupt recovery
>>>        hda: lost interrupt
>>>        ================================================
>>>        This does need to be fixed later on.
>>> -c 1000: ~11085 samples
>>> -c 100000: ~48 samples ('perf report' still showed some data.)
>>> -F 10: ~118 samples
>>> -F 1000: ~352 samples
>>> -F 100000: ~379 samples
>>>
>>> I'll try to take time to look into the patch to see if anything can be
>>> changed.
>>>
>>
>> I have found it useful to enable tracing, and then placing trace_printk() in
>> mipspmu_event_set_period() to look at the values of:
>>
>> sample_period, period_left that are being used.
>>
>> Also you could use a trace_printk() in mipsxx_pmu_write_counter() to check
>> the value being written to the register.
>>
>> What hardware are you using to test this?  I wonder if there is a board with
>> a 32-bit CPU that I could get access to.
>>
>> David Daney
>>
>>
>>>
>>> Deng-Cheng
>>>
>>>
>>> 2011/1/26 David Daney<ddaney@caviumnetworks.com>:
>>>>
>>>> On 01/24/2011 07:42 PM, Deng-Cheng Zhu wrote:
>>>>>
>>>>> Hi, David
>>>>>
>>>>>
>>>>> This version does fix the problem with 'perf stat'. However, when
>>>>> working
>>>>> with 'perf record', the following happened:
>>>>>
>>>>> -sh-4.0# perf record -f -e cycles -e instructions -e branches \
>>>>>>
>>>>>> -e branch-misses -e r12 find / -name "*sys*">/dev/null
>>>>>
>>>>> [ perf record: Woken up 1 times to write data ]
>>>>> [ perf record: Captured and wrote 0.001 MB perf.data (~53 samples) ]
>>>>
>>>>
>>>> I get the same thing.  What happens if you supply either '-c xxx' or '-f
>>>> xxx'?
>>>>
>>>> I get:octeon:~/linux/tools/perf# ./perf record -e cycles /bin/ls -l /
>>>> total 100
>>>> drwxr-xr-x   2 root root  4096 2010-11-12 11:39 bin
>>>> [...]
>>>> drwxr-xr-x  13 root root  4096 2007-05-25 12:28 var
>>>> [ perf record: Woken up 1 times to write data ]
>>>> [ perf record: Captured and wrote 0.002 MB perf.data (~82 samples) ]
>>>>
>>>> Almost no samples as you got.
>>>>
>>>> But if I do:
>>>>
>>>> octeon:~/linux/tools/perf# ./perf record -F 100000 -e cycles /bin/ls -l /
>>>> total 100
>>>> drwxr-xr-x   2 root root  4096 2010-11-12 11:39 bin
>>>> [...]
>>>> drwxr-xr-x  13 root root  4096 2007-05-25 12:28 var
>>>> [ perf record: Woken up 1 times to write data ]
>>>> [ perf record: Captured and wrote 0.404 MB perf.data (~17653 samples) ]
>>>>
>>>> Look many more samples!
>>>>
>>>> The question is, what is it supposed to do?
>>>>
>>>> If you can get a reasonable number of samples out if you supply -c or
>>>> -F, then I would argue that it is working and the default settings for
>>>> -F are not a good fit for your test case.
>>>>
>>>> I have slightly changed the patch.  You could try the attached version
>>>> instead and tell me the results.
>>>>
>>>>
>>>> David Daney
>>>>
>>>>
>>>>
>>>
>>
>>
>
