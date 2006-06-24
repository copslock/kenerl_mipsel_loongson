Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2006 03:07:26 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:40888 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133929AbWFXCHP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jun 2006 03:07:15 +0100
Received: (qmail 10822 invoked by uid 101); 24 Jun 2006 02:07:08 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 24 Jun 2006 02:07:08 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k5O278AW008558;
	Fri, 23 Jun 2006 19:07:08 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF7KJ3J>; Fri, 23 Jun 2006 19:07:08 -0700
Message-ID: <C28979E4F697C249ABDA83AC0C33CDF8143EF9@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
Subject: [PATCH 5/6] RM9000 arch, WAR
Date:	Fri, 23 Jun 2006 19:06:57 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Kiran_Thota@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kiran_Thota@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


- Add code to flush scache also (need to revisit if any missing)
- Add init code for scache
- Add WAR for E9000 ENTRYHI bug, aha! And this brings back OPCODE for "or"

Signed-off-by: Kiran Kumar Thota <kiran_thota@pmc-sierra.com>


diff -Naur a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
--- a/arch/mips/mm/c-r4k.c	2005-07-11 11:28:10.000000000 -0700
+++ b/arch/mips/mm/c-r4k.c	2006-06-22 11:48:21.000000000 -0700
@@ -649,7 +649,11 @@
 		a = addr & ~(dc_lsize - 1);
 		end = (addr + size - 1) & ~(dc_lsize - 1);
 		while (1) {
+#ifdef CONFIG_CPU_RM9000
+			flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
+#else
 			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
+#endif
 			if (a == end)
 				break;
 			a += dc_lsize;
@@ -694,7 +698,11 @@
 		a = addr & ~(dc_lsize - 1);
 		end = (addr + size - 1) & ~(dc_lsize - 1);
 		while (1) {
+#ifdef CONFIG_CPU_RM9000
+			flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
+#else
 			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
+#endif
 			if (a == end)
 				break;
 			a += dc_lsize;
@@ -1164,6 +1172,9 @@
 	case CPU_RM9000:
 #ifdef CONFIG_RM7000_CPU_SCACHE
 		rm7k_sc_init();
+#ifdef CONFIG_CPU_RM9000
+		sc_present = 1;
+#endif
 #endif
 		return;
 
diff -Naur a/arch/mips/mm/sc-rm7k.c b/arch/mips/mm/sc-rm7k.c
--- a/arch/mips/mm/sc-rm7k.c	2005-07-11 11:28:10.000000000 -0700
+++ b/arch/mips/mm/sc-rm7k.c	2006-06-22 11:48:21.000000000 -0700
@@ -144,6 +144,9 @@
 void __init rm7k_sc_init(void)
 {
 	unsigned int config = read_c0_config();
+#ifdef CONFIG_CPU_RM9000
+	struct cpuinfo_mips *c = &current_cpu_data;
+#endif
 
 	if ((config & RM7K_CONF_SC))
 		return;
@@ -154,6 +157,12 @@
 	if (!(config & RM7K_CONF_SE))
 		rm7k_sc_enable();
 
+#ifdef CONFIG_CPU_RM9000
+	c->scache.linesz = 16<<((config & R4K_CONF_SB) >> 22);
+	c->scache.ways = 4;
+	c->scache.waybit = 5;
+	c->options |= MIPS_CPU_CACHE_CDEX_S;
+#endif
 	/*
 	 * While we're at it let's deal with the tertiary cache.
 	 */
diff -Naur a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
--- a/arch/mips/mm/tlbex.c	2005-07-11 11:28:10.000000000 -0700
+++ b/arch/mips/mm/tlbex.c	2006-06-22 12:24:19.000000000 -0700
@@ -50,6 +50,12 @@
 	return R10000_LLSC_WAR;
 }
 
+static __init int __attribute__((unused)) e9000_llsc_war(void)
+{
+	return E9000_ENTRYHI_WAR;
+}
+
+
 /*
  * A little micro-assembler, intended for TLB refill handler
  * synthesizing. It is intentionally kept simple, does only support
@@ -95,7 +101,7 @@
 	insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
 	insn_dsubu, insn_eret, insn_j, insn_jal, insn_jr, insn_ld,
 	insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0, insn_mtc0,
-	insn_ori, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
+	insn_or, insn_ori, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
 	insn_sra, insn_srl, insn_subu, insn_sw, insn_tlbp, insn_tlbwi,
 	insn_tlbwr, insn_xor, insn_xori
 };
@@ -147,6 +153,7 @@
 	{ insn_lw, M(lw_op,0,0,0,0,0), RS | RT | SIMM },
 	{ insn_mfc0, M(cop0_op,mfc_op,0,0,0,0), RT | RD },
 	{ insn_mtc0, M(cop0_op,mtc_op,0,0,0,0), RT | RD },
+	{ insn_or, M(spec_op,0,0,0,0,or_op), RS | RT | RD },
 	{ insn_ori, M(ori_op,0,0,0,0,0), RS | RT | UIMM },
 	{ insn_rfe, M(cop0_op,cop_op,0,0,0,rfe_op), 0 },
 	{ insn_sc, M(sc_op,0,0,0,0,0), RS | RT | SIMM },
@@ -378,6 +385,7 @@
 I_u2s3u1(_lw);
 I_u1u2(_mfc0);
 I_u1u2(_mtc0);
+I_u3u1u2(_or);
 I_u2u1u3(_ori);
 I_0(_rfe);
 I_u2s3u1(_sc);
@@ -1157,6 +1165,16 @@
 		/* No need for i_nop */
 	}
 
+	if (e9000_llsc_war()) {
+		i_MFC0(&p, K0, C0_BADVADDR);
+		i_MFC0(&p, K1, C0_ENTRYHI);
+		i_ori(&p, K0, K0, 0x1fff);
+		i_xori(&p, K0, K0, 0x1fff);
+		i_andi(&p, K1, K1, 0x0fff);
+		i_or(&p, K0, K0, K1);
+		i_MTC0(&p, K0, C0_ENTRYHI);
+        }
+
 #ifdef CONFIG_MIPS64
 	build_get_pmde64(&p, &l, &r, K0, K1); /* get pmd in K1 */
 #else
@@ -1665,6 +1683,16 @@
 		/* No need for i_nop */
 	}
 
+        if (e9000_llsc_war()) {
+                i_MFC0(&p, K0, C0_BADVADDR);
+                i_MFC0(&p, K1, C0_ENTRYHI);
+                i_ori(&p, K0, K0, 0x1fff);
+                i_xori(&p, K0, K0, 0x1fff);
+                i_andi(&p, K1, K1, 0x0fff);
+                i_or(&p, K0, K0, K1);
+                i_MTC0(&p, K0, C0_ENTRYHI);
+        }
+
 	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
 	build_pte_present(&p, &l, &r, K0, K1, label_nopage_tlbl);
 	build_make_valid(&p, &r, K0, K1);
@@ -1704,6 +1732,16 @@
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
+        if (e9000_llsc_war()) {
+                i_MFC0(&p, K0, C0_BADVADDR);
+                i_MFC0(&p, K1, C0_ENTRYHI);
+                i_ori(&p, K0, K0, 0x1fff);
+                i_xori(&p, K0, K0, 0x1fff);
+                i_andi(&p, K1, K1, 0x0fff);
+                i_or(&p, K0, K0, K1);
+                i_MTC0(&p, K0, C0_ENTRYHI);
+        }
+
 	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
 	build_pte_writable(&p, &l, &r, K0, K1, label_nopage_tlbs);
 	build_make_write(&p, &r, K0, K1);
@@ -1743,6 +1781,16 @@
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
+        if (e9000_llsc_war()) {
+                i_MFC0(&p, K0, C0_BADVADDR);
+                i_MFC0(&p, K1, C0_ENTRYHI);
+                i_ori(&p, K0, K0, 0x1fff);
+                i_xori(&p, K0, K0, 0x1fff);
+                i_andi(&p, K1, K1, 0x0fff);
+                i_or(&p, K0, K0, K1);
+                i_MTC0(&p, K0, C0_ENTRYHI);
+        }
+
 	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
 	build_pte_modifiable(&p, &l, &r, K0, K1, label_nopage_tlbm);
 	/* Present and writable bits set, set accessed and dirty bits. */
diff -Naur a/include/asm-mips/war.h b/include/asm-mips/war.h
--- a/include/asm-mips/war.h	2005-07-11 11:28:10.000000000 -0700
+++ b/include/asm-mips/war.h	2006-06-22 11:48:21.000000000 -0700
@@ -182,10 +182,16 @@
  * being fetched may case spurious exceptions.
  */
 #if defined(CONFIG_MOMENCO_JAGUAR_ATX) || defined(CONFIG_MOMENCO_OCELOT_3) || \
-    defined(CONFIG_PMC_YOSEMITE)
+    defined(CONFIG_PMC_YOSEMITE) || defined(CONFIG_PMC_SEQUOIA)
 #define ICACHE_REFILLS_WORKAROUND_WAR	1
 #endif
 
+/* E9000 has a bug - The EntryHi register gets corrupt in some exceptional cases */
+#if defined(CONFIG_MOMENCO_JAGUAR_ATX) || defined(CONFIG_MOMENCO_OCELOT_3) || \
+    defined(CONFIG_PMC_YOSEMITE) || defined(CONFIG_PMC_SEQUOIA)
+#define E9000_ENTRYHI_WAR	1
+#endif
+
 
 /*
  * ON the R10000 upto version 2.6 (not sure about 2.7) there is a bug that
@@ -198,6 +204,9 @@
 /*
  * Workarounds default to off
  */
+#ifndef E9000_ENTRYHI_WAR
+#define E9000_ENTRYHI_WAR		0
+#endif
 #ifndef ICACHE_REFILLS_WORKAROUND_WAR
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #endif
