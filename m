Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2016 17:36:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61863 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27035796AbcE0PgLrtwxz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 May 2016 17:36:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 9BCB2CF8547EA;
        Fri, 27 May 2016 16:36:01 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 27 May 2016 16:36:05 +0100
Received: from localhost (10.100.200.32) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 27 May
 2016 16:36:04 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-arch@vger.kernel.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        "# v4 . 4+" <stable@vger.kernel.org>
Subject: [PATCH 1/2] compiler-gcc: Allow arch-specific override of unreachable
Date:   Fri, 27 May 2016 16:35:49 +0100
Message-ID: <20160527153550.27303-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.32]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Include an arch-specific asm/compiler-gcc.h and allow for it to define a
custom version of unreachable(), which is needed to workaround a bug in
current versions of GCC for the MIPS architecture. This patch includes
an effectively empty asm-generic implementation of asm/compiler-gcc.h &
leaves the architecture specifics to a further patch.

Marked for stable as far back as v4.4 such that the MIPS patch depending
upon it can be backported too.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: <stable@vger.kernel.org> # v4.4+
---
 include/asm-generic/compiler-gcc.h | 8 ++++++++
 include/linux/compiler-gcc.h       | 7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 include/asm-generic/compiler-gcc.h

diff --git a/include/asm-generic/compiler-gcc.h b/include/asm-generic/compiler-gcc.h
new file mode 100644
index 0000000..e8ba230
--- /dev/null
+++ b/include/asm-generic/compiler-gcc.h
@@ -0,0 +1,8 @@
+#ifndef __LINUX_COMPILER_H
+#error "Please don't include <asm/compiler.gcc.h> directly, include <linux/compiler.h> instead."
+#endif
+
+/*
+ * We have nothing architecture-specific to do here, simply leave everything to
+ * the generic linux/compiler-gcc.h.
+ */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 3d5202e..e556cb8 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -9,6 +9,9 @@
 		     + __GNUC_MINOR__ * 100	\
 		     + __GNUC_PATCHLEVEL__)
 
+/* Allow architectures to override some definitions where necessary */
+#include <asm/compiler-gcc.h>
+
 /* Optimization barrier */
 
 /* The "volatile" is due to gcc bugs */
@@ -196,7 +199,9 @@
  * this in the preprocessor, but we can live with this because they're
  * unreleased.  Really, we need to have autoconf for the kernel.
  */
-#define unreachable() __builtin_unreachable()
+#ifndef unreachable
+# define unreachable() __builtin_unreachable()
+#endif
 
 /* Mark a function definition as prohibited from being cloned. */
 #define __noclone	__attribute__((__noclone__, __optimize__("no-tracer")))
-- 
2.8.3
