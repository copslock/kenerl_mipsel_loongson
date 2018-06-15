Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 19:41:40 +0200 (CEST)
Received: from [167.114.142.138] ([167.114.142.138]:36016 "EHLO
        mail.efficios.com" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993041AbeFORlcRrHrJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 19:41:32 +0200
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 44BF122B4F0;
        Fri, 15 Jun 2018 13:41:26 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id kGL2OF0fpHXa; Fri, 15 Jun 2018 13:41:25 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5F60C22B4EA;
        Fri, 15 Jun 2018 13:41:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5F60C22B4EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529084485;
        bh=dz8Ek6hDwHt70bS7YLmPpMoAxFFm/jf4HkSRl36mccM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=H8FYpyJhK5VzWqhFo287ExgnsIcSLgKNsVadyAoSKU+7nUNCv8YKOYKjl1/b6wKBM
         w3zr/fwp+87XCtVldCMZ2M8pLRXCWXV5g6zqdnzJyBm/txqnZlaq3ZlO3DLTOGpDHg
         d4LUWGtMsUwMPZsZuzb7yfuxGyJw9TmRw7h7aYF52GgdI6VutBKTi/Icxs3KwiKeE0
         0fAaW2EWCFiltt3QcqMT6JA4+thOb007AnsR/zRP6Hz8+3uPySNYsr7zWgTe6PVbUd
         ZUvjOiHxbox4tZxGpEN/OULGOj53z5ORh+AiM1Ljg5skIv/QgtaxbsffPZV/eIq8cx
         Q5lFNcKhFTZ+g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id kYqJBTxNb_Jn; Fri, 15 Jun 2018 13:41:25 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4739822B4E0;
        Fri, 15 Jun 2018 13:41:25 -0400 (EDT)
Date:   Fri, 15 Jun 2018 13:41:25 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        James Hogan <jhogan@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Message-ID: <1881638448.14415.1529084485237.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180614235211.31357-3-paul.burton@mips.com>
References: <20180614235211.31357-1-paul.burton@mips.com> <20180614235211.31357-3-paul.burton@mips.com>
Subject: Re: [PATCH 2/4] MIPS: Add syscall detection for restartable
 sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: MIPS: Add syscall detection for restartable sequences
Thread-Index: 8labt1W//S0SV+XkhJcEQoKv5WqiTg==
Return-Path: <compudj@efficios.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64311
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

----- On Jun 14, 2018, at 7:52 PM, Paul Burton paul.burton@mips.com wrote:

> Syscalls are not allowed inside restartable sequences, so add a call to
> rseq_syscall() at the very beginning of the system call exit path when
> CONFIG_DEBUG_RSEQ=y. This will help us to detect whether there is a
> syscall issued erroneously inside a restartable sequence.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
> 
> arch/mips/kernel/entry.S | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
> index 38a302919e6b..d7de8adcfcc8 100644
> --- a/arch/mips/kernel/entry.S
> +++ b/arch/mips/kernel/entry.S
> @@ -79,6 +79,10 @@ FEXPORT(ret_from_fork)
> 	jal	schedule_tail		# a0 = struct task_struct *prev
> 
> FEXPORT(syscall_exit)
> +#ifdef CONFIG_DEBUG_RSEQ
> +	move	a0, sp
> +	jal	rseq_syscall
> +#endif
> 	local_irq_disable		# make sure need_resched and
> 					# signals dont change between
> 					# sampling and return
> @@ -141,6 +145,10 @@ work_notifysig:				# deal with pending signals and
> 	j	resume_userspace_check
> 
> FEXPORT(syscall_exit_partial)
> +#ifdef CONFIG_DEBUG_RSEQ
> +	move	a0, sp
> +	jal	rseq_syscall
> +#endif
> 	local_irq_disable		# make sure need_resched doesn't
> 					# change between and return
> 	LONG_L	a2, TI_FLAGS($28)	# current->work

Just to double-check: you did test with CONFIG_DEBUG_RSEQ=y, right ?

Are there any live registers that need to be saved before calling
rseq_syscall ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
