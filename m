Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:01:28 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:34662 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251735AbYJXA54 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:57:56 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d660002>; Thu, 23 Oct 2008 20:57:10 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:09 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:08 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v4Bc005613;
	Thu, 23 Oct 2008 17:57:04 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v4cR005612;
	Thu, 23 Oct 2008 17:57:04 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 13/37] Add Cavium OCTEON processor constants.
Date:	Thu, 23 Oct 2008 17:56:37 -0700
Message-Id: <1224809821-5532-14-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:08.0813 (UTC) FILETIME=[70E1D7D0:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

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
index de6d09e..7b24183 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -114,6 +114,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "SB1 "
 #elif defined CONFIG_CPU_LOONGSON2
 #define MODULE_PROC_FAMILY "LOONGSON2 "
+#elif defined CONFIG_CPU_CAVIUM_OCTEON
+#define MODULE_PROC_FAMILY "OCTEON "
 #else
 #error MODULE_PROC_FAMILY undefined for your processor configuration
 #endif
-- 
1.5.5.1
