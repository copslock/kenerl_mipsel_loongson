Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2010 08:17:17 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:63077 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491039Ab0KSHRN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Nov 2010 08:17:13 +0100
Received: by wwb34 with SMTP id 34so214371wwb.24
        for <multiple recipients>; Thu, 18 Nov 2010 23:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=717P+WGYG6KnRcP3Nk2/7bHuoWs4hZFdykzCeaGHs2U=;
        b=KGLYEeGAsxH2sAyJQNHbUbIraIbP4ILn2MMaU+/fZ0/k/qs7NJp+ZsYeNihDjSbdp5
         mTYW771Q6VJwBMr1APT5cyUGAS/yTK/frm8DOtgr04pMvN3QlCneNxzOGivZaaiZD6b3
         KG1ZRunWFtYjBuPiHTcy3ZNpMr8wSNuDfMJks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JB/MF0u9e9OvkSkEqnrXLax+vhU+qI9zxISy0218Mmu1nF16frdeUTszuw5GP/AmX1
         WUHlfpRQsmRDzeKrn5Lqbc8qMqVPRyKFkKxYreXcDBA+GHqzPdYpJSZM2agckprbWrHY
         YT/Rn2U/wSqsIemE2BTsq2L6rCJISrXYV5b5U=
MIME-Version: 1.0
Received: by 10.216.45.199 with SMTP id p49mr514217web.29.1290151021245; Thu,
 18 Nov 2010 23:17:01 -0800 (PST)
Received: by 10.216.236.138 with HTTP; Thu, 18 Nov 2010 23:16:38 -0800 (PST)
In-Reply-To: <1290072458.18450.1.camel@e102144-lin.cambridge.arm.com>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
        <1290063401-25440-6-git-send-email-dengcheng.zhu@gmail.com>
        <1290072458.18450.1.camel@e102144-lin.cambridge.arm.com>
Date:   Fri, 19 Nov 2010 15:16:38 +0800
Message-ID: <AANLkTin7+-f662m=mbv_XiVxETx-5Q0PnSDhhM9GVYis@mail.gmail.com>
Subject: Re: [PATCH 5/5] MIPS/Perf-events: Use unsigned delta for right shift
 in event update
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
X-archive-position: 28424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks. The commit you pointed out was also in this patch set (#3).

But I think the return value should stick to 0, not 1. Something out of my
consideration?


Deng-Cheng


2010/11/18 Will Deacon <will.deacon@arm.com>:
> On Thu, 2010-11-18 at 06:56 +0000, Deng-Cheng Zhu wrote:
>> Leverage the commit for ARM by Will Deacon:
>>
>> 446a5a8b1eb91a6990e5c8fe29f14e7a95b69132
>>         ARM: 6205/1: perf: ensure counter delta is treated as unsigned
>>
>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
>> ---
>>  arch/mips/kernel/perf_event.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
>> index 345232a..0f1cdf5 100644
>> --- a/arch/mips/kernel/perf_event.c
>> +++ b/arch/mips/kernel/perf_event.c
>> @@ -169,7 +169,7 @@ static void mipspmu_event_update(struct perf_event *event,
>>         unsigned long flags;
>>         int shift = 64 - TOTAL_BITS;
>>         s64 prev_raw_count, new_raw_count;
>> -       s64 delta;
>> +       u64 delta;
>>
>>  again:
>>         prev_raw_count = local64_read(&hwc->prev_count);
>> --
>> 1.7.1
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> You might also want to look at commit 65b4711f if you based
> the MIPS port on the old ARM code.
>
> Thanks,
>
> Will
>
> --
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
>
> -- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
>
>
