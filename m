Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Sep 2013 13:33:37 +0200 (CEST)
Received: from merlin.infradead.org ([205.233.59.134]:34263 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827301Ab3IJLd3kXctP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Sep 2013 13:33:29 +0200
Received: from dhcp-077-248-225-117.chello.nl ([77.248.225.117] helo=twins)
        by merlin.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1VJMCF-0000zx-6a; Tue, 10 Sep 2013 11:33:27 +0000
Received: by twins (Postfix, from userid 1000)
        id D478C841A696; Tue, 10 Sep 2013 13:33:22 +0200 (CEST)
Date:   Tue, 10 Sep 2013 13:33:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [RFC][PATCH] MIPS: Use pagefault_{dis,en}able for k{,un}map_coherent
Message-ID: <20130910113322.GE31370@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37778
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

Hi Ralf,

I was poking about the preempt_count muck and stumbled upon this..

Should you be using the pagefault_*() methods here?

--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -124,7 +124,7 @@ void *kmap_coherent(struct page *page, u
 
 	BUG_ON(Page_dcache_dirty(page));
 
-	inc_preempt_count();
+	pagefault_disable();
 	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
 #ifdef CONFIG_MIPS_MT_SMTC
 	idx += FIX_N_COLOURS * smp_processor_id() +
@@ -193,8 +193,7 @@ void kunmap_coherent(void)
 	write_c0_entryhi(old_ctx);
 	EXIT_CRITICAL(flags);
 #endif
-	dec_preempt_count();
-	preempt_check_resched();
+	pagefault_enable();
 }
 
 void copy_user_highpage(struct page *to, struct page *from,
