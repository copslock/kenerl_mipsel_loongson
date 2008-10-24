Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:12:25 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:28775 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251768AbYJXA7B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:59:01 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d690002>; Thu, 23 Oct 2008 20:57:13 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:12 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:12 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v71P005702;
	Thu, 23 Oct 2008 17:57:07 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v7wF005701;
	Thu, 23 Oct 2008 17:57:07 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 35/37] Set c0 status for ST0_KX on Cavium OCTEON.
Date:	Thu, 23 Oct 2008 17:56:59 -0700
Message-Id: <1224809821-5532-36-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:12.0423 (UTC) FILETIME=[7308AF70:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

Always set ST0_KX on Octeon since IO addresses are at 64bit addresses.
Keep in mind this also moves the TLB handler.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/head.S  |   12 ++++++++++--
 arch/mips/kernel/traps.c |    7 +++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 492a0a8..dcd0be5 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -106,7 +106,11 @@
 	.endm
 
 	.macro	setup_c0_status_pri
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_CAVIUM_OCTEON)
+	/*
+	 * Note: We always set ST0_KX on Octeon since IO addresses are at
+	 * 64bit addresses. Keep in mind this also moves the TLB handler.
+	 */
 	setup_c0_status ST0_KX 0
 #else
 	setup_c0_status 0 0
@@ -114,7 +118,11 @@
 	.endm
 
 	.macro	setup_c0_status_sec
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_CAVIUM_OCTEON)
+	/*
+	 * Note: We always set ST0_KX on Octeon since IO addresses are at
+	 * 64bit addresses. Keep in mind this also moves the TLB handler.
+	 */
 	setup_c0_status ST0_KX ST0_BEV
 #else
 	setup_c0_status 0 ST0_BEV
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 91c7aa2..8bed9a8 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1472,6 +1472,13 @@ void __cpuinit per_cpu_trap_init(void)
 #ifdef CONFIG_64BIT
 	status_set |= ST0_FR|ST0_KX|ST0_SX|ST0_UX;
 #endif
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+	/*
+	 * Note: We always set ST0_KX on Octeon since IO addresses are at
+	 * 64bit addresses. Keep in mind this also moves the TLB handler.
+	 */
+	status_set |= ST0_KX;
+#endif
 	if (current_cpu_data.isa_level == MIPS_CPU_ISA_IV)
 		status_set |= ST0_XX;
 	if (cpu_has_dsp)
-- 
1.5.5.1
