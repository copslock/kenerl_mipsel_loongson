Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 00:33:15 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:9711 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8226165AbULBAdK>; Thu, 2 Dec 2004 00:33:10 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iB20X8dh013093;
	Wed, 1 Dec 2004 16:33:08 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iB20X80r013091;
	Wed, 1 Dec 2004 16:33:08 -0800
Date: Wed, 1 Dec 2004 16:33:08 -0800
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] 2.4: Preemption fixes for Broadcom DMA Page operations
Message-ID: <20041202003308.GA13085@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello !

The attached patch implements preempt_disable/preempt_enable around the SB1 DMA
page operations. Please review ...

Thanks
Manish Lachwani

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-bcm91125-dma

--- arch/mips/mm/pg-sb1.c.orig	2004-12-01 10:59:53.000000000 -0800
+++ arch/mips/mm/pg-sb1.c	2004-12-01 11:08:59.000000000 -0800
@@ -157,7 +157,11 @@
 
 void sb1_dma_init(void)
 {
-	int cpu = smp_processor_id();
+	int cpu;
+
+	preempt_disable();
+
+	cpu = smp_processor_id();
 	uint64_t base_val = PHYSADDR(&page_descr[cpu]) | V_DM_DSCR_BASE_RINGSZ(1);
 
 	out64(base_val,
@@ -166,15 +170,23 @@
 	      IO_SPACE_BASE + A_DM_REGISTER(cpu, R_DM_DSCR_BASE));
 	out64(base_val | M_DM_DSCR_BASE_ENABL,
 	      IO_SPACE_BASE + A_DM_REGISTER(cpu, R_DM_DSCR_BASE));
+
+	preempt_enable();
 }
 
 void sb1_clear_page_dma(void *page)
 {
-	int cpu = smp_processor_id();
+	int cpu;
+
+	preempt_disable();
+
+	cpu = smp_processor_id();
 
 	/* if the page is above Kseg0, use old way */
-	if (KSEGX(page) != K0BASE)
+	if (KSEGX(page) != K0BASE) {
+		preempt_enable();
 		return sb1_clear_page(page);
+	}
 
 	page_descr[cpu].dscr_a = PHYSADDR(page) | M_DM_DSCRA_ZERO_MEM | M_DM_DSCRA_L2C_DEST | M_DM_DSCRA_INTERRUPT;
 	page_descr[cpu].dscr_b = V_DM_DSCRB_SRC_LENGTH(PAGE_SIZE);
@@ -187,17 +199,27 @@
 	while (!(in64(IO_SPACE_BASE + A_DM_REGISTER(cpu, R_DM_DSCR_BASE_DEBUG)) & M_DM_DSCR_BASE_INTERRUPT))
 		;
 	in64(IO_SPACE_BASE + A_DM_REGISTER(cpu, R_DM_DSCR_BASE));
+
+	preempt_enable();
 }
 
 void sb1_copy_page_dma(void *to, void *from)
 {
-	unsigned long from_phys = PHYSADDR(from);
-	unsigned long to_phys = PHYSADDR(to);
-	int cpu = smp_processor_id();
+	unsigned long from_phys;
+	unsigned long to_phys;
+	int cpu;
+
+	preempt_disable();
+
+	from_phys = PHYSADDR(from);
+	to_phys = PHYSADDR(to);
+	cpu = smp_processor_id();
 
 	/* if either page is above Kseg0, use old way */
-	if ((KSEGX(to) != K0BASE) || (KSEGX(from) != K0BASE))
+	if ((KSEGX(to) != K0BASE) || (KSEGX(from) != K0BASE)) {
+		preempt_enable();
 		return sb1_copy_page(to, from);
+	}
 
 	page_descr[cpu].dscr_a = PHYSADDR(to_phys) | M_DM_DSCRA_L2C_DEST | M_DM_DSCRA_INTERRUPT;
 	page_descr[cpu].dscr_b = PHYSADDR(from_phys) | V_DM_DSCRB_SRC_LENGTH(PAGE_SIZE);
@@ -210,6 +232,8 @@
 	while (!(in64(IO_SPACE_BASE + A_DM_REGISTER(cpu, R_DM_DSCR_BASE_DEBUG)) & M_DM_DSCR_BASE_INTERRUPT))
 		;
 	in64(IO_SPACE_BASE + A_DM_REGISTER(cpu, R_DM_DSCR_BASE));
+
+	preempt_enable();
 }
 
 #endif
--- drivers/char/Config.in.orig	2004-12-01 10:33:59.000000000 -0800
+++ drivers/char/Config.in	2004-12-01 10:34:22.000000000 -0800
@@ -178,7 +178,7 @@
          define_bool CONFIG_AU1X00_USB_DEVICE y
          fi
       fi
-      if [ "$CONFIG_SIBYTE_SB1250" = "y" ]; then
+      if [ "$CONFIG_SIBYTE_BOARD" = "y" ]; then
          bool '  Support for sb1250 onchip DUART' CONFIG_SIBYTE_SB1250_DUART
          if [ "$CONFIG_SIBYTE_SB1250_DUART" = "y" ]; then
             bool '  Console on SB1250 DUART' CONFIG_SIBYTE_SB1250_DUART_CONSOLE
--- drivers/net/Config.in.orig	2004-12-01 10:41:37.000000000 -0800
+++ drivers/net/Config.in	2004-12-01 10:41:46.000000000 -0800
@@ -104,7 +104,7 @@
    if [ "$CONFIG_IDT_79EB434" = "y" ]; then
       bool '  IDT RC32434 Ethernet support' CONFIG_IDT_RC32434_ETH
    fi
-   if [ "$CONFIG_SIBYTE_SB1250" = "y" ]; then
+   if [ "$CONFIG_SIBYTE_BOARD" = "y" ]; then
       tristate '  SB1250 Ethernet support' CONFIG_NET_SB1250_MAC
    fi
    if [ "$CONFIG_SGI_IP27" = "y" ]; then

--M9NhX3UHpAaciwkO--
