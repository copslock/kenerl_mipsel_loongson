Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 02:30:34 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:47418 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008111AbbCEBaLhNrq0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Mar 2015 02:30:11 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t251RNFU006134;
        Wed, 4 Mar 2015 17:27:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     akpm@linux-foundation.org
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        Laura Abbott <lauraa@codeaurora.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v3 8/8] x86: switch to using asm-generic for seccomp.h
Date:   Wed,  4 Mar 2015 17:27:08 -0800
Message-Id: <1425518828-16017-9-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

Switch to using the newly created asm-generic/seccomp.h for the seccomp
strict mode syscall definitions. The obsolete sigreturn syscall override
is retained in 32-bit mode, and the ia32 syscall overrides are used in
the compat case. Remaining definitions were identical.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/seccomp.h    | 21 ++++++++++++++++++---
 arch/x86/include/asm/seccomp_32.h | 11 -----------
 arch/x86/include/asm/seccomp_64.h | 17 -----------------
 3 files changed, 18 insertions(+), 31 deletions(-)
 delete mode 100644 arch/x86/include/asm/seccomp_32.h
 delete mode 100644 arch/x86/include/asm/seccomp_64.h

diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index 0f3d7f099224..0c8c7c8861b4 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -1,5 +1,20 @@
+#ifndef _ASM_X86_SECCOMP_H
+#define _ASM_X86_SECCOMP_H
+
+#include <asm/unistd.h>
+
 #ifdef CONFIG_X86_32
-# include <asm/seccomp_32.h>
-#else
-# include <asm/seccomp_64.h>
+#define __NR_seccomp_sigreturn		__NR_sigreturn
 #endif
+
+#ifdef CONFIG_COMPAT
+#include <asm/ia32_unistd.h>
+#define __NR_seccomp_read_32		__NR_ia32_read
+#define __NR_seccomp_write_32		__NR_ia32_write
+#define __NR_seccomp_exit_32		__NR_ia32_exit
+#define __NR_seccomp_sigreturn_32	__NR_ia32_sigreturn
+#endif
+
+#include <asm-generic/seccomp.h>
+
+#endif /* _ASM_X86_SECCOMP_H */
diff --git a/arch/x86/include/asm/seccomp_32.h b/arch/x86/include/asm/seccomp_32.h
deleted file mode 100644
index b811d6f5780c..000000000000
--- a/arch/x86/include/asm/seccomp_32.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef _ASM_X86_SECCOMP_32_H
-#define _ASM_X86_SECCOMP_32_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_sigreturn
-
-#endif /* _ASM_X86_SECCOMP_32_H */
diff --git a/arch/x86/include/asm/seccomp_64.h b/arch/x86/include/asm/seccomp_64.h
deleted file mode 100644
index 84ec1bd161a5..000000000000
--- a/arch/x86/include/asm/seccomp_64.h
+++ /dev/null
@@ -1,17 +0,0 @@
-#ifndef _ASM_X86_SECCOMP_64_H
-#define _ASM_X86_SECCOMP_64_H
-
-#include <linux/unistd.h>
-#include <asm/ia32_unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#define __NR_seccomp_read_32 __NR_ia32_read
-#define __NR_seccomp_write_32 __NR_ia32_write
-#define __NR_seccomp_exit_32 __NR_ia32_exit
-#define __NR_seccomp_sigreturn_32 __NR_ia32_sigreturn
-
-#endif /* _ASM_X86_SECCOMP_64_H */
-- 
1.9.1
