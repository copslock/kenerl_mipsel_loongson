Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 18:20:34 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:42677 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022513AbYG2RU1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Jul 2008 18:20:27 +0100
Received: (qmail 9110 invoked by uid 1000); 29 Jul 2008 19:20:23 +0200
Date:	Tue, 29 Jul 2008 19:20:23 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Au1x does not need hazard workarounds.
Message-ID: <20080729172023.GA9043@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20043
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
 arch/mips/mm/tlbex.c       |   10 +++++-----
 include/asm-mips/hazards.h |    7 ++++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 76da73a..aec56b0 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -292,6 +292,11 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_R4300:
 	case CPU_5KC:
 	case CPU_TX49XX:
+	case CPU_PR4450:
+		uasm_i_nop(p);
+		tlbw(p);
+		break;
+
 	case CPU_AU1000:
 	case CPU_AU1100:
 	case CPU_AU1500:
@@ -299,11 +304,6 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_AU1200:
 	case CPU_AU1210:
 	case CPU_AU1250:
-	case CPU_PR4450:
-		uasm_i_nop(p);
-		tlbw(p);
-		break;
-
 	case CPU_R10000:
 	case CPU_R12000:
 	case CPU_R14000:
diff --git a/include/asm-mips/hazards.h b/include/asm-mips/hazards.h
index 2de638f..b4f2ed6 100644
--- a/include/asm-mips/hazards.h
+++ b/include/asm-mips/hazards.h
@@ -87,7 +87,7 @@ do {									\
 	: "=r" (tmp));							\
 } while (0)
 
-#elif defined(CONFIG_CPU_MIPSR1)
+#elif defined(CONFIG_CPU_MIPSR1) && !defined(CONFIG_MACH_ALCHEMY)
 
 /*
  * These are slightly complicated by the fact that we guarantee R1 kernels to
@@ -138,10 +138,11 @@ do {									\
 		__instruction_hazard();					\
 } while (0)
 
-#elif defined(CONFIG_CPU_R10000)
+#elif defined(CONFIG_CPU_R10000) || defined(CONFIG_MACH_ALCHEMY)
 
 /*
- * R10000 rocks - all hazards handled in hardware, so this becomes a nobrainer.
+ * R10000 and Au1 rock - all hazards handled in hardware, so this
+ * becomes a nobrainer.
  */
 
 ASMMACRO(mtc0_tlbw_hazard,
-- 
1.5.6.3
