Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Sep 2010 06:17:30 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:45154 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491157Ab0IGERZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Sep 2010 06:17:25 +0200
Received: (qmail 11306 invoked from network); 7 Sep 2010 04:17:22 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 7 Sep 2010 04:17:22 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Mon, 06 Sep 2010 21:17:22 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 6 Sep 2010 21:03:52 -0700
Subject: [PATCH 5/5] MIPS: Move FIXADDR_TOP into spaces.h
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Message-Id: <d84f0a8caeb61c388b1145f89c879de3@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 27723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4960

Memory maps and addressing quirks are normally defined in <spaces.h>.
There are already three targets that need to override FIXADDR_TOP, and
others exist.  This will be a cleaner approach than adding lots of
ifdefs in fixmap.h .

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/fixmap.h              |   10 +---------
 arch/mips/include/asm/mach-bcm63xx/spaces.h |   17 +++++++++++++++++
 arch/mips/include/asm/mach-generic/spaces.h |    4 ++++
 arch/mips/include/asm/mach-tx39xx/spaces.h  |   17 +++++++++++++++++
 arch/mips/include/asm/mach-tx49xx/spaces.h  |   17 +++++++++++++++++
 5 files changed, 56 insertions(+), 9 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/spaces.h
 create mode 100644 arch/mips/include/asm/mach-tx39xx/spaces.h
 create mode 100644 arch/mips/include/asm/mach-tx49xx/spaces.h

diff --git a/arch/mips/include/asm/fixmap.h b/arch/mips/include/asm/fixmap.h
index 0b89b83..98bcc98 100644
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -14,6 +14,7 @@
 #define _ASM_FIXMAP_H
 
 #include <asm/page.h>
+#include <spaces.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
@@ -67,15 +68,6 @@ enum fixed_addresses {
  * the start of the fixmap, and leave one page empty
  * at the top of mem..
  */
-#ifdef CONFIG_BCM63XX
-#define FIXADDR_TOP     ((unsigned long)(long)(int)0xff000000)
-#else
-#if defined(CONFIG_CPU_TX39XX) || defined(CONFIG_CPU_TX49XX)
-#define FIXADDR_TOP	((unsigned long)(long)(int)(0xff000000 - 0x20000))
-#else
-#define FIXADDR_TOP	((unsigned long)(long)(int)0xfffe0000)
-#endif
-#endif
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
diff --git a/arch/mips/include/asm/mach-bcm63xx/spaces.h b/arch/mips/include/asm/mach-bcm63xx/spaces.h
new file mode 100644
index 0000000..cb8d2ab
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/spaces.h
@@ -0,0 +1,17 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994 - 1999, 2000, 03, 04 Ralf Baechle
+ * Copyright (C) 2000, 2002  Maciej W. Rozycki
+ * Copyright (C) 1990, 1999, 2000 Silicon Graphics, Inc.
+ */
+#ifndef _ASM_BCM63XX_SPACES_H
+#define _ASM_BCM63XX_SPACES_H
+
+#define FIXADDR_TOP		_AC(0xff000000, UL)
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* __ASM_BCM63XX_SPACES_H */
diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index c9fa4b1..77c36ee 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -82,4 +82,8 @@
 #define PAGE_OFFSET		(CAC_BASE + PHYS_OFFSET)
 #endif
 
+#ifndef FIXADDR_TOP
+#define FIXADDR_TOP		_AC(0xfffe0000, UL)
+#endif
+
 #endif /* __ASM_MACH_GENERIC_SPACES_H */
diff --git a/arch/mips/include/asm/mach-tx39xx/spaces.h b/arch/mips/include/asm/mach-tx39xx/spaces.h
new file mode 100644
index 0000000..0cf322b
--- /dev/null
+++ b/arch/mips/include/asm/mach-tx39xx/spaces.h
@@ -0,0 +1,17 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994 - 1999, 2000, 03, 04 Ralf Baechle
+ * Copyright (C) 2000, 2002  Maciej W. Rozycki
+ * Copyright (C) 1990, 1999, 2000 Silicon Graphics, Inc.
+ */
+#ifndef _ASM_TX39XX_SPACES_H
+#define _ASM_TX39XX_SPACES_H
+
+#define FIXADDR_TOP		_AC(0xfefe0000, UL)
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* __ASM_TX39XX_SPACES_H */
diff --git a/arch/mips/include/asm/mach-tx49xx/spaces.h b/arch/mips/include/asm/mach-tx49xx/spaces.h
new file mode 100644
index 0000000..455e042
--- /dev/null
+++ b/arch/mips/include/asm/mach-tx49xx/spaces.h
@@ -0,0 +1,17 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994 - 1999, 2000, 03, 04 Ralf Baechle
+ * Copyright (C) 2000, 2002  Maciej W. Rozycki
+ * Copyright (C) 1990, 1999, 2000 Silicon Graphics, Inc.
+ */
+#ifndef _ASM_TX49XX_SPACES_H
+#define _ASM_TX49XX_SPACES_H
+
+#define FIXADDR_TOP		_AC(0xfefe0000, UL)
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* __ASM_TX49XX_SPACES_H */
-- 
1.7.0.4
