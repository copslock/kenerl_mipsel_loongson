Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 01:40:06 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:61435 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225217AbTCGBkF>;
	Fri, 7 Mar 2003 01:40:05 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h271e2S16032;
	Thu, 6 Mar 2003 17:40:02 -0800
Date: Thu, 6 Mar 2003 17:40:01 -0800
From: Jun Sun <jsun@mvista.com>
To: Kip Walker <kwalker@broadcom.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [pathch] kernel/sched.c bogon?
Message-ID: <20030306174001.K26071@mvista.com>
References: <3E67EF64.152CFC6C@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E67EF64.152CFC6C@broadcom.com>; from kwalker@broadcom.com on Thu, Mar 06, 2003 at 05:01:24PM -0800
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


I reported this bug last May.  Apparently it is still not
taken up-stream.   Ralf, why don't we fix it here and push
it up from you?

BTW, this bug actually has effect on real-time performance under
preemptible kernel.  It can delay the execution of the highest
priority real-time process from execution up to 1 jiffy.

Jun

On Thu, Mar 06, 2003 at 05:01:24PM -0800, Kip Walker wrote:
> 
> The comparisons of oldest_idle below trigger compiler warnings and
> should probably be safely type-cast:
> 
> Kip
> 
> Index: kernel/sched.c
> ===================================================================
> RCS file: /home/cvs/linux/kernel/sched.c,v
> retrieving revision 1.64.2.6
> diff -u -r1.64.2.6 sched.c
> --- kernel/sched.c      25 Feb 2003 22:03:13 -0000      1.64.2.6
> +++ kernel/sched.c      7 Mar 2003 00:57:35 -0000
> @@ -282,7 +282,7 @@
>                                 target_tsk = tsk;
>                         }
>                 } else {
> -                       if (oldest_idle == -1ULL) {
> +                       if (oldest_idle == (cycles_t) -1) {
>                                 int prio = preemption_goodness(tsk, p,
> cpu);
>  
>                                 if (prio > max_prio) {
> @@ -294,7 +294,7 @@
>         }
>         tsk = target_tsk;
>         if (tsk) {
> -               if (oldest_idle != -1ULL) {
> +               if (oldest_idle != (cycles_t) -1) {
>                         best_cpu = tsk->processor;
>                         goto send_now_idle;
>                 }
> 
> 
