Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 20:18:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38685 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823608Ab3FHSSqqag3B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 20:18:46 +0200
Date:   Sat, 8 Jun 2013 19:18:46 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Alchemy: fix wait function
In-Reply-To: <1369315716-7408-1-git-send-email-manuel.lauss@gmail.com>
Message-ID: <alpine.LFD.2.03.1306081907130.21418@linux-mips.org>
References: <1369315716-7408-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Thu, 23 May 2013, Manuel Lauss wrote:

> Only an interrupt can wake the core from 'wait', enable interrupts
> locally before executing 'wait'.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Ralf made me aware of the race in between enabling interrupts and
> entering wait.  While this patch does not eliminate it, it shrinks it
> to 1 instruction.  It's not perfect, but lets Alchemy boot until a
> more sophisticated solution (like __r4k_wait) can be implemented
> without having to duplicate the interrupt exception handler.

 I suggest double-checking with Alchemy documentation, but I doubt there 
is a race here, the write-back pipeline stage of MTC0 should overlap with 
the execution stage of WAIT, so assuming interrupts were previously 
disabled there should be no window between setting CP0.Status.IE and 
executing WAIT that would permit an interrrupt exception to be taken.  

 There is a bug in your change however.

>  arch/mips/kernel/idle.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
> index 3b09b88..1d37b4b 100644
> --- a/arch/mips/kernel/idle.c
> +++ b/arch/mips/kernel/idle.c
> @@ -93,9 +93,9 @@ static void rm7k_wait_irqoff(void)
>  }
>  
>  /*
> - * The Au1xxx wait is available only if using 32khz counter or
> - * external timer source, but specifically not CP0 Counter.
> - * alchemy/common/time.c may override cpu_wait!
> + * Au1 'wait' is only useful when the 32kHz counter is used as timer,
> + * since coreclock (and the cp0 counter) stops upon executing it. Only an
> + * interrupt can wake it, so they must be enabled before entering idle modes.
>   */
>  static void au1k_wait(void)
>  {
> @@ -103,8 +103,10 @@ static void au1k_wait(void)
>  	"	.set	mips3			\n"
>  	"	cache	0x14, 0(%0)		\n"
>  	"	cache	0x14, 32(%0)		\n"
> +	"	mfc0	$8, $12			\n"
> +	"	ori	$8, $8, 1		\n"
>  	"	sync				\n"
> -	"	nop				\n"
> +	"	mtc0	$8, $12			\n"	/* enable irqs */
>  	"	wait				\n"
>  	"	nop				\n"
>  	"	nop				\n"
> @@ -112,7 +114,6 @@ static void au1k_wait(void)
>  	"	nop				\n"
>  	"	.set	mips0			\n"
>  	: : "r" (au1k_wait));
> -	local_irq_enable();
>  }
>  
>  static int __initdata nowait;

 You can't just take $8 away under the feet of GCC without telling the 
compiler, it may be storing some data there across the asm.  Rather than 
picking an arbitrary register as a clobber I suggest using an output 
register constraint associated with a scratch variable (depending on 
register usage GCC may possibly be able to reuse the same register both 
for input and for output).

  Maciej
