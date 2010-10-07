Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 01:08:45 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18317 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491755Ab0JGXFI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 01:05:08 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cae50de0002>; Thu, 07 Oct 2010 18:59:42 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:21 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:21 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o97N48FW026964;
        Thu, 7 Oct 2010 16:04:08 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o97N48G4026963;
        Thu, 7 Oct 2010 16:04:08 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 08/14] MIPS: Octeon: Scale Octeon2 clocks in  octeon_init_cvmcount()
Date:   Thu,  7 Oct 2010 16:03:47 -0700
Message-Id: <1286492633-26885-9-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2010 23:04:21.0137 (UTC) FILETIME=[F9F9F010:01CB6673]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The per-CPU clocks are synchronized from IPD_CLK_COUNT, on cn63XX it
must be scaled by the clock frequency ratio.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/csrc-octeon.c |   34 ++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index b6847c8..c85a681 100644
--- a/arch/mips/cavium-octeon/csrc-octeon.c
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -4,14 +4,18 @@
  * for more details.
  *
  * Copyright (C) 2007 by Ralf Baechle
+ * Copyright (C) 2009, 2010 Cavium Networks, Inc.
  */
 #include <linux/clocksource.h>
 #include <linux/init.h>
+#include <linux/smp.h>
 
+#include <asm/cpu-info.h>
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-ipd-defs.h>
+#include <asm/octeon/cvmx-mio-defs.h>
 
 /*
  * Set the current core's cvmcount counter to the value of the
@@ -19,11 +23,23 @@
  * on-line.  This allows for a read from a local cpu register to
  * access a synchronized counter.
  *
+ * On CPU_CAVIUM_OCTEON2 the IPD_CLK_COUNT is scaled by rdiv/sdiv.
  */
 void octeon_init_cvmcount(void)
 {
 	unsigned long flags;
 	unsigned loops = 2;
+	u64 f = 0;
+	u64 rdiv = 0;
+	u64 sdiv = 0;
+	if (current_cpu_type() == CPU_CAVIUM_OCTEON2) {
+		union cvmx_mio_rst_boot rst_boot;
+		rst_boot.u64 = cvmx_read_csr(CVMX_MIO_RST_BOOT);
+		rdiv = rst_boot.s.c_mul;	/* CPU clock */
+		sdiv = rst_boot.s.pnr_mul;	/* I/O clock */
+		f = (0x8000000000000000ull / sdiv) * 2;
+	}
+
 
 	/* Clobber loops so GCC will not unroll the following while loop. */
 	asm("" : "+r" (loops));
@@ -33,8 +49,20 @@ void octeon_init_cvmcount(void)
 	 * Loop several times so we are executing from the cache,
 	 * which should give more deterministic timing.
 	 */
-	while (loops--)
-		write_c0_cvmcount(cvmx_read_csr(CVMX_IPD_CLK_COUNT));
+	while (loops--) {
+		u64 ipd_clk_count = cvmx_read_csr(CVMX_IPD_CLK_COUNT);
+		if (rdiv != 0) {
+			ipd_clk_count = ipd_clk_count * rdiv;
+			if (f != 0) {
+				asm("dmultu\t%[cnt],%[f]\n\t"
+				    "mfhi\t%[cnt]"
+				    : [cnt] "+r" (ipd_clk_count),
+				      [f] "=r" (f)
+				    : : "hi", "lo");
+			}
+		}
+		write_c0_cvmcount(ipd_clk_count);
+	}
 	local_irq_restore(flags);
 }
 
@@ -77,7 +105,7 @@ unsigned long long notrace sched_clock(void)
 void __init plat_time_init(void)
 {
 	clocksource_mips.rating = 300;
-	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
+	clocksource_set_clock(&clocksource_mips, octeon_get_clock_rate());
 	clocksource_register(&clocksource_mips);
 }
 
-- 
1.7.2.3
