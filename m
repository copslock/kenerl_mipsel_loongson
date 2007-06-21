Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2007 10:03:04 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:54929 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S20024993AbXFUJDB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Jun 2007 10:03:01 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1I1IZ9-000346-9F
	for linux-mips@linux-mips.org; Thu, 21 Jun 2007 02:02:59 -0700
Message-ID: <11229250.post@talk.nabble.com>
Date:	Thu, 21 Jun 2007 02:02:59 -0700 (PDT)
From:	Daniel Laird <daniel.j.laird@nxp.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Philips(NXP)/STB810 changes
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: daniel.j.laird@nxp.com
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips


We have found the following changes are necessary for the Philips(NXP)/STB810
platform


Signed-off-by: Daniel Laird <daniel.j.laird@nxp.com> 

--- kernel/include/asm-mips/mipsregs.h
+++ kernel-new/include/asm-mips/mipsregs.h 
@@ -498,6 +498,25 @@
 #define MIPS_CONF_AT		(_ULCAST_(3) << 13)
 #define MIPS_CONF_M		(_ULCAST_(1) << 31)
 
+/* Bits specific to the PR4450 CMEM Registers */
+#define PR4450_CMEMF_BBA     (_ULCAST_(2047) << 20)
+#define PR4450_CMEMB_BBA     20
+#define PR4450_CMEMF_SIZE    (_ULCAST_(15) << 1)
+#define PR4450_CMEMB_SIZE    1
+#define PR4450_CMEM_SIZE_1MB    0
+#define PR4450_CMEM_SIZE_2MB    1
+#define PR4450_CMEM_SIZE_4MB    2
+#define PR4450_CMEM_SIZE_8MB    3
+#define PR4450_CMEM_SIZE_16MB   4
+#define PR4450_CMEM_SIZE_32MB   5
+#define PR4450_CMEM_SIZE_64MB   6
+#define PR4450_CMEM_SIZE_128MB  7
+#define PR4450_CMEM_SIZE_256MB  8
+#define PR4450_CMEM_SIZE_512MB  9
+#define PR4450_CMEM_SIZE_1GB   10
+#define PR4450_CMEMF_VALID   (_ULCAST_(1) << 0)
+#define PR4450_CMEMB_VALID   0
+
 /*
  * Bits in the MIPS32/64 PRA coprocessor 0 config registers 1 and above.
  */
@@ -917,6 +936,14 @@
 #define read_c0_diag5()		__read_32bit_c0_register($22, 5)
 #define write_c0_diag5(val)	__write_32bit_c0_register($22, 5, val)
 
+#ifdef CONFIG_SOC_PNX8550
+#define read_c0_diag6()		__read_32bit_c0_register($22, 6)
+#define write_c0_diag6(val)	__write_32bit_c0_register($22, 6, val)
+
+#define read_c0_diag7()		__read_32bit_c0_register($22, 7)
+#define write_c0_diag7(val)	__write_32bit_c0_register($22, 7, val)
+#endif
+
 #define read_c0_debug()		__read_32bit_c0_register($23, 0)
 #define write_c0_debug(val)	__write_32bit_c0_register($23, 0, val)
 
--- kernel/arch/mips/philips/pnx8550/common/setup.c
+++ kernel-new/arch/mips/philips/pnx8550/common/setup.c 
@@ -100,11 +100,29 @@
 
 	board_setup();  /* board specific setup */
 
-        _machine_restart = pnx8550_machine_restart;
-        _machine_halt = pnx8550_machine_halt;
-        pm_power_off = pnx8550_machine_power_off;
+    _machine_restart = pnx8550_machine_restart;
+    _machine_halt = pnx8550_machine_halt;
+    pm_power_off = pnx8550_machine_power_off;
+	board_time_init = pnx8550_time_init;
 
-	board_time_init = pnx8550_time_init;
+    /* Setup CMEM Registers */
+    /* CMEM0 = MMIO */
+    write_c0_diag4((0x1be00000 & PR4450_CMEMF_BBA) |
+                   (PR4450_CMEM_SIZE_2MB << PR4450_CMEMB_SIZE) |
+                   (1 << PR4450_CMEMB_VALID));
+
+    /* CMEM1 = XIO */
+    write_c0_diag5((0x10000000 & PR4450_CMEMF_BBA) |
+                   (PR4450_CMEM_SIZE_128MB << PR4450_CMEMB_SIZE) |
+                   (1 << PR4450_CMEMB_VALID));
+
+    /* CMEM2 = PCI */
+    write_c0_diag6((0x20000000 & PR4450_CMEMF_BBA) |
+                   (PR4450_CMEM_SIZE_128MB << PR4450_CMEMB_SIZE) |
+                   (1 << PR4450_CMEMB_VALID));
+
+    /* CMEM3 = Not used */
+    write_c0_diag7(0);
 
 	/* Clear the Global 2 Register, PCI Inta Output Enable Registers
 	   Bit 1:Enable DAC Powerdown

Cheers
Dan Laird

-- 
View this message in context: http://www.nabble.com/-PATCH--Philips%28NXP%29-STB810-changes-tf3957431.html#a11229250
Sent from the linux-mips main mailing list archive at Nabble.com.
