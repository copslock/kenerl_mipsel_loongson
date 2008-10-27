Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 15:52:54 +0000 (GMT)
Received: from apollo.i-cable.com ([203.83.115.103]:50324 "HELO
	apollo.i-cable.com") by ftp.linux-mips.org with SMTP
	id S22511314AbYJ0Pwp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Oct 2008 15:52:45 +0000
Received: (qmail 5348 invoked by uid 508); 27 Oct 2008 15:52:33 -0000
Received: from 203.83.114.122 by apollo (envelope-from <r0bertz@gentoo.org>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7730.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.1975 secs); 27 Oct 2008 15:52:33 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 27 Oct 2008 15:52:33 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id m9RFqLmB009549;
	Mon, 27 Oct 2008 23:52:33 +0800 (CST)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH] lemote/lm2e: added io_map_base to pci controller
Date:	Mon, 27 Oct 2008 23:33:24 +0000
Message-Id: <1225150404-25317-1-git-send-email-r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.0.2
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 arch/mips/include/asm/mach-lemote/pci.h |   30 ++++++++++++++++++++++++++++++
 arch/mips/lemote/lm2e/pci.c             |   13 ++++++++++---
 arch/mips/lemote/lm2e/setup.c           |   11 +++--------
 3 files changed, 43 insertions(+), 11 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-lemote/pci.h

diff --git a/arch/mips/include/asm/mach-lemote/pci.h b/arch/mips/include/asm/mach-lemote/pci.h
new file mode 100644
index 0000000..ea6aa14
--- /dev/null
+++ b/arch/mips/include/asm/mach-lemote/pci.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2008 Zhang Le <r0bertz@gentoo.org>
+ *
+ * This program is free software; you can redistribute it
+ * and/or modify it under the terms of the GNU General
+ * Public License as published by the Free Software
+ * Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied
+ * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the Free
+ * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
+ * 02139, USA.
+ */
+
+#ifndef _LEMOTE_PCI_H_
+#define _LEMOTE_PCI_H_
+
+#define LOONGSON2E_PCI_MEM_START	0x14000000UL
+#define LOONGSON2E_PCI_MEM_END		0x1fffffffUL
+#define LOONGSON2E_PCI_IO_START		0x00004000UL
+#define LOONGSON2E_IO_PORT_BASE		0x1fd00000UL
+
+#endif /* !_LEMOTE_PCI_H_ */
diff --git a/arch/mips/lemote/lm2e/pci.c b/arch/mips/lemote/lm2e/pci.c
index c1e41f1..8be03a8 100644
--- a/arch/mips/lemote/lm2e/pci.c
+++ b/arch/mips/lemote/lm2e/pci.c
@@ -30,19 +30,20 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <asm/mips-boards/bonito64.h>
+#include <asm/mach-lemote/pci.h>
 
 extern struct pci_ops bonito64_pci_ops;
 
 static struct resource loongson2e_pci_mem_resource = {
 	.name   = "LOONGSON2E PCI MEM",
-	.start  = 0x14000000UL,
-	.end    = 0x1fffffffUL,
+	.start  = LOONGSON2E_PCI_MEM_START,
+	.end    = LOONGSON2E_PCI_MEM_END,
 	.flags  = IORESOURCE_MEM,
 };
 
 static struct resource loongson2e_pci_io_resource = {
 	.name   = "LOONGSON2E PCI IO MEM",
-	.start  = 0x00004000UL,
+	.start  = LOONGSON2E_PCI_IO_START,
 	.end    = IO_SPACE_LIMIT,
 	.flags  = IORESOURCE_IO,
 };
@@ -82,6 +83,12 @@ static void __init ict_pcimap(void)
 static int __init pcibios_init(void)
 {
 	ict_pcimap();
+
+	loongson2e_pci_controller.io_map_base =
+	    (unsigned long) ioremap(LOONGSON2E_IO_PORT_BASE,
+				    loongson2e_pci_io_resource.end -
+				    loongson2e_pci_io_resource.start + 1);
+
 	register_pci_controller(&loongson2e_pci_controller);
 
 	return 0;
diff --git a/arch/mips/lemote/lm2e/setup.c b/arch/mips/lemote/lm2e/setup.c
index 2cc6745..ebd6cea 100644
--- a/arch/mips/lemote/lm2e/setup.c
+++ b/arch/mips/lemote/lm2e/setup.c
@@ -34,6 +34,7 @@
 #include <asm/mc146818-time.h>
 #include <asm/time.h>
 #include <asm/wbflush.h>
+#include <asm/mach-lemote/pci.h>
 
 #ifdef CONFIG_VT
 #include <linux/console.h>
@@ -42,12 +43,6 @@
 
 extern void mips_reboot_setup(void);
 
-#ifdef CONFIG_64BIT
-#define PTR_PAD(p) ((0xffffffff00000000)|((unsigned long long)(p)))
-#else
-#define PTR_PAD(p) (p)
-#endif
-
 unsigned long cpu_clock_freq;
 unsigned long bus_clock;
 unsigned int memsize;
@@ -80,8 +75,8 @@ static void wbflush_loongson2e(void)
 
 void __init plat_mem_setup(void)
 {
-	set_io_port_base(PTR_PAD(0xbfd00000));
-
+	set_io_port_base((unsigned long)ioremap(LOONGSON2E_IO_PORT_BASE,
+				IO_SPACE_LIMIT - LOONGSON2E_PCI_IO_START + 1));
 	mips_reboot_setup();
 
 	__wbflush = wbflush_loongson2e;
-- 
1.6.0.2
