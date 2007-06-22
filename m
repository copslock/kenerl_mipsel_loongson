Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2007 07:33:54 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:19417 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S20022064AbXFVGdv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Jun 2007 07:33:51 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1I1ciK-0001ce-TJ
	for linux-mips@linux-mips.org; Thu, 21 Jun 2007 23:33:48 -0700
Message-ID: <11246928.post@talk.nabble.com>
Date:	Thu, 21 Jun 2007 23:33:48 -0700 (PDT)
From:	Daniel Laird <daniel.j.laird@nxp.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Philips(NXP)/STB810 changes
In-Reply-To: <20070621142721.GC21938@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: daniel.j.laird@nxp.com
References: <11229250.post@talk.nabble.com> <467A67B6.6090909@ru.mvista.com> <11232209.post@talk.nabble.com> <20070621142721.GC21938@linux-mips.org>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips


Useful script that checkpatch.pl! 
Okay third attempt.  

Please find attached a patch that sets up the CMEM registers for PNX8550
properly:

Setup the CMEM registers for PNX8550 correctly.

Signed-off-by: Daniel Laird <daniel.j.laird@NXP.com>
---

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
@@ -75,6 +75,20 @@
 	},
 };
 
+/* Define the CMEM regions for the processor. */
+#define CMEM_VALID       (1 << PR4450_CMEMB_VALID)
+#define CMEM_REGION      (0x1be00000 & PR4450_CMEMF_BBA)
+#define MMIO_CMEM_SIZE   (PR4450_CMEM_SIZE_2MB << PR4450_CMEMB_SIZE)
+#define MMIO_CMEM_ENABLE (CMEM_REGION | MMIO_CMEM_SIZE | CMEM_VALID)
+
+#define XIO_CMEM_REGION  (0x10000000 & PR4450_CMEMF_BBA)
+#define XIO_CMEM_SIZE    (PR4450_CMEM_SIZE_128MB << PR4450_CMEMB_SIZE)
+#define XIO_CMEM_ENABLE  (XIO_CMEM_REGION | XIO_CMEM_SIZE | CMEM_VALID)
+
+#define PCI_CMEM_REGION  (0x20000000 & PR4450_CMEMF_BBA)
+#define PCI_CMEM_SIZE    (PR4450_CMEM_SIZE_128MB << PR4450_CMEMB_SIZE)
+#define PCI_CMEM_ENABLE  (PCI_CMEM_REGION | PCI_CMEM_SIZE | CMEM_VALID)
+
 #define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct
resource))
 
 extern struct resource pci_io_resource;
@@ -105,6 +119,19 @@
         pm_power_off = pnx8550_machine_power_off;
 
 	board_time_init = pnx8550_time_init;
+
+	/* Setup CMEM Registers */
+	/* CMEM0 = MMIO */
+	write_c0_diag4(MMIO_REGION_ENABLE);
+
+	/* CMEM1 = XIO */
+	write_c0_diag5(XIO_CMEM_ENABLE);
+
+	/* CMEM2 = PCI */
+	write_c0_diag6(PCI_CMEM_ENABLE);
+
+	/* CMEM3 = Not used */
+	write_c0_diag7(0);
 
 	/* Clear the Global 2 Register, PCI Inta Output Enable Registers
 	   Bit 1:Enable DAC Powerdown

Attached Email:
http://www.nabble.com/file/p11246928/pnx8550_cmem_setup.patch
pnx8550_cmem_setup.patch 
Cheers
Daniel Laird
-- 
View this message in context: http://www.nabble.com/-PATCH--Philips%28NXP%29-STB810-changes-tf3957431.html#a11246928
Sent from the linux-mips main mailing list archive at Nabble.com.
