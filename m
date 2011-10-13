Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2011 12:12:13 +0200 (CEST)
Received: from e9.ny.us.ibm.com ([32.97.182.139]:41452 "EHLO e9.ny.us.ibm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491002Ab1JMKMG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Oct 2011 12:12:06 +0200
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
        by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p9D9Zqtc028321;
        Thu, 13 Oct 2011 05:35:52 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
        by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p9DABxPn2466026;
        Thu, 13 Oct 2011 06:11:59 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
        by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p9DABxnO011547;
        Thu, 13 Oct 2011 06:11:59 -0400
Received: from thinktux.localdomain (thinktux.in.ibm.com [9.124.35.31])
        by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id p9DABvov011472;
        Thu, 13 Oct 2011 06:11:58 -0400
Received: by thinktux.localdomain (Postfix, from userid 500)
        id 7DA95220595; Thu, 13 Oct 2011 15:42:04 +0530 (IST)
Date:   Thu, 13 Oct 2011 15:42:04 +0530
From:   Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To:     Maneesh Soni <manesoni@cisco.com>
Cc:     ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, david.daney@cavium.com,
        kamensky@cisco.com
Subject: Re: [PATCH] MIPS Kprobes: Support branch instructions probing
Message-ID: <20111013101204.GB19054@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20111013090749.GB16761@cisco.com> <20111013094137.GA19054@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111013094137.GA19054@in.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-archive-position: 31231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ananth@in.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8949

On Thu, Oct 13, 2011 at 03:11:37PM +0530, Ananth N Mavinakayanahalli wrote:
> On Thu, Oct 13, 2011 at 02:37:49PM +0530, Maneesh Soni wrote:
> 
> ...
> 
> I know nothing of MIPS internals, but...
>  
> >  static int __kprobes kprobe_handler(struct pt_regs *regs)
> > @@ -239,8 +531,13 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
> >  			save_previous_kprobe(kcb);
> >  			set_current_kprobe(p, regs, kcb);
> >  			kprobes_inc_nmissed_count(p);
> > -			prepare_singlestep(p, regs);
> > +			prepare_singlestep(p, regs, kcb);
> >  			kcb->kprobe_status = KPROBE_REENTER;
> > +			if (kcb->flags & SKIP_DELAYSLOT) {
> > +				resume_execution(p, regs, kcb);
> > +				restore_previous_kprobe(kcb);
> > +				preempt_enable_no_resched();
> > +			}
> >  			return 1;
> >  		} else {
> >  			if (addr->word != breakpoint_insn.word) {
> > @@ -284,8 +581,15 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
> >  	}
> > 
> >  ss_probe:
> > -	prepare_singlestep(p, regs);
> > -	kcb->kprobe_status = KPROBE_HIT_SS;
> > +	prepare_singlestep(p, regs, kcb);
> > +	if (kcb->flags & SKIP_DELAYSLOT) {
> > +		kcb->kprobe_status = KPROBE_HIT_SSDONE;
> > +		if (p->post_handler)
> > +			p->post_handler(p, regs, 0);
> > +		resume_execution(p, regs, kcb);
> 
> You are missing a preempt_disable_no_resched() here.

Oops! I meant preempt_enable_no_resched().

Ananth
