Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 12:08:19 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007216AbbCFLIQeEoxY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 12:08:16 +0100
Date:   Fri, 6 Mar 2015 11:08:16 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Andrew Bresticker <abrestic@chromium.org>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Provide fallback reboot/poweroff/halt
 implementations
In-Reply-To: <1425513563-9897-1-git-send-email-abrestic@chromium.org>
Message-ID: <alpine.LFD.2.11.1503061059070.15786@eddie.linux-mips.org>
References: <1425513563-9897-1-git-send-email-abrestic@chromium.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46226
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

On Wed, 4 Mar 2015, Andrew Bresticker wrote:

> If a machine-specific hook is not implemented for restart, poweroff,
> or halt, fall back to halting secondary CPUs, disabling interrupts,
> and spinning.  In the case of restart, attempt to restart the system
> via do_kernel_restart() (which will call any registered restart
> handlers) before halting.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  arch/mips/kernel/reset.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
> index 07fc524..87b1f08 100644
> --- a/arch/mips/kernel/reset.c
> +++ b/arch/mips/kernel/reset.c
> @@ -29,16 +29,36 @@ void machine_restart(char *command)
>  {
>  	if (_machine_restart)
>  		_machine_restart(command);
> +
> +#ifdef CONFIG_SMP
> +	smp_send_stop();
> +#endif
> +	do_kernel_restart(command);
> +	pr_emerg("Reboot failed -- System halted\n");
> +	local_irq_disable();
> +	while (1);

 I think it would make sense to put WAIT or suchlike in the final loop 
so that such a halted system does not suck power unnecessarily.  I think 
bits in arch/mips/kernel/idle.c should do, after some massaging.  As the 
next step perhaps, don't treat it as a NACK for this change.

  Maciej
