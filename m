Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2011 11:41:53 +0200 (CEST)
Received: from e9.ny.us.ibm.com ([32.97.182.139]:37522 "EHLO e9.ny.us.ibm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491001Ab1JMJlq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Oct 2011 11:41:46 +0200
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
        by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p9D95VCc015628;
        Thu, 13 Oct 2011 05:05:31 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
        by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p9D9fcgE2355264;
        Thu, 13 Oct 2011 05:41:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
        by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p9D9fXdd031323;
        Thu, 13 Oct 2011 06:41:35 -0300
Received: from thinktux.localdomain (thinktux.in.ibm.com [9.124.35.31])
        by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id p9D9fVde030793;
        Thu, 13 Oct 2011 06:41:32 -0300
Received: by thinktux.localdomain (Postfix, from userid 500)
        id 31F22220595; Thu, 13 Oct 2011 15:11:38 +0530 (IST)
Date:   Thu, 13 Oct 2011 15:11:38 +0530
From:   Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To:     Maneesh Soni <manesoni@cisco.com>
Cc:     ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, david.daney@cavium.com,
        kamensky@cisco.com
Subject: Re: [PATCH] MIPS Kprobes: Support branch instructions probing
Message-ID: <20111013094137.GA19054@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20111013090749.GB16761@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111013090749.GB16761@cisco.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-archive-position: 31230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ananth@in.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8918

On Thu, Oct 13, 2011 at 02:37:49PM +0530, Maneesh Soni wrote:

...

I know nothing of MIPS internals, but...
 
>  static int __kprobes kprobe_handler(struct pt_regs *regs)
> @@ -239,8 +531,13 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
>  			save_previous_kprobe(kcb);
>  			set_current_kprobe(p, regs, kcb);
>  			kprobes_inc_nmissed_count(p);
> -			prepare_singlestep(p, regs);
> +			prepare_singlestep(p, regs, kcb);
>  			kcb->kprobe_status = KPROBE_REENTER;
> +			if (kcb->flags & SKIP_DELAYSLOT) {
> +				resume_execution(p, regs, kcb);
> +				restore_previous_kprobe(kcb);
> +				preempt_enable_no_resched();
> +			}
>  			return 1;
>  		} else {
>  			if (addr->word != breakpoint_insn.word) {
> @@ -284,8 +581,15 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
>  	}
> 
>  ss_probe:
> -	prepare_singlestep(p, regs);
> -	kcb->kprobe_status = KPROBE_HIT_SS;
> +	prepare_singlestep(p, regs, kcb);
> +	if (kcb->flags & SKIP_DELAYSLOT) {
> +		kcb->kprobe_status = KPROBE_HIT_SSDONE;
> +		if (p->post_handler)
> +			p->post_handler(p, regs, 0);
> +		resume_execution(p, regs, kcb);

You are missing a preempt_disable_no_resched() here.

Ananth
