Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:29:37 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37443 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011496AbcAYWZARu7VQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:25:00 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id D79D8203DF;
        Mon, 25 Jan 2016 22:24:58 +0000 (UTC)
Received: from localhost (199-83-221-254.PUBLIC.monkeybrains.net [199.83.221.254])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A5C203DA;
        Mon, 25 Jan 2016 22:24:58 +0000 (UTC)
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
Subject: [PATCH v2 16/16] x86/compat: Remove is_compat_task
Date:   Mon, 25 Jan 2016 14:24:30 -0800
Message-Id: <c48a8336218fcd6e27a386d89afef155458f1551.1453759363.git.luto@kernel.org>
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
X-archive-position: 51376
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

x86's is_compat_task always checked the current syscall type, not
the task type.  It has no non-arch users any more, so just remove it
to avoid confusion.

On x86, nothing should really be checking the task ABI.  There are
legitimate users for the syscall ABI and for the mm ABI.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/compat.h | 3 ++-
 arch/x86/include/asm/ftrace.h | 2 +-
 arch/x86/kernel/process_64.c  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index acdee09228b3..ebb102e1bbc7 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -316,9 +316,10 @@ static inline bool is_x32_task(void)
 	return false;
 }
 
-static inline bool is_compat_task(void)
+static inline bool in_compat_syscall(void)
 {
 	return is_ia32_task() || is_x32_task();
 }
+#define in_compat_syscall in_compat_syscall	/* override the generic impl */
 
 #endif /* _ASM_X86_COMPAT_H */
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 24938852db30..21b66dbf3601 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -58,7 +58,7 @@ int ftrace_int3_handler(struct pt_regs *regs);
 #define ARCH_TRACE_IGNORE_COMPAT_SYSCALLS 1
 static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 {
-	if (is_compat_task())
+	if (in_compat_syscall())
 		return true;
 	return false;
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index b9d99e0f82c4..71a18a22ae2f 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -476,7 +476,7 @@ void set_personality_ia32(bool x32)
 		if (current->mm)
 			current->mm->context.ia32_compat = TIF_X32;
 		current->personality &= ~READ_IMPLIES_EXEC;
-		/* is_compat_task() uses the presence of the x32
+		/* in_compat_syscall() uses the presence of the x32
 		   syscall bit flag to determine compat status */
 		current_thread_info()->status &= ~TS_COMPAT;
 	} else {
-- 
2.5.0
