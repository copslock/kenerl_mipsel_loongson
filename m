Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2018 03:15:56 +0200 (CEST)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:33458
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993024AbeGRBPxHpRjl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jul 2018 03:15:53 +0200
Received: by mail-it0-x243.google.com with SMTP id y124-v6so16113612itc.0;
        Tue, 17 Jul 2018 18:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KkCPA4iVjt5oodRnLb1cD13F+gfTwx1/KZRAmRFN1Ws=;
        b=qK6jb0epDhhUhdAnA/fZB3f9Z3VCep3x0DyBFictItsYOLPhxvcUt9VvUHGyYwMcV5
         1X7d8SxG+Z6P6N8uvkFzOjQtBkLHXGh2Xl3PaqHepRnCHyopLv5MgjwdDVjPuu+xxTal
         l1zEnOqte7oev42P0GLo4UZgkxdAnpLeUQxIRdAC7RUPUARwg1S00SYXp4yqL6kycI8F
         +kJUo/K1J+cHvHaAFHxQC1kKuZgK3RoqcqWH68TD1HZihZg4LhGoK/82T2tcnm5D+t8m
         IEWaktDYbg95Y8CnXXok6oI9dwg7m7zWUoE2lUpgPTOCwFs5lSWDe0tnARjImKsG469r
         BWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KkCPA4iVjt5oodRnLb1cD13F+gfTwx1/KZRAmRFN1Ws=;
        b=LT3bL7GKhkaMMCzxIyMEfrv61XDrkmGzHa95rB96RyJPTZfT3wlIJs4zR5XEjOMLlQ
         D9AE3S5TfNPqiQoYHTctNXayP/frjKiseYOBzkZuJvqJ27xEfzz83R4Butpco3E/ct1u
         BN88qZM2/ptxcTYgcF3YyKVtX4NuzLK0m2jB5qByZQPz+k2N9malAeytpIm11rr3jzEG
         H0Yqn7VEaELUKEq07qfrIi2bww41vndLHPNqAJQzLkw7oRYZeYBBSgGw1esagUZTZX/d
         27LEQzwB46isYUHP5MSb29qDxaGzS3E3MiO6nJt5Dbid2LSYz2heBL/trbAToS+5ctjv
         9PlQ==
X-Gm-Message-State: AOUpUlGN5xxqU2iwQ6Zv/hSicEaR8mIYV/wD7Zy74vApZyJx0igua0Of
        nTV0XxDAuUuKgAU1r5LCzaXK5A62lp+uRYKV92M=
X-Google-Smtp-Source: AAOMgpf0VOFwWm/Zs+9fyLuVTeTKB5dkQKa91gWhKWy83huHSnIvYKshtsS2zR03P9W6y2b4QqArtMbiqu652cI0uZk=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr363968itb.16.1531876546766;
 Tue, 17 Jul 2018 18:15:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:3757:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 18:15:46
 -0700 (PDT)
In-Reply-To: <20180717175232.ea7pi2bqswnzmznc@pburton-laptop>
References: <1531467477-9952-1-git-send-email-chenhc@lemote.com> <20180717175232.ea7pi2bqswnzmznc@pburton-laptop>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Wed, 18 Jul 2018 09:15:46 +0800
X-Google-Sender-Auth: UqQjVUCJ3GfsGIrQVJeJ2SvMIwA
Message-ID: <CAAhV-H5_==ZdKTOJTNXkRBTqmr5cxFvcaVabfNarEiQt_LvHZQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Change definition of cpu_relax() for Loongson-3
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

On Wed, Jul 18, 2018 at 1:52 AM, Paul Burton <paul.burton@mips.com> wrote:
> Hi Huacai,
>
> On Fri, Jul 13, 2018 at 03:37:57PM +0800, Huacai Chen wrote:
>> Linux expects that if a CPU modifies a memory location, then that
>> modification will eventually become visible to other CPUs in the system.
>>
>> On Loongson-3 processor with SFB (Store Fill Buffer), loads may be
>> prioritised over stores so it is possible for a store operation to be
>> postponed if a polling loop immediately follows it. If the variable
>> being polled indirectly depends on the outstanding store [for example,
>> another CPU may be polling the variable that is pending modification]
>> then there is the potential for deadlock if interrupts are disabled.
>> This deadlock occurs in qspinlock code.
>>
>> This patch changes the definition of cpu_relax() to smp_mb() for
>> Loongson-3, forcing a flushing of the SFB on SMP systems before the
>> next load takes place. If the Kernel is not compiled for SMP support,
>> this will expand to a barrier() as before.
>>
>> References: 534be1d5a2da940 (ARM: 6194/1: change definition of cpu_relax() for ARM11MPCore)
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/include/asm/processor.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
>> index af34afb..a8c4a3a 100644
>> --- a/arch/mips/include/asm/processor.h
>> +++ b/arch/mips/include/asm/processor.h
>> @@ -386,7 +386,17 @@ unsigned long get_wchan(struct task_struct *p);
>>  #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
>>  #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
>>
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +/*
>> + * Loongson-3's SFB (Store-Fill-Buffer) may get starved when stuck in a read
>> + * loop. Since spin loops of any kind should have a cpu_relax() in them, force
>> + * a Store-Fill-Buffer flush from cpu_relax() such that any pending writes will
>> + * become available as expected.
>> + */
>
> I think "may starve writes" or "may queue writes indefinitely" would be
> clearer than "may get starved".
Need I change the comment and resend? Or you change the comment and get merged?

Huacai

>
>> +#define cpu_relax()  smp_mb()
>> +#else
>>  #define cpu_relax()  barrier()
>> +#endif
>>
>>  /*
>>   * Return_address is a replacement for __builtin_return_address(count)
>> --
>> 2.7.0
>
> Apart from the comment above though this looks better to me.
>
> Re-copying the LKMM maintainers - are you happy(ish) with this?
>
> Thanks,
>     Paul
