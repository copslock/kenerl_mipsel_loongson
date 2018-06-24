Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jun 2018 19:08:45 +0200 (CEST)
Received: from mail.efficios.com ([167.114.142.138]:35812 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992514AbeFXRIfkDn-L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Jun 2018 19:08:35 +0200
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EA5F71B7A5F;
        Sun, 24 Jun 2018 13:08:26 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id IatNLKutw4_4; Sun, 24 Jun 2018 13:08:26 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 83BD51B7A5C;
        Sun, 24 Jun 2018 13:08:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 83BD51B7A5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529860106;
        bh=hAqvlgCUMk8xqzaVlWhPaA4bAFIJJlvbOocB3CNR07I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gPkS4mTkDIQgfC5PTogUetCIqh7+7kiZITIhdmgnyYuZRhvI9vlOri0XhXA1vDrwL
         f7Qa1Nb33gefYM47mmUAMvP/X79117qL5Pa8/kjQjOndDgZ7RRNDvJZvK2tTqP6mDr
         yh+T+Y6UuBvtzkDD5Tq22/f68FQCUHllqko//zTdCjGn2KX3OL68q9E0mfR1nQbT6e
         +FIXyuflWZNSZd/8wURx8ncYgqxl8KrPlD7R6xJdHgR0kDTlqsbnmxcHxYI/YDJ0vh
         xokzDp3z+ZLxOynjMB4my3AOPI0Za7/kyJo0h17Bf7d9OQrmYRWGErUf0u1itpY39v
         nGJodMj6LwUZQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ET7ld-2N8hyx; Sun, 24 Jun 2018 13:08:26 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 6F05C1B7A55;
        Sun, 24 Jun 2018 13:08:26 -0400 (EDT)
Date:   Sun, 24 Jun 2018 13:08:26 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <929268757.2788.1529860106385.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180624165800.2732-1-paul.burton@mips.com>
References: <20180624165800.2732-1-paul.burton@mips.com>
Subject: Re: [PATCH] MIPS: Add ksig argument to
 rseq_{signal_deliver,handle_notify_resume}
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: MIPS: Add ksig argument to rseq_{signal_deliver,handle_notify_resume}
Thread-Index: SBYsSNqHvmHZSquWL19MpbLUYdGwdQ==
Return-Path: <compudj@efficios.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mathieu.desnoyers@efficios.com
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

----- On Jun 24, 2018, at 12:58 PM, Paul Burton paul.burton@mips.com wrote:

> Commit 784e0300fe9f ("rseq: Avoid infinite recursion when delivering
> SIGSEGV") added a new ksig argument to the rseq_signal_deliver() &
> rseq_handle_notify_resume() functions, and was merged in v4.18-rc2.
> Meanwhile MIPS support for restartable sequences was also merged in
> v4.18-rc2 with commit 9ea141ad5471 ("MIPS: Add support for restartable
> sequences"), and therefore didn't get updated for the API change.
> 
> This results in build failures like the following:
> 
>    CC      arch/mips/kernel/signal.o
>  arch/mips/kernel/signal.c: In function 'handle_signal':
>  arch/mips/kernel/signal.c:804:22: error: passing argument 1 of
>    'rseq_signal_deliver' from incompatible pointer type
>    [-Werror=incompatible-pointer-types]
>    rseq_signal_deliver(regs);
>                        ^~~~
>  In file included from ./include/linux/context_tracking.h:5,
>                   from arch/mips/kernel/signal.c:12:
>  ./include/linux/sched.h:1811:56: note: expected 'struct ksignal *' but
>    argument is of type 'struct pt_regs *'
>    static inline void rseq_signal_deliver(struct ksignal *ksig,
>                                           ~~~~~~~~~~~~~~~~^~~~
>  arch/mips/kernel/signal.c:804:2: error: too few arguments to function
>    'rseq_signal_deliver'
>    rseq_signal_deliver(regs);
>    ^~~~~~~~~~~~~~~~~~~
> 
> Fix this by adding the ksig argument as was done for other architectures
> in commit 784e0300fe9f ("rseq: Avoid infinite recursion when delivering
> SIGSEGV").

Looks like we both noticed the same issue. Your commit message is more
exhaustive than mine, so yours should be merged rather than mine.

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
> 
> arch/mips/kernel/signal.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
> index 00f2535d2226..0a9cfe7a0372 100644
> --- a/arch/mips/kernel/signal.c
> +++ b/arch/mips/kernel/signal.c
> @@ -801,7 +801,7 @@ static void handle_signal(struct ksignal *ksig, struct
> pt_regs *regs)
> 		regs->regs[0] = 0;		/* Don't deal with this again.	*/
> 	}
> 
> -	rseq_signal_deliver(regs);
> +	rseq_signal_deliver(ksig, regs);
> 
> 	if (sig_uses_siginfo(&ksig->ka, abi))
> 		ret = abi->setup_rt_frame(vdso + abi->vdso->off_rt_sigreturn,
> @@ -870,7 +870,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void
> *unused,
> 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
> 		clear_thread_flag(TIF_NOTIFY_RESUME);
> 		tracehook_notify_resume(regs);
> -		rseq_handle_notify_resume(regs);
> +		rseq_handle_notify_resume(NULL, regs);
> 	}
> 
> 	user_enter();
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
