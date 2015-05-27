Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 15:15:41 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007447AbbE0NPPGZtDo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2015 15:15:15 +0200
Date:   Wed, 27 May 2015 14:15:15 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/3] MIPS: tlb-r3k: Move CP0.Wired register initialisation
 to `tlb_init'
In-Reply-To: <alpine.LFD.2.11.1505261431090.11225@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1505262322110.11225@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1505261431090.11225@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47691
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

Move the initialisation of the CP0.Wired register implemented by Toshiba 
TX3922 and TX3927 processors from `tx39_cache_init' to `tlb_init' where 
it belongs, correcting code structure and making sure initialisation 
does not rely on `tx39_cache_init' being called before `tlb_init' to 
work correctly.

Make `r3k_have_wired_reg' static as it's no longer externally referred 
to; remove a stale declaration too.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
James,

 You may have to reexport `r3k_have_wired_reg' if you implement R3k 
SysRq-x changes I suggested and this change goes in first.  In that case 
I suggest that you put the declaration in a header, having them 
scattered across .c files is asking for trouble.

  Maciej

linux-mips-tlb-r3k-init-wired.diff
Index: linux-20150524-3maxp/arch/mips/lib/r3k_dump_tlb.c
===================================================================
--- linux-20150524-3maxp.orig/arch/mips/lib/r3k_dump_tlb.c
+++ linux-20150524-3maxp/arch/mips/lib/r3k_dump_tlb.c
@@ -14,8 +14,6 @@
 #include <asm/pgtable.h>
 #include <asm/tlbdebug.h>
 
-extern int r3k_have_wired_reg;	/* defined in tlb-r3k.c */
-
 static void dump_tlb(int first, int last)
 {
 	int	i;
Index: linux-20150524-3maxp/arch/mips/mm/c-tx39.c
===================================================================
--- linux-20150524-3maxp.orig/arch/mips/mm/c-tx39.c
+++ linux-20150524-3maxp/arch/mips/mm/c-tx39.c
@@ -28,8 +28,6 @@ static unsigned long icache_size, dcache
 
 #include <asm/r4kcache.h>
 
-extern int r3k_have_wired_reg;	/* in r3k-tlb.c */
-
 /* This sequence is required to ensure icache is disabled immediately */
 #define TX39_STOP_STREAMING() \
 __asm__ __volatile__( \
@@ -383,8 +381,6 @@ void tx39_cache_init(void)
 	case CPU_TX3927:
 	default:
 		/* TX39/H2,H3 core (writeback 2way-set-associative cache) */
-		r3k_have_wired_reg = 1;
-		write_c0_wired(0);	/* set 8 on reset... */
 		/* board-dependent init code may set WBON */
 
 		__flush_cache_vmap	= tx39__flush_cache_vmap;
Index: linux-20150524-3maxp/arch/mips/mm/tlb-r3k.c
===================================================================
--- linux-20150524-3maxp.orig/arch/mips/mm/tlb-r3k.c
+++ linux-20150524-3maxp/arch/mips/mm/tlb-r3k.c
@@ -36,7 +36,7 @@ extern void build_tlb_refill_handler(voi
 		"nop\n\t"		\
 		".set	pop\n\t")
 
-int r3k_have_wired_reg;		/* should be in cpu_data? */
+static int r3k_have_wired_reg;			/* Should be in cpu_data? */
 
 /* TLB operations. */
 static void local_flush_tlb_from(int entry)
@@ -280,6 +280,13 @@ void add_wired_entry(unsigned long entry
 
 void tlb_init(void)
 {
+	switch (current_cpu_type()) {
+	case CPU_TX3922:
+	case CPU_TX3927:
+		r3k_have_wired_reg = 1;
+		write_c0_wired(0);		/* Set to 8 on reset... */
+		break;
+	}
 	local_flush_tlb_from(0);
 	build_tlb_refill_handler();
 }
