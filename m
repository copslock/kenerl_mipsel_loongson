Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Feb 2011 14:52:26 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:55744 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491069Ab1BLNwW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Feb 2011 14:52:22 +0100
Received: by bwz5 with SMTP id 5so3880905bwz.36
        for <multiple recipients>; Sat, 12 Feb 2011 05:52:16 -0800 (PST)
Received: by 10.204.66.65 with SMTP id m1mr551659bki.71.1297518736228;
        Sat, 12 Feb 2011 05:52:16 -0800 (PST)
Received: from [192.168.2.2] ([91.79.98.123])
        by mx.google.com with ESMTPS id q18sm329969bka.3.2011.02.12.05.52.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 05:52:14 -0800 (PST)
Message-ID: <4D569044.5070801@mvista.com>
Date:   Sat, 12 Feb 2011 16:51:00 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     maksim.rayskiy@gmail.com
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        Maksim Rayskiy <mrayskiy@broadcom.com>
Subject: Re: [PATCH] MIPS: move idle task creation to work queue
References: <1297480946-28053-1-git-send-email-maksim.rayskiy@gmail.com>
In-Reply-To: <1297480946-28053-1-git-send-email-maksim.rayskiy@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 12-02-2011 6:22, maksim.rayskiy@gmail.com wrote:

> From: Maksim Rayskiy <mrayskiy@broadcom.com>

> To avoid forking usertask when creating an idle task, move fork_idle
> to a work queue.
> This is a small improvement to previous commit 467f0b8.

    Linus akss to also specify the commit summary in parens.

> Signed-off-by: Maksim Rayskiy <mrayskiy@broadcom.com>
[...]

> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 4593916..98bd504 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -193,6 +193,21 @@ void __devinit smp_prepare_boot_cpu(void)
>    */
>   static struct task_struct *cpu_idle_thread[NR_CPUS];
>
> +struct create_idle {
> +	struct work_struct work;
> +	struct task_struct *idle;
> +	struct completion done;
> +	int cpu;
> +};
> +
> +static void __cpuinit do_fork_idle(struct work_struct *work)
> +{
> +	struct create_idle *c_idle =
> +		container_of(work, struct create_idle, work);

     Empty line wouldn't hurt here...

> +	c_idle->idle = fork_idle(c_idle->cpu);
> +	complete(&c_idle->done);
> +}
> +
>   int __cpuinit __cpu_up(unsigned int cpu)
>   {
>   	struct task_struct *idle;
> @@ -203,16 +218,21 @@ int __cpuinit __cpu_up(unsigned int cpu)
>   	 * Linux can schedule processes on this slave.
>   	 */
>   	if (!cpu_idle_thread[cpu]) {
> -		idle = fork_idle(cpu);
> -		cpu_idle_thread[cpu] = idle;
> +		/* Schedule work item to avoid forking user task.
> +		   Ported from x86 */

   The preferred style of multi-line comments is this:

/*
  * bla
  * bla
  */

WBR, Sergei
