Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Sep 2015 18:01:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7579 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008441AbbIYQA7ze0pi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Sep 2015 18:00:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F17B5E5E2EA0D;
        Fri, 25 Sep 2015 17:00:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 25 Sep 2015 17:00:53 +0100
Received: from localhost (192.168.159.196) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 25 Sep
 2015 17:00:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v2 3/3] MIPS: initialise MAARs on secondary CPUs
Date:   Fri, 25 Sep 2015 08:59:38 -0700
Message-ID: <1443196778-5528-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1443196778-5528-1-git-send-email-paul.burton@imgtec.com>
References: <1443196778-5528-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.196]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49368
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

MAARs should be initialised on each CPU (or rather, core) in the system
in order to achieve consistent behaviour & performance. Previously they
have only been initialised on the boot CPU which leads to performance
problems if tasks are later scheduled on a secondary CPU, particularly
if those tasks make use of unaligned vector accesses where some CPUs
don't handle any cases in hardware for non-speculative memory regions.
Fix this by recording the MAAR configuration from the boot CPU and
applying it to secondary CPUs as part of their bringup.

Reported-by: Doug Gilmore <doug.gilmore@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/include/asm/maar.h |  9 +++++++++
 arch/mips/kernel/smp.c       |  2 ++
 arch/mips/mm/init.c          | 28 +++++++++++++++++++++++++---
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/maar.h b/arch/mips/include/asm/maar.h
index b02891f..21d9607 100644
--- a/arch/mips/include/asm/maar.h
+++ b/arch/mips/include/asm/maar.h
@@ -66,6 +66,15 @@ static inline void write_maar_pair(unsigned idx, phys_addr_t lower,
 }
 
 /**
+ * maar_init() - initialise MAARs
+ *
+ * Performs initialisation of MAARs for the current CPU, making use of the
+ * platforms implementation of platform_maar_init where necessary and
+ * duplicating the setup it provides on secondary CPUs.
+ */
+extern void maar_init(void);
+
+/**
  * struct maar_config - MAAR configuration data
  * @lower:	The lowest address that the MAAR pair will affect. Must be
  *		aligned to a 2^16 byte boundary.
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index a31896c..bd4385a 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -42,6 +42,7 @@
 #include <asm/mmu_context.h>
 #include <asm/time.h>
 #include <asm/setup.h>
+#include <asm/maar.h>
 
 cpumask_t cpu_callin_map;		/* Bitmask of started secondaries */
 
@@ -157,6 +158,7 @@ asmlinkage void start_secondary(void)
 	mips_clockevent_init();
 	mp_ops->init_secondary();
 	cpu_report();
+	maar_init();
 
 	/*
 	 * XXX parity protection should be folded in here when it's converted
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 023c164..8770e61 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -44,6 +44,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/fixmap.h>
+#include <asm/maar.h>
 
 /*
  * We have up to 8 empty zeroed pages so we can map one of the right colour
@@ -288,10 +289,14 @@ unsigned __weak platform_maar_init(unsigned num_pairs)
 	return num_configured;
 }
 
-static void maar_init(void)
+void maar_init(void)
 {
 	unsigned num_maars, used, i;
 	phys_addr_t lower, upper, attr;
+	static struct {
+		struct maar_config cfgs[3];
+		unsigned used;
+	} recorded = { { { 0 } }, 0 };
 
 	if (!cpu_has_maar)
 		return;
@@ -304,8 +309,14 @@ static void maar_init(void)
 	/* MAARs should be in pairs */
 	WARN_ON(num_maars % 2);
 
-	/* Configure the required MAARs */
-	used = platform_maar_init(num_maars / 2);
+	/* Set MAARs using values we recorded already */
+	if (recorded.used) {
+		used = maar_config(recorded.cfgs, recorded.used, num_maars / 2);
+		BUG_ON(used != recorded.used);
+	} else {
+		/* Configure the required MAARs */
+		used = platform_maar_init(num_maars / 2);
+	}
 
 	/* Disable any further MAARs */
 	for (i = (used * 2); i < num_maars; i++) {
@@ -315,6 +326,9 @@ static void maar_init(void)
 		back_to_back_c0_hazard();
 	}
 
+	if (recorded.used)
+		return;
+
 	pr_info("MAAR configuration:\n");
 	for (i = 0; i < num_maars; i += 2) {
 		write_c0_maari(i);
@@ -341,6 +355,14 @@ static void maar_init(void)
 			pr_cont(" speculate");
 
 		pr_cont("\n");
+
+		/* Record the setup for use on secondary CPUs */
+		if (used <= ARRAY_SIZE(recorded.cfgs)) {
+			recorded.cfgs[recorded.used].lower = lower;
+			recorded.cfgs[recorded.used].upper = upper;
+			recorded.cfgs[recorded.used].attrs = attr;
+			recorded.used++;
+		}
 	}
 }
 
-- 
2.5.3
