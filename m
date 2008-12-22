Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Dec 2008 19:21:17 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:10680 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24208361AbYLVTVO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Dec 2008 19:21:14 +0000
Received: (qmail 15755 invoked from network); 22 Dec 2008 20:20:50 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 22 Dec 2008 20:20:50 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 1/2] Alchemy: MIPS hazard workarounds are not required.
Date:	Mon, 22 Dec 2008 20:21:07 +0100
Message-Id: <1229973668-18182-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Quoting the Au1xxx manuals:
"All pipeline hazards and dependencies are enforced by hardware interlocks
 so that any sequence of instructions is guaranteed to execute correctly.
 Therefore, it is not necessary to pad legacy MIPS hazards (such as
 load delay slots and coprocessor accesses) with NOPs."

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/include/asm/hazards.h |    5 +++--
 arch/mips/mm/tlbex.c            |   14 +++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 43baed1..0a0f241 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -87,7 +87,7 @@ do {									\
 	: "=r" (tmp));							\
 } while (0)
 
-#elif defined(CONFIG_CPU_MIPSR1)
+#elif defined(CONFIG_CPU_MIPSR1) && !defined(CONFIG_MACH_ALCHEMY)
 
 /*
  * These are slightly complicated by the fact that we guarantee R1 kernels to
@@ -138,7 +138,8 @@ do {									\
 		__instruction_hazard();					\
 } while (0)
 
-#elif defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_CAVIUM_OCTEON)
+#elif defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_CAVIUM_OCTEON)	\
+   || defined(CONFIG_MACH_ALCHEMY)
 
 /*
  * R10000 rocks - all hazards handled in hardware, so this becomes a nobrainer.
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 4294203..c36e8c2 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -292,13 +292,6 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_R4300:
 	case CPU_5KC:
 	case CPU_TX49XX:
-	case CPU_AU1000:
-	case CPU_AU1100:
-	case CPU_AU1500:
-	case CPU_AU1550:
-	case CPU_AU1200:
-	case CPU_AU1210:
-	case CPU_AU1250:
 	case CPU_PR4450:
 		uasm_i_nop(p);
 		tlbw(p);
@@ -318,6 +311,13 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_BCM4710:
 	case CPU_LOONGSON2:
 	case CPU_CAVIUM_OCTEON:
+	case CPU_AU1000:
+	case CPU_AU1100:
+	case CPU_AU1500:
+	case CPU_AU1550:
+	case CPU_AU1200:
+	case CPU_AU1210:
+	case CPU_AU1250:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
 		tlbw(p);
-- 
1.6.0.4
