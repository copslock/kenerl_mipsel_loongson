Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Dec 2004 20:26:39 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:15613 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225196AbULCU0d>; Fri, 3 Dec 2004 20:26:33 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iB3KQVdh019863
	for <linux-mips@linux-mips.org>; Fri, 3 Dec 2004 12:26:31 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iB3KQVBs019861
	for linux-mips@linux-mips.org; Fri, 3 Dec 2004 12:26:31 -0800
Date: Fri, 3 Dec 2004 12:26:31 -0800
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Subject: [PATCH] Build fixes for Broadcom DMA Pageops in 2.6
Message-ID: <20041203202631.GA19855@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello !

Attached patch incorporates build related fixes to the Broadcom DMA Pageops
in 2.6. Please review ...

Thanks
Manish Lachwani

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_broadcom_dmapageops.patch"

Source: MontaVista Software, Inc. | URL | Manish Lachwani <mlachwani@mvista.com>
Type: Defect Fix
Disposition: Submitted to Linux-MIPS
Description:
	Build fixes for Broadcom DMA Page Ops

Index: linux/arch/mips/mm/pg-sb1.c
===================================================================
--- linux.orig/arch/mips/mm/pg-sb1.c
+++ linux/arch/mips/mm/pg-sb1.c
@@ -162,7 +162,7 @@
 void sb1_dma_init(void)
 {
 	int cpu = smp_processor_id();
-	uint64_t base_val = PHYSADDR(&page_descr[cpu]) | V_DM_DSCR_BASE_RINGSZ(1);
+	uint64_t base_val = CPHYSADDR(&page_descr[cpu]) | V_DM_DSCR_BASE_RINGSZ(1);
 
 	__raw_writeq(base_val,
 		     IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_BASE)));
@@ -180,7 +180,7 @@
 	if (KSEGX(page) != CAC_BASE)
 		return clear_page_cpu(page);
 
-	page_descr[cpu].dscr_a = PHYSADDR(page) | M_DM_DSCRA_ZERO_MEM | M_DM_DSCRA_L2C_DEST | M_DM_DSCRA_INTERRUPT;
+	page_descr[cpu].dscr_a = CPHYSADDR(page) | M_DM_DSCRA_ZERO_MEM | M_DM_DSCRA_L2C_DEST | M_DM_DSCRA_INTERRUPT;
 	page_descr[cpu].dscr_b = V_DM_DSCRB_SRC_LENGTH(PAGE_SIZE);
 	__raw_writeq(1, IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_COUNT)));
 
@@ -195,16 +195,16 @@
 
 void copy_page(void *to, void *from)
 {
-	unsigned long from_phys = PHYSADDR(from);
-	unsigned long to_phys = PHYSADDR(to);
+	unsigned long from_phys = CPHYSADDR(from);
+	unsigned long to_phys = CPHYSADDR(to);
 	int cpu = smp_processor_id();
 
 	/* if either page is above Kseg0, use old way */
 	if ((KSEGX(to) != CAC_BASE) || (KSEGX(from) != CAC_BASE))
 		return copy_page_cpu(to, from);
 
-	page_descr[cpu].dscr_a = PHYSADDR(to_phys) | M_DM_DSCRA_L2C_DEST | M_DM_DSCRA_INTERRUPT;
-	page_descr[cpu].dscr_b = PHYSADDR(from_phys) | V_DM_DSCRB_SRC_LENGTH(PAGE_SIZE);
+	page_descr[cpu].dscr_a = CPHYSADDR(to_phys) | M_DM_DSCRA_L2C_DEST | M_DM_DSCRA_INTERRUPT;
+	page_descr[cpu].dscr_b = CPHYSADDR(from_phys) | V_DM_DSCRB_SRC_LENGTH(PAGE_SIZE);
 	__raw_writeq(1, IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_COUNT)));
 
 	/*

--5mCyUwZo2JvN/JJP--
