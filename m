Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 12:02:24 +0000 (GMT)
Received: from mail-out.m-online.net ([212.18.0.9]:31894 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S8133646AbWBTMCQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 12:02:16 +0000
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id EC02E7336A;
	Mon, 20 Feb 2006 13:09:12 +0100 (CET)
Received: from schenk.isar.de (host-82-135-47-202.customer.m-online.net [82.135.47.202])
	by mail.m-online.net (Postfix) with ESMTP id E15DCB9783;
	Mon, 20 Feb 2006 13:09:12 +0100 (CET)
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id k1KC9Ca27702;
	Mon, 20 Feb 2006 13:09:12 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (Postfix) with ESMTP id 5E6484B417;
	Mon, 20 Feb 2006 13:09:12 +0100 (CET)
Message-ID: <43F9B168.6090105@rtschenk.de>
Date:	Mon, 20 Feb 2006 13:09:12 +0100
From:	Rojhalat Ibrahim <imr@rtschenk.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050919
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Mark E Mason <mark.e.mason@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tracking down exception in sched.c
References: <7E000E7F06B05C49BDBB769ADAF44D0773A636@NT-SJCA-0750.brcm.ad.broadcom.com>
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D0773A636@NT-SJCA-0750.brcm.ad.broadcom.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <imr@rtschenk.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imr@rtschenk.de
Precedence: bulk
X-list: linux-mips

Hi,

I tracked this one down to 88a2a4ac6b671a4b0dd5d2d762418904c05f4104
(percpu data: only iterate over possible CPUs). I don't know if this
is the correct way to fix this, but the following patch makes the
problem go away for me.

--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -6021,7 +6021,7 @@ void __init sched_init(void)
        runqueue_t *rq;
        int i, j, k;

-       for_each_cpu(i) {
+       for (i = 0; i < NR_CPUS; i++) {
                prio_array_t *array;

                rq = cpu_rq(i);

Any other suggestions, how to fix this?

Thanks,
Rojhalat Ibrahim


Mark E Mason wrote:
> [Cross-posted from LKML]
>  
> Hello all,
>  
> Working from the linux-mip.org repository (which just recently merged
> from the kernel.org repository), we've been getting exceptions on
> several different processors due to NULL pointer dereferences in
> sched.c.  These happen on SMP systems only (but both 32 and 64-bit
> systems trigger this problem).
>  
> The Oops output and surrounding text (w/ backtrace) is below.  What I've
> traced is down to so far is that enqueue_task() gets called with a ready
> queue (rq) where (rq->active == NULL).
> 
> Backtracing a bit, the following patch triggers an earlier, slightly
> more controlled failure:
> 
> [mason@hawaii linux.git]$ git diff kernel/sched.c diff --git
> a/kernel/sched.c b/kernel/sched.c
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -1264,6 +1264,7 @@ static int try_to_wake_up(task_t *p, uns  #endif
> 
>         rq = task_rq_lock(p, &flags);
> +       BUG_ON(rq->active == NULL);
>         old_state = p->state;
>         if (!(old_state & state))
>                 goto out;
> 
> 
> My question is, is the above assert valid (ie. Should rq->active always
> be non-NULL at this point)?  It seems like it should be, but I'm pretty
> new to this code, and thought I should double-check before going off
> into the weeds.
> 
> If anyone has any ideas about where specifically to look for the
> underlying problem, I'd appreciate it.
> 
> Thanks (very much) in advance,
> Mark Mason
> mason@broadcom.com
> Newberg, Oregon
>  
