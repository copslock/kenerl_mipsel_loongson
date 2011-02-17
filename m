Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 16:26:39 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:35509 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491104Ab1BQP0e convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Feb 2011 16:26:34 +0100
Received: by gxk21 with SMTP id 21so1022001gxk.36
        for <multiple recipients>; Thu, 17 Feb 2011 07:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tAiq91hXcOVrPgC/BCUMoiUCLW5yUJPx5jcN/zFcZOE=;
        b=QNFjEfqYl6U3OvoGBAcvIBhhbHA1yOpOoul84GRjr6xO4dJvduxy+JrH1FEKFxSqND
         0FXdyznzvFsmRRMf4Ps78cud8UrmQ01HibhU6gAG+LvujdlqWAJBdjyRHeNiYJotKxdq
         sdGG3Kf47kaiZ9V8ynopPfOHlmtDvplDc6vys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KaNHRxBcAN19I92MZHngNZAhjv7TuXfEBGZMqtv2sEXMwg/YyRhQuahcIiz1Q0ACYA
         EbS4xk1B6d5aFE+tRObv52KcjmSQ4JSfmPqzV2LENZIXzIS1wn82jha0z5xoloLyduSG
         vMitw/vufAaXRVt1ljV0fpqkPUTIcW+kgycWE=
MIME-Version: 1.0
Received: by 10.151.158.14 with SMTP id k14mr2449360ybo.357.1297956387884;
 Thu, 17 Feb 2011 07:26:27 -0800 (PST)
Received: by 10.147.124.7 with HTTP; Thu, 17 Feb 2011 07:26:27 -0800 (PST)
In-Reply-To: <20110217133559.GA12732@linux-mips.org>
References: <1295650776-28444-1-git-send-email-ddaney@caviumnetworks.com>
        <1295650776-28444-5-git-send-email-ddaney@caviumnetworks.com>
        <AANLkTimFnBJeU7BT6ARM=+KSod0UB-XFZTxgWWh1N=i2@mail.gmail.com>
        <4D3F68BE.5080803@caviumnetworks.com>
        <AANLkTim54xV64utR0GdS1r4_LBoAjEOHH9_=TYSLSqMF@mail.gmail.com>
        <4D41BC6B.8010408@caviumnetworks.com>
        <AANLkTi=R86zBH8ZY+CdGyeXsSd0-yHdRVVx0ZWTJf4qe@mail.gmail.com>
        <AANLkTikTV-=A8H=h_F+025VB37tHSmxpsNCGndi_dAFW@mail.gmail.com>
        <20110217133559.GA12732@linux-mips.org>
Date:   Thu, 17 Feb 2011 23:26:27 +0800
Message-ID: <AANLkTi=60AK4S3Gwnc8FaarKdJ0O2MV7Tvu8YmOAj7ZO@mail.gmail.com>
Subject: [PATCH v2 4/4] MIPS: perf: Add support for 64-bit perf counters.
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8BIT
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Since another function mipsxx_pmu_read_counter_64() has already been
defined, the counter wide judgement should not be needed here. And
yes, U32_MASK is right here to zero out the upper 32 bits of the
64-bit return value.

Deng-Cheng


在 2011年2月17日星期四，Ralf Baechle <ralf@linux-mips.org> 写道：
> On Thu, Feb 17, 2011 at 06:46:39PM +0800, Deng-Cheng Zhu wrote:
>
>> The reason of the perf-record failure on 32bit platforms is that the 32bit
>> counter read function mipsxx_pmu_read_counter() returns wrong 64bit values.
>> For example, the counter value 0x12345678 will be returned as
>> 0xffffffff12345678. So in mipspmu_event_update(), the delta will be wrong.
>> So here's a possible fix for your reference:
>>
>> --- a/arch/mips/kernel/perf_event_mipsxx.c
>> +++ b/arch/mips/kernel/perf_event_mipsxx.c
>> @@ -184,19 +184,21 @@ static unsigned int
>> mipsxx_pmu_swizzle_perf_idx(unsigned int idx)
>>         return idx;
>>  }
>>
>> +#define U32_MASK 0xffffffff
>> +
>>  static u64 mipsxx_pmu_read_counter(unsigned int idx)
>>  {
>>         idx = mipsxx_pmu_swizzle_perf_idx(idx);
>>
>>         switch (idx) {
>>         case 0:
>> -               return read_c0_perfcntr0();
>> +               return read_c0_perfcntr0() & U32_MASK;
>>         case 1:
>> -               return read_c0_perfcntr1();
>> +               return read_c0_perfcntr1() & U32_MASK;
>>         case 2:
>> -               return read_c0_perfcntr2();
>> +               return read_c0_perfcntr2() & U32_MASK;
>>         case 3:
>> -               return read_c0_perfcntr3();
>> +               return read_c0_perfcntr3() & U32_MASK;
>
> read_c0_perfctrl0 etc. are defined in mipsregs.h as 32-bit reads returning
> a signed int.  That was ok on 32-bit kernels.  To support the optional
> 64-bit counters the code will have to be changed to something like:
>
> static u64 mipsxx_pmu_read_counter(unsigned int idx)
> {
>         idx = mipsxx_pmu_swizzle_perf_idx(idx);
>
>         switch (idx) {
>         case 0:
>                 if (read_c0_perfctrl0() & M_PERFCTL_WIDE)
>                         return read_c0_64_bit_perfcntr0();
>                 else
>                         return read_c0_32_bit_perfcntr0();
>         case 1:
>                 if (read_c0_perfctrl1() & M_PERFCTL_WIDE)
>                         return read_c0_64_bit_perfcntr1();
>                 else
>                         return read_c0_32_bit_perfcntr1();
> ...
>
> And read_c0_32_bit_perfcntrX need to zero-extend their return value.
>
>   Ralf
>
