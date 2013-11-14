Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2013 17:15:52 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:1076 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865326Ab3KNQM7CoOj3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Nov 2013 17:12:59 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2 09/12] MIPS: Add function for flushing the TLB using the TLBINV instruction
Date:   Thu, 14 Nov 2013 16:12:29 +0000
Message-ID: <1384445552-30573-10-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
References: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_14_16_12_59
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38529
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

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 0558f9b..d9910a1 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -705,6 +705,19 @@ static inline int mm_insn_16bit(u16 insn)
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
-- 
1.8.4.3
