Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 07:32:02 +0100 (BST)
Received: from crux.i-cable.com ([203.83.115.104]:41017 "HELO crux.i-cable.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20023632AbZEHGax (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 May 2009 07:30:53 +0100
Received: (qmail 2501 invoked by uid 107); 8 May 2009 06:30:44 -0000
Received: from 203.83.114.121 by crux (envelope-from <r0bertz@gentoo.org>, uid 104) with qmail-scanner-2.01 
 (clamdscan: 0.94.2/9149. spamassassin: 2.63.   
 Clear:RC:1(203.83.114.121):SA:0(2.6/5.0):. 
 Processed in 8.376433 secs); 08 May 2009 06:30:44 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 8 May 2009 06:30:36 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n486UVwj000812;
	Fri, 8 May 2009 14:30:35 +0800 (HKT)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH 1/3] MIPS: added cpu_has_uncached_accelerated feature
Date:	Fri,  8 May 2009 14:30:01 +0800
Message-Id: <a1356a5b181a188435ff569b4f7abe57cf8fd7eb.1241764065.git.r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <cover.1241764064.git.r0bertz@gentoo.org>
References: <cover.1241764064.git.r0bertz@gentoo.org>
In-Reply-To: <cover.1241764064.git.r0bertz@gentoo.org>
References: <cover.1241764064.git.r0bertz@gentoo.org>
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 arch/mips/include/asm/cpu-features.h |    4 ++++
 arch/mips/include/asm/cpu.h          |    1 +
 arch/mips/kernel/cpu-probe.c         |    4 ++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index c0047f8..63a34d3 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -220,6 +220,10 @@
 #define cpu_has_inclusive_pcaches	(cpu_data[0].options & MIPS_CPU_INCLUSIVE_CACHES)
 #endif
 
+#ifndef cpu_has_uncached_accelerated
+#define cpu_has_uncached_accelerated	(cpu_data[0].options & MIPS_CPU_UNCACHED_ACCELERATED)
+#endif
+
 #ifndef cpu_dcache_line_size
 #define cpu_dcache_line_size()	cpu_data[0].dcache.linesz
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 3bdc0e3..846477b 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -265,6 +265,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_VINT		0x00080000 /* CPU supports MIPSR2 vectored interrupts */
 #define MIPS_CPU_VEIC		0x00100000 /* CPU supports MIPSR2 external interrupt controller mode */
 #define MIPS_CPU_ULRI		0x00200000 /* CPU has ULRI feature */
+#define MIPS_CPU_UNCACHED_ACCELERATED	0x00400000 /* CPU has uncached accelerated feature */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b13b8eb..1910ccf 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -547,7 +547,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->options = MIPS_CPU_TLB | MIPS_CPU_4K_CACHE | MIPS_CPU_4KEX |
 		             MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
-		             MIPS_CPU_LLSC;
+		             MIPS_CPU_LLSC | MIPS_CPU_UNCACHED_ACCELERATED;
 		c->tlbsize = 64;
 		break;
 	case PRID_IMP_R12000:
@@ -576,7 +576,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS |
 			     MIPS_CPU_FPU | MIPS_CPU_LLSC |
-			     MIPS_CPU_32FPR;
+			     MIPS_CPU_32FPR | MIPS_CPU_UNCACHED_ACCELERATED;
 		c->tlbsize = 64;
 		break;
 	}
-- 
1.6.2.3
