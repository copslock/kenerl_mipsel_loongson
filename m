Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 16:25:13 +0100 (BST)
Received: from gw-eur4.philips.com ([161.85.125.10]:38477 "EHLO
	gw-eur4.philips.com") by ftp.linux-mips.org with ESMTP
	id S20021404AbXGSPZL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 16:25:11 +0100
Received: from smtpscan-eur6.philips.com (smtpscan-eur6.mail.philips.com [130.144.57.169])
	by gw-eur4.philips.com (Postfix) with ESMTP id 9226949701
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 15:24:35 +0000 (UTC)
Received: from smtpscan-eur6.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP id 74B6E3E3
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 15:24:35 +0000 (GMT)
Received: from smtprelay-eur1.philips.com (smtprelay-eur1.philips.com [130.144.57.170])
	by smtpscan-eur6.philips.com (Postfix) with ESMTP id 4E2C73A0
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 15:24:35 +0000 (GMT)
Received: from lnx32www01.soton.sc.philips.com (pww.osrp.sc.philips.com [130.141.89.1])
	by smtprelay-eur1.philips.com (Postfix) with ESMTP id 146EB250D
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 15:24:35 +0000 (GMT)
Received: from krate.soton.sc.philips.com (krate [130.141.7.10])
	by lnx32www01.soton.sc.philips.com (8.13.7/8.13.7) with ESMTP id l6JFOYbh025656
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 16:24:34 +0100
Received: from stout.soton.sc.philips.com (root@stout [130.141.7.8])
	by krate.soton.sc.philips.com (8.12.11/8.12.11) with ESMTP id l6JFOT9c005242
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 16:24:29 +0100 (BST)
Received: from [130.141.93.19] (host9319 [130.141.93.19])
	by stout.soton.sc.philips.com (8.11.3/8.11.3) with ESMTP id l6JFOTl24020
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 16:24:29 +0100 (BST)
Message-ID: <469F822D.9040209@nxp.com>
Date:	Thu, 19 Jul 2007 16:24:29 +0100
From:	Daniel Laird <daniel.j.laird@nxp.com>
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix known HW bug with MIPS core on NXP/Philips PNX8550
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.j.laird@nxp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

Update Patch

Fix known bug with MIPS core when using TLB on NXP/Philips PNX8550

Signed-off-by: Daniel Laird <daniel.j.laird@nxp.com>
---
 tlb-r4k.c |    4 +++
 tlbex.c   |   71 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
---
Index: linux-2.6.22.1/arch/mips/mm/tlbex.c
===================================================================
--- linux-2.6.22.1/arch/mips/mm/tlbex.c    (revision 8)
+++ linux-2.6.22.1/arch/mips/mm/tlbex.c    (working copy)
@@ -435,6 +435,9 @@
     label_nopage_tlbm,
     label_smp_pgtable_change,
     label_r3000_write_probe_fail,
+#ifdef CONFIG_PNX8550
+    label_pnx8550_bac_reset
+#endif
 };
 
 struct label {
@@ -470,6 +473,9 @@
 L_LA(_nopage_tlbm)
 L_LA(_smp_pgtable_change)
 L_LA(_r3000_write_probe_fail)
+#ifdef CONFIG_PNX8550
+L_LA(_pnx8550_bac_reset)
+#endif
 
 /* convenience macros for instructions */
 #ifdef CONFIG_64BIT
@@ -698,6 +704,14 @@
     r_mips_pc16(r, *p, l);
     i_bgez(p, reg, 0);
 }
+#ifdef CONFIG_PNX8550
+static void il_beq(u32 **p, struct reloc **r, unsigned int reg1,
+           unsigned int reg2, enum label_id l)
+{
+    r_mips_pc16(r, *p, l);
+    i_beq(p, reg1, reg2, 0);
+}
+#endif
 
 /* The only general purpose registers allowed in TLB handlers. */
 #define K0        26
@@ -705,6 +719,7 @@
 
 /* Some CP0 registers */
 #define C0_INDEX    0, 0
+#define C0_RANDOM   1, 0
 #define C0_ENTRYLO0    2, 0
 #define C0_TCBIND    2, 2
 #define C0_ENTRYLO1    3, 0
@@ -712,6 +727,7 @@
 #define C0_BADVADDR    8, 0
 #define C0_ENTRYHI    10, 0
 #define C0_EPC        14, 0
+#define C0_CONFIG    16, 0
 #define C0_XCONTEXT    20, 0
 
 #ifdef CONFIG_64BIT
@@ -734,6 +750,57 @@
 static __initdata struct label labels[128];
 static __initdata struct reloc relocs[128];
 
+#ifdef CONFIG_PNX8550
+static void __init build_pnx8550_bug_fix( u32 **p, struct label **l, 
struct reloc **r)
+{
+#define MFC0(_reg, _cp, _sel)    \
+    ((cop0_op)  << OP_SH    \
+    | (mfc_op) << RS_SH    \
+    | (_reg)   << RT_SH    \
+    | (_cp)    << RD_SH    \
+    | (_sel))
+
+#define MTC0(_reg, _cp, _sel)    \
+    ((cop0_op)  << OP_SH    \
+    | (mtc_op) << RS_SH    \
+    | (_reg)   << RT_SH    \
+    | (_cp)    << RD_SH    \
+    | (_sel))
+
+    /* load epc and badvaddr to k0 and k1 */
+    i_MFC0(p, K0, C0_EPC);
+    i_MFC0(p, K1, C0_BADVADDR);
+
+    /* branch if code entry  */
+    il_beq(p, r, K0, K1, label_pnx8550_bac_reset);
+    i_addiu(p, K0, K0, 4);
+
+    /* branch if code entry in BDS */
+    il_beq(p, r, K0, K1, label_pnx8550_bac_reset);
+    i_nop(p);
+    /* Write data tlb entry 11..31 */
+    i_tlbwr(p);
+    i_eret(p);
+    /* BAC Reset */
+    l_pnx8550_bac_reset(l, *p);
+    **p = MFC0(K0, C0_CONFIG, 7);
+    (*p)++;
+    i_ori(p, K0, K0, (1<<14));
+
+    **p = MTC0(K0, C0_CONFIG, 7);
+    (*p)++;
+
+    /* read random reg, sub 11, div by 2 */
+    i_MFC0(p, K1, C0_RANDOM);
+    i_addiu(p, K1, K1, -11);
+    i_srl(p, K1, K1, 1);
+
+    /* use as index for tlbwi */
+    i_MTC0(p, K1, C0_INDEX);
+    i_tlbwi(p);
+}
+#endif
+
 /*
  * The R3000 TLB handler is simple.
  */
@@ -1261,8 +1328,12 @@
 
     build_get_ptep(&p, K0, K1);
     build_update_entries(&p, K0, K1);
+#ifndef CONFIG_PNX8550
     build_tlb_write_entry(&p, &l, &r, tlb_random);
     l_leave(&l, p);
+#else
+    build_pnx8550_bug_fix(&p, &l, &r);
+#endif
     i_eret(&p); /* return from trap */
 
 #ifdef CONFIG_64BIT
Index: linux-2.6.22.1/arch/mips/mm/tlb-r4k.c
===================================================================
--- linux-2.6.22.1/arch/mips/mm/tlb-r4k.c    (revision 8)
+++ linux-2.6.22.1/arch/mips/mm/tlb-r4k.c    (working copy)
@@ -456,7 +456,11 @@
      */
     probe_tlb(config);
     write_c0_pagemask(PM_DEFAULT_MASK);
+#ifdef CONFIG_SOC_PNX8550
+    write_c0_wired(11);
+#else
     write_c0_wired(0);
+#endif
     write_c0_framemask(0);
     temp_tlb_entry = current_cpu_data.tlbsize - 1;
 
