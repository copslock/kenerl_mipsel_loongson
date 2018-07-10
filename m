Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 06:26:50 +0200 (CEST)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:38120
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbeGJE0lW0eM0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jul 2018 06:26:41 +0200
Received: by mail-it0-x243.google.com with SMTP id v71-v6so18963455itb.3;
        Mon, 09 Jul 2018 21:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XhD9eiHNeRL8E0pzbWEs43rDPTbjybVbhpbGnbaVICc=;
        b=dwO9VbXcERMzlC2SUsHGBRvGwnnbCTwoh6JqZlZS42i8ZOeUuX4o/oT2zgukGaV1X5
         jGwmN54LZx1yGXCgsfjc6cRvM8ZmiRqY2pyh430abBgnv0sDjYuC7m9o8Voti96ZfUuA
         Gh4LfHC31VSlp8+QiQ/Ogo7wXKkbovG7118nketZKLPIfEdxCx0tynHr0uchzl1HQ6Qd
         ksWzQUKPKsmP2Pw/95BvyjcnE+PrWrZxwkbWjZHXAGaZowFPCDvppT/0uqX3ty+JExAI
         i811YUiTN1UmzVIm3tPxX/0F/D0pjVzqCxNQU5yPAI3FTg+5M4oe21RUQCelKrKNB1hB
         92DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XhD9eiHNeRL8E0pzbWEs43rDPTbjybVbhpbGnbaVICc=;
        b=XOrMRZ920MqRFWHtk9enQFNpoFJJ+mRZt52HWFKZzj/a8aNPQj2DdPj8BYToGWHmDJ
         vNB3mYT1r+f+2XzPVuawrSYmttM80QCQqcdyrGvDRaekDF7C9D7AT3BuDTMvdRcnsUXm
         jI0fhU2oWfUXDJPEQY2asBiADeJ4wa7KOpjRnxhagQL7qD1inSKcOsTuwe5MCjDTrU6q
         hyoERJAJzLJyEqk5iGAAJRu7goegQjPbRg8EY7Ts/wEJ6Hm03e/ZAIVxcAC8FrNfXV/4
         RRqJDuIqxFgP0nU1x/iZpnCBEPNEWt0G4Ao/A4uckF5FaO7brpggkK2kyXpDNn0yOCtC
         qfdg==
X-Gm-Message-State: AOUpUlFc7gA5NCuWlCqnZUJIFIn5j+kpNUiS0b3Y8C9RE/S+UKfxnYTR
        AqKzmLTzKCiGX/aP4d6aACmUhBUqA8Oi2uF7DWU=
X-Google-Smtp-Source: AAOMgpcqRsbHPHVGbfJJPlFkADcC4ObMbbUJoC8meBbp/ZjVdLW4dIHTqxVMubRpM9g1jBiZO5ufEUNaa4hv2OersV8=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr2893457iti.135.1531196795136;
 Mon, 09 Jul 2018 21:26:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:3757:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 21:26:34 -0700 (PDT)
In-Reply-To: <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com> <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Tue, 10 Jul 2018 12:26:34 +0800
X-Google-Sender-Auth: flr9zZnDnypc24E2yy1xGpxkGrI
Message-ID: <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
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
X-archive-position: 64750
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

Hi, Paul and Peter,

I think we find the real root cause, READ_ONCE() doesn't need any
barriers, the problematic code is queued_spin_lock_slowpath() in
kernel/locking/qspinlock.c:

        if (old & _Q_TAIL_MASK) {
                prev = decode_tail(old);

                /* Link @node into the waitqueue. */
                WRITE_ONCE(prev->next, node);

                pv_wait_node(node, prev);
                arch_mcs_spin_lock_contended(&node->locked);

                /*
                 * While waiting for the MCS lock, the next pointer may have
                 * been set by another lock waiter. We optimistically load
                 * the next pointer & prefetch the cacheline for writing
                 * to reduce latency in the upcoming MCS unlock operation.
                 */
                next = READ_ONCE(node->next);
                if (next)
                        prefetchw(next);
        }

After WRITE_ONCE(prev->next, node); arch_mcs_spin_lock_contended()
enter a READ_ONCE() loop, so the effect of WRITE_ONCE() is invisible
by other cores because of the write buffer. As a result,
arch_mcs_spin_lock_contended() will wait for ever because the waiters
of prev->next will wait for ever. I think the right way to fix this is
flush SFB after this WRITE_ONCE(), but I don't have a good solution:
1, MIPS has wbflush() which can be used to flush SFB, but other archs
don't have;
2, Every arch has mb(), and add mb() after WRITE_ONCE() can actually
solve Loongson's problem, but in syntax, mb() is different from
wbflush();
3, Maybe we can define a Loongson-specific WRITE_ONCE(), but not every
WRITE_ONCE() need wbflush(), we only need wbflush() between
WRITE_ONCE() and a READ_ONCE() loop.

Any ideas?

Huacai


On Tue, Jul 10, 2018 at 12:49 AM, Paul Burton <paul.burton@mips.com> wrote:
> Hi Huacai,
>
> On Mon, Jul 09, 2018 at 10:26:38AM +0800, Huacai Chen wrote:
>> After commit 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire()
>> in MCS spin loop") Loongson-3 fails to boot. This is because Loongson-3
>> has SFB (Store Fill Buffer) and the weak-ordering may cause READ_ONCE()
>> to get an old value in a tight loop. So in smp_cond_load_acquire() we
>> need a __smp_rmb() before the READ_ONCE() loop.
>>
>> This patch introduce a Loongson-specific smp_cond_load_acquire(). And
>> it should be backported to as early as linux-4.5, in which release the
>> smp_cond_acquire() is introduced.
>>
>> There may be other cases where memory barriers is needed, we will fix
>> them one by one.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/include/asm/barrier.h | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
>> index a5eb1bb..e8c4c63 100644
>> --- a/arch/mips/include/asm/barrier.h
>> +++ b/arch/mips/include/asm/barrier.h
>> @@ -222,6 +222,24 @@
>>  #define __smp_mb__before_atomic()    __smp_mb__before_llsc()
>>  #define __smp_mb__after_atomic()     smp_llsc_mb()
>>
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +/* Loongson-3 need a __smp_rmb() before READ_ONCE() loop */
>> +#define smp_cond_load_acquire(ptr, cond_expr)                        \
>> +({                                                           \
>> +     typeof(ptr) __PTR = (ptr);                              \
>> +     typeof(*ptr) VAL;                                       \
>> +     __smp_rmb();                                            \
>> +     for (;;) {                                              \
>> +             VAL = READ_ONCE(*__PTR);                        \
>> +             if (cond_expr)                                  \
>> +                     break;                                  \
>> +             cpu_relax();                                    \
>> +     }                                                       \
>> +     __smp_rmb();                                            \
>> +     VAL;                                                    \
>> +})
>> +#endif       /* CONFIG_CPU_LOONGSON3 */
>
> The discussion on v1 of this patch [1] seemed to converge on the view
> that Loongson suffers from the same problem as ARM platforms which
> enable the CONFIG_ARM_ERRATA_754327 workaround, and that we might
> require a similar workaround.
>
> Is there a reason you've not done that, and instead tweaked your patch
> that's specific to the smp_cond_load_acquire() case? I'm not comfortable
> with fixing just this one case when there could be many similar
> problematic pieces of code you just haven't hit yet.
>
> Please also keep the LKMM maintainers on copy for this - their feedback
> will be valuable & I'll be much more comfortable applying a workaround
> for Loongson's behavior here if it's one that they're OK with.
>
> Thanks,
>     Paul
>
> [1] https://www.linux-mips.org/archives/linux-mips/2018-06/msg00139.html
