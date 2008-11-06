Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 20:58:02 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:44698 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23298198AbYKFUzZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Nov 2008 20:55:25 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4913599d0001>; Thu, 06 Nov 2008 15:54:53 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:53 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:53 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mA6KsmXQ027712;
	Thu, 6 Nov 2008 12:54:48 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mA6KslSd027711;
	Thu, 6 Nov 2008 12:54:47 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 09/29] MIPS: Add Cavium OCTEON processor constants.
Date:	Thu,  6 Nov 2008 12:54:22 -0800
Message-Id: <1226004875-27654-9-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <491358F5.7040002@caviumnetworks.com>
References: <491358F5.7040002@caviumnetworks.com>
X-OriginalArrivalTime: 06 Nov 2008 20:54:53.0214 (UTC) FILETIME=[EAC5F3E0:01C94051]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/cpu.h    |   14 ++++++++++++++
 arch/mips/include/asm/module.h |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 229a786..c018727 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -33,6 +33,7 @@
 #define PRID_COMP_TOSHIBA	0x070000
 #define PRID_COMP_LSI		0x080000
 #define PRID_COMP_LEXRA		0x0b0000
+#define PRID_COMP_CAVIUM	0x0d0000
 
 
 /*
@@ -114,6 +115,18 @@
 #define PRID_IMP_BCM3302	0x9000
 
 /*
+ * These are the PRID's for when 23:16 == PRID_COMP_CAVIUM
+ */
+
+#define PRID_IMP_CAVIUM_CN38XX 0x0000
+#define PRID_IMP_CAVIUM_CN31XX 0x0100
+#define PRID_IMP_CAVIUM_CN30XX 0x0200
+#define PRID_IMP_CAVIUM_CN58XX 0x0300
+#define PRID_IMP_CAVIUM_CN56XX 0x0400
+#define PRID_IMP_CAVIUM_CN50XX 0x0600
+#define PRID_IMP_CAVIUM_CN52XX 0x0700
+
+/*
  * Definitions for 7:0 on legacy processors
  */
 
@@ -203,6 +216,7 @@ enum cpu_type_enum {
 	 * MIPS64 class processors
 	 */
 	CPU_5KC, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
+	CPU_CAVIUM_OCTEON,
 
 	CPU_LAST
 };
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index e2e09b2..d94085a 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -116,6 +116,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "SB1 "
 #elif defined CONFIG_CPU_LOONGSON2
 #define MODULE_PROC_FAMILY "LOONGSON2 "
+#elif defined CONFIG_CPU_CAVIUM_OCTEON
+#define MODULE_PROC_FAMILY "OCTEON "
 #else
 #error MODULE_PROC_FAMILY undefined for your processor configuration
 #endif
-- 
1.5.6.5
