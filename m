Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2006 12:56:49 +0100 (BST)
Received: from mail04.hansenet.de ([213.191.73.12]:20474 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20037891AbWH0L4r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 27 Aug 2006 12:56:47 +0100
Received: from [213.39.141.67] (213.39.141.67) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44EC4423000F6382; Sun, 27 Aug 2006 13:56:41 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 7803B1770DB;
	Sun, 27 Aug 2006 13:56:40 +0200 (CEST)
X-Mailbox-Line:	From c201cfb18301415f409505efed9f045e50a58f39 Mon Sep 17 00:00:00 2001
From:	thomas@koeller.dyndns.org
Date:	Sun, 27 Aug 2006 13:54:31 +0200
Subject: [PATCH] Move excite_fpga.h to include/asm-mips/mach-excite
Organization: Basler AG
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas =?iso-8859-15?q?K=F6ller?= <thomas.koeller@baslerweb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608271354.31525.thomas@koeller.dyndns.org>
Return-Path: <thomas@koeller.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@koeller.dyndns.org
Precedence: bulk
X-list: linux-mips

excite_fpga.h, like all platform headers, really belongs in the
platform header directory.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
---
 arch/mips/basler/excite/excite_fpga.h      |   80 
----------------------------
 include/asm-mips/mach-excite/excite_fpga.h |   80 
++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/arch/mips/basler/excite/excite_fpga.h 
b/arch/mips/basler/excite/excite_fpga.h
deleted file mode 100644
index 38fcda7..0000000
--- a/arch/mips/basler/excite/excite_fpga.h
+++ /dev/null
@@ -1,80 +0,0 @@
-#ifndef EXCITE_FPGA_H_INCLUDED
-#define EXCITE_FPGA_H_INCLUDED
-
-
-/**
- * Adress alignment of the individual FPGA bytes.
- * The address arrangement of the individual bytes of the FPGA is two
- * byte aligned at the embedded MK2 platform.
- */
-#ifdef EXCITE_CCI_FPGA_MK2
-typedef unsigned char excite_cci_fpga_align_t __attribute__ ((aligned(2)));
-#else
-typedef unsigned char excite_cci_fpga_align_t;
-#endif
-
-
-/**
- * Size of Dual Ported RAM.
- */
-#define EXCITE_DPR_SIZE 263
-
-
-/**
- * Size of Reserved Status Fields in Dual Ported RAM.
- */
-#define EXCITE_DPR_STATUS_SIZE 7
-
-
-
-/**
- * FPGA.
- * Hardware register layout of the FPGA interface. The FPGA must accessed
- * byte wise solely.
- * @see EXCITE_CCI_DPR_MK2
- */
-typedef struct excite_fpga {
-
-	/**
-	 * Dual Ported RAM.
-	 */
-	excite_cci_fpga_align_t dpr[EXCITE_DPR_SIZE];
-
-	/**
-	 * Status.
-	 */
-	excite_cci_fpga_align_t status[EXCITE_DPR_STATUS_SIZE];
-
-#ifdef EXCITE_CCI_FPGA_MK2
-	/**
-	 * RM9000 Interrupt.
-	 * Write access initiates interrupt at the RM9000 (MIPS) processor of the 
eXcite.
-	 */
-	excite_cci_fpga_align_t rm9k_int;
-#else
-	/**
-	 * MK2 Interrupt.
-	 * Write access initiates interrupt at the ARM processor of the MK2.
-	 */
-	excite_cci_fpga_align_t mk2_int;
-
-	excite_cci_fpga_align_t gap[0x1000-0x10f];
-
-	/**
-	 * IRQ Source/Acknowledge.
-	 */
-	excite_cci_fpga_align_t rm9k_irq_src;
-
-	/**
-	 * IRQ Mask.
-	 * Set bits enable the related interrupt.
-	 */
-	excite_cci_fpga_align_t rm9k_irq_mask;
-#endif
-
-
-} excite_fpga;
-
-
-
-#endif	/* ndef EXCITE_FPGA_H_INCLUDED */
diff --git a/include/asm-mips/mach-excite/excite_fpga.h 
b/include/asm-mips/mach-excite/excite_fpga.h
new file mode 100644
index 0000000..38fcda7
--- /dev/null
+++ b/include/asm-mips/mach-excite/excite_fpga.h
@@ -0,0 +1,80 @@
+#ifndef EXCITE_FPGA_H_INCLUDED
+#define EXCITE_FPGA_H_INCLUDED
+
+
+/**
+ * Adress alignment of the individual FPGA bytes.
+ * The address arrangement of the individual bytes of the FPGA is two
+ * byte aligned at the embedded MK2 platform.
+ */
+#ifdef EXCITE_CCI_FPGA_MK2
+typedef unsigned char excite_cci_fpga_align_t __attribute__ ((aligned(2)));
+#else
+typedef unsigned char excite_cci_fpga_align_t;
+#endif
+
+
+/**
+ * Size of Dual Ported RAM.
+ */
+#define EXCITE_DPR_SIZE 263
+
+
+/**
+ * Size of Reserved Status Fields in Dual Ported RAM.
+ */
+#define EXCITE_DPR_STATUS_SIZE 7
+
+
+
+/**
+ * FPGA.
+ * Hardware register layout of the FPGA interface. The FPGA must accessed
+ * byte wise solely.
+ * @see EXCITE_CCI_DPR_MK2
+ */
+typedef struct excite_fpga {
+
+	/**
+	 * Dual Ported RAM.
+	 */
+	excite_cci_fpga_align_t dpr[EXCITE_DPR_SIZE];
+
+	/**
+	 * Status.
+	 */
+	excite_cci_fpga_align_t status[EXCITE_DPR_STATUS_SIZE];
+
+#ifdef EXCITE_CCI_FPGA_MK2
+	/**
+	 * RM9000 Interrupt.
+	 * Write access initiates interrupt at the RM9000 (MIPS) processor of the 
eXcite.
+	 */
+	excite_cci_fpga_align_t rm9k_int;
+#else
+	/**
+	 * MK2 Interrupt.
+	 * Write access initiates interrupt at the ARM processor of the MK2.
+	 */
+	excite_cci_fpga_align_t mk2_int;
+
+	excite_cci_fpga_align_t gap[0x1000-0x10f];
+
+	/**
+	 * IRQ Source/Acknowledge.
+	 */
+	excite_cci_fpga_align_t rm9k_irq_src;
+
+	/**
+	 * IRQ Mask.
+	 * Set bits enable the related interrupt.
+	 */
+	excite_cci_fpga_align_t rm9k_irq_mask;
+#endif
+
+
+} excite_fpga;
+
+
+
+#endif	/* ndef EXCITE_FPGA_H_INCLUDED */
-- 
1.4.0


-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
