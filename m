Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2007 08:42:11 +0100 (BST)
Received: from gw-eur4.philips.com ([161.85.125.10]:22939 "EHLO
	gw-eur4.philips.com") by ftp.linux-mips.org with ESMTP
	id S20023029AbXGQHmJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jul 2007 08:42:09 +0100
Received: from smtpscan-eur8.philips.com (smtpscan-eur8.mail.philips.com [130.144.57.173])
	by gw-eur4.philips.com (Postfix) with ESMTP id 624A649713
	for <linux-mips@linux-mips.org>; Tue, 17 Jul 2007 07:41:31 +0000 (UTC)
Received: from smtpscan-eur8.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP id 41DA187D
	for <linux-mips@linux-mips.org>; Tue, 17 Jul 2007 07:41:31 +0000 (GMT)
Received: from smtprelay-eur1.philips.com (smtprelay-eur1.philips.com [130.144.57.170])
	by smtpscan-eur8.philips.com (Postfix) with ESMTP id EE2244FF
	for <linux-mips@linux-mips.org>; Tue, 17 Jul 2007 07:41:30 +0000 (GMT)
Received: from lnx32www01.soton.sc.philips.com (pww.osrp.sc.philips.com [130.141.89.1])
	by smtprelay-eur1.philips.com (Postfix) with ESMTP id CCDA82B44
	for <linux-mips@linux-mips.org>; Tue, 17 Jul 2007 07:41:30 +0000 (GMT)
Received: from krate.soton.sc.philips.com (krate [130.141.7.10])
	by lnx32www01.soton.sc.philips.com (8.13.7/8.13.7) with ESMTP id l6H7fUFr016380
	for <linux-mips@linux-mips.org>; Tue, 17 Jul 2007 08:41:30 +0100
Received: from stout.soton.sc.philips.com (root@stout [130.141.7.8])
	by krate.soton.sc.philips.com (8.12.11/8.12.11) with ESMTP id l6H7fPMt022749
	for <linux-mips@linux-mips.org>; Tue, 17 Jul 2007 08:41:25 +0100 (BST)
Received: from [130.141.93.19] (host9319 [130.141.93.19])
	by stout.soton.sc.philips.com (8.11.3/8.11.3) with ESMTP id l6H7fPl12327
	for <linux-mips@linux-mips.org>; Tue, 17 Jul 2007 08:41:25 +0100 (BST)
Message-ID: <469C72A4.8080307@nxp.com>
Date:	Tue, 17 Jul 2007 08:41:24 +0100
From:	Daniel Laird <daniel.j.laird@nxp.com>
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] Correctly setup STB810 CMEM registers for XIO/PCI/MMIO access.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.j.laird@nxp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

Please find below a patch that allows STB810 to work for us. It sets uip 
the memory apertures correctly for XIO/MMIO and PCI.

Setup the CMEM registers for STB810/PNX8550 correctly.

Signed-off-by: Daniel Laird <daniel.j.laird@nxp.com>
---
 arch/mips/philips/pnx8550/common/setup.c |   27 +++++++++++++++++++++++++++
 include/asm-mips/mipsregs.h              |   27 +++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff -urN linux-2.6.22.orig/arch/mips/philips/pnx8550/common/setup.c 
linux-2.6.22/arch/mips/philips/pnx8550/common/setup.c
--- linux-2.6.22.orig/arch/mips/philips/pnx8550/common/setup.c    
2007-07-17 08:32:05.000000000 +0100
+++ linux-2.6.22/arch/mips/philips/pnx8550/common/setup.c    2007-07-17 
08:32:54.000000000 +0100
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
@@ -106,6 +120,19 @@
 
     board_time_init = pnx8550_time_init;
 
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
+
     /* Clear the Global 2 Register, PCI Inta Output Enable Registers
        Bit 1:Enable DAC Powerdown
       -> 0:DACs are enabled and are working normally
diff -urN linux-2.6.22.orig/include/asm-mips/mipsregs.h 
linux-2.6.22/include/asm-mips/mipsregs.h
--- linux-2.6.22.orig/include/asm-mips/mipsregs.h    2007-07-17 
08:32:25.000000000 +0100
+++ linux-2.6.22/include/asm-mips/mipsregs.h    2007-07-17 
08:32:54.000000000 +0100
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
@@ -919,6 +938,14 @@
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
