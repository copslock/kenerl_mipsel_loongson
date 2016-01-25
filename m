Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:25:31 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011530AbcAYWYpLZEQM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:24:45 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 6E1F820389;
        Mon, 25 Jan 2016 22:24:42 +0000 (UTC)
Received: from localhost (199-83-221-254.PUBLIC.monkeybrains.net [199.83.221.254])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A264D20376;
        Mon, 25 Jan 2016 22:24:41 +0000 (UTC)
From:   Andy Lutomirski <luto@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-parisc@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v2 01/16] compat: Add in_compat_syscall to ask whether we're in a compat syscall
Date:   Mon, 25 Jan 2016 14:24:15 -0800
Message-Id: <4cd121066a85fe57356569e3bae28fe9d7098806.1453759363.git.luto@kernel.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <luto@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@kernel.org
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

A lot of code currently abuses is_compat_task to determine this.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 include/linux/compat.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index a76c9172b2eb..f911bcec618f 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -5,6 +5,8 @@
  * syscall compatibility layer.
  */
 
+#include <linux/types.h>
+
 #ifdef CONFIG_COMPAT
 
 #include <linux/stat.h>
@@ -713,9 +715,22 @@ asmlinkage long compat_sys_sched_rr_get_interval(compat_pid_t pid,
 
 asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
 					    int, const char __user *);
+
+/*
+ * For most but not all architectures, "am I in a compat syscall?" and
+ * "am I a compat task?" are the same question.  For architectures on which
+ * they aren't the same question, arch code can override in_compat_syscall.
+ */
+
+#ifndef in_compat_syscall
+static inline bool in_compat_syscall(void) { return is_compat_task(); }
+#endif
+
 #else
 
 #define is_compat_task() (0)
+static inline bool in_compat_syscall(void) { return false; }
 
 #endif /* CONFIG_COMPAT */
+
 #endif /* _LINUX_COMPAT_H */
-- 
2.5.0
