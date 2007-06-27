Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2007 06:40:42 +0100 (BST)
Received: from gw-eur4.philips.com ([161.85.125.10]:5374 "EHLO
	gw-eur4.philips.com") by ftp.linux-mips.org with ESMTP
	id S20022276AbXF0Fkk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Jun 2007 06:40:40 +0100
Received: from smtpscan-eur6.philips.com (smtpscan-eur6.mail.philips.com [130.144.57.169])
	by gw-eur4.philips.com (Postfix) with ESMTP id 200EB49708
	for <linux-mips@linux-mips.org>; Wed, 27 Jun 2007 05:40:34 +0000 (UTC)
Received: from smtpscan-eur6.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP id 4EF83664
	for <linux-mips@linux-mips.org>; Wed, 27 Jun 2007 05:40:33 +0000 (GMT)
Received: from smtprelay-eur1.philips.com (smtprelay-eur1.philips.com [130.144.57.170])
	by smtpscan-eur6.philips.com (Postfix) with ESMTP id EFE459CC
	for <linux-mips@linux-mips.org>; Wed, 27 Jun 2007 05:40:32 +0000 (GMT)
Received: from lnx32www01.soton.sc.philips.com (pww.osrp.sc.philips.com [130.141.89.1])
	by smtprelay-eur1.philips.com (Postfix) with ESMTP id BFD84E9A
	for <linux-mips@linux-mips.org>; Wed, 27 Jun 2007 05:40:32 +0000 (GMT)
Received: from krate.soton.sc.philips.com (krate [130.141.7.10])
	by lnx32www01.soton.sc.philips.com (8.13.7/8.13.7) with ESMTP id l5R5eWwP021117
	for <linux-mips@linux-mips.org>; Wed, 27 Jun 2007 06:40:32 +0100
Received: from stout.soton.sc.philips.com (root@stout [130.141.7.8])
	by krate.soton.sc.philips.com (8.12.11/8.12.11) with ESMTP id l5R5eRZJ027290
	for <linux-mips@linux-mips.org>; Wed, 27 Jun 2007 06:40:27 +0100 (BST)
Received: from [130.141.93.19] (host9319 [130.141.93.19])
	by stout.soton.sc.philips.com (8.11.3/8.11.3) with ESMTP id l5R5eRl29090
	for <linux-mips@linux-mips.org>; Wed, 27 Jun 2007 06:40:27 +0100 (BST)
Message-ID: <4681F84A.1080503@nxp.com>
Date:	Wed, 27 Jun 2007 06:40:26 +0100
From:	Daniel Laird <daniel.j.laird@nxp.com>
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] Philips/NXP STB810 CMEM Memory Settings
Content-Type: multipart/mixed;
 boundary="------------040506010608050407070207"
Return-Path: <daniel.j.laird@nxp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040506010608050407070207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please find below a patch that sets the CMEM registers for 
STB810/PNX8550 correctly so that XIO/PCI/MMIO all work
-----------------------------------------------

Setup the CMEM registers for PNX8550 correctly.

Signed-off-by: Daniel Laird <daniel.j.laird@NXP.com>
---

--- kernel/include/asm-mips/mipsregs.h
+++ kernel-new/include/asm-mips/mipsregs.h
@@ -498,6 +498,25 @@
 #define MIPS_CONF_AT        (_ULCAST_(3) << 13)
 #define MIPS_CONF_M        (_ULCAST_(1) << 31)
 
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
 #define read_c0_diag5()        __read_32bit_c0_register($22, 5)
 #define write_c0_diag5(val)    __write_32bit_c0_register($22, 5, val)
 
+#ifdef CONFIG_SOC_PNX8550
+#define read_c0_diag6()        __read_32bit_c0_register($22, 6)
+#define write_c0_diag6(val)    __write_32bit_c0_register($22, 6, val)
+
+#define read_c0_diag7()        __read_32bit_c0_register($22, 7)
+#define write_c0_diag7(val)    __write_32bit_c0_register($22, 7, val)
+#endif
+
 #define read_c0_debug()        __read_32bit_c0_register($23, 0)
 #define write_c0_debug(val)    __write_32bit_c0_register($23, 0, val)
 
--- kernel/arch/mips/philips/pnx8550/common/setup.c
+++ kernel-new/arch/mips/philips/pnx8550/common/setup.c
--- 
/home/laird/kernels/linux-2.6.21/arch/mips/philips/pnx8550/common/setup.c
+++ 
/home/laird/ccm_wa/ipstb/ipstb/ipstb/src/open/linux/overlay/arch/mips/philips/pnx8550/common/setup.c 

@@ -75,6 +75,20 @@
     },
 };
 
+/* Define the CMEM regions for the processor. */
+#define CMEM_VALID       (1 << PR4450_CMEMB_VALID)
+#define MMIO_CMEM_REGION (0x1be00000 & PR4450_CMEMF_BBA)
+#define MMIO_CMEM_SIZE   (PR4450_CMEM_SIZE_2MB << PR4450_CMEMB_SIZE)
+#define MMIO_CMEM_ENABLE (MMIO_CMEM_REGION | MMIO_CMEM_SIZE | CMEM_VALID)
+
+#define XIO_CMEM_REGION  (0x10000000 & PR4450_CMEMF_BBA)
+#define XIO_CMEM_SIZE    (PR4450_CMEM_SIZE_128MB << PR4450_CMEMB_SIZE)
+#define XIO_CMEM_ENABLE  (XIO_CMEM_REGION | XIO_CMEM_SIZE | CMEM_VALID)
+
+#define PCI_CMEM_REGION  (0x20000000 & PR4450_CMEMF_BBA)
+#define PCI_CMEM_SIZE    (PR4450_CMEM_SIZE_128MB << PR4450_CMEMB_SIZE)
+#define PCI_CMEM_ENABLE  (PCI_CMEM_REGION | PCI_CMEM_SIZE | CMEM_VALID)
+
 #define STANDARD_IO_RESOURCES 
(sizeof(standard_io_resources)/sizeof(struct resource))
 
 extern struct resource pci_io_resource;
@@ -105,6 +119,19 @@
         pm_power_off = pnx8550_machine_power_off;
 
     board_time_init = pnx8550_time_init;
+
+    /* Setup CMEM Registers */
+    /* CMEM0 = MMIO */
+    write_c0_diag4(MMIO_CMEM_ENABLE);
+
+    /* CMEM1 = XIO */
+    write_c0_diag5(XIO_CMEM_ENABLE);
+
+    /* CMEM2 = PCI */
+    write_c0_diag6(PCI_CMEM_ENABLE);
+
+    /* CMEM3 = Not used */
+    write_c0_diag7(0);
 
     /* Clear the Global 2 Register, PCI Inta Output Enable Registers
        Bit 1:Enable DAC Powerdown

Cheers
Daniel Laird


--------------040506010608050407070207
Content-Type: text/plain;
 name="pnx8550_cmem_setup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnx8550_cmem_setup.patch"

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
--- /home/laird/kernels/linux-2.6.21/arch/mips/philips/pnx8550/common/setup.c 
+++ /home/laird/ccm_wa/ipstb/ipstb/ipstb/src/open/linux/overlay/arch/mips/philips/pnx8550/common/setup.c 
@@ -75,6 +75,20 @@
 	},
 };
 
+/* Define the CMEM regions for the processor. */
+#define CMEM_VALID       (1 << PR4450_CMEMB_VALID)
+#define MMIO_CMEM_REGION (0x1be00000 & PR4450_CMEMF_BBA)
+#define MMIO_CMEM_SIZE   (PR4450_CMEM_SIZE_2MB << PR4450_CMEMB_SIZE)
+#define MMIO_CMEM_ENABLE (MMIO_CMEM_REGION | MMIO_CMEM_SIZE | CMEM_VALID)
+
+#define XIO_CMEM_REGION  (0x10000000 & PR4450_CMEMF_BBA)
+#define XIO_CMEM_SIZE    (PR4450_CMEM_SIZE_128MB << PR4450_CMEMB_SIZE)
+#define XIO_CMEM_ENABLE  (XIO_CMEM_REGION | XIO_CMEM_SIZE | CMEM_VALID)
+
+#define PCI_CMEM_REGION  (0x20000000 & PR4450_CMEMF_BBA)
+#define PCI_CMEM_SIZE    (PR4450_CMEM_SIZE_128MB << PR4450_CMEMB_SIZE)
+#define PCI_CMEM_ENABLE  (PCI_CMEM_REGION | PCI_CMEM_SIZE | CMEM_VALID)
+
 #define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
 
 extern struct resource pci_io_resource;
@@ -105,6 +119,19 @@
         pm_power_off = pnx8550_machine_power_off;
 
 	board_time_init = pnx8550_time_init;
+
+	/* Setup CMEM Registers */
+	/* CMEM0 = MMIO */
+	write_c0_diag4(MMIO_CMEM_ENABLE);
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

--------------040506010608050407070207--
