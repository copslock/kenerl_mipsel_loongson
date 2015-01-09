Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 09:34:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51538 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006516AbbAIIevIZjIn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 09:34:51 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4B7FFE2C4A985
        for <linux-mips@linux-mips.org>; Fri,  9 Jan 2015 08:34:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 9 Jan 2015 08:34:44 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Fri, 9 Jan 2015 08:34:43 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Markos Chandras <Markos.Chandras@imgtec.com>
Subject: RE: MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS
Thread-Topic: MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS
Thread-Index: AQHQK7OZUOghtkpbfki5Go9AQJbAt5y3baLA
Date:   Fri, 9 Jan 2015 08:34:42 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320F9B4C3@LEMAIL01.le.imgtec.org>
References: <1420719457-690-1-git-send-email-paul.burton@imgtec.com>
 <54AF3C2C.7040807@imgtec.com>
In-Reply-To: <54AF3C2C.7040807@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.64]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> writes:
> > +	/* Prevent any threads from obtaining live FP context */
> > +	atomic_set(&task->mm->context.fp_mode_switching, 1);
> > +	smp_mb__after_atomic();
> > +
> > +	/*
> > +	 * If there are multiple online CPUs then wait until all threads
> whose
> > +	 * FP mode is about to change have been context switched. This
> approach
> > +	 * allows us to only worry about whether an FP mode switch is in
> > +	 * progress when FP is first used in a tasks time slice. Pretty
> much all
> > +	 * of the mode switch overhead can thus be confined to cases where
> mode
> > +	 * switches are actually occuring. That is, to here. However for
> the
> > +	 * thread performing the mode switch it may take a while...
> > +	 */
> > +	if (num_online_cpus() > 1) {
> > +		spin_lock_irq(&task->sighand->siglock);
> > +
> > +		for_each_thread(task, t) {
> > +			if (t == current)
> > +				continue;
> > +
> > +			switch_count = t->nvcsw + t->nivcsw;
> > +
> > +			do {
> > +				spin_unlock_irq(&task->sighand->siglock);
> > +				cond_resched();
> > +				spin_lock_irq(&task->sighand->siglock);
> > +			} while ((t->nvcsw + t->nivcsw) == switch_count);
> > +		}
> > +
> > +		spin_unlock_irq(&task->sighand->siglock);
> > +	}
> >
> This piece of thread walking seems to be not thread safe for newly
> created thread.
> Thread creation is not locked between points of copy_thread which copies
> task thread flags and makeing thread visible to walking via
> "for_each_thread".
> 
> So it is possible in environment with two threads - one is creating an
> another thread, another one switching FPU mode and waiting and race
> condition may causes a newly thread in old mode but the rest of thread
> group is in new mode.
> 
> Besides that, it looks like in kernel with tickless mode a scheduler may
> no come a long time in idle system, in extreme case - forever.

Only commenting on the tickless issue... The requirement for the
PR_SET_FP_MODE call is that all threads in the current thread group switch
to the new mode prior to it returning. I believe that simply means there
is no alternative other than for the tickless case to wait as long as it
has to wait? If the prctl failed in tickless mode (or timed out) then that
is likely to lead to a program failing to load its libraries and aborting.

So if the only other alternative is for the prctl to fail then I'm not
sure if that is any better than waiting forever.

For the vast majority of cases the prctl calls to change mode will happen
very early in the user-process, while it is still single threaded. These
will be part of loading an application's initial set of shared libraries.
Perhaps that means this corner case of a long delay is not overly dangerous
anyway?

Thanks,
Matthew
