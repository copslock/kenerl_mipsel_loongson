Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2015 17:19:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7048 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011208AbbGOPR7ojSwK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2015 17:17:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 25190AF11B255;
        Wed, 15 Jul 2015 16:17:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 15 Jul 2015 16:17:53 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 15 Jul 2015 16:17:52 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 6/6] MIPS: Rearrange ENTRYLO field definitions
Date:   Wed, 15 Jul 2015 16:17:47 +0100
Message-ID: <1436973467-3877-7-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1436973467-3877-1-git-send-email-james.hogan@imgtec.com>
References: <1436973467-3877-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The generic field definitions (i.e. present before MIPS32/MIPS64) in
mipsregs.h are conventionally not prefixed with MIPS_, so rename the
recently added MIPS_ENTRYLO_* definitions for the G, V, D, and C fields
to ENTRYLO_*. Also rearrange to put the EntryLo and EntryHi definitions
in the right place in the file.

Fixes: 8ab6abcb6aa4 ("MIPS: mipsregs.h: Add EntryLo bit definitions")
Reported-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 52 +++++++++++++++++++++-------------------
 arch/mips/lib/dump_tlb.c         | 18 +++++++-------
 2 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index c5b0956a8530..922c1c435d8b 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -112,6 +112,30 @@
 #define CP0_TX39_CACHE	$7
 
 
+/* Generic EntryLo bit definitions */
+#define ENTRYLO_G		(_ULCAST_(1) << 0)
+#define ENTRYLO_V		(_ULCAST_(1) << 1)
+#define ENTRYLO_D		(_ULCAST_(1) << 2)
+#define ENTRYLO_C_SHIFT		3
+#define ENTRYLO_C		(_ULCAST_(7) << ENTRYLO_C_SHIFT)
+
+/* R3000 EntryLo bit definitions */
+#define R3K_ENTRYLO_G		(_ULCAST_(1) << 8)
+#define R3K_ENTRYLO_V		(_ULCAST_(1) << 9)
+#define R3K_ENTRYLO_D		(_ULCAST_(1) << 10)
+#define R3K_ENTRYLO_N		(_ULCAST_(1) << 11)
+
+/* MIPS32/64 EntryLo bit definitions */
+#ifdef CONFIG_64BIT
+/* as read by dmfc0 */
+#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << 62)
+#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << 63)
+#else
+/* as read by mfc0 */
+#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << 30)
+#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << 31)
+#endif
+
 /*
  * Values for PageMask register
  */
@@ -203,6 +227,9 @@
 #define PG_ESP		(_ULCAST_(1) <<	 28)
 #define PG_IEC		(_ULCAST_(1) <<  27)
 
+/* MIPS32/64 EntryHI bit definitions */
+#define MIPS_ENTRYHI_EHINV	(_ULCAST_(1) << 10)
+
 /*
  * R4x00 interrupt enable / cause bits
  */
@@ -586,31 +613,6 @@
 #define MIPS_MAAR_S		(_ULCAST_(1) << 1)
 #define MIPS_MAAR_V		(_ULCAST_(1) << 0)
 
-/*  EntryHI bit definition */
-#define MIPS_ENTRYHI_EHINV	(_ULCAST_(1) << 10)
-
-/* R3000 EntryLo bit definitions */
-#define R3K_ENTRYLO_G		(_ULCAST_(1) << 8)
-#define R3K_ENTRYLO_V		(_ULCAST_(1) << 9)
-#define R3K_ENTRYLO_D		(_ULCAST_(1) << 10)
-#define R3K_ENTRYLO_N		(_ULCAST_(1) << 11)
-
-/* R4000 compatible EntryLo bit definitions */
-#define MIPS_ENTRYLO_G		(_ULCAST_(1) << 0)
-#define MIPS_ENTRYLO_V		(_ULCAST_(1) << 1)
-#define MIPS_ENTRYLO_D		(_ULCAST_(1) << 2)
-#define MIPS_ENTRYLO_C_SHIFT	3
-#define MIPS_ENTRYLO_C		(_ULCAST_(7) << MIPS_ENTRYLO_C_SHIFT)
-#ifdef CONFIG_64BIT
-/* as read by dmfc0 */
-#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << 62)
-#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << 63)
-#else
-/* as read by mfc0 */
-#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << 30)
-#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << 31)
-#endif
-
 /* CMGCRBase bit definitions */
 #define MIPS_CMGCRB_BASE	11
 #define MIPS_CMGCRF_BASE	(~_ULCAST_((1 << MIPS_CMGCRB_BASE) - 1))
diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 64f90f626681..92a37319efbe 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -114,7 +114,7 @@ static void dump_tlb(int first, int last)
 		 * leave only a single G bit set after a machine check exception
 		 * due to duplicate TLB entry.
 		 */
-		if (!((entrylo0 | entrylo1) & MIPS_ENTRYLO_G) &&
+		if (!((entrylo0 | entrylo1) & ENTRYLO_G) &&
 		    (entryhi & 0xff) != asid)
 			continue;
 
@@ -123,8 +123,8 @@ static void dump_tlb(int first, int last)
 		 */
 		printk("Index: %2d pgmask=%s ", i, msk2str(pagemask));
 
-		c0 = (entrylo0 & MIPS_ENTRYLO_C) >> MIPS_ENTRYLO_C_SHIFT;
-		c1 = (entrylo1 & MIPS_ENTRYLO_C) >> MIPS_ENTRYLO_C_SHIFT;
+		c0 = (entrylo0 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
+		c1 = (entrylo1 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
 
 		printk("va=%0*lx asid=%02lx\n",
 		       vwidth, (entryhi & ~0x1fffUL),
@@ -141,9 +141,9 @@ static void dump_tlb(int first, int last)
 			       (entrylo0 & MIPS_ENTRYLO_XI) ? 1 : 0);
 		printk("pa=%0*llx c=%d d=%d v=%d g=%d] [",
 		       pwidth, pa, c0,
-		       (entrylo0 & MIPS_ENTRYLO_D) ? 1 : 0,
-		       (entrylo0 & MIPS_ENTRYLO_V) ? 1 : 0,
-		       (entrylo0 & MIPS_ENTRYLO_G) ? 1 : 0);
+		       (entrylo0 & ENTRYLO_D) ? 1 : 0,
+		       (entrylo0 & ENTRYLO_V) ? 1 : 0,
+		       (entrylo0 & ENTRYLO_G) ? 1 : 0);
 		/* RI/XI are in awkward places, so mask them off separately */
 		pa = entrylo1 & ~(MIPS_ENTRYLO_RI | MIPS_ENTRYLO_XI);
 		if (xpa)
@@ -155,9 +155,9 @@ static void dump_tlb(int first, int last)
 			       (entrylo1 & MIPS_ENTRYLO_XI) ? 1 : 0);
 		printk("pa=%0*llx c=%d d=%d v=%d g=%d]\n",
 		       pwidth, pa, c1,
-		       (entrylo1 & MIPS_ENTRYLO_D) ? 1 : 0,
-		       (entrylo1 & MIPS_ENTRYLO_V) ? 1 : 0,
-		       (entrylo1 & MIPS_ENTRYLO_G) ? 1 : 0);
+		       (entrylo1 & ENTRYLO_D) ? 1 : 0,
+		       (entrylo1 & ENTRYLO_V) ? 1 : 0,
+		       (entrylo1 & ENTRYLO_G) ? 1 : 0);
 	}
 	printk("\n");
 
-- 
2.3.6
