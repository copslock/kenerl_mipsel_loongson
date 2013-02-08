Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Feb 2013 18:37:05 +0100 (CET)
Received: from mail-da0-f42.google.com ([209.85.210.42]:41782 "EHLO
        mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823899Ab3BHRhDyjRyd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Feb 2013 18:37:03 +0100
Received: by mail-da0-f42.google.com with SMTP id z17so1916184dal.29
        for <multiple recipients>; Fri, 08 Feb 2013 09:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=i3ns2P73+eYkZfGJdsk225D8ev3lCcZZ31Dhvnl78kA=;
        b=CJaBnwui32NqoXvNITiI3HU9380HxtwMMdOzalMcGaGxqR9XNMeRJG9F6R9RxSnB/r
         8zLifp7+eiB6wiop2SRanqTry1jH+tKX4KhHrL/2bIsVr0E+8YlH9qmQoEhuggmRE6/s
         meFwLVqQp8HNEvfhGL/p9TV3XCDZ/YZANcwj3GC6gqPI5w1Xo1rkDFzmil8z1HRhHO6L
         TINSzRriDptpBm9zpsIlSrfFb0voaURNgIs1OxRD3OwIplpxNqGJyuivR231Ozeu/GIx
         2BWmlKQgbMJY16FLILCC2lIFaVa9FwzuxJ/BRx9BaBlXSQEwAdhja2k6NQ1F4s+fDAbF
         pi5Q==
X-Received: by 10.66.84.10 with SMTP id u10mr19471597pay.24.1360345016247;
        Fri, 08 Feb 2013 09:36:56 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id y9sm56010099paw.1.2013.02.08.09.36.54
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 08 Feb 2013 09:36:55 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r18Harj1020648;
        Fri, 8 Feb 2013 09:36:53 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r18HaqFd020647;
        Fri, 8 Feb 2013 09:36:52 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Quit exporting kernel internel break codes to uapi/asm/break.h
Date:   Fri,  8 Feb 2013 09:36:51 -0800
Message-Id: <1360345011-20614-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
X-archive-position: 35729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The internal codes are not part of the kernel's abi.

Signed-off-by: David Daney <david.daney@cavium.com>
---

The transition of break.h to /uapi/asm happened in 3.8rc, so it is not
too late to prevent this crap from escaping to the kernel's userspace
ABI.

 arch/mips/include/asm/break.h      | 27 +++++++++++++++++++++++++++
 arch/mips/include/uapi/asm/break.h | 12 +++---------
 2 files changed, 30 insertions(+), 9 deletions(-)
 create mode 100644 arch/mips/include/asm/break.h

diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
new file mode 100644
index 0000000..67b6f72
--- /dev/null
+++ b/arch/mips/include/asm/break.h
@@ -0,0 +1,27 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1995, 2003 by Ralf Baechle
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ */
+#ifndef __ASM_BREAK_H
+#define __ASM_BREAK_H
+
+#ifdef __UAPI_ASM_BREAK_H
+#error "Error: Do not directly include <uapi/asm/break.h>"
+#endif
+#include <uapi/asm/break.h>
+
+/*
+ * Break codes used internally to the kernel.
+ */
+#define BRK_BUG		512	/* Used by BUG() */
+#define BRK_KDB		513	/* Used in KDB_ENTER() */
+#define BRK_MEMU	514	/* Used by FPU emulator */
+#define BRK_KPROBE_BP	515	/* Kprobe break */
+#define BRK_KPROBE_SSTEPBP 516	/* Kprobe single step software implementation */
+#define BRK_MULOVF	1023	/* Multiply overflow */
+
+#endif /* __ASM_BREAK_H */
diff --git a/arch/mips/include/uapi/asm/break.h b/arch/mips/include/uapi/asm/break.h
index 9161e68..ede4baa 100644
--- a/arch/mips/include/uapi/asm/break.h
+++ b/arch/mips/include/uapi/asm/break.h
@@ -6,8 +6,8 @@
  * Copyright (C) 1995, 2003 by Ralf Baechle
  * Copyright (C) 1999 Silicon Graphics, Inc.
  */
-#ifndef __ASM_BREAK_H
-#define __ASM_BREAK_H
+#ifndef __UAPI_ASM_BREAK_H
+#define __UAPI_ASM_BREAK_H
 
 /*
  * The following break codes are or were in use for specific purposes in
@@ -27,11 +27,5 @@
 #define BRK_STACKOVERFLOW 9	/* For Ada stackchecking */
 #define BRK_NORLD	10	/* No rld found - not used by Linux/MIPS */
 #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
-#define BRK_BUG		512	/* Used by BUG() */
-#define BRK_KDB		513	/* Used in KDB_ENTER() */
-#define BRK_MEMU	514	/* Used by FPU emulator */
-#define BRK_KPROBE_BP	515	/* Kprobe break */
-#define BRK_KPROBE_SSTEPBP 516	/* Kprobe single step software implementation */
-#define BRK_MULOVF	1023	/* Multiply overflow */
 
-#endif /* __ASM_BREAK_H */
+#endif /* __UAPI_ASM_BREAK_H */
-- 
1.7.11.7
