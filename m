Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 16:39:13 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:40249 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992521AbeDSOiqA8xJB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 16:38:46 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LlnHM-1eZpsM14EK-00ZTEP; Thu, 19 Apr 2018 16:37:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 03/17] y2038: ia64: Remove unneeded ipc uapi header files
Date:   Thu, 19 Apr 2018 16:37:23 +0200
Message-Id: <20180419143737.606138-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:togmoBqsxPzWYZRjoFWcVxWB8zwSf3VacbiJCfeT+d9Xss8JIqC
 m3aeZZa0gbY0vMTtvPR4rnllAegCZwvIUHmT9vMCfYDPM1zAYXzdWjQ3cNrgaNt7u8pb9Yn
 aaCdkCi5bFn9vquqUqWIrakTxl6upoal9CgusA39F6HVsC8PFtv42Pn1+lENE9+zhDg/XJ4
 94YNXC7q9hLFtHG0Nz18w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a8+4xEiDwvg=:qIGdbUviRp1TU+YUq9AKT+
 tc2Ne6l4NINpyVOjpERT/tgXHdXoOhP3+ywX1Q7LayHPe90nyKIfUKkL2wwgV2W9BOorwfWa6
 mh31AWD1s2zD29r6tD9gEJDPawrzuUseV6tWxh9eKs1R+m5nMugscwcX3YWVMMwwPPj++iIo3
 3XmjjRpWl6FNKsiaZBmD3D6I5Vh54jC0UgCono+nuSmtXw60A2zP9tCwCt3F7lyK4Q7319vlC
 jWbFqdLuMzRX5uJctQhrgn2wegDWlAw4Kb/sElqOjk57juFbLsg/6eqN2/aCCRmOGPSROFed8
 dyKrWjGFB168w64Pk7J9U74Lcabt9qPZGBhN/Gsr5wcuDjyRgWudhvzBsIGzgJG4KMAHAdzjR
 a4TCHPJEYEXtMYCZ0RYoeq/x6V5R7YnhcR9Lgm+ENdVFY3xExE8PDa76ALBMRWV+Gn6RyHibb
 0psdK9JkPoxuUWeZWrHIObifKxECZD8nTeCzTH+hhgkkE9VloTHYBdBLVRmw10hK4JpuV63bD
 NwwSJPAyMSVtw7z/EBFWqaEfqLsk6Ls/2NDQ2EXb0YR6EfNZV9G8jHXH5/Wwus4lHHeJKYSx1
 rZ6Lby13uB5IeAEasa8GakGgVok7mE/oSAAmmYk1iWeB26xB6XXSLtvcu5M5hhgsejwvSPO/i
 prwZ7t9GzBtvrsOPZalLGe2DSaEKFeA76AoCh0TfmmHi4PtrjNhnYyQR+7V32bRvaQrBTQUbh
 Vt7ZfZtu0FhKOVmFzQ+XbRevvfH4he2yVPW7qQ==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

The ia64 ipcbuf/msgbuf/sembuf/shmbuf header files are all identical
to the version from asm-generic.

This patch removes the files and replaces them with 'generic-y'
statements as part of the y2038 changes. While ia64 no longer has
a compat mode and doesn't need the file any more, it seem nicer
to clean this up anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/include/uapi/asm/Kbuild   |  4 ++++
 arch/ia64/include/uapi/asm/ipcbuf.h |  2 --
 arch/ia64/include/uapi/asm/msgbuf.h | 28 --------------------------
 arch/ia64/include/uapi/asm/sembuf.h | 23 ----------------------
 arch/ia64/include/uapi/asm/shmbuf.h | 39 -------------------------------------
 5 files changed, 4 insertions(+), 92 deletions(-)
 delete mode 100644 arch/ia64/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/sembuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/shmbuf.h

diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index c0527cfc48f0..3982e673e967 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -2,5 +2,9 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
+generic-y += ipcbuf.h
 generic-y += kvm_para.h
+generic-y += msgbuf.h
 generic-y += poll.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
diff --git a/arch/ia64/include/uapi/asm/ipcbuf.h b/arch/ia64/include/uapi/asm/ipcbuf.h
deleted file mode 100644
index 90d6445a14df..000000000000
--- a/arch/ia64/include/uapi/asm/ipcbuf.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/ipcbuf.h>
diff --git a/arch/ia64/include/uapi/asm/msgbuf.h b/arch/ia64/include/uapi/asm/msgbuf.h
deleted file mode 100644
index aa25df92d9dc..000000000000
--- a/arch/ia64/include/uapi/asm/msgbuf.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_MSGBUF_H
-#define _ASM_IA64_MSGBUF_H
-
-/*
- * The msqid64_ds structure for IA-64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct msqid64_ds {
-	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused1;
-	unsigned long  __unused2;
-};
-
-#endif /* _ASM_IA64_MSGBUF_H */
diff --git a/arch/ia64/include/uapi/asm/sembuf.h b/arch/ia64/include/uapi/asm/sembuf.h
deleted file mode 100644
index 6ed058760afc..000000000000
--- a/arch/ia64/include/uapi/asm/sembuf.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_SEMBUF_H
-#define _ASM_IA64_SEMBUF_H
-
-/*
- * The semid64_ds structure for IA-64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct semid64_ds {
-	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	__kernel_time_t	sem_otime;		/* last semop time */
-	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long	sem_nsems;		/* no. of semaphores in array */
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-};
-
-#endif /* _ASM_IA64_SEMBUF_H */
diff --git a/arch/ia64/include/uapi/asm/shmbuf.h b/arch/ia64/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 6ef57cb70dee..000000000000
--- a/arch/ia64/include/uapi/asm/shmbuf.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_SHMBUF_H
-#define _ASM_IA64_SHMBUF_H
-
-/*
- * The shmid64_ds structure for IA-64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	__kernel_time_t		shm_ctime;	/* last change time */
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused1;
-	unsigned long		__unused2;
-};
-
-struct shminfo64 {
-	unsigned long	shmmax;
-	unsigned long	shmmin;
-	unsigned long	shmmni;
-	unsigned long	shmseg;
-	unsigned long	shmall;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _ASM_IA64_SHMBUF_H */
-- 
2.9.0
