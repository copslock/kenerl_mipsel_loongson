Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2011 02:57:53 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:54512 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492837Ab1ANB4W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jan 2011 02:56:22 +0100
Received: (qmail 12119 invoked from network); 14 Jan 2011 01:56:19 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 14 Jan 2011 01:56:19 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Thu, 13 Jan 2011 17:56:19 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <anemo@mba.ocn.ne.jp>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 RESEND 3/6] MIPS: Move FIXADDR_TOP into spaces.h
Date:   Thu, 13 Jan 2011 17:52:14 -0800
Message-Id: <57b81e075a9f318b77ac9d74d952a5e0@localhost>
In-Reply-To: <491015d51e5d3d36c517da09e038ecaf@localhost>
References: <491015d51e5d3d36c517da09e038ecaf@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

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
index 0000000..61e750f
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
+#define FIXADDR_TOP		((unsigned long)(long)(int)0xff000000)
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* __ASM_BCM63XX_SPACES_H */
diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index c9fa4b1..d7a9efd 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -82,4 +82,8 @@
 #define PAGE_OFFSET		(CAC_BASE + PHYS_OFFSET)
 #endif
 
+#ifndef FIXADDR_TOP
+#define FIXADDR_TOP		((unsigned long)(long)(int)0xfffe0000)
+#endif
+
 #endif /* __ASM_MACH_GENERIC_SPACES_H */
diff --git a/arch/mips/include/asm/mach-tx39xx/spaces.h b/arch/mips/include/asm/mach-tx39xx/spaces.h
new file mode 100644
index 0000000..151fe7a
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
+#define FIXADDR_TOP		((unsigned long)(long)(int)0xfefe0000)
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* __ASM_TX39XX_SPACES_H */
diff --git a/arch/mips/include/asm/mach-tx49xx/spaces.h b/arch/mips/include/asm/mach-tx49xx/spaces.h
new file mode 100644
index 0000000..0cb10a6
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
+#define FIXADDR_TOP		((unsigned long)(long)(int)0xfefe0000)
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* __ASM_TX49XX_SPACES_H */
-- 
1.7.0.4
