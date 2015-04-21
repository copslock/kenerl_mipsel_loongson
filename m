Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 20:33:12 +0200 (CEST)
Received: from smtp.gentoo.org ([140.211.166.183]:51562 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010448AbbDUSdKpr0j4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Apr 2015 20:33:10 +0200
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with ESMTP id AB23C34097F;
        Tue, 21 Apr 2015 18:33:04 +0000 (UTC)
From:   Mike Frysinger <vapier@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     oss@malat.biz, Mike Frysinger <vapier@chromium.org>
Subject: [PATCH] Revert "MIPS: Provide correct siginfo_t.si_stime"
Date:   Tue, 21 Apr 2015 14:33:03 -0400
Message-Id: <1429641183-15873-1-git-send-email-vapier@gentoo.org>
X-Mailer: git-send-email 2.3.5
Return-Path: <vapier@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier@gentoo.org
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

From: Mike Frysinger <vapier@chromium.org>

This reverts commit 8cb48fe169dd682b6c29a3b7ef18333e4f577890.

UAPI headers cannot use "uapi/" in their paths by design -- when they're
installed, they do not have the uapi/ prefix.  Otherwise doing so breaks
userland badly:
$ printf '#include <stddef.h>\n#include <linux/signal.h>\n' > test.c
$ mips64-unknown-linux-gnu-gcc -c test.c
In file included from /usr/mips64-unknown-linux-gnu/usr/include/linux/signal.h:5:0,
                 from test.c:2:
/usr/mips64-unknown-linux-gnu/usr/include/asm/siginfo.h:31:38: fatal error: uapi/asm-generic/siginfo.h: No such file or directory
compilation terminated.

Signed-off-by: Mike Frysinger <vapier@chromium.org>
---
 arch/mips/include/asm/siginfo.h      | 29 +++++++++++++++++++++++++++++
 arch/mips/include/uapi/asm/siginfo.h | 11 ++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/siginfo.h

diff --git a/arch/mips/include/asm/siginfo.h b/arch/mips/include/asm/siginfo.h
new file mode 100644
index 0000000..dd9a762
--- /dev/null
+++ b/arch/mips/include/asm/siginfo.h
@@ -0,0 +1,29 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1998, 1999, 2001, 2003 Ralf Baechle
+ * Copyright (C) 2000, 2001 Silicon Graphics, Inc.
+ */
+#ifndef _ASM_SIGINFO_H
+#define _ASM_SIGINFO_H
+
+#include <uapi/asm/siginfo.h>
+
+
+/*
+ * Duplicated here because of <asm-generic/siginfo.h> braindamage ...
+ */
+#include <linux/string.h>
+
+static inline void copy_siginfo(struct siginfo *to, struct siginfo *from)
+{
+	if (from->si_code < 0)
+		memcpy(to, from, sizeof(*to));
+	else
+		/* _sigchld is currently the largest know union member */
+		memcpy(to, from, 3*sizeof(int) + sizeof(from->_sifields._sigchld));
+}
+
+#endif /* _ASM_SIGINFO_H */
diff --git a/arch/mips/include/uapi/asm/siginfo.h b/arch/mips/include/uapi/asm/siginfo.h
index 2cb7fde..d08f83f 100644
--- a/arch/mips/include/uapi/asm/siginfo.h
+++ b/arch/mips/include/uapi/asm/siginfo.h
@@ -16,6 +16,13 @@
 #define HAVE_ARCH_SIGINFO_T
 
 /*
+ * We duplicate the generic versions - <asm-generic/siginfo.h> is just borked
+ * by design ...
+ */
+#define HAVE_ARCH_COPY_SIGINFO
+struct siginfo;
+
+/*
  * Careful to keep union _sifields from shifting ...
  */
 #if _MIPS_SZLONG == 32
@@ -28,9 +35,8 @@
 
 #define __ARCH_SIGSYS
 
-#include <uapi/asm-generic/siginfo.h>
+#include <asm-generic/siginfo.h>
 
-/* We can't use generic siginfo_t, because our si_code and si_errno are swapped */
 typedef struct siginfo {
 	int si_signo;
 	int si_code;
@@ -118,6 +124,5 @@ typedef struct siginfo {
 #define SI_TIMER __SI_CODE(__SI_TIMER, -3) /* sent by timer expiration */
 #define SI_MESGQ __SI_CODE(__SI_MESGQ, -4) /* sent by real time mesq state change */
 
-#include <asm-generic/siginfo.h>
 
 #endif /* _UAPI_ASM_SIGINFO_H */
-- 
2.3.5
