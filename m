Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 11:30:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30389 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859957AbaGLJaN0ixSc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jul 2014 11:30:13 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 07ED21CB771A6;
        Sat, 12 Jul 2014 10:30:04 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 12 Jul
 2014 10:30:05 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sat, 12 Jul 2014 10:30:05 +0100
Received: from localhost (192.168.79.155) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 12 Jul
 2014 10:30:04 +0100
Date:   Sat, 12 Jul 2014 10:30:03 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Chen Jie <chenj@lemote.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?utf-8?B?546L6ZSQ?= <wangr@lemote.com>
Subject: Re: [PATCH] Not preempt in CP1 exception handling
Message-ID: <20140712093003.GF8187@pburton-laptop>
References: <1405047990-12519-1-git-send-email-chenhc@lemote.com>
 <1405048453-12633-1-git-send-email-chenj@lemote.com>
 <20140711155631.GE8187@pburton-laptop>
 <CAGXxSxV2KWiArguRRKWcbC82sZJweyjiDBBpJdWPne_Ag_Z_+w@mail.gmail.com>
 <CAAhV-H5z1Xu5Mg0X68Yf_mpi8ZBg96TEYLkk4_2_Grb8=ET05Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAAhV-H5z1Xu5Mg0X68Yf_mpi8ZBg96TEYLkk4_2_Grb8=ET05Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.79.155]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Sat, Jul 12, 2014 at 05:10:35PM +0800, Huacai Chen wrote:
> Hi, Paul,
> 
> You means my patch (http://patchwork.linux-mips.org/patch/7297/) is
> the correct way?

I believe you patch will fix the problem, but I think it would be better
to remove the check for !preemptible() & the BUG_ON entirely.

> Another question: Your patch
> (http://patchwork.linux-mips.org/patch/7307/) remove
> preempt_disable()/preempt_enable() in init_fpu(). It will cause
> problems if there is another function call init_fpu() because it is
> previously preempt-safe. Maybe introduce a new function (e.g.
> __init_fpu()) is a better way?

It may cause a problem if there were other callers, but there is only
one caller of init_fpu (enable_restore_fp_context) and it needs to
disable preemption for longer than the init_fpu function anyway. I see
no value in keeping init_fpu as a wrapper that disables preemption
when there would be nothing calling it.

Thanks,
    Paul

> Huacai
> 
> On Sat, Jul 12, 2014 at 7:28 AM, Chen Jie <chenj@lemote.com> wrote:
> > 2014-07-11 23:56 GMT+08:00 Paul Burton <paul.burton@imgtec.com>:
> >> On Fri, Jul 11, 2014 at 11:14:13AM +0800, chenj wrote:
> >>> do_ade may be invoked with preempt enabled. do_cpu will be invoked with
> >>> preempt enabled. When it's preempted(in do_ade/do_cpu), TIF_USEDFPU will be
> >>> cleared, when it returns to do_ade/do_cpu, the fpu is actually disabled.
> >>>
> >>> e.g.
> >>> In do_ade()
> >>>   emulate_load_store_insn():
> >>>     BUG_ON(!is_fpu_owner()); <-- This assertion may be breaked.
> >>>
> >>> In do_cpu()
> >>>   enable_restore_fp_context():
> >>>     was_fpu_owner = is_fpu_owner();
> >>
> >> Preemption should indeed be disabled around the assignment & use of the
> >> was_fpu_owner variable, but note that you can only hit the problem if
> >> using MSA. One of the MSA fixes I just submitted also fixes this along
> >> with another instance of the problem:
> >>
> >>   http://patchwork.linux-mips.org/patch/7307/
> >>
> >> I prefer my patch to this since it disables preemption for less time,
> >> in addition to fixing the !used_math() case.
> >>
> >> In emulate_load_store_insn I believe the correct fix is simply to remove
> >> that BUG_ON. The code is about to give up FPU ownership anyway, so it's
> >> not like there is any requirement being violated if it was already lost.
> > Yes, you're right.
> >
> > """ /* arch/mips/kernel/unaligned.c */
> > lose_fpu(1);    /* Save FPU state for the emulator. */
> > res = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1, &fault_addr);
> > own_fpu(1);     /* Restore FPU state. */
> > """
> >
> > Going deep into the code, I find lost_fpu(1) will save fpu context if
> > owns fpu (otherwise, if preempted, the fpu context will be saved in
> > process switch), then fpu_emulator_cop1Handler manipulates the saved
> > fpu context, own_fpu(1) restores it.
> >
> > So, remove "BUG_ON(!is_fpu_owner())" is OK.
> >
