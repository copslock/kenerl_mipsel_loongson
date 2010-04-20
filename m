Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2010 15:56:15 +0200 (CEST)
Received: from tomts13.bellnexxia.net ([209.226.175.34]:33416 "EHLO
        tomts13-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492772Ab0DTN4L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Apr 2010 15:56:11 +0200
Received: from toip4.srvr.bell.ca ([209.226.175.87])
          by tomts13-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20100420135552.TXEF12176.tomts13-srv.bellnexxia.net@toip4.srvr.bell.ca>
          for <linux-mips@linux-mips.org>; Tue, 20 Apr 2010 09:55:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAKVOzUtGGNqG/2dsb2JhbACcAXK9S4UPBIZP
Received: from bas6-montreal19-1176033926.dsl.bell.ca (HELO krystal.dyndns.org) ([70.24.218.134])
  by toip4.srvr.bell.ca with ESMTP; 20 Apr 2010 10:10:28 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 1000)
  by krystal.dyndns.org with local; Tue, 20 Apr 2010 09:55:48 -0400
  id 001B6594.4BCDB264.00007205
Date:   Tue, 20 Apr 2010 09:55:48 -0400
From:   Mathieu Desnoyers <compudj@krystal.dyndns.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     ltt-dev@lists.casi.polymtl.ca, linux-mips@linux-mips.org
Subject: Re: [ltt-dev] [PATCH 1/3] lttng: MIPS: Fix syscall entry tracing.
Message-ID: <20100420135548.GA25175@Krystal>
References: <1271722791-27885-1-git-send-email-ddaney@caviumnetworks.com> <1271722791-27885-2-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1271722791-27885-2-git-send-email-ddaney@caviumnetworks.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.6.27.31-grsec (i686)
X-Uptime: 09:55:31 up 12 days, 23:49,  3 users,  load average: 0.37, 0.26,
        0.20
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <compudj@krystal.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: compudj@krystal.dyndns.org
Precedence: bulk
X-list: linux-mips

* David Daney (ddaney@caviumnetworks.com) wrote:
> For the 32-bit kernel and all three ABIs of the 64-bit kernel, we need
> to test the _TIF_KERNEL_TRACE flag on syscall entry.  Otherwise, no
> syscall entry tracing for you!

Merged into the LTTng tree, thanks !

Mathieu

> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/kernel/scall32-o32.S |    2 +-
>  arch/mips/kernel/scall64-64.S  |    2 +-
>  arch/mips/kernel/scall64-n32.S |    2 +-
>  arch/mips/kernel/scall64-o32.S |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
> index fd2a9bb..28f262d 100644
> --- a/arch/mips/kernel/scall32-o32.S
> +++ b/arch/mips/kernel/scall32-o32.S
> @@ -52,7 +52,7 @@ NESTED(handle_sys, PT_SIZE, sp)
>  
>  stack_done:
>  	lw	t0, TI_FLAGS($28)	# syscall tracing enabled?
> -	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
> +	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_KERNEL_TRACE
>  	and	t0, t1
>  	bnez	t0, syscall_trace_entry	# -> yes
>  
> diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
> index 18bf7f3..38c0c95 100644
> --- a/arch/mips/kernel/scall64-64.S
> +++ b/arch/mips/kernel/scall64-64.S
> @@ -54,7 +54,7 @@ NESTED(handle_sys64, PT_SIZE, sp)
>  
>  	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
>  
> -	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
> +	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_KERNEL_TRACE
>  	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
>  	and	t0, t1, t0
>  	bnez	t0, syscall_trace_entry
> diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
> index 3541fd3..fbecc01 100644
> --- a/arch/mips/kernel/scall64-n32.S
> +++ b/arch/mips/kernel/scall64-n32.S
> @@ -53,7 +53,7 @@ NESTED(handle_sysn32, PT_SIZE, sp)
>  
>  	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
>  
> -	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
> +	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_KERNEL_TRACE
>  	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
>  	and	t0, t1, t0
>  	bnez	t0, n32_syscall_trace_entry
> diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
> index 14dde4c..0db5589 100644
> --- a/arch/mips/kernel/scall64-o32.S
> +++ b/arch/mips/kernel/scall64-o32.S
> @@ -81,7 +81,7 @@ NESTED(handle_sys, PT_SIZE, sp)
>  	PTR	4b, bad_stack
>  	.previous
>  
> -	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
> +	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_KERNEL_TRACE
>  	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
>  	and	t0, t1, t0
>  	bnez	t0, trace_a_syscall
> -- 
> 1.6.6.1
> 
> 
> _______________________________________________
> ltt-dev mailing list
> ltt-dev@lists.casi.polymtl.ca
> http://lists.casi.polymtl.ca/cgi-bin/mailman/listinfo/ltt-dev
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
