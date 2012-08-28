Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2012 11:41:25 +0200 (CEST)
Received: from [124.207.24.138] ([124.207.24.138]:42376 "EHLO
        mail.ss.pku.edu.cn" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903718Ab2H1JlM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Aug 2012 11:41:12 +0200
Received: from mail-iy0-f177.google.com (mail-iy0-f177.google.com [209.85.210.177])
        (Authenticated sender: mlin@ss.pku.edu.cn)
        by mail.ss.pku.edu.cn (Postfix) with ESMTPA id 7B6E0DBCC9;
        Tue, 28 Aug 2012 17:41:02 +0800 (CST)
Received: by iaai1 with SMTP id i1so10692885iaa.36
        for <multiple recipients>; Tue, 28 Aug 2012 02:40:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.181.136 with SMTP id dw8mr13161930igc.31.1346146859276;
 Tue, 28 Aug 2012 02:40:59 -0700 (PDT)
Received: by 10.50.84.104 with HTTP; Tue, 28 Aug 2012 02:40:59 -0700 (PDT)
In-Reply-To: <20120828081353.GB23288@linux-mips.org>
References: <CAF1ivSYqNpzZD5U6Ne_FL_gDmPC0aETb7Gt3uyWZzNp9tTMP5Q@mail.gmail.com>
        <20120828081353.GB23288@linux-mips.org>
Date:   Tue, 28 Aug 2012 17:40:59 +0800
Message-ID: <CAF1ivSbCYW3Dfs7Ej=XdAhdk5Xc+enoY-wKmwZSZ4bJ+HmPa8g@mail.gmail.com>
Subject: Re: panic in hrtimer_run_queues
From:   Lin Ming <mlin@ss.pku.edu.cn>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, noor.mubeen@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlin@ss.pku.edu.cn
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Aug 28, 2012 at 4:13 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Aug 28, 2012 at 09:42:51AM +0800, Lin Ming wrote:
>
>> Hi list,
>>
>> I'm working on a board running 2.6.30 kernel.
>> The panic log is attached in the end.
>>
>> 8002c098:       0c00aeaa        jal     8002baa8 <__remove_hrtimer>
>> 8002c09c:       00003821        move    a3,zero
>> 8002c0a0:       8e220020        lw      v0,32(s1)
>> 8002c0a4:       0040f809        jalr    v0
>> 8002c0a8:       02202021        move    a0,s1
>> 8002c0ac:       02002821        move    a1,s0
>> ------> panic happens here.
>> But this instruction just move data between registers.
>> How could it cause memory access panic?
>
> in case of a jal or jalr instruction the return address will point to the
> instruction of the jal(r) instruction plus 2 instruction as here.  This
> is where in case of a successful return from the subroutine execution
> would continue.
>
> But in your case v0 (that's register $2) contains 0 and it's been loaded
> from address 32(s1) before, so it would appear that memory at that
> address has either been overwritten or not initialized.

You are right. It should be panic at 8002c0a4.

$ addr2line -i -e vmlinux 8002c0a4
linux-2.6.30/kernel/hrtimer.c:1164

Line 1164:
fn = timer->function;
restart = fn(timer);   <---- line 1164

Seems "fn" is corrupted....

Thanks for the info!

static void __run_hrtimer(struct hrtimer *timer)
{
        struct hrtimer_clock_base *base = timer->base;
        struct hrtimer_cpu_base *cpu_base = base->cpu_base;
        enum hrtimer_restart (*fn)(struct hrtimer *);
        int restart;

        WARN_ON(!irqs_disabled());

        debug_hrtimer_deactivate(timer);
        __remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK, 0);
        timer_stats_account_hrtimer(timer);
        fn = timer->function;

        /*
         * Because we run timers from hardirq context, there is no chance
         * they get migrated to another cpu, therefore its safe to unlock
         * the timer base.
         */
        spin_unlock(&cpu_base->lock);
        restart = fn(timer);     <----------- line 1164
        spin_lock(&cpu_base->lock);

        /*
         * Note: We clear the CALLBACK bit after enqueue_hrtimer and
         * we do not reprogramm the event hardware. Happens either in
         * hrtimer_start_range_ns() or in hrtimer_interrupt()
         */
        if (restart != HRTIMER_NORESTART) {
                BUG_ON(timer->state != HRTIMER_STATE_CALLBACK);
                enqueue_hrtimer(timer, base);
        }
        timer->state &= ~HRTIMER_STATE_CALLBACK;
}


>
>   Ralf
