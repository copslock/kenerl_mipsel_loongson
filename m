Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 01:14:44 +0100 (BST)
Received: from fed1rmmtao12.cox.net ([IPv6:::ffff:68.230.241.27]:20152 "EHLO
	fed1rmmtao12.cox.net") by linux-mips.org with ESMTP
	id <S8225240AbUJUAOj>; Thu, 21 Oct 2004 01:14:39 +0100
Received: from opus ([68.107.143.141]) by fed1rmmtao12.cox.net
          (InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
          id <20041021001430.MUIG9689.fed1rmmtao12.cox.net@opus>
          for <linux-mips@linux-mips.org>; Wed, 20 Oct 2004 20:14:30 -0400
Date: Wed, 20 Oct 2004 17:14:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-mips@linux-mips.org
Subject: [PATCH 2.6.9] KSEG/CKSEG fixes
Message-ID: <20041021001427.GA25441@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <trini@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trini@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

The following is needed to get an SB1250 to compile & boot in 64bit
mode (briefly tested).

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.9.orig/arch/mips/sibyte/sb1250/irq_handler.S
+++ linux-2.6.9/arch/mips/sibyte/sb1250/irq_handler.S
@@ -121,9 +121,14 @@
 	/*
 	 * Default...we've hit an IP[2] interrupt, which means we've got to
 	 * check the 1250 interrupt registers to figure out what to do
-	 * Need to detect which CPU we're on, now that smp_affinity is supported.
+	 * Need to detect which CPU we're on, now that smp_affinity is
+	 * supported.
 	 */
+#ifdef CONFIG_MIPS64
+	PTR_LA	v0, CKSEG1 + A_IMR_CPU0_BASE
+#else
 	PTR_LA	v0, KSEG1 + A_IMR_CPU0_BASE
+#endif
 #ifdef CONFIG_SMP
 	lw	t1, TI_CPU($28)
 	sll	t1, IMR_REGISTER_SPACING_SHIFT
--- linux-2.6.9.orig/arch/mips/mm/c-sb1.c
+++ linux-2.6.9/arch/mips/mm/c-sb1.c
@@ -488,7 +488,11 @@ void ld_mmu_sb1(void)
 	/* Special cache error handler for SB1 */
 	memcpy((void *)(CAC_BASE   + 0x100), &except_vec2_sb1, 0x80);
 	memcpy((void *)(UNCAC_BASE + 0x100), &except_vec2_sb1, 0x80);
+#ifdef CONFIG_MIPS64
+	memcpy((void *)CKSEG1ADDR(&handle_vec2_sb1), &handle_vec2_sb1, 0x80);
+#else
 	memcpy((void *)KSEG1ADDR(&handle_vec2_sb1), &handle_vec2_sb1, 0x80);
+#endif
 
 	probe_cache_sizes();
 
--- linux-2.6.9.orig/drivers/net/sb1250-mac.c
+++ linux-2.6.9/drivers/net/sb1250-mac.c
@@ -2879,8 +2879,13 @@ sbmac_init_module(void)
 		dev->mem_end = 0;
 		if (sbmac_init(dev, idx)) {
 			port = A_MAC_CHANNEL_BASE(idx);
+#ifdef CONFIG_MIPS64
+			SBMAC_WRITECSR(CKSEG1ADDR(port+R_MAC_ETHERNET_ADDR),
+					sbmac_orig_hwaddr[idx] );
+#else
 			SBMAC_WRITECSR(KSEG1ADDR(port+R_MAC_ETHERNET_ADDR),
 					sbmac_orig_hwaddr[idx] );
+#endif
 			free_netdev(dev);
 			continue;
 		}
--- linux-2.6.9.orig/arch/mips/mm/tlb-sb1.c
+++ linux-2.6.9/arch/mips/mm/tlb-sb1.c
@@ -26,14 +26,14 @@
 #ifdef CONFIG_MIPS32
 extern void except_vec0_sb1(void);
 extern void except_vec1_generic(void);
+#define UNIQUE_ENTRYHI(idx) (KSEG0 + ((idx) << (PAGE_SHIFT + 1)))
 #endif
 #ifdef CONFIG_MIPS64
 extern void except_vec0_generic(void);
 extern void except_vec1_sb1(void);
+#define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
 #endif
 
-#define UNIQUE_ENTRYHI(idx) (KSEG0 + ((idx) << (PAGE_SHIFT + 1)))
-
 /* Dump the current entry* and pagemask registers */
 static inline void dump_cur_tlb_regs(void)
 {

-- 
Tom Rini
http://gate.crashing.org/~trini/
