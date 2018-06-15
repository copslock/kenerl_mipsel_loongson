Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 20:43:53 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:38224 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993030AbeFOSnp2WwpN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 20:43:45 +0200
Received: from mipsdag03.mipstec.com (mail3.mips.com [12.201.5.33]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Fri, 15 Jun 2018 18:43:17 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag03.mipstec.com
 (10.20.40.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 15
 Jun 2018 11:43:29 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Fri, 15 Jun
 2018 11:43:29 -0700
Date:   Fri, 15 Jun 2018 11:43:17 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     linux-mips <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        James Hogan <jhogan@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/4] MIPS: Add syscall detection for restartable sequences
Message-ID: <20180615184317.vogskh6rg53kfuzz@pburton-laptop>
References: <20180614235211.31357-1-paul.burton@mips.com>
 <20180614235211.31357-3-paul.burton@mips.com>
 <1881638448.14415.1529084485237.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1881638448.14415.1529084485237.JavaMail.zimbra@efficios.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529088197-321457-25892-1763-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.33
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194092
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: mathieu.desnoyers@efficios.com,linux-mips@linux-mips.org,peterz@infradead.org,jhogan@kernel.org,linux-kernel@vger.kernel.org,boqun.feng@gmail.com,paulmck@linux.vnet.ibm.com,ralf@linux-mips.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Mathieu,

On Fri, Jun 15, 2018 at 01:41:25PM -0400, Mathieu Desnoyers wrote:
> > diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
> > index 38a302919e6b..d7de8adcfcc8 100644
> > --- a/arch/mips/kernel/entry.S
> > +++ b/arch/mips/kernel/entry.S
> > @@ -79,6 +79,10 @@ FEXPORT(ret_from_fork)
> > 	jal	schedule_tail		# a0 = struct task_struct *prev
> > 
> > FEXPORT(syscall_exit)
> > +#ifdef CONFIG_DEBUG_RSEQ
> > +	move	a0, sp
> > +	jal	rseq_syscall
> > +#endif
> > 	local_irq_disable		# make sure need_resched and
> > 					# signals dont change between
> > 					# sampling and return
> > @@ -141,6 +145,10 @@ work_notifysig:				# deal with pending signals and
> > 	j	resume_userspace_check
> > 
> > FEXPORT(syscall_exit_partial)
> > +#ifdef CONFIG_DEBUG_RSEQ
> > +	move	a0, sp
> > +	jal	rseq_syscall
> > +#endif
> > 	local_irq_disable		# make sure need_resched doesn't
> > 					# change between and return
> > 	LONG_L	a2, TI_FLAGS($28)	# current->work
> 
> Just to double-check: you did test with CONFIG_DEBUG_RSEQ=y, right ?

Yes, I did. Although I only ran the selftests, which I don't believe
would actually trigger the SIGSEGV condition.

Side-note: maybe it'd be useful to have a test that does intentionally
perform a syscall within a restartable sequence & checks that it
actually receives a SIGSEGV?.

> Are there any live registers that need to be saved before calling
> rseq_syscall ?

No - we just need gp/$28 & sp/$29, and the calling convention means
rseq_syscall() should return with those unmodified. Everything else that
we or userland care about is about to be loaded from the stack anyway.

Thanks,
    Paul
