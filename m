Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2014 20:26:51 +0200 (CEST)
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:41878 "EHLO
        cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009370AbaIVS0tOYNoX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Sep 2014 20:26:49 +0200
Received: from [67.246.153.56] ([67.246.153.56:50134] helo=gandalf.local.home)
        by cdptpa-oedge02 (envelope-from <rostedt@goodmis.org>)
        (ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
        id 3D/9B-04172-3E960245; Mon, 22 Sep 2014 18:26:43 +0000
Date:   Mon, 22 Sep 2014 14:26:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] MIPS: mcount: Fix selfpc address for static trace
Message-ID: <20140922142642.7f70fb0f@gandalf.local.home>
In-Reply-To: <1411392779-9554-3-git-send-email-markos.chandras@imgtec.com>
References: <1411392779-9554-1-git-send-email-markos.chandras@imgtec.com>
        <1411392779-9554-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: Claws Mail 3.10.1 (GTK+ 2.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-RR-Connecting-IP: 107.14.168.130:25
X-Cloudmark-Score: 0
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

On Mon, 22 Sep 2014 14:32:59 +0100
Markos Chandras <markos.chandras@imgtec.com> wrote:

> According to Documentation/trace/ftrace-design.txt, the selfpc
> should be the return address minus the mcount overhead (8 bytes).
> This brings static trace in line with the dynamic trace regarding
> the selfpc argument to the tracing function.
> 
> This also removes the magic number '8' with the proper
> MCOUNT_INSN_SIZE.

I could also update the generic code to handle delay slots.

-- Steve

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/kernel/mcount.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
> index 2f7c734771f4..3af48b7c7a47 100644
> --- a/arch/mips/kernel/mcount.S
> +++ b/arch/mips/kernel/mcount.S
> @@ -79,7 +79,7 @@ _mcount:
>  	PTR_S	MCOUNT_RA_ADDRESS_REG, PT_R12(sp)
>  #endif
>  
> -	PTR_SUBU a0, ra, 8	/* arg1: self address */
> +	PTR_SUBU a0, ra, MCOUNT_INSN_SIZE /* arg1: self address */
>  	PTR_LA   t1, _stext
>  	sltu     t2, a0, t1	/* t2 = (a0 < _stext) */
>  	PTR_LA   t1, _etext
> @@ -138,7 +138,7 @@ NESTED(_mcount, PT_SIZE, ra)
>  static_trace:
>  	MCOUNT_SAVE_REGS
>  
> -	move	a0, ra		/* arg1: self return address */
> +	PTR_SUBU a0, ra, MCOUNT_INSN_SIZE	/* arg1: self address */
>  	jalr	t2		/* (1) call *ftrace_trace_function */
>  	 move	a1, AT		/* arg2: parent's return address */
>  
