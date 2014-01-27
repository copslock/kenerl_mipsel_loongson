Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:35:11 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44767 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827279AbaA0UZfopZyG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:25:35 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 44/58] MIPS: asm: cpu: Add cpu flag for Enhanced Virtual Addressing
Date:   Mon, 27 Jan 2014 20:19:31 +0000
Message-ID: <1390853985-14246-45-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_25_30
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39163
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

The MIPS *Aptiv family uses bit 28 in Config5 CP0 register to
indicate whether the core supports EVA or not.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h | 4 +++-
 arch/mips/include/asm/cpu.h          | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 9052fb9..6b95c8e 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -26,7 +26,9 @@
 #ifndef cpu_has_segments
 #define cpu_has_segments	(cpu_data[0].options & MIPS_CPU_SEGMENTS)
 #endif
-
+#ifndef cpu_has_eva
+#define cpu_has_eva		(cpu_data[0].options & MIPS_CPU_EVA)
+#endif
 
 /*
  * For the moment we don't consider R6000 and R8000 so we can assume that
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 76411df..1474750 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -358,6 +358,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_MICROMIPS	0x01000000 /* CPU has microMIPS capability */
 #define MIPS_CPU_TLBINV		0x02000000 /* CPU supports TLBINV/F */
 #define MIPS_CPU_SEGMENTS	0x04000000 /* CPU supports Segmentation Control registers */
+#define MIPS_CPU_EVA		0x80000000 /* CPU supports Enhanced Virtual Addressing */
 
 /*
  * CPU ASE encodings
-- 
1.8.5.3
