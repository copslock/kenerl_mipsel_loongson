Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Feb 2015 01:53:13 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:46900 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007598AbbB1AxLdwWoU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Feb 2015 01:53:11 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t1S0qTLl008209;
        Fri, 27 Feb 2015 16:52:31 -0800
Date:   Fri, 27 Feb 2015 16:52:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Russell King <linux@arm.linux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        James Hogan <james.hogan@imgtec.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH] seccomp: switch to using asm-generic for seccomp.h
Message-ID: <20150228005228.GA23638@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46054
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

Most architectures don't need to do anything special for the strict
seccomp syscall entries. Remove the redundant headers and reduce the
others.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/seccomp.h          | 12 +-----------
 arch/microblaze/include/asm/seccomp.h   | 17 +----------------
 arch/mips/include/asm/seccomp.h         |  7 ++-----
 arch/parisc/include/asm/seccomp.h       | 17 +----------------
 arch/powerpc/include/asm/seccomp.h      |  1 +
 arch/powerpc/include/uapi/asm/Kbuild    |  1 -
 arch/powerpc/include/uapi/asm/seccomp.h | 16 ----------------
 arch/s390/include/asm/seccomp.h         | 17 +----------------
 arch/sh/include/asm/seccomp.h           | 11 +----------
 arch/sparc/include/asm/seccomp.h        | 16 +---------------
 arch/x86/include/asm/seccomp.h          | 21 ++++++++++++++++++---
 arch/x86/include/asm/seccomp_32.h       | 11 -----------
 arch/x86/include/asm/seccomp_64.h       | 17 -----------------
 13 files changed, 27 insertions(+), 137 deletions(-)
 create mode 100644 arch/powerpc/include/asm/seccomp.h
 delete mode 100644 arch/powerpc/include/uapi/asm/seccomp.h
 delete mode 100644 arch/x86/include/asm/seccomp_32.h
 delete mode 100644 arch/x86/include/asm/seccomp_64.h

diff --git a/arch/arm/include/asm/seccomp.h b/arch/arm/include/asm/seccomp.h
index 52b156b341f5..66ca6a30bf5c 100644
--- a/arch/arm/include/asm/seccomp.h
+++ b/arch/arm/include/asm/seccomp.h
@@ -1,11 +1 @@
-#ifndef _ASM_ARM_SECCOMP_H
-#define _ASM_ARM_SECCOMP_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#endif /* _ASM_ARM_SECCOMP_H */
+#include <asm-generic/seccomp.h>
diff --git a/arch/microblaze/include/asm/seccomp.h b/arch/microblaze/include/asm/seccomp.h
index 0d912758a0d7..66ca6a30bf5c 100644
--- a/arch/microblaze/include/asm/seccomp.h
+++ b/arch/microblaze/include/asm/seccomp.h
@@ -1,16 +1 @@
-#ifndef _ASM_MICROBLAZE_SECCOMP_H
-#define _ASM_MICROBLAZE_SECCOMP_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read		__NR_read
-#define __NR_seccomp_write		__NR_write
-#define __NR_seccomp_exit		__NR_exit
-#define __NR_seccomp_sigreturn		__NR_sigreturn
-
-#define __NR_seccomp_read_32		__NR_read
-#define __NR_seccomp_write_32		__NR_write
-#define __NR_seccomp_exit_32		__NR_exit
-#define __NR_seccomp_sigreturn_32	__NR_sigreturn
-
-#endif	/* _ASM_MICROBLAZE_SECCOMP_H */
+#include <asm-generic/seccomp.h>
diff --git a/arch/mips/include/asm/seccomp.h b/arch/mips/include/asm/seccomp.h
index f29c75cf83c6..1d8a2e2c75c1 100644
--- a/arch/mips/include/asm/seccomp.h
+++ b/arch/mips/include/asm/seccomp.h
@@ -2,11 +2,6 @@
 
 #include <linux/unistd.h>
 
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
 /*
  * Kludge alert:
  *
@@ -29,4 +24,6 @@
 
 #endif /* CONFIG_MIPS32_O32 */
 
+#include <asm-generic/seccomp.h>
+
 #endif /* __ASM_SECCOMP_H */
diff --git a/arch/parisc/include/asm/seccomp.h b/arch/parisc/include/asm/seccomp.h
index 015f7887aa29..66ca6a30bf5c 100644
--- a/arch/parisc/include/asm/seccomp.h
+++ b/arch/parisc/include/asm/seccomp.h
@@ -1,16 +1 @@
-#ifndef _ASM_PARISC_SECCOMP_H
-#define _ASM_PARISC_SECCOMP_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#define __NR_seccomp_read_32 __NR_read
-#define __NR_seccomp_write_32 __NR_write
-#define __NR_seccomp_exit_32 __NR_exit
-#define __NR_seccomp_sigreturn_32 __NR_rt_sigreturn
-
-#endif	/* _ASM_PARISC_SECCOMP_H */
+#include <asm-generic/seccomp.h>
diff --git a/arch/powerpc/include/asm/seccomp.h b/arch/powerpc/include/asm/seccomp.h
new file mode 100644
index 000000000000..66ca6a30bf5c
--- /dev/null
+++ b/arch/powerpc/include/asm/seccomp.h
@@ -0,0 +1 @@
+#include <asm-generic/seccomp.h>
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 7a3f795ac218..79c4068be278 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -25,7 +25,6 @@ header-y += posix_types.h
 header-y += ps3fb.h
 header-y += ptrace.h
 header-y += resource.h
-header-y += seccomp.h
 header-y += sembuf.h
 header-y += setup.h
 header-y += shmbuf.h
diff --git a/arch/powerpc/include/uapi/asm/seccomp.h b/arch/powerpc/include/uapi/asm/seccomp.h
deleted file mode 100644
index 00c1d9133cfe..000000000000
--- a/arch/powerpc/include/uapi/asm/seccomp.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef _ASM_POWERPC_SECCOMP_H
-#define _ASM_POWERPC_SECCOMP_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#define __NR_seccomp_read_32 __NR_read
-#define __NR_seccomp_write_32 __NR_write
-#define __NR_seccomp_exit_32 __NR_exit
-#define __NR_seccomp_sigreturn_32 __NR_sigreturn
-
-#endif	/* _ASM_POWERPC_SECCOMP_H */
diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
index 781a9cf9b002..66ca6a30bf5c 100644
--- a/arch/s390/include/asm/seccomp.h
+++ b/arch/s390/include/asm/seccomp.h
@@ -1,16 +1 @@
-#ifndef _ASM_S390_SECCOMP_H
-#define _ASM_S390_SECCOMP_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read	__NR_read
-#define __NR_seccomp_write	__NR_write
-#define __NR_seccomp_exit	__NR_exit
-#define __NR_seccomp_sigreturn	__NR_sigreturn
-
-#define __NR_seccomp_read_32	__NR_read
-#define __NR_seccomp_write_32	__NR_write
-#define __NR_seccomp_exit_32	__NR_exit
-#define __NR_seccomp_sigreturn_32 __NR_sigreturn
-
-#endif	/* _ASM_S390_SECCOMP_H */
+#include <asm-generic/seccomp.h>
diff --git a/arch/sh/include/asm/seccomp.h b/arch/sh/include/asm/seccomp.h
index 3280ed3802ef..66ca6a30bf5c 100644
--- a/arch/sh/include/asm/seccomp.h
+++ b/arch/sh/include/asm/seccomp.h
@@ -1,10 +1 @@
-#ifndef __ASM_SECCOMP_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#endif /* __ASM_SECCOMP_H */
+#include <asm-generic/seccomp.h>
diff --git a/arch/sparc/include/asm/seccomp.h b/arch/sparc/include/asm/seccomp.h
index adca1bce41d4..66ca6a30bf5c 100644
--- a/arch/sparc/include/asm/seccomp.h
+++ b/arch/sparc/include/asm/seccomp.h
@@ -1,15 +1 @@
-#ifndef _ASM_SECCOMP_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#define __NR_seccomp_read_32 __NR_read
-#define __NR_seccomp_write_32 __NR_write
-#define __NR_seccomp_exit_32 __NR_exit
-#define __NR_seccomp_sigreturn_32 __NR_sigreturn
-
-#endif /* _ASM_SECCOMP_H */
+#include <asm-generic/seccomp.h>
diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index 0f3d7f099224..b13ac5f63702 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -1,5 +1,20 @@
+#ifndef _ASM_X86_SECCOMP_H
+#define _ASM_X86_SECCOMP_H
+
+#include <asm/unistd.h>
+
+#ifdef CONFIG_COMPAT
+#include <asm/ia32_unistd.h>
+#define __NR_seccomp_read_32		__NR_ia32_read
+#define __NR_seccomp_write_32		__NR_ia32_write
+#define __NR_seccomp_exit_32		__NR_ia32_exit
+#define __NR_seccomp_sigreturn_32	__NR_ia32_sigreturn
+#endif
+
 #ifdef CONFIG_X86_32
-# include <asm/seccomp_32.h>
-#else
-# include <asm/seccomp_64.h>
+#define __NR_seccomp_sigreturn		__NR_sigreturn
 #endif
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


-- 
Kees Cook
Chrome OS Security
