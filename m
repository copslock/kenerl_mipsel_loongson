Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 00:14:33 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:56649 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006738AbbCBXObuddvf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Mar 2015 00:14:31 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t22NCscM032472;
        Mon, 2 Mar 2015 15:12:54 -0800
Date:   Mon, 2 Mar 2015 15:12:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
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
        x86@kernel.org, Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Laura Abbott <lauraa@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] seccomp: switch to using asm-generic for seccomp.h
Message-ID: <20150302231254.GA4857@www.outflux.net>
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
X-archive-position: 46081
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
v2:
- use Kbuild "generic-y" instead of explicit #include lines (sfr)
---
 arch/arm/include/asm/Kbuild             |  1 +
 arch/arm/include/asm/seccomp.h          | 11 -----------
 arch/microblaze/include/asm/Kbuild      |  1 +
 arch/microblaze/include/asm/seccomp.h   | 16 ----------------
 arch/mips/include/asm/seccomp.h         |  7 ++-----
 arch/parisc/include/asm/Kbuild          |  1 +
 arch/parisc/include/asm/seccomp.h       | 16 ----------------
 arch/powerpc/include/asm/Kbuild         |  1 +
 arch/powerpc/include/uapi/asm/Kbuild    |  1 -
 arch/powerpc/include/uapi/asm/seccomp.h | 16 ----------------
 arch/s390/include/asm/Kbuild            |  1 +
 arch/s390/include/asm/seccomp.h         | 16 ----------------
 arch/sh/include/asm/Kbuild              |  1 +
 arch/sh/include/asm/seccomp.h           | 10 ----------
 arch/sparc/include/asm/Kbuild           |  1 +
 arch/sparc/include/asm/seccomp.h        | 15 ---------------
 arch/x86/include/asm/seccomp.h          | 21 ++++++++++++++++++---
 arch/x86/include/asm/seccomp_32.h       | 11 -----------
 arch/x86/include/asm/seccomp_64.h       | 17 -----------------
 19 files changed, 27 insertions(+), 137 deletions(-)
 delete mode 100644 arch/arm/include/asm/seccomp.h
 delete mode 100644 arch/microblaze/include/asm/seccomp.h
 delete mode 100644 arch/parisc/include/asm/seccomp.h
 delete mode 100644 arch/powerpc/include/uapi/asm/seccomp.h
 delete mode 100644 arch/s390/include/asm/seccomp.h
 delete mode 100644 arch/sh/include/asm/seccomp.h
 delete mode 100644 arch/sparc/include/asm/seccomp.h
 delete mode 100644 arch/x86/include/asm/seccomp_32.h
 delete mode 100644 arch/x86/include/asm/seccomp_64.h

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index fe74c0d1e485..d7be5a9fd171 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -22,6 +22,7 @@ generic-y += preempt.h
 generic-y += resource.h
 generic-y += rwsem.h
 generic-y += scatterlist.h
+generic-y += seccomp.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += sembuf.h
diff --git a/arch/arm/include/asm/seccomp.h b/arch/arm/include/asm/seccomp.h
deleted file mode 100644
index 52b156b341f5..000000000000
--- a/arch/arm/include/asm/seccomp.h
+++ /dev/null
@@ -1,11 +0,0 @@
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
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index ab564a6db5c3..877e2f610655 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -8,5 +8,6 @@ generic-y += irq_work.h
 generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += scatterlist.h
+generic-y += seccomp.h
 generic-y += syscalls.h
 generic-y += trace_clock.h
diff --git a/arch/microblaze/include/asm/seccomp.h b/arch/microblaze/include/asm/seccomp.h
deleted file mode 100644
index 0d912758a0d7..000000000000
--- a/arch/microblaze/include/asm/seccomp.h
+++ /dev/null
@@ -1,16 +0,0 @@
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
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 8686237a3c3c..12b341d04f88 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -20,6 +20,7 @@ generic-y += param.h
 generic-y += percpu.h
 generic-y += poll.h
 generic-y += preempt.h
+generic-y += seccomp.h
 generic-y += segment.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/parisc/include/asm/seccomp.h b/arch/parisc/include/asm/seccomp.h
deleted file mode 100644
index 015f7887aa29..000000000000
--- a/arch/parisc/include/asm/seccomp.h
+++ /dev/null
@@ -1,16 +0,0 @@
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
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 382b28e364dc..c3a772f19dfd 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -5,5 +5,6 @@ generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += scatterlist.h
+generic-y += seccomp.h
 generic-y += trace_clock.h
 generic-y += vtime.h
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
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index c631f98fd524..369fbfcd85fc 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -5,4 +5,5 @@ generic-y += irq_work.h
 generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += scatterlist.h
+generic-y += seccomp.h
 generic-y += trace_clock.h
diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
deleted file mode 100644
index 781a9cf9b002..000000000000
--- a/arch/s390/include/asm/seccomp.h
+++ /dev/null
@@ -1,16 +0,0 @@
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
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 654ebb6bd5d8..457aaa82c30d 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -25,6 +25,7 @@ generic-y += poll.h
 generic-y += preempt.h
 generic-y += resource.h
 generic-y += scatterlist.h
+generic-y += seccomp.h
 generic-y += sembuf.h
 generic-y += serial.h
 generic-y += shmbuf.h
diff --git a/arch/sh/include/asm/seccomp.h b/arch/sh/include/asm/seccomp.h
deleted file mode 100644
index 3280ed3802ef..000000000000
--- a/arch/sh/include/asm/seccomp.h
+++ /dev/null
@@ -1,10 +0,0 @@
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
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 94f36e7086a7..41646380db97 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -16,6 +16,7 @@ generic-y += module.h
 generic-y += mutex.h
 generic-y += preempt.h
 generic-y += scatterlist.h
+generic-y += seccomp.h
 generic-y += serial.h
 generic-y += trace_clock.h
 generic-y += types.h
diff --git a/arch/sparc/include/asm/seccomp.h b/arch/sparc/include/asm/seccomp.h
deleted file mode 100644
index adca1bce41d4..000000000000
--- a/arch/sparc/include/asm/seccomp.h
+++ /dev/null
@@ -1,15 +0,0 @@
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
