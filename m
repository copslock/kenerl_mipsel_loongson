Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 14:42:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44438 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822451Ab3FJMmecYQLc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 14:42:34 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5ACgVQO003107;
        Mon, 10 Jun 2013 14:42:31 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5ACgTG3003106;
        Mon, 10 Jun 2013 14:42:29 +0200
Date:   Mon, 10 Jun 2013 14:42:29 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org, ddaney.cavm@gmail.com
Subject: Re: [PATCH 2/5] MIPS: Allow kernel to use coprocessor 2
Message-ID: <20130610124229.GH28380@linux-mips.org>
References: <1370849404-4918-1-git-send-email-jchandra@broadcom.com>
 <1370849404-4918-3-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370849404-4918-3-git-send-email-jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36802
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

On Mon, Jun 10, 2013 at 01:00:01PM +0530, Jayachandran C wrote:

> Kernel threads should be able to use COP2 if the platform needs it.
> Do not call die_if_kernel() for a coprocessor unusable exception if
> the exception due to COP2 usage.  Instead, the default notifier for
> COP2 exceptions is updated to call die_if_kernel.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  arch/mips/kernel/traps.c |   15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index beba1e6..142d2be 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1056,15 +1056,9 @@ static int default_cu2_call(struct notifier_block *nfb, unsigned long action,
>  {
>  	struct pt_regs *regs = data;
>  
> -	switch (action) {
> -	default:
> -		die_if_kernel("Unhandled kernel unaligned access or invalid "
> +	die_if_kernel("COP2: Unhandled kernel unaligned access or invalid "
>  			      "instruction", regs);
> -		/* Fall through	 */
> -
> -	case CU2_EXCEPTION:
> -		force_sig(SIGILL, current);
> -	}
> +	force_sig(SIGILL, current);
>  
>  	return NOTIFY_OK;
>  }

The idea for cu2_chain notifiers is that they should return a value with
NOTIFY_STOP_MASK set.  That would prevent further calls to other notifiers.
The default_cu2_call() notifier is installed with the lowest possible
priority and is meant to only be called if there is no other notifier was
installed, that is on a bog standard MIPS core with no CP2.

> @@ -1080,10 +1074,11 @@ asmlinkage void do_cpu(struct pt_regs *regs)
>  	unsigned long __maybe_unused flags;
>  
>  	prev_state = exception_enter();
> -	die_if_kernel("do_cpu invoked from kernel context!", regs);
> -
>  	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
>  
> +	if (cpid != 2)
> +		die_if_kernel("do_cpu invoked from kernel context!", regs);
> +
>  	switch (cpid) {
>  	case 0:
>  		epc = (unsigned int __user *)exception_epc(regs);

I'm ok with this segment.

  Ralf
