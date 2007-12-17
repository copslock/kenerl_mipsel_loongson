Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2007 19:45:33 +0000 (GMT)
Received: from DSL022.labridge.com ([206.117.136.22]:7181 "EHLO perches.com")
	by ftp.linux-mips.org with ESMTP id S20027486AbXLQTpY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Dec 2007 19:45:24 +0000
Received: from localhost.localdomain (192-168-1-128.LABridge.com [192.168.1.128] (may be forged))
	by perches.com (8.9.3/8.9.3) with ESMTP id KAA32728;
	Mon, 17 Dec 2007 10:43:13 -0800
From:	Joe Perches <joe@perches.com>
To:	linux-kernel@vger.kernel.org
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] include/asm-mips/: Spelling fixes
Date:	Mon, 17 Dec 2007 11:30:09 -0800
Message-Id: <1197919875-5288-10-git-send-email-joe@perches.com>
X-Mailer: git-send-email 1.5.3.7.949.g2221a6
Message-Id: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918890.git.joe@perches.com>
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips


Signed-off-by: Joe Perches <joe@perches.com>
---
 include/asm-mips/mach-excite/excite_fpga.h  |    2 +-
 include/asm-mips/mach-wrppmc/mach-gt64120.h |    2 +-
 include/asm-mips/sgi/ip22.h                 |    2 +-
 include/asm-mips/sn/sn0/hubio.h             |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-mips/mach-excite/excite_fpga.h b/include/asm-mips/mach-excite/excite_fpga.h
index 38fcda7..0a1ef69 100644
--- a/include/asm-mips/mach-excite/excite_fpga.h
+++ b/include/asm-mips/mach-excite/excite_fpga.h
@@ -3,7 +3,7 @@
 
 
 /**
- * Adress alignment of the individual FPGA bytes.
+ * Address alignment of the individual FPGA bytes.
  * The address arrangement of the individual bytes of the FPGA is two
  * byte aligned at the embedded MK2 platform.
  */
diff --git a/include/asm-mips/mach-wrppmc/mach-gt64120.h b/include/asm-mips/mach-wrppmc/mach-gt64120.h
index 00d8bf6..465234a 100644
--- a/include/asm-mips/mach-wrppmc/mach-gt64120.h
+++ b/include/asm-mips/mach-wrppmc/mach-gt64120.h
@@ -45,7 +45,7 @@
 #define GT_PCI_IO_SIZE	0x02000000UL
 
 /*
- * PCI interrupts will come in on either the INTA or INTD interrups lines,
+ * PCI interrupts will come in on either the INTA or INTD interrupts lines,
  * which are mapped to the #2 and #5 interrupt pins of the MIPS.  On our
  * boards, they all either come in on IntD or they all come in on IntA, they
  * aren't mixed. There can be numerous PCI interrupts, so we keep a list of the
diff --git a/include/asm-mips/sgi/ip22.h b/include/asm-mips/sgi/ip22.h
index f4981c4..c0501f9 100644
--- a/include/asm-mips/sgi/ip22.h
+++ b/include/asm-mips/sgi/ip22.h
@@ -15,7 +15,7 @@
 /*
  * These are the virtual IRQ numbers, we divide all IRQ's into
  * 'spaces', the 'space' determines where and how to enable/disable
- * that particular IRQ on an SGI machine. HPC DMA and MC DMA interrups
+ * that particular IRQ on an SGI machine. HPC DMA and MC DMA interrupts
  * are not supported this way. Driver is supposed to allocate HPC/MC
  * interrupt as shareable and then look to proper status bit (see
  * HAL2 driver). This will prevent many complications, trust me ;-)
diff --git a/include/asm-mips/sn/sn0/hubio.h b/include/asm-mips/sn/sn0/hubio.h
index ef91b33..0187895 100644
--- a/include/asm-mips/sn/sn0/hubio.h
+++ b/include/asm-mips/sn/sn0/hubio.h
@@ -338,7 +338,7 @@ typedef union io_perf_cnt {
 #define IIO_IFDR	0x400398	/* IOQ FIFO Depth */
 #define IIO_IIAP	0x4003a0	/* IIQ Arbitration Parameters */
 #define IIO_IMMR	IIO_IIAP
-#define IIO_ICMR	0x4003a8	/* CRB Managment Register */
+#define IIO_ICMR	0x4003a8	/* CRB Management Register */
 #define IIO_ICCR	0x4003b0	/* CRB Control Register */
 #define IIO_ICTO	0x4003b8	/* CRB Time Out Register */
 #define IIO_ICTP	0x4003c0	/* CRB Time Out Prescalar */
-- 
1.5.3.7.949.g2221a6
