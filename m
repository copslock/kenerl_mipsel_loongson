Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 19:17:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45447 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835114Ab3FJRRYIoYDs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 19:17:24 +0200
Date:   Mon, 10 Jun 2013 18:17:24 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v3] MIPS: Alchemy: fix wait function
In-Reply-To: <1370722541-25407-1-git-send-email-manuel.lauss@gmail.com>
Message-ID: <alpine.LFD.2.03.1306101816150.18329@linux-mips.org>
References: <1370722541-25407-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36812
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

On Sat, 8 Jun 2013, Manuel Lauss wrote:

> diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
> index 3b09b88..0c655de 100644
> --- a/arch/mips/kernel/idle.c
> +++ b/arch/mips/kernel/idle.c
> @@ -93,26 +93,27 @@ static void rm7k_wait_irqoff(void)
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
> +	unsigned long c0status = read_c0_status() | 1;	/* irqs on */
> +
>  	__asm__(
>  	"	.set	mips3			\n"
>  	"	cache	0x14, 0(%0)		\n"
>  	"	cache	0x14, 32(%0)		\n"
>  	"	sync				\n"
> -	"	nop				\n"
> +	"	mtc0	%1, $12			\n" /* wr c0status */
>  	"	wait				\n"
>  	"	nop				\n"
>  	"	nop				\n"
>  	"	nop				\n"
>  	"	nop				\n"
>  	"	.set	mips0			\n"
> -	: : "r" (au1k_wait));
> -	local_irq_enable();
> +	: : "r" (au1k_wait), "r" (c0status));
>  }
>  
>  static int __initdata nowait;

 Not exacly what I had in mind, but this looks good to me too. :)

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

  Maciej
