Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 19:58:02 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10114 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492562Ab0GWR56 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jul 2010 19:57:58 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c49d8400001>; Fri, 23 Jul 2010 10:58:24 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:57:56 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:57:56 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6NHvr37024460;
        Fri, 23 Jul 2010 10:57:53 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6NHvrEd024459;
        Fri, 23 Jul 2010 10:57:53 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/3] MIPS: Octeon: Clean up SMP CPU numbering.
Date:   Fri, 23 Jul 2010 10:57:49 -0700
Message-Id: <1279907871-24419-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279907871-24419-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279907871-24419-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 23 Jul 2010 17:57:56.0774 (UTC) FILETIME=[94A5C460:01CB2A90]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Also number offline CPUs that could potentially be brought on-line
later.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/smp.c |   37 ++++++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 6d99b9d..8ff2c7b 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2008 Cavium Networks
+ * Copyright (C) 2004-2008, 2009, 2010 Cavium Networks
  */
 #include <linux/cpu.h>
 #include <linux/init.h>
@@ -102,24 +102,47 @@ static void octeon_smp_setup(void)
 	const int coreid = cvmx_get_core_num();
 	int cpus;
 	int id;
-
 	int core_mask = octeon_get_boot_coremask();
+#ifdef CONFIG_HOTPLUG_CPU
+	unsigned int num_cores = cvmx_octeon_num_cores();
+#endif
+
+	/* The present CPUs are initially just the boot cpu (CPU 0). */
+	for (id = 0; id < NR_CPUS; id++) {
+		set_cpu_possible(id, id == 0);
+		set_cpu_present(id, id == 0);
+	}
 
-	cpus_clear(cpu_possible_map);
 	__cpu_number_map[coreid] = 0;
 	__cpu_logical_map[0] = coreid;
-	cpu_set(0, cpu_possible_map);
 
+	/* The present CPUs get the lowest CPU numbers. */
 	cpus = 1;
-	for (id = 0; id < 16; id++) {
+	for (id = 0; id < NR_CPUS; id++) {
 		if ((id != coreid) && (core_mask & (1 << id))) {
-			cpu_set(cpus, cpu_possible_map);
+			set_cpu_possible(cpus, true);
+			set_cpu_present(cpus, true);
 			__cpu_number_map[id] = cpus;
 			__cpu_logical_map[cpus] = id;
 			cpus++;
 		}
 	}
-	cpu_present_map = cpu_possible_map;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	/*
+	 * The possible CPUs are all those present on the chip.  We
+	 * will assign CPU numbers for possible cores as well.  Cores
+	 * are always consecutively numberd from 0.
+	 */
+	for (id = 0; id < num_cores && id < NR_CPUS; id++) {
+		if (!(core_mask & (1 << id))) {
+			set_cpu_possible(cpus, true);
+			__cpu_number_map[id] = cpus;
+			__cpu_logical_map[cpus] = id;
+			cpus++;
+		}
+	}
+#endif
 
 	octeon_smp_hotplug_setup();
 }
-- 
1.7.1.1
