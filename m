Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 18:10:47 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43747 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822969Ab3KGRJ6JcA7S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 18:09:58 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 4/6] MIPS: mm: Use the TLBINVF instruction to flush the VTLB
Date:   Thu, 7 Nov 2013 17:08:38 +0000
Message-ID: <1383844120-29601-5-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com>
References: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_07_17_09_52
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

The TLBINVF instruction can be used to flush the entire VTLB.
This eliminates the need for the TLBWI loop and improves performance.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h | 13 +++++++++++++
 arch/mips/mm/tlb-r4k.c           | 18 ++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 412fe99..9cd0e13 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -685,6 +685,19 @@ static inline int mm_insn_16bit(u16 insn)
 }
 
 /*
+ * TLB Invalidate Flush
+ */
+static inline void tlbinvf(void)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set noreorder\n\t"
+		".word 0x42000004\n\t" /* tlbinvf */
+		".set pop");
+}
+
+
+/*
  * Functions to access the R10000 performance counters.	 These are basically
  * mfc0 and mtc0 instructions from and to coprocessor register with a 5-bit
  * performance counter number encoded into bits 1 ... 5 of the instruction.
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 363aa03..427dcac 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -83,13 +83,19 @@ void local_flush_tlb_all(void)
 	entry = read_c0_wired();
 
 	/* Blast 'em all away. */
-	while (entry < current_cpu_data.tlbsize) {
-		/* Make sure all entries differ. */
-		write_c0_entryhi(UNIQUE_ENTRYHI(entry));
-		write_c0_index(entry);
+	if (cpu_has_tlbinv && current_cpu_data.tlbsize) {
+		write_c0_index(0);
 		mtc0_tlbw_hazard();
-		tlb_write_indexed();
-		entry++;
+		tlbinvf();  /* invalidate VTLB */
+	} else {
+		while (entry < current_cpu_data.tlbsize) {
+			/* Make sure all entries differ. */
+			write_c0_entryhi(UNIQUE_ENTRYHI(entry));
+			write_c0_index(entry);
+			mtc0_tlbw_hazard();
+			tlb_write_indexed();
+			entry++;
+		}
 	}
 	tlbw_use_hazard();
 	write_c0_entryhi(old_ctx);
-- 
1.8.4
