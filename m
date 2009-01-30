Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2009 17:30:23 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:1742 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21366381AbZA3R3h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Jan 2009 17:29:37 +0000
Received: (qmail 16263 invoked from network); 30 Jan 2009 18:29:36 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 30 Jan 2009 18:29:36 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 3/3] Alchemy: MIPS hazard workarounds are not required.
Date:	Fri, 30 Jan 2009 18:30:11 +0100
Message-Id: <1233336611-6450-3-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.1.1
In-Reply-To: <1233336611-6450-2-git-send-email-mano@roarinelk.homelinux.net>
References: <1233336611-6450-1-git-send-email-mano@roarinelk.homelinux.net>
 <1233336611-6450-2-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

The Alchemy manuals state:

"All pipeline hazards and dependencies are enforced by hardware interlocks
 so that any sequence of instructions is guaranteed to execute correctly.
 Therefore, it is not necessary to pad legacy MIPS hazards (such as
 load delay slots and coprocessor accesses) with NOPs."

Run-tested on Au12x0, without any ill effects.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/include/asm/hazards.h |    5 +++--
 arch/mips/mm/tlbex.c            |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 43baed1..7cb68a4 100644
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
+#elif defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_CAVIUM_OCTEON) ||\
+      defined(CONFIG_MACH_ALCHEMY)
 
 /*
  * R10000 rocks - all hazards handled in hardware, so this becomes a nobrainer.
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 00ac573..bb58628 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -292,7 +292,6 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_R4300:
 	case CPU_5KC:
 	case CPU_TX49XX:
-	case CPU_ALCHEMY:
 	case CPU_PR4450:
 		uasm_i_nop(p);
 		tlbw(p);
@@ -312,6 +311,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_BCM4710:
 	case CPU_LOONGSON2:
 	case CPU_CAVIUM_OCTEON:
+	case CPU_ALCHEMY:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
 		tlbw(p);
-- 
1.6.1.1
