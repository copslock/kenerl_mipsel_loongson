Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Mar 2017 23:42:26 +0100 (CET)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:60991 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993955AbdCLWmRM0pkR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Mar 2017 23:42:17 +0100
Received: from [IPv6:2003:86:281b:7f00:1e80:e46c:af8e:5409] (p20030086281B7F001E80E46CAF8E5409.dip0.t-ipconnect.de [IPv6:2003:86:281b:7f00:1e80:e46c:af8e:5409])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 6294410026B;
        Sun, 12 Mar 2017 23:42:16 +0100 (CET)
Subject: Re: [PATCH] MIPS: smp-mt: fix missing task_stack_page compile error
To:     ralf@linux-mips.org, james.hogan@imgtec.com
References: <20170312181551.22378-1-hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, efault@gmx.de
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <36806645-a59e-b6bb-dc17-4245199187c8@hauke-m.de>
Date:   Sun, 12 Mar 2017 23:42:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170312181551.22378-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 03/12/2017 07:15 PM, Hauke Mehrtens wrote:
> arch/mips/include/asm/processor.h references task_stack_page, but it is
> not defined anywhere. Including linux/sched/task_stack.h directly in
> asm/processor.h caused a different compile warning.
> 
> This fixes the folowing compile error in kernel 4.11-rc1:
>   CC      arch/mips/kernel/smp-mt.o
> In file included from ./arch/mips/include/asm/irq.h:16:0,
>                  from ./include/linux/irq.h:26,
>                  from ./include/asm-generic/hardirq.h:12,
>                  from ./arch/mips/include/asm/hardirq.h:16,
>                  from ./include/linux/hardirq.h:8,
>                  from ./include/linux/interrupt.h:12,
>                  from arch/mips/kernel/smp-mt.c:23:
> arch/mips/kernel/smp-mt.c: In function 'vsmp_boot_secondary':
> ./arch/mips/include/asm/processor.h:384:41: error: implicit declaration of function 'task_stack_page' [-Werror=implicit-function-declaration]
>  #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
>                                          ^
> ./arch/mips/include/asm/mipsmtregs.h:339:11: note: in definition of macro 'mttgpr'
>   : : "r" (v));       \
>            ^
> arch/mips/kernel/smp-mt.c:215:2: note: in expansion of macro 'write_tc_gpr_sp'
>   write_tc_gpr_sp( __KSTK_TOS(idle));
>   ^
> arch/mips/kernel/smp-mt.c:215:19: note: in expansion of macro '__KSTK_TOS'
>   write_tc_gpr_sp( __KSTK_TOS(idle));
>                    ^
> cc1: all warnings being treated as errors
> scripts/Makefile.build:294: recipe for target 'arch/mips/kernel/smp-mt.o' failed
> 
> Fixes: f3ac60671954 ("sched/headers: Move task-stack related APIs from <linux/sched.h> to <linux/sched/task_stack.h>")
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/kernel/smp-mt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
> index e077ea3e11fb..effc1ed18954 100644
> --- a/arch/mips/kernel/smp-mt.c
> +++ b/arch/mips/kernel/smp-mt.c
> @@ -18,7 +18,7 @@
>   * Copyright (C) 2006 Ralf Baechle (ralf@linux-mips.org)
>   */
>  #include <linux/kernel.h>
> -#include <linux/sched.h>
> +#include <linux/sched/task_stack.h>
>  #include <linux/cpumask.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqchip/mips-gic.h>

This is already fixed in this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc69910f329d61821897871e0e957eda39beb3d8

Hauke
