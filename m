Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2018 22:28:36 +0200 (CEST)
Received: from mail.efficios.com ([IPv6:2607:5300:60:7898::beef]:35642 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993426AbeFPU2aN0UNd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jun 2018 22:28:30 +0200
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 353231AD8E9;
        Sat, 16 Jun 2018 16:28:23 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id VDqYTmiV6sWp; Sat, 16 Jun 2018 16:28:22 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CA7E41AD8E5;
        Sat, 16 Jun 2018 16:28:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CA7E41AD8E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529180902;
        bh=X5vUEOdk1XyPi30VUQMQWVBkjjmEVnZ9hzsFnZdSMNs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Yq+XnrDPelamtdRVfpV+4Fb+YswBfjX7qemRDBkDYSHYJRVP4hj1P0Kbw/v1oi3zj
         dzR+xm2XkIvjSWduZ8xweacmZTv9QC+WAg6A4M0tSwNwvJNfqqw8iF4rCdi5rNt5mg
         iK0/t8eo/dN8TZkbP2nactI3MF/mdgQbxF9VFlCCW8MU1o0HXO2g0slgiz8yqLlRWK
         JWdkYisN+CQ3W9QxQIAVxpW5KCdb2xJsvRfAspAJj1w7SPNoLcYh3RK5s+9Rg+zT+O
         7y45W6m2RsWdQULHFJCBllJR9Ev7ngjHg5ToT0Jr6SyAl7TE1asDLPUpCz7KfwgdQt
         gLDNenwvAPw1Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Z9MkFkHz-BZq; Sat, 16 Jun 2018 16:28:22 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B30D91AD8DF;
        Sat, 16 Jun 2018 16:28:22 -0400 (EDT)
Date:   Sat, 16 Jun 2018 16:28:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        James Hogan <jhogan@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Message-ID: <1395794863.16071.1529180902679.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180615184317.vogskh6rg53kfuzz@pburton-laptop>
References: <20180614235211.31357-1-paul.burton@mips.com> <20180614235211.31357-3-paul.burton@mips.com> <1881638448.14415.1529084485237.JavaMail.zimbra@efficios.com> <20180615184317.vogskh6rg53kfuzz@pburton-laptop>
Subject: Re: [PATCH 2/4] MIPS: Add syscall detection for restartable
 sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: MIPS: Add syscall detection for restartable sequences
Thread-Index: SlHyYEUEN8xEhKN/NjbikbkJQDt2ag==
Return-Path: <compudj@efficios.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64327
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

----- On Jun 15, 2018, at 2:43 PM, Paul Burton paul.burton@mips.com wrote:

> Hi Mathieu,
> 
> On Fri, Jun 15, 2018 at 01:41:25PM -0400, Mathieu Desnoyers wrote:
>> > diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
>> > index 38a302919e6b..d7de8adcfcc8 100644
>> > --- a/arch/mips/kernel/entry.S
>> > +++ b/arch/mips/kernel/entry.S
>> > @@ -79,6 +79,10 @@ FEXPORT(ret_from_fork)
>> > 	jal	schedule_tail		# a0 = struct task_struct *prev
>> > 
>> > FEXPORT(syscall_exit)
>> > +#ifdef CONFIG_DEBUG_RSEQ
>> > +	move	a0, sp
>> > +	jal	rseq_syscall
>> > +#endif
>> > 	local_irq_disable		# make sure need_resched and
>> > 					# signals dont change between
>> > 					# sampling and return
>> > @@ -141,6 +145,10 @@ work_notifysig:				# deal with pending signals and
>> > 	j	resume_userspace_check
>> > 
>> > FEXPORT(syscall_exit_partial)
>> > +#ifdef CONFIG_DEBUG_RSEQ
>> > +	move	a0, sp
>> > +	jal	rseq_syscall
>> > +#endif
>> > 	local_irq_disable		# make sure need_resched doesn't
>> > 					# change between and return
>> > 	LONG_L	a2, TI_FLAGS($28)	# current->work
>> 
>> Just to double-check: you did test with CONFIG_DEBUG_RSEQ=y, right ?
> 
> Yes, I did. Although I only ran the selftests, which I don't believe
> would actually trigger the SIGSEGV condition.

Yeah, I typically hand-craft a critical section that generate a
system call in order to trigger this. It's hackish however, and
only triggers the SIGSEGV on kernels with CONFIG_DEBUG_RSEQ=y.

> 
> Side-note: maybe it'd be useful to have a test that does intentionally
> perform a syscall within a restartable sequence & checks that it
> actually receives a SIGSEGV?.

We'd have to craft asm code for each architecture issuing a system
call in a rseq c.s. to test this. And we'd need to make this test
only runs on a kernel with CONFIG_DEBUG_RSEQ=y.

I'm not convinced yet it's worth the effort to cleanly integrate this
in selftests, but I'm very open to the idea.

> 
>> Are there any live registers that need to be saved before calling
>> rseq_syscall ?
> 
> No - we just need gp/$28 & sp/$29, and the calling convention means
> rseq_syscall() should return with those unmodified. Everything else that
> we or userland care about is about to be loaded from the stack anyway.

Sounds good!

Thanks,

Mathieu

> 
> Thanks,
>     Paul

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
