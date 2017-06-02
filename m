Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 00:39:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20455 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993914AbdFBWi5lKvv3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 00:38:57 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 89C868E25227F;
        Fri,  2 Jun 2017 23:38:45 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 23:38:49
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/6] MIPS: Add CPU shared FTLB feature detection
Date:   Fri, 2 Jun 2017 15:38:01 -0700
Message-ID: <20170602223806.5078-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602223806.5078-1-paul.burton@imgtec.com>
References: <20170602223806.5078-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Some systems share FTLB RAMs or entries between sibling CPUs (ie.
hardware threads, or VP(E)s, within a core). These properties require
kernel handling in various places. As a start this patch introduces
cpu_has_shared_ftlb_ram & cpu_has_shared_ftlb_entries feature macros
which we set appropriately for I6400 & I6500 CPUs. Further patches will
make use of these macros as appropriate.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---
This depends upon my "MIPS: Probe the I6500 CPU" patch being applied
first in order to make use of CPU_I6500.

 arch/mips/include/asm/cpu-features.h | 41 ++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/cpu.h          |  4 ++++
 arch/mips/kernel/cpu-probe.c         | 11 ++++++++++
 3 files changed, 56 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 494d38274142..d6ea8e7c5107 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -487,6 +487,47 @@
 # define cpu_has_perf		(cpu_data[0].options & MIPS_CPU_PERF)
 #endif
 
+#if defined(CONFIG_SMP) && defined(__mips_isa_rev) && (__mips_isa_rev >= 6)
+/*
+ * Some systems share FTLB RAMs between threads within a core (siblings in
+ * kernel parlance). This means that FTLB entries may become invalid at almost
+ * any point when an entry is evicted due to a sibling thread writing an entry
+ * to the shared FTLB RAM.
+ *
+ * This is only relevant to SMP systems, and the only systems that exhibit this
+ * property implement MIPSr6 or higher so we constrain support for this to
+ * kernels that will run on such systems.
+ */
+# ifndef cpu_has_shared_ftlb_ram
+#  define cpu_has_shared_ftlb_ram \
+	(current_cpu_data.options & MIPS_CPU_SHARED_FTLB_RAM)
+# endif
+
+/*
+ * Some systems take this a step further & share FTLB entries between siblings.
+ * This is implemented as TLB writes happening as usual, but if an entry
+ * written by a sibling exists in the shared FTLB for a translation which would
+ * otherwise cause a TLB refill exception then the CPU will use the entry
+ * written by its sibling rather than triggering a refill & writing a matching
+ * TLB entry for itself.
+ *
+ * This is naturally only valid if a TLB entry is known to be suitable for use
+ * on all siblings in a CPU, and so it only takes effect when MMIDs are in use
+ * rather than ASIDs or when a TLB entry is marked global.
+ */
+# ifndef cpu_has_shared_ftlb_entries
+#  define cpu_has_shared_ftlb_entries \
+	(current_cpu_data.options & MIPS_CPU_SHARED_FTLB_ENTRIES)
+# endif
+#endif /* SMP && __mips_isa_rev >= 6 */
+
+#ifndef cpu_has_shared_ftlb_ram
+# define cpu_has_shared_ftlb_ram 0
+#endif
+#ifndef cpu_has_shared_ftlb_entries
+# define cpu_has_shared_ftlb_entries 0
+#endif
+
 /*
  * Guest capabilities
  */
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 3069359b0120..9bc820c4e1ed 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -417,6 +417,10 @@ enum cpu_type_enum {
 #define MIPS_CPU_GUESTID	MBIT_ULL(51)	/* CPU uses VZ ASE GuestID feature */
 #define MIPS_CPU_DRG		MBIT_ULL(52)	/* CPU has VZ Direct Root to Guest (DRG) */
 #define MIPS_CPU_UFR		MBIT_ULL(53)	/* CPU supports User mode FR switching */
+#define MIPS_CPU_SHARED_FTLB_RAM \
+				MBIT_ULL(54)	/* CPU shares FTLB RAM with another */
+#define MIPS_CPU_SHARED_FTLB_ENTRIES \
+				MBIT_ULL(55)	/* CPU shares FTLB entries with another */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 353ade2c130a..8135002116df 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1653,6 +1653,17 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 	decode_configs(c);
 
 	spram_config();
+
+	switch (__get_cpu_type(c->cputype)) {
+	case CPU_I6500:
+		c->options |= MIPS_CPU_SHARED_FTLB_ENTRIES;
+		/* fall-through */
+	case CPU_I6400:
+		c->options |= MIPS_CPU_SHARED_FTLB_RAM;
+		/* fall-through */
+	default:
+		break;
+	}
 }
 
 static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
-- 
2.13.0
