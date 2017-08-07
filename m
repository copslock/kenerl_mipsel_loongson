Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 10:23:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43006 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991786AbdHGIXiw8b7T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Aug 2017 10:23:38 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v778NcVT020604;
        Mon, 7 Aug 2017 10:23:38 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v778NcAq020603;
        Mon, 7 Aug 2017 10:23:38 +0200
Date:   Mon, 7 Aug 2017 10:23:38 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Cc:     linux-mips@linux-mips.org,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] mips: Fix race on setting and getting cpu_online_mask
Message-ID: <20170807082338.GA20422@linux-mips.org>
References: <77b85cd2-2ee8-ae51-a27f-ff046900c3f9@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b85cd2-2ee8-ae51-a27f-ff046900c3f9@nokia.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Aug 03, 2017 at 08:20:22AM +0200, Matija Glavinic Pecotic wrote:

> While testing cpu hoptlug (cpu down and up in loops) on kernel 4.4, it was
> observed that occasionally check for cpu online will fail in kernel/cpu.c,
> _cpu_up:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/kernel/cpu.c?h=v4.4.79#n485
>  518        /* Arch-specific enabling code. */
>  519        ret = __cpu_up(cpu, idle);
>  520
>  521        if (ret != 0)
>  522                goto out_notify;
>  523        BUG_ON(!cpu_online(cpu));
> 
> Reason is race between start_secondary and _cpu_up. cpu_callin_map is set
> before cpu_online_mask. In __cpu_up, cpu_callin_map is waited for, but cpu
> online mask is not, resulting in race in which secondary processor started
> and set cpu_callin_map, but not yet set the online mask,resulting in above
> BUG being hit.
> 
> Upstream differs in the area. cpu_online check is in bringup_wait_for_ap,
> which is after cpu reached AP_ONLINE_IDLE,where secondary passed its start
> function. Nonetheless, fix makes start_secondary safe and not depending on
> other locks throughout the code. It protects as well against cpu_online
> checks put in between sometimes in the future.
> 
> Fix this by moving completion after all flags are set.
> 
> Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
> ---
>  arch/mips/kernel/smp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 770d4d1..6bace76 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -376,9 +376,6 @@ asmlinkage void start_secondary(void)
>  	cpumask_set_cpu(cpu, &cpu_coherent_mask);
>  	notify_cpu_starting(cpu);
>  
> -	complete(&cpu_running);
> -	synchronise_count_slave(cpu);
> -
>  	set_cpu_online(cpu, true);
>  
>  	set_cpu_sibling_map(cpu);
> @@ -386,6 +383,9 @@ asmlinkage void start_secondary(void)
>  
>  	calculate_cpu_foreign_map();
>  
> +	complete(&cpu_running);
> +	synchronise_count_slave(cpu);
> +
>  	/*
>  	 * irq will be enabled in ->smp_finish(), enabling it too early
>  	 * is dangerous.

Makes sense, applied - but after applying I was wondering if
synchronise_count_slave() should be before the complete, not after.

  Ralf
