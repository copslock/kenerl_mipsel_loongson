Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 13:25:58 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:40409 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133646AbWBTNZu
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 13:25:50 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k1KDWZdW020022;
	Mon, 20 Feb 2006 05:32:36 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k1KDWY89017768;
	Mon, 20 Feb 2006 05:32:35 -0800 (PST)
Message-ID: <43F9C58E.4020606@mips.com>
Date:	Mon, 20 Feb 2006 14:35:10 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To:	Rojhalat Ibrahim <imr@rtschenk.de>
CC:	Mark E Mason <mark.e.mason@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: Tracking down exception in sched.c
References: <7E000E7F06B05C49BDBB769ADAF44D0773A636@NT-SJCA-0750.brcm.ad.broadcom.com> <43F9B168.6090105@rtschenk.de>
In-Reply-To: <43F9B168.6090105@rtschenk.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

The "for" loop is what used to be there, but if you use it in
a system with "hot-pluggable" CPUs, I could imagine that there
would be problems.  While for_each_cpu is pathetically inefficient
as it gets expanded and compiled for MIPS, if your phys_cpu_present_map
(which is by default what gets used in MIPS as cpu_possible_map
for the purposes of sched.c) is being properly initialized and
maintained, the behavior of the two loops should be the same.
Have you double-checked that?  Secondary CPUs turn generally
set their bits in that mask in prom_build_cpu_map().

		Regards,

		Kevin K.

Rojhalat Ibrahim wrote:
> Hi,
> 
> I tracked this one down to 88a2a4ac6b671a4b0dd5d2d762418904c05f4104
> (percpu data: only iterate over possible CPUs). I don't know if this
> is the correct way to fix this, but the following patch makes the
> problem go away for me.
> 
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -6021,7 +6021,7 @@ void __init sched_init(void)
>         runqueue_t *rq;
>         int i, j, k;
> 
> -       for_each_cpu(i) {
> +       for (i = 0; i < NR_CPUS; i++) {
>                 prio_array_t *array;
> 
>                 rq = cpu_rq(i);
> 
> Any other suggestions, how to fix this?
> 
> Thanks,
> Rojhalat Ibrahim
> 
> 
> Mark E Mason wrote:
>> [Cross-posted from LKML]
>>  
>> Hello all,
>>  
>> Working from the linux-mip.org repository (which just recently merged
>> from the kernel.org repository), we've been getting exceptions on
>> several different processors due to NULL pointer dereferences in
>> sched.c.  These happen on SMP systems only (but both 32 and 64-bit
>> systems trigger this problem).
>>  
>> The Oops output and surrounding text (w/ backtrace) is below.  What I've
>> traced is down to so far is that enqueue_task() gets called with a ready
>> queue (rq) where (rq->active == NULL).
>>
>> Backtracing a bit, the following patch triggers an earlier, slightly
>> more controlled failure:
>>
>> [mason@hawaii linux.git]$ git diff kernel/sched.c diff --git
>> a/kernel/sched.c b/kernel/sched.c
>> --- a/kernel/sched.c
>> +++ b/kernel/sched.c
>> @@ -1264,6 +1264,7 @@ static int try_to_wake_up(task_t *p, uns  #endif
>>
>>         rq = task_rq_lock(p, &flags);
>> +       BUG_ON(rq->active == NULL);
>>         old_state = p->state;
>>         if (!(old_state & state))
>>                 goto out;
>>
>>
>> My question is, is the above assert valid (ie. Should rq->active always
>> be non-NULL at this point)?  It seems like it should be, but I'm pretty
>> new to this code, and thought I should double-check before going off
>> into the weeds.
>>
>> If anyone has any ideas about where specifically to look for the
>> underlying problem, I'd appreciate it.
>>
>> Thanks (very much) in advance,
>> Mark Mason
>> mason@broadcom.com
>> Newberg, Oregon
>>  
> 
