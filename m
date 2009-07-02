Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 04:47:13 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:35887 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492001AbZGBCqd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Jul 2009 04:46:33 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n622ephT016293
	for <linux-mips@linux-mips.org>; Wed, 1 Jul 2009 19:40:51 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 19:40:50 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n622eoBo005980;
	Wed, 1 Jul 2009 19:40:50 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 03/15] [MTI] Clean up SPRAM support a little
To:	linux-mips@linux-mips.org
Cc:	chris@mips.com
Date:	Wed, 01 Jul 2009 19:40:25 -0700
Message-ID: <20090702024025.23268.1460.stgit@linux-raghu>
In-Reply-To: <20090702023938.23268.65453.stgit@linux-raghu>
References: <20090702023938.23268.65453.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2009 02:40:50.0928 (UTC) FILETIME=[833C7F00:01C9FABE]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Chris Dearman <chris@mips.com>

Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/include/asm/spram.h |   10 ++++++++++
 arch/mips/kernel/cpu-probe.c  |    8 +-------
 arch/mips/kernel/spram.c      |    5 ++---
 3 files changed, 13 insertions(+), 10 deletions(-)
 create mode 100644 arch/mips/include/asm/spram.h

diff --git a/arch/mips/include/asm/spram.h b/arch/mips/include/asm/spram.h
new file mode 100644
index 0000000..0b89006
--- /dev/null
+++ b/arch/mips/include/asm/spram.h
@@ -0,0 +1,10 @@
+#ifndef _MIPS_SPRAM_H
+#define _MIPS_SPRAM_H
+
+#ifdef CONFIG_CPU_MIPSR2
+extern __init void spram_config(void);
+#else
+static inline void spram_config(void) { };
+#endif /* CONFIG_CPU_MIPSR2 */
+
+#endif /* _MIPS_SPRAM_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 1abe990..2d35217 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -23,7 +23,7 @@
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 #include <asm/watch.h>
-
+#include <asm/spram.h>
 /*
  * Not all of the MIPS CPUs have the "wait" instruction available. Moreover,
  * the implementation of the "wait" feature differs between CPU families. This
@@ -711,12 +711,6 @@ static void __cpuinit decode_configs(struct cpuinfo_mips *c)
 	mips_probe_watch_registers(c);
 }
 
-#ifdef CONFIG_CPU_MIPSR2
-extern void spram_config(void);
-#else
-static inline void spram_config(void) {}
-#endif
-
 static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index 6ddb507..1821d12 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -13,7 +13,6 @@
 #include <linux/ptrace.h>
 #include <linux/stddef.h>
 
-#include <asm/cpu.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
 #include <asm/system.h>
@@ -198,8 +197,7 @@ static __cpuinit void probe_spram(char *type,
 		offset += 2 * SPRAM_TAG_STRIDE;
 	}
 }
-
-__cpuinit void spram_config(void)
+void __cpuinit spram_config(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int config0;
@@ -208,6 +206,7 @@ __cpuinit void spram_config(void)
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_74K:
+	case CPU_1004K:
 		config0 = read_c0_config();
 		/* FIXME: addresses are Malta specific */
 		if (config0 & (1<<24)) {
