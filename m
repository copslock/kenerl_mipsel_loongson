Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2012 22:45:06 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33695 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817539Ab2JMUo7Gf3B8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Oct 2012 22:44:59 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9DKivuI006474
        for <linux-mips@linux-mips.org>; Sat, 13 Oct 2012 22:44:58 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9DKiv3d006473
        for linux-mips@linux-mips.org; Sat, 13 Oct 2012 22:44:57 +0200
Date:   Sat, 13 Oct 2012 22:44:57 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: [PATCH] tlbex: Deal with re-definition of label
Message-ID: <20121013204457.GA5340@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The microassembler used in tlbex.c does not notice if a label is redefined
resulting in relocations against such labels silently missrelocated.
The issues exists since commit add6eb04776db4189ea89f596cbcde31b899be9d
[Synthesize TLB exception handlers at runtime.] in 2.6.10 and went unnoticed
for so long because the relocations for the affected branches got computed
to do something *almost* sensible.

Over the past years there have been a few very mysterious reports about
weird things happening on QED/IDT RM5231 / RM5261 processors; I have
a little hope this bug might be the solution.  R4000/R4400 processors
are equally affected.

The fix is a bit cheesy.  Among other reasons this is because this was
easier to implement than a gas-like local label feature and also because
it gets away without a memory allocator.

Please test this.  Thanks,

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 42a5d55..1128c7a 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -147,7 +147,14 @@ enum label_id {
 	label_leave,
 	label_vmalloc,
 	label_vmalloc_done,
-	label_tlbw_hazard,
+	label_tlbw_hazard_0,
+	label_tlbw_hazard_1,
+	label_tlbw_hazard_2,
+	label_tlbw_hazard_3,
+	label_tlbw_hazard_4,
+	label_tlbw_hazard_5,
+	label_tlbw_hazard_6,
+	label_tlbw_hazard_7,
 	label_split,
 	label_tlbl_goaround1,
 	label_tlbl_goaround2,
@@ -166,7 +173,14 @@ UASM_L_LA(_second_part)
 UASM_L_LA(_leave)
 UASM_L_LA(_vmalloc)
 UASM_L_LA(_vmalloc_done)
-UASM_L_LA(_tlbw_hazard)
+UASM_L_LA(_tlbw_hazard_0)
+UASM_L_LA(_tlbw_hazard_1)
+UASM_L_LA(_tlbw_hazard_2)
+UASM_L_LA(_tlbw_hazard_3)
+UASM_L_LA(_tlbw_hazard_4)
+UASM_L_LA(_tlbw_hazard_5)
+UASM_L_LA(_tlbw_hazard_6)
+UASM_L_LA(_tlbw_hazard_7)
 UASM_L_LA(_split)
 UASM_L_LA(_tlbl_goaround1)
 UASM_L_LA(_tlbl_goaround2)
@@ -180,6 +194,72 @@ UASM_L_LA(_large_segbits_fault)
 UASM_L_LA(_tlb_huge_update)
 #endif
 
+static int hazard_instance;
+
+static void uasm_bgezl_hazard(u32 **p, struct uasm_reloc **r, int instance)
+{
+	switch (instance) {
+	case 0:
+		uasm_il_bgezl(p, r, 0, label_tlbw_hazard_0);
+		return;
+	case 1:
+		uasm_il_bgezl(p, r, 0, label_tlbw_hazard_1);
+		return;
+	case 2:
+		uasm_il_bgezl(p, r, 0, label_tlbw_hazard_2);
+		return;
+	case 3:
+		uasm_il_bgezl(p, r, 0, label_tlbw_hazard_3);
+		return;
+	case 4:
+		uasm_il_bgezl(p, r, 0, label_tlbw_hazard_4);
+		return;
+	case 5:
+		uasm_il_bgezl(p, r, 0, label_tlbw_hazard_5);
+		return;
+	case 6:
+		uasm_il_bgezl(p, r, 0, label_tlbw_hazard_6);
+		return;
+	case 7:
+		uasm_il_bgezl(p, r, 0, label_tlbw_hazard_7);
+		return;
+	default:
+		BUG();
+	}
+}
+
+static void uasm_bgezl_label(struct uasm_label **l, u32 **p, int instance)
+{
+	switch (instance) {
+	case 0:
+		uasm_l_tlbw_hazard_0(l, *p);
+		break;
+	case 1:
+		uasm_l_tlbw_hazard_1(l, *p);
+		break;
+	case 2:
+		uasm_l_tlbw_hazard_2(l, *p);
+		break;
+	case 3:
+		uasm_l_tlbw_hazard_3(l, *p);
+		break;
+	case 4:
+		uasm_l_tlbw_hazard_4(l, *p);
+		break;
+	case 5:
+		uasm_l_tlbw_hazard_5(l, *p);
+		break;
+	case 6:
+		uasm_l_tlbw_hazard_6(l, *p);
+		break;
+	case 7:
+		uasm_l_tlbw_hazard_7(l, *p);
+		break;
+	default:
+		BUG();
+	}
+}
+
 /*
  * For debug purposes.
  */
@@ -465,9 +545,10 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		 * This branch uses up a mtc0 hazard nop slot and saves
 		 * two nops after the tlbw instruction.
 		 */
-		uasm_il_bgezl(p, r, 0, label_tlbw_hazard);
+		uasm_bgezl_hazard(p, r, hazard_instance);
 		tlbw(p);
-		uasm_l_tlbw_hazard(l, *p);
+		uasm_bgezl_label(l, p, hazard_instance);
+		hazard_instance++;
 		uasm_i_nop(p);
 		break;
 
@@ -514,13 +595,15 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 
 	case CPU_NEVADA:
 		uasm_i_nop(p); /* QED specifies 2 nops hazard */
+		uasm_i_nop(p); /* QED specifies 2 nops hazard */
 		/*
 		 * This branch uses up a mtc0 hazard nop slot and saves
 		 * a nop after the tlbw instruction.
 		 */
-		uasm_il_bgezl(p, r, 0, label_tlbw_hazard);
+		uasm_bgezl_hazard(p, r, hazard_instance);
 		tlbw(p);
-		uasm_l_tlbw_hazard(l, *p);
+		uasm_bgezl_label(l, p, hazard_instance);
+		hazard_instance++;
 		break;
 
 	case CPU_RM7000:
