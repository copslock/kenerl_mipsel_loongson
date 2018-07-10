Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 12:54:57 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:52872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeGJKyu3t-Mz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jul 2018 12:54:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wT/D8dlh+DEbPPAlvljqwIB07NujI0kOqV6KWQyouFY=; b=odEof8dXHdzL6xFQh1+wAiWKC
        fNFBW84S1PiDCW8vJnZOyavBIqFbUOZhepi0UloKVKxfAgGRiRGeWADHq4fr3VQufVZBnHA9NgB0M
        lSFHRHBKgZ9Aj8p979ZbNvE42TI1guZawod9GrwRrhAcr3jgy7KpdpfCfN2vtOEU+Aq6/C9QXn/YN
        eg8QB7VgCGKDAT+piCFGcPJYjKjh3AkJfSgBdwT6bXkzWFKDnLd6EKyUtmxYrSbgno/2TMOQXe4s2
        OEXR0hdPc70aGNjFybiUsC/OMLzMUpQ7Li8EPPRNFbEbBRvMGHf8kOX75Ii0xHjTsoJLHHsWTNQwE
        7HaqSLa2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcqI4-0007YB-5M; Tue, 10 Jul 2018 10:54:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3E45203E577F; Tue, 10 Jul 2018 12:54:37 +0200 (CEST)
Date:   Tue, 10 Jul 2018 12:54:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180710105437.GT2512@hirez.programming.kicks-ass.net>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
 <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
 <20180710093637.GF2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710093637.GF2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Tue, Jul 10, 2018 at 11:36:37AM +0200, Peter Zijlstra wrote:

> So now explain why the cpu_relax() hack that arm did doesn't work for
> you?

So below is the patch I think you want; if not explain in detail how
this is wrong.

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index af34afbc32d9..e59773de6528 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -386,7 +386,17 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
 #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
 
+#ifdef CONFIG_CPU_LOONGSON3
+/*
+ * Loongson-3 has a CPU bug where the store buffer gets starved when stuck in a
+ * read loop. Since spin loops of any kind should have a cpu_relax() in them,
+ * force a store-buffer flush from cpu_relax() such that any pending writes
+ * will become available as expected.
+ */
+#define cpu_relax()	smp_mb()
+#else
 #define cpu_relax()	barrier()
+#endif
 
 /*
  * Return_address is a replacement for __builtin_return_address(count)
