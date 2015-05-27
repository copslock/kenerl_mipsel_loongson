Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 15:15:22 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007445AbbE0NPIsySuz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2015 15:15:08 +0200
Date:   Wed, 27 May 2015 14:15:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH 1/3] MIPS: tlb-r3k: Also invalidate wired TLB entries on
 boot
In-Reply-To: <alpine.LFD.2.11.1505261431090.11225@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1505262308070.11225@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1505261431090.11225@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47690
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

Most R3k processor implementations have their 8 first TLB entries fixed 
as wired, so we always skip them in TLB invalidation.  That however 
means any leftover entries present there at boot will stay throughout 
the life of the kernel, unless replaced with new ones.

So rename `local_flush_tlb_all' to `local_flush_tlb_from' and make it 
accept the TLB entry to start from.  Then use 0 initially at bootstrap, 
and the first regular entry later on, bypassing any wired entries.  
Wrap the latter arrangement into a new `local_flush_tlb_all' entry 
point.

There is no need to disable interrupts in the call made from `tlb_init' 
because it's made before the interrupt subsystem has been initialised; 
this is also true for secondary processors, should we ever support R3k 
SMP.  So move this piece of code to new `local_flush_tlb_all'.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Hi,

 In testing James's SysRq TLB dump feature I noticed these suspicious 
entries:

Index:  0 va=7ffff000 asid=00000dc0
  [pa=ff6fe000 n=1 d=1 v=1 g=1]
Index:  1 va=7ffff000 asid=00000dc0
  [pa=ff6fe000 n=1 d=1 v=1 g=1]
Index:  4 va=7ffff000 asid=00000fc0
  [pa=fefff000 n=1 d=1 v=1 g=1]
Index:  7 va=7ffff000 asid=00000fc0
  [pa=fffff000 n=1 d=1 v=1 g=1]

On further inspection I realised we never actually invalidate wired 
entries on classic R3k processors.  We escaped the issue with multiple 
global mappings for the last KUSEG page seen here (that would inevitably 
lead to a TLB shutdown if ever referenced) as we avoid the last 32kB of 
KUSEG page to avoid address wraparound issues with CP0.Status.UX set on 
64-bit processors.

  Maciej

linux-mips-tlb-r3k-init-flush-wired.diff
Index: linux-20150524-3maxp/arch/mips/mm/tlb-r3k.c
===================================================================
--- linux-20150524-3maxp.orig/arch/mips/mm/tlb-r3k.c
+++ linux-20150524-3maxp/arch/mips/mm/tlb-r3k.c
@@ -39,20 +39,12 @@ extern void build_tlb_refill_handler(voi
 int r3k_have_wired_reg;		/* should be in cpu_data? */
 
 /* TLB operations. */
-void local_flush_tlb_all(void)
+static void local_flush_tlb_from(int entry)
 {
-	unsigned long flags;
 	unsigned long old_ctx;
-	int entry;
-
-#ifdef DEBUG_TLB
-	printk("[tlball]");
-#endif
 
-	local_irq_save(flags);
 	old_ctx = read_c0_entryhi() & ASID_MASK;
 	write_c0_entrylo0(0);
-	entry = r3k_have_wired_reg ? read_c0_wired() : 8;
 	for (; entry < current_cpu_data.tlbsize; entry++) {
 		write_c0_index(entry << 8);
 		write_c0_entryhi((entry | 0x80000) << 12);
@@ -60,6 +52,17 @@ void local_flush_tlb_all(void)
 		tlb_write_indexed();
 	}
 	write_c0_entryhi(old_ctx);
+}
+
+void local_flush_tlb_all(void)
+{
+	unsigned long flags;
+
+#ifdef DEBUG_TLB
+	printk("[tlball]");
+#endif
+	local_irq_save(flags);
+	local_flush_tlb_from(r3k_have_wired_reg ? read_c0_wired() : 8);
 	local_irq_restore(flags);
 }
 
@@ -277,7 +280,6 @@ void add_wired_entry(unsigned long entry
 
 void tlb_init(void)
 {
-	local_flush_tlb_all();
-
+	local_flush_tlb_from(0);
 	build_tlb_refill_handler();
 }
