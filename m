Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2011 12:12:41 +0200 (CEST)
Received: from ams-iport-1.cisco.com ([144.254.224.140]:65451 "EHLO
        ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491005Ab1JMKM2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2011 12:12:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=manesoni@cisco.com; l=1484; q=dns/txt;
  s=iport; t=1318500748; x=1319710348;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=I/P10tROSvc4qVtiIw5YlPNk5SCeWfBBDnB7FvyV1cI=;
  b=PUvrHb3q9ERZqs2XF6inMqjP6ilMMNDn5fsbFC9PvC2QHsHV2Rd51vWF
   AGfWZEi6ec/uFR/6MCKmdlxyhFruCtNXUlnz8UuZRqcBrdQqFtiFOQCjg
   1ElbJOUmjouba3KuFw8m3xK3d6+mYk8JY2UllQPmMgpavOrFp6tVa59FW
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av4EABe5lk6Q/khM/2dsb2JhbABDqFGBBYFTAQEBBBIBAgEREz8QCxgcEhQYMQsqoS8BgykPAZpwhwxhBId/i3mRXQ
X-IronPort-AV: E=Sophos;i="4.69,339,1315180800"; 
   d="scan'208";a="119017620"
Received: from ams-core-3.cisco.com ([144.254.72.76])
  by ams-iport-1.cisco.com with ESMTP; 13 Oct 2011 10:12:21 +0000
Received: from cisco.com (dhcp-72-163-207-192.cisco.com [72.163.207.192])
        by ams-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id p9DACLpQ002738;
        Thu, 13 Oct 2011 10:12:21 GMT
Received: by cisco.com (Postfix, from userid 1001)
        id 16EDD81C9F; Thu, 13 Oct 2011 15:42:18 +0530 (IST)
Date:   Thu, 13 Oct 2011 15:42:18 +0530
From:   Maneesh Soni <manesoni@cisco.com>
To:     Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc:     ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, david.daney@cavium.com,
        kamensky@cisco.com
Subject: Re: [PATCH] MIPS Kprobes: Support branch instructions probing
Message-ID: <20111013101217.GD16761@cisco.com>
Reply-To: manesoni@cisco.com
References: <20111013090749.GB16761@cisco.com>
 <20111013094137.GA19054@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111013094137.GA19054@in.ibm.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manesoni@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8950

On Thu, Oct 13, 2011 at 03:11:38PM +0530, Ananth N Mavinakayanahalli wrote:
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
> 
ok.. you meant preempt_enable_no_resched(). Will add it in the next
version. Thanks for pointing it out.

Thanks
Maneesh
