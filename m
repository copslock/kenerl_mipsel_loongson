Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2010 12:30:23 +0100 (CET)
Received: from mail-ww0-f54.google.com ([74.125.82.54]:62638 "EHLO
        mail-ww0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491198Ab0KSLaP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Nov 2010 12:30:15 +0100
Received: by wwi17 with SMTP id 17so2675601wwi.23
        for <multiple recipients>; Fri, 19 Nov 2010 03:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9WWMP7VaLk1hrVMuEjnpl5wRHnvbBFrmMg4iMawwZZo=;
        b=OHVpP0CzhnugVnB7EcnFpmJcgXRS341G79lHqLik22e5MkAU1G56njMhxYq5QPM3Ka
         l+ooK/C1TaRi/s0wbu7oMg5/Vm0emeOYW9ifSKVUK6Crx72RGcxhux6PhQchQVR5iS0s
         h9QjyUfW3xIKwdLWpolcfKMOBUloOijb5ZxgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PdaxowgncmQWzKHwuY24euDca/WQPMG9YwDuEOfRX29GZneHcquv8keYkW43FFWlxu
         zeJarmTEoBytNKPenQ8IsozFHfmoUqZnai4UCLEEfb1rnY2PKZHFmv2EPoypc8t39HoG
         MDhC5G2qqSze2phUimbN0oa8nFDlypZGDIRm0=
MIME-Version: 1.0
Received: by 10.216.176.20 with SMTP id a20mr1730781wem.14.1290166208798; Fri,
 19 Nov 2010 03:30:08 -0800 (PST)
Received: by 10.216.236.138 with HTTP; Fri, 19 Nov 2010 03:30:08 -0800 (PST)
In-Reply-To: <1290159806.9342.7.camel@e102144-lin.cambridge.arm.com>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
        <1290063401-25440-4-git-send-email-dengcheng.zhu@gmail.com>
        <1290159806.9342.7.camel@e102144-lin.cambridge.arm.com>
Date:   Fri, 19 Nov 2010 19:30:08 +0800
Message-ID: <AANLkTikdLqo0-jkLkY-jGxurKMnmv+gb0VWWDZu6TOwd@mail.gmail.com>
Subject: Re: [PATCH 3/5] MIPS/Perf-events: Check event state in validate_event()
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Ah, I see. Thanks for your explanation.

But by doing this, I think we need to modify validate_group() as well.
Consider a group which has all its events either not for this PMU or in
OFF/Error state. Then the last validate_event() in validate_group() does
not work. Right? So, how about the following:

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 1ee44a3..4010bc0 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -486,8 +486,8 @@ static int validate_event(struct cpu_hw_events *cpuc,
 {
 	struct hw_perf_event fake_hwc = event->hw;

-	if (event->pmu && event->pmu != &pmu)
-		return 0;
+	if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
+		return 1;

 	return mipspmu->alloc_counter(cpuc, &fake_hwc) >= 0;
 }
@@ -496,6 +496,7 @@ static int validate_group(struct perf_event *event)
 {
 	struct perf_event *sibling, *leader = event->group_leader;
 	struct cpu_hw_events fake_cpuc;
+	struct hw_perf_event fake_hwc = event->hw;

 	memset(&fake_cpuc, 0, sizeof(fake_cpuc));

@@ -507,10 +508,12 @@ static int validate_group(struct perf_event *event)
 			return -ENOSPC;
 	}

-	if (!validate_event(&fake_cpuc, event))
+	if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
+		return -EINVAL;
+	else if (mipspmu->alloc_counter(&fake_cpuc, &fake_hwc) < 0)
 		return -ENOSPC;
-
-	return 0;
+	else
+		return 0;
 }

 /* This is needed by specific irq handlers in perf_event_*.c */


Thanks,

Deng-Cheng


2010/11/19 Will Deacon <will.deacon@arm.com>:
> Hi Deng-Cheng,
>
> On Thu, 2010-11-18 at 06:56 +0000, Deng-Cheng Zhu wrote:
>> Ignore events that are not for this PMU or are in off/error state.
>>
> Sorry I didn't see this before, thanks for pointing out that you
> had included it for MIPS.
>
>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
>> ---
>>  arch/mips/kernel/perf_event.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
>> index 1ee44a3..9c6442a 100644
>> --- a/arch/mips/kernel/perf_event.c
>> +++ b/arch/mips/kernel/perf_event.c
>> @@ -486,7 +486,7 @@ static int validate_event(struct cpu_hw_events *cpuc,
>>  {
>>         struct hw_perf_event fake_hwc = event->hw;
>>
>> -       if (event->pmu && event->pmu != &pmu)
>> +       if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
>>                 return 0;
>>
>>         return mipspmu->alloc_counter(cpuc, &fake_hwc) >= 0;
>
> So this is the opposite of what we're doing on ARM. Our
> approach is to ignore events that are OFF (or in the ERROR
> state) or that belong to a different PMU. We do this by
> allowing them to *pass* validation (i.e. by returning 1 above).
> This means that we won't unconditionally fail a mixed event group.
>
> x86 does something similar in the collect_events function.
>
> Will
>
> --
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
>
> -- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
>
>
