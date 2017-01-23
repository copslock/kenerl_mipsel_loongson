Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2017 23:26:24 +0100 (CET)
Received: from lpdvsmtp01.broadcom.com ([192.19.211.62]:56872 "EHLO
        relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbdAWW0QI0Jee (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2017 23:26:16 +0100
Received: from mail-irv-17.broadcom.com (mail-irv-17.broadcom.com [10.15.198.34])
        by relay.smtp.broadcom.com (Postfix) with ESMTP id 2AE5128059A;
        Mon, 23 Jan 2017 14:26:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 relay.smtp.broadcom.com 2AE5128059A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1485210372;
        bh=1TLWAuF9pl8djETsX3nhJyYriuN4+vypOoOoOm+cSOo=;
        h=From:To:Cc:Subject:Date:From;
        b=KI8riUwPYt2JeW+4RhT15dOxcaIiuTaCkugyy5LxqwbjVg1b3n76QfZKgas6Fy7JD
         X4RNCGC5KFkhzC+3cjRJMnj2psbTys+M/OTC89umTpFihEF0COVSH7SoRTKF6FyP88
         Dd0sO0rp1cjWPliCeorqxq74KgIrDq0J8O8PhsCc=
Received: from stb-bld-02.irv.broadcom.com (stb-bld-02.broadcom.com [10.13.134.28])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 77D1E81F52;
        Mon, 23 Jan 2017 14:26:11 -0800 (PST)
From:   justinpopo6@gmail.com
To:     linux-mips@linux-mips.org
Cc:     bcm-kernel-feedback-list@broadcom.com, leonid.yegoshin@imgtec.com,
        f.fainelli@gmail.com, mattredfearn@imgtec.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH] MIPS: Add cacheinfo support
Date:   Mon, 23 Jan 2017 14:26:00 -0800
Message-Id: <20170123222600.31953-1-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.11.0
Return-Path: <justinpopo6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinpopo6@gmail.com
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

From: Justin Chen <justinpopo6@gmail.com>

Add cacheinfo support for MIPS architectures.

Use information from the cpuinfo_mips struct to populate the
cacheinfo struct. This allows an architecture agnostic approach,
however this also means if cache information is not properly
populated within the cpuinfo_mips struct, there is nothing
we can do. (I.E. c-r3k.c)

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 arch/mips/kernel/Makefile    |  8 ++--
 arch/mips/kernel/cacheinfo.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 4 deletions(-)
 create mode 100644 arch/mips/kernel/cacheinfo.c

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 4a603a3ea657..712c1ae6afdc 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -4,10 +4,10 @@
 
 extra-y		:= head.o vmlinux.lds
 
-obj-y		+= cpu-probe.o branch.o elf.o entry.o genex.o idle.o irq.o \
-		   process.o prom.o ptrace.o reset.o setup.o signal.o \
-		   syscall.o time.o topology.o traps.o unaligned.o watch.o \
-		   vdso.o
+obj-y		+= cpu-probe.o branch.o cacheinfo.o elf.o entry.o genex.o \
+		   idle.o irq.o process.o prom.o ptrace.o reset.o setup.o \
+		   signal.o syscall.o time.o topology.o traps.o unaligned.o \
+		   watch.o vdso.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = -pg
diff --git a/arch/mips/kernel/cacheinfo.c b/arch/mips/kernel/cacheinfo.c
new file mode 100644
index 000000000000..11e6ad7ed0d2
--- /dev/null
+++ b/arch/mips/kernel/cacheinfo.c
@@ -0,0 +1,90 @@
+/*
+ * MIPS cacheinfo support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/cacheinfo.h>
+
+/* Populates leaf and increments to next leaf */
+#define populate_cache(cache, leaf, c_level, c_type)		\
+	leaf->type = c_type;					\
+	leaf->level = c_level;					\
+	leaf->coherency_line_size = cache.linesz;		\
+	leaf->number_of_sets = cache.sets;			\
+	leaf->ways_of_associativity = cache.ways;		\
+	leaf->size = cache.linesz * cache.sets * cache.ways;
+
+static int __init_cache_level(unsigned int cpu)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	int levels = 0, leaves = 0;
+
+	/*
+	 * If Dcache is not set, we assume the cache structures
+	 * are not properly initialized.
+	 */
+	if (c->dcache.waysize)
+		levels += 1;
+	else
+		return -ENOENT;
+
+	leaves += (c->icache.waysize) ? 2 : 1;
+
+	if (c->scache.waysize) {
+		levels++;
+		leaves++;
+	}
+
+	if (c->tcache.waysize) {
+		levels++;
+		leaves++;
+	}
+
+	this_cpu_ci->num_levels = levels;
+	this_cpu_ci->num_leaves = leaves;
+
+	return 0;
+}
+
+static int __populate_cache_leaves(unsigned int cpu)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+
+	if (c->icache.waysize) {
+		populate_cache(c->dcache, this_leaf, 1, CACHE_TYPE_DATA);
+		this_leaf++;
+		populate_cache(c->icache, this_leaf, 1, CACHE_TYPE_INST);
+		this_leaf++;
+	} else {
+		populate_cache(c->dcache, this_leaf, 1, CACHE_TYPE_UNIFIED);
+		this_leaf++;
+	}
+
+	if (c->scache.waysize) {
+		populate_cache(c->scache, this_leaf, 2, CACHE_TYPE_UNIFIED);
+		this_leaf++;
+	}
+
+	if (c->tcache.waysize) {
+		populate_cache(c->tcache, this_leaf, 3, CACHE_TYPE_UNIFIED);
+		this_leaf++;
+	}
+
+	return 0;
+}
+
+DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
+DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
-- 
2.11.0
