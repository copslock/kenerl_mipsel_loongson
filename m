Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2007 16:47:54 +0000 (GMT)
Received: from mx.mips.com ([63.167.95.198]:37826 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20029072AbXLQQrq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Dec 2007 16:47:46 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id lBHGdXA4013152;
	Mon, 17 Dec 2007 08:39:34 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id lBHGe5ZK029893;
	Mon, 17 Dec 2007 08:40:06 -0800 (PST)
Message-ID: <017c01c840cb$7a5049c0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Pavel Kiryukhin" <vksavl@gmail.com>, <linux-mips@linux-mips.org>
Cc:	<vksavl@gmail.com>
References: <73cd086a0712170517i146a452exea775f3942c1d5da@mail.gmail.com>
Subject: Re: [PATCH][MIPS] fix user_cpus_allowed assignment
Date:	Mon, 17 Dec 2007 17:40:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1914
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1914
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This looks to be a correct fix.  Long term, we really do need to convince
the scheduler maintainer to provide hooks that will allow hardware-driven
affinity to be integrated with application-driven affinity in a sensible way,
without requiring replication (and replicated maintenence) of the system
call code in private copies like this.  I asked for such hooks in sched.c
when it first became apparent that dynamic FPU affinity was desirable,
but was blown off at that time, so, with regret, I perpetrated the local copy
hack.  But it's silly, and MIPS can't possibly be the only architecture where 
Linux is used in systems with assymmetric resources where adaptive affinity 
is useful.

            Regards,

            Kevin K.

----- Original Message ----- 
From: "Pavel Kiryukhin" <vksavl@gmail.com>
To: <linux-mips@linux-mips.org>
Cc: <vksavl@gmail.com>
Sent: Monday, December 17, 2007 2:17 PM
Subject: [PATCH][MIPS] fix user_cpus_allowed assignment


> Hi,
> there seems to be a bug in affinity handling for CONFIG_MIPS_MT_FPAFF=y.
> It can be easily reproduced - for two-cpus system set new mask to 4.
> Call fails, but next sched_getaffinity() call returns 0 as current
> mask.
> Simple fix is below.
> 
> Signed-off-by: Pavel Kiryukhin <vksavl@gmail.com>
> 
> diff --git a/arch/mips/kernel/mips-mt-fpaff.c
> b/arch/mips/kernel/mips-mt-fpaff.cindex 892665b..774f91e 100644
> --- a/arch/mips/kernel/mips-mt-fpaff.c
> +++ b/arch/mips/kernel/mips-mt-fpaff.c
> @@ -87,9 +87,6 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t
> pid, unsigned int len,
>         if (retval)
>                 goto out_unlock;
> 
> -       /* Record new user-specified CPU set for future reference */
> -       p->thread.user_cpus_allowed = new_mask;
> -
>         /* Unlock the task list */
>         read_unlock(&tasklist_lock);
> 
> @@ -104,6 +101,10 @@ asmlinkage long
> mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
>                 retval = set_cpus_allowed(p, new_mask);
>         }
> 
> +        /* Record new user-specified CPU set for future reference */
> +       if (!retval)
> +               p->thread.user_cpus_allowed = new_mask;
> +
>  out_unlock:
>         put_task_struct(p);
>         unlock_cpu_hotplug();
> 
> 
