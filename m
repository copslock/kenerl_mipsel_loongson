Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 03:26:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49238 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010256AbbAIC0DO8kGR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 03:26:03 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 58260D9369725
        for <linux-mips@linux-mips.org>; Fri,  9 Jan 2015 02:25:56 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 9 Jan
 2015 02:25:57 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 9 Jan
 2015 02:25:57 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 8 Jan 2015
 18:25:48 -0800
Message-ID: <54AF3C2C.7040807@imgtec.com>
Date:   Thu, 8 Jan 2015 18:25:48 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS
References: <1420719457-690-1-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1420719457-690-1-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

> +	/* Prevent any threads from obtaining live FP context */
> +	atomic_set(&task->mm->context.fp_mode_switching, 1);
> +	smp_mb__after_atomic();
> +
> +	/*
> +	 * If there are multiple online CPUs then wait until all threads whose
> +	 * FP mode is about to change have been context switched. This approach
> +	 * allows us to only worry about whether an FP mode switch is in
> +	 * progress when FP is first used in a tasks time slice. Pretty much all
> +	 * of the mode switch overhead can thus be confined to cases where mode
> +	 * switches are actually occuring. That is, to here. However for the
> +	 * thread performing the mode switch it may take a while...
> +	 */
> +	if (num_online_cpus() > 1) {
> +		spin_lock_irq(&task->sighand->siglock);
> +
> +		for_each_thread(task, t) {
> +			if (t == current)
> +				continue;
> +
> +			switch_count = t->nvcsw + t->nivcsw;
> +
> +			do {
> +				spin_unlock_irq(&task->sighand->siglock);
> +				cond_resched();
> +				spin_lock_irq(&task->sighand->siglock);
> +			} while ((t->nvcsw + t->nivcsw) == switch_count);
> +		}
> +
> +		spin_unlock_irq(&task->sighand->siglock);
> +	}
>
This piece of thread walking seems to be not thread safe for newly 
created thread.
Thread creation is not locked between points of copy_thread which copies 
task thread flags
and makeing thread visible to walking via "for_each_thread".

So it is possible in environment with two threads - one is creating an 
another thread,
another one switching FPU mode and waiting and race condition may causes 
a newly thread in old mode
but the rest of thread group is in new mode.

Besides that, it looks like in kernel with tickless mode a scheduler may 
no come a long time in idle system,
in extreme case - forever.

- Leonid.
