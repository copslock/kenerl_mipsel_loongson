Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 14:38:56 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:10624 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21103512AbZAMOiy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jan 2009 14:38:54 +0000
Received: (qmail 18794 invoked by uid 1000); 13 Jan 2009 15:35:52 +0100
Date:	Tue, 13 Jan 2009 15:35:52 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: [RFC PATCH] Alchemy: detect Au1300
Message-ID: <20090113143552.GA18721@roarinelk.homelinux.net>
References: <20090113135302.GA18442@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090113135302.GA18442@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Add code to detect Au1300 and its variants.  c0_prid uses a layout
different from previous Alchemy chips and company ID switched to RMI.

Core and cache-wise it is compatible with previous Alchemy chips.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
This patch depends on "Alchemy: remove superfluous cpu-model constants."
Information was pieced together from the Au1300 databook, and obviously
only compile tested. (Also, the irq controller looks completely different
so this patch alone is insufficient to get linux working on it).

 arch/mips/include/asm/cpu.h  |    1 +
 arch/mips/kernel/cpu-probe.c |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 3bdc0e3..8dd3038 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -33,6 +33,7 @@
 #define PRID_COMP_TOSHIBA	0x070000
 #define PRID_COMP_LSI		0x080000
 #define PRID_COMP_LEXRA		0x0b0000
+#define PRID_COMP_RMI		0x0c0000
 #define PRID_COMP_CAVIUM	0x0d0000
 
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 0f33858..9499610 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -19,6 +19,7 @@
 #include <asm/bugs.h>
 #include <asm/cpu.h>
 #include <asm/fpu.h>
+#include <asm/io.h>
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 #include <asm/watch.h>
@@ -886,6 +887,41 @@ static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
 	}
 }
 
+static inline void cpu_probe_rmi(struct cpuinfo_mips *c, unsigned int cpu)
+{
+	decode_configs(c);
+	switch (c->processor_id & 0xff000000) {
+	case 0x80000000:		/* Au1300 */
+		c->cputype = CPU_ALCHEMY;
+
+		/* OTP-ROM Config0 register indicates the presence
+		 * of various peripherals.  Combinations of those
+		 * bits are marketed unter different names.
+		 */
+		switch (__raw_readl((void *)0xb0002000)) {
+		case 0x00000000:
+			__cpu_name[cpu] = "Au1380";
+			break;
+		case 0x0000000d:
+			__cpu_name[cpu] = "Au1370";
+			break;
+		case 0x00000010:
+			__cpu_name[cpu] = "Au1350";
+			break;
+		case 0x0000001d:
+			__cpu_name[cpu] = "Au1340";
+			break;
+		default:
+			__cpu_name[cpu] = "Au1300";
+			break;
+		}
+	default:
+		printk(KERN_INFO "Unknown RMI chip!\n");
+		c->cputype = CPU_UNKNOWN;
+		break;
+	}
+}
+
 const char *__cpu_name[NR_CPUS];
 
 __cpuinit void cpu_probe(void)
@@ -920,6 +956,9 @@ __cpuinit void cpu_probe(void)
 	case PRID_COMP_NXP:
 		cpu_probe_nxp(c, cpu);
 		break;
+	case PRID_COMP_RMI:
+		cpu_probe_rmi(c, cpu);
+		break;
 	case PRID_COMP_CAVIUM:
 		cpu_probe_cavium(c, cpu);
 		break;
-- 
1.6.1
