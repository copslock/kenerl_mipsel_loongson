Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 16:21:27 +0100 (BST)
Received: from apollo.i-cable.com ([203.83.115.103]:54494 "HELO
	apollo.i-cable.com") by ftp.linux-mips.org with SMTP
	id S22227021AbYJWPVW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 16:21:22 +0100
Received: (qmail 11619 invoked by uid 508); 23 Oct 2008 15:21:17 -0000
Received: from 203.83.114.122 by apollo (envelope-from <r0bertz@gentoo.org>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7730.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.177468 secs); 23 Oct 2008 15:21:17 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 23 Oct 2008 15:21:17 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id m9NFLFMG021434;
	Thu, 23 Oct 2008 23:21:16 +0800 (CST)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH 1/2] defined LEMOTE_IO_PORT_BASE for Lemote Loonson 2E box's IO base
Date:	Thu, 23 Oct 2008 23:02:21 +0000
Message-Id: <1224802942-5969-1-git-send-email-r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <n>
References: <n>
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 arch/mips/include/asm/lemote/pci.h |   27 +++++++++++++++++++++++++++
 arch/mips/lemote/lm2e/setup.c      |    9 ++-------
 2 files changed, 29 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/include/asm/lemote/pci.h

diff --git a/arch/mips/include/asm/lemote/pci.h b/arch/mips/include/asm/lemote/pci.h
new file mode 100644
index 0000000..c49eddb
--- /dev/null
+++ b/arch/mips/include/asm/lemote/pci.h
@@ -0,0 +1,27 @@
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
+#define LEMOTE_IO_PORT_BASE         CKSEG1ADDR(0xbfd00000)
+
+#endif /* !_LEMOTE_PCI_H_ */
diff --git a/arch/mips/lemote/lm2e/setup.c b/arch/mips/lemote/lm2e/setup.c
index 2cc6745..6f7076d 100644
--- a/arch/mips/lemote/lm2e/setup.c
+++ b/arch/mips/lemote/lm2e/setup.c
@@ -34,6 +34,7 @@
 #include <asm/mc146818-time.h>
 #include <asm/time.h>
 #include <asm/wbflush.h>
+#include <asm/lemote/pci.h>
 
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
@@ -80,7 +75,7 @@ static void wbflush_loongson2e(void)
 
 void __init plat_mem_setup(void)
 {
-	set_io_port_base(PTR_PAD(0xbfd00000));
+	set_io_port_base(LEMOTE_IO_PORT_BASE);
 
 	mips_reboot_setup();
 
-- 
1.6.0.2
