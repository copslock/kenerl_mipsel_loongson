Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2008 18:08:21 +0100 (BST)
Received: from sitar.i-cable.com ([203.83.115.100]:7301 "HELO
	sitar.i-cable.com") by ftp.linux-mips.org with SMTP
	id S22144987AbYJVRIP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Oct 2008 18:08:15 +0100
Received: (qmail 26250 invoked by uid 508); 22 Oct 2008 17:08:04 -0000
Received: from 203.83.114.121 by sitar (envelope-from <r0bertz@gentoo.org>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7708.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.089954 secs); 22 Oct 2008 17:08:04 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 22 Oct 2008 17:08:03 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id m9MH7qwU007666;
	Thu, 23 Oct 2008 01:08:03 +0800 (HKT)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH] defined a macro for lemote 2e box IO base
Date:	Thu, 23 Oct 2008 00:48:58 +0000
Message-Id: <1224722939-18557-1-git-send-email-r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.0.2
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

---
 arch/mips/include/asm/lemote/pci.h |   31 +++++++++++++++++++++++++++++++
 arch/mips/lemote/lm2e/setup.c      |    9 ++-------
 2 files changed, 33 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/include/asm/lemote/pci.h

diff --git a/arch/mips/include/asm/lemote/pci.h b/arch/mips/include/asm/lemote/pci.h
new file mode 100644
index 0000000..8e5c9c3
--- /dev/null
+++ b/arch/mips/include/asm/lemote/pci.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2008 Zhang Le <r0bertz@gentoo.org>
+ *
+ *     This program is free software; you can redistribute it
+ *     and/or modify it under the terms of the GNU General
+ *     Public License as published by the Free Software
+ *     Foundation; either version 2 of the License, or (at your
+ *     option) any later version.
+ *
+ *     This program is distributed in the hope that it will be
+ *     useful, but WITHOUT ANY WARRANTY; without even the implied
+ *     warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ *     PURPOSE.  See the GNU General Public License for more
+ *     details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this program; if not, write to the Free
+ *     Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
+ *     02139, USA.
+ */
+
+#ifndef _LEMOTE_PCI_H_
+#define _LEMOTE_PCI_H_
+
+#ifdef CONFIG_64BIT
+#define LEMOTE_IO_PORT_BASE 0xffffffffbfd00000
+#else
+#define LEMOTE_IO_PORT_BASE 0xbfd00000
+#endif
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
