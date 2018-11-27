Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2018 04:52:49 +0100 (CET)
Received: from mail-ua1-x941.google.com ([IPv6:2607:f8b0:4864:20::941]:39405
        "EHLO mail-ua1-x941.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992554AbeK0DwobW88l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2018 04:52:44 +0100
Received: by mail-ua1-x941.google.com with SMTP id k10so7138122ual.6
        for <linux-mips@linux-mips.org>; Mon, 26 Nov 2018 19:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjUd6rh9Oz+kjGbUZS5mymEL2IOV7D6CriXwQhdsMjU=;
        b=QcPHoePkZX1rXMUYdsVjgFNEGwWi1t+kNzgHHl7f02t25QRLbxRsn38LV2ypdJ1Bet
         e0+PckNHOH/jab6l82SPjcFUnqnD3WPfuEI6R4N3zDp97pjS+o0tFeOUkhgdRhgDOJYl
         Tkr5tUn3ZIRFk36wyPZPqRF9qxyxgtvKyaE9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjUd6rh9Oz+kjGbUZS5mymEL2IOV7D6CriXwQhdsMjU=;
        b=nmjhPXAccAmCZ/Qx9K4p+QmvDLxUDQlA3Ujf5TmctKdkuIgST3cZMWTSjOzw9ljqC4
         FH+3fYkwwXN061oEI/4G4TVBpwYo6K7f4jlr6f9Wrg2jt+g0/3YuKSBapUzpLb6etpB8
         nn3DnUf40r1HlTuT1ygAW33ukyU72GLF4rbzwz8DT2MxxaZjqQJuGHduLxt/FxEXOUka
         aa67Ve8c1AIs6QZTRakLBLzeXTdHljqfMvNxIbgtFR/emmLAfuDXpGoDpNc2POW8ouQ9
         cLUDKt5Us1MskWDv2F+fWX0SX4ddbl9sJWdEViL/Fdr+BNs0ImUr25/qsKQ1R+CKTPNX
         moWQ==
X-Gm-Message-State: AA+aEWay66lIF0qdLAP7VzxXDKk0nvqjTEG2SqAtv/OOwJhBdmUVgEP6
        AR74yD8WJF7TptxRQnFM520CKAjxOcc=
X-Google-Smtp-Source: AFSGD/VcIg0cm7SRMnqjAmq0Ras7dFjoiA864ntIOM0eojNpUeD1VgK+inGTVP3zW2vZM9S36pGryw==
X-Received: by 2002:a9f:364a:: with SMTP id s10mr11736976uad.78.1543290762354;
        Mon, 26 Nov 2018 19:52:42 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id c11sm827778vsd.9.2018.11.26.19.52.40
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 19:52:41 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id y27so12912245vsi.1
        for <linux-mips@linux-mips.org>; Mon, 26 Nov 2018 19:52:40 -0800 (PST)
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr13126300vsc.149.1543290760514;
 Mon, 26 Nov 2018 19:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20181112182659.245726-1-dianders@chromium.org>
 <20181112182659.245726-3-dianders@chromium.org> <20181114220744.GB4044@brain-police>
In-Reply-To: <20181114220744.GB4044@brain-police>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 26 Nov 2018 19:52:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WYa8Hfo0hN8eqTBsjGY7A0nnQBoG1nSrvQ92we+v5kuA@mail.gmail.com>
Message-ID: <CAD=FV=WYa8Hfo0hN8eqTBsjGY7A0nnQBoG1nSrvQ92we+v5kuA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
To:     Will Deacon <will.deacon@arm.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, jhogan@kernel.org,
        linux-hexagon@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        dalias@libc.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au, paul.burton@mips.com,
        rkuo@codeaurora.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <dianders@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dianders@chromium.org
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

Hi,

On Wed, Nov 14, 2018 at 2:07 PM Will Deacon <will.deacon@arm.com> wrote:
>
> > +void __weak kgdb_call_nmi_hook(void *ignored)
> > +{
> > +     kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> > +}
>
> I suppose you could pass the cpu as an argument, but it doesn't really
> matter.

I probably won't change it for now if it doesn't matter...


> Also, I think there are cases where the CSD callback can run without
> having received an IPI, so we could potentially up passing NULL for the regs
> here which probably goes boom.

Hrm, good point.  This is not a new issue so I'd tend to add it to the
TODO list rather than block the series.  I'll also add a comment in
the code since I'm touching it anyway.

Interestingly enough quite a bit of things continue to work just fine
even if this is NULL.  I simulated setting this to NULL for all CPUs
and I could drop into the debugger, type "btc" to backtrace all CPUs,
attach to kgdb, etc.  ...but when I typed "cpu 1" it went boom.  So it
seems like parts of kdb use this but definitely not everything.

Also interesting is that on MIPS this is always NULL.  I have no idea
why but my patch series preserves this oddity.  Presumably if someone
was on a SMP MIPS machine and did "cpu 1" from kdb they'd go boom too.

In general kdb has a lot of crufty stuff like this in it.  We need to
work to get rid of the cruft but one step at a time I think.

I've started a kgdb-wishlist:

https://bugs.chromium.org/p/chromium/issues/list?q=label%3Akgdb-wishlist

...and this is crbug.com/908723


> > +void __weak kgdb_roundup_cpus(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int this_cpu = get_cpu();
>
> Do you actually need to disable preemption here? afaict, irqs are already
> disabled by the kgdb core.

Ah, right.  I can just use raw_smp_processor_id().  Done.  I didn't
try to see if I could use smp_processor_id() since
kgdb_call_nmi_hook() already used raw_smp_processor_id(), but I can
dig if you wish.


> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, cpu_online_mask) {
>
> for_each_online_cpu(cpu) ?

Done.


> I'm assuming this is serialised wrt CPU hotplug somehow?

I doubt it.  I can add it to my wishlist (crbug.com/908722) , but I
don't think it's something I'm going to try to solve right now and
it's definitely not new.  I think we need to make some sort of attempt
in kgdb_cpu_enter() to stop hotplugging, though we'd have to take into
account that we may be entering kgdb in an IRQ context so it might be
hard to grab a mutex.  We need to account for it there since that
function has code like:

> while (kgdb_do_roundup && --time_left &&
>        (atomic_read(&masters_in_kgdb) + atomic_read(&slaves_in_kgdb)) !=
>    online_cpus)
> udelay(1000);

...and that would also be broken if cpus were plugging / unplugging.

In general, at least, the worst case would be that we'd either have an
extra 1 second delay entering the debugger (because we were waiting
for a CPU to respond that's been hotplugged) or we'd enter kgdb
without stopping one of the CPUs.  Neither of those is ideal but I
don't think we'd end up in too bad shape.

Oh, but actually, I guess I should probably check the error return of
smp_call_function_single_async() and if it returns an error I should
unset rounding_up...  That would make things behave slightly better
and is probably right anyway.


Overall: thank you very much for the review and the feedback.  Sorry
I'm not really fixing everything here.  My hope is to move things to a
slightly better state but I don't have time to fix everything.
Hopefully I can find some more time soon to fix more, or perhaps
someone else will.


-Doug
