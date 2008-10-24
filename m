Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:00:10 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:23398 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251725AbYJXA5o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:57:44 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d640001>; Thu, 23 Oct 2008 20:57:08 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:08 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:07 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v3Sr005589;
	Thu, 23 Oct 2008 17:57:03 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v3T1005588;
	Thu, 23 Oct 2008 17:57:03 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 07/37] Don't assume boot CPU is CPU0 if MIPS_DISABLE_BOOT_CPU_ZERO set.
Date:	Thu, 23 Oct 2008 17:56:31 -0700
Message-Id: <1224809821-5532-8-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:07.0985 (UTC) FILETIME=[70638010:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

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
index b905744..5f832ee 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -746,6 +746,10 @@ config HOTPLUG_CPU
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
1.5.5.1
