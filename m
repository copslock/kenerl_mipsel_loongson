Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2010 12:27:47 +0100 (CET)
Received: from casper.infradead.org ([85.118.1.10]:56088 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491188Ab0KSL1j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Nov 2010 12:27:39 +0100
Received: from f199130.upc-f.chello.nl ([80.56.199.130] helo=laptop)
        by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
        id 1PJP7Z-0002Hv-MF; Fri, 19 Nov 2010 11:27:33 +0000
Received: by laptop (Postfix, from userid 1000)
        id 6358E1035D2D7; Fri, 19 Nov 2010 12:27:32 +0100 (CET)
Subject: Re: [PATCH 3/5] MIPS/Perf-events: Check event state in
 validate_event()
From:   Peter Zijlstra <a.p.zijlstra@chello.nl>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, ralf@linux-mips.org,
        fweisbec@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, wuzhangjin@gmail.com,
        paulus@samba.org, mingo@elte.hu, acme@redhat.com
In-Reply-To: <1290159806.9342.7.camel@e102144-lin.cambridge.arm.com>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
         <1290063401-25440-4-git-send-email-dengcheng.zhu@gmail.com>
         <1290159806.9342.7.camel@e102144-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Fri, 19 Nov 2010 12:27:31 +0100
Message-ID: <1290166051.2109.1539.camel@laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <a.p.zijlstra@chello.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.p.zijlstra@chello.nl
Precedence: bulk
X-list: linux-mips

On Fri, 2010-11-19 at 09:43 +0000, Will Deacon wrote:
> Hi Deng-Cheng,
> 
> On Thu, 2010-11-18 at 06:56 +0000, Deng-Cheng Zhu wrote:
> > Ignore events that are not for this PMU or are in off/error state.
> > 
> Sorry I didn't see this before, thanks for pointing out that you
> had included it for MIPS.
> 
> > Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
> > ---
> >  arch/mips/kernel/perf_event.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
> > index 1ee44a3..9c6442a 100644
> > --- a/arch/mips/kernel/perf_event.c
> > +++ b/arch/mips/kernel/perf_event.c
> > @@ -486,7 +486,7 @@ static int validate_event(struct cpu_hw_events *cpuc,
> >  {
> >         struct hw_perf_event fake_hwc = event->hw;
> > 
> > -       if (event->pmu && event->pmu != &pmu)
> > +       if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
> >                 return 0;
> > 
> >         return mipspmu->alloc_counter(cpuc, &fake_hwc) >= 0;
> 
> So this is the opposite of what we're doing on ARM. Our
> approach is to ignore events that are OFF (or in the ERROR
> state) or that belong to a different PMU. We do this by
> allowing them to *pass* validation (i.e. by returning 1 above).
> This means that we won't unconditionally fail a mixed event group.
> 
> x86 does something similar in the collect_events function.

Right, note that the generic code only allows mixing with software
events, so simply accepting them is ok as software events give the
guarantee they're always schedulable.
