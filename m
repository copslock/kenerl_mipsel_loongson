Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:06:36 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:34836 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22533319AbYJ1AEg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:04:36 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f60006>; Mon, 27 Oct 2008 20:04:06 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:09 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:08 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S034cc003272;
	Mon, 27 Oct 2008 17:03:04 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S034oi003271;
	Mon, 27 Oct 2008 17:03:04 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 07/36] Don't assume boot CPU is CPU0 if MIPS_DISABLE_BOOT_CPU_ZERO set.
Date:	Mon, 27 Oct 2008 17:02:39 -0700
Message-Id: <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com>
References: <490655B6.4030406@caviumnetworks.com>
 <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Oct 2008 00:03:09.0007 (UTC) FILETIME=[8F75ADF0:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

MIPS SMP code currently assumes that the boot CPU will be CPU0
of the system.  For some systems, this may not be the case.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
---
 arch/mips/Kconfig      |    4 ++++
 arch/mips/kernel/smp.c |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 653574b..7ff95fb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -747,6 +747,10 @@ config HOTPLUG_CPU
 	bool
 	default n
 
+config MIPS_DISABLE_BOOT_CPU_ZERO
+       bool
+       default n
+
 config I8259
 	bool
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index b79ea70..e2597ef 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -195,12 +195,14 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 /* preload SMP state for boot cpu */
 void __devinit smp_prepare_boot_cpu(void)
 {
+#ifndef MIPS_DISABLE_BOOT_CPU_ZERO
 	/*
 	 * This assumes that bootup is always handled by the processor
 	 * with the logic and physical number 0.
 	 */
 	__cpu_number_map[0] = 0;
 	__cpu_logical_map[0] = 0;
+#endif
 	cpu_set(0, phys_cpu_present_map);
 	cpu_set(0, cpu_online_map);
 	cpu_set(0, cpu_callin_map);
-- 
1.5.6.5
