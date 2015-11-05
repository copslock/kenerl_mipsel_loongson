Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2015 01:52:02 +0100 (CET)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34298 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012548AbbKEAvnr3ZQs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2015 01:51:43 +0100
Received: by wmeg8 with SMTP id g8so45803wme.1;
        Wed, 04 Nov 2015 16:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=02+IDgPS9iLA3p4ZUv+MIAD5+TAh44vVnvEiocJAYWw=;
        b=KagN8kniQHfghBb+IdZ33eb6fAf8Ap2YKa+jsaLe47viNaOY6BJAannAyr0jPPPHiW
         6F035C3j9aPdJ6MXZPsDR8h4MiJ7IHOEKPhUpLAeAw21raTTakTHcFebkK2NsBFXfW8x
         R8t1dFmHHtlaYrPjA4LFQdvsGKAnaM8XrYUB7wAxjiDMkbWG5AOn6LgQfiKRXOzsekxg
         w/gdIDJwhgrfHwvr0HrrX0Yz9VrdCfh65HDzkHIVnMwuToWARm4UKr/7X8RQqe2PZzky
         uodk+5KvAxz+PIc/I1d9rvwDxn2hpeOvtXQYiZkS95xrNeuT9PUUngg1jnxQIXHoG0hL
         CQkA==
X-Received: by 10.28.6.206 with SMTP id 197mr60499wmg.102.1446684698571;
        Wed, 04 Nov 2015 16:51:38 -0800 (PST)
Received: from amanieu-laptop.wireless.ropemaker.crm.lan ([31.205.92.76])
        by smtp.gmail.com with ESMTPSA id 194sm5558927wmh.19.2015.11.04.16.51.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Nov 2015 16:51:38 -0800 (PST)
From:   Amanieu d'Antras <amanieu@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Amanieu d'Antras <amanieu@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v2 01/20] compat: Add generic compat_siginfo_t
Date:   Thu,  5 Nov 2015 00:50:20 +0000
Message-Id: <1446684640-4112-2-git-send-email-amanieu@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
References: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
Return-Path: <amanieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amanieu@gmail.com
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

This matches the normal siginfo_t as closely as possible, unlike
some architecture-specific versions which are missing some fields.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
---
 arch/arm64/include/asm/compat.h   |  2 ++
 arch/mips/include/asm/compat.h    |  1 +
 arch/parisc/include/asm/compat.h  |  2 ++
 arch/powerpc/include/asm/compat.h |  1 +
 arch/s390/include/asm/compat.h    |  2 ++
 arch/sparc/include/asm/compat.h   |  1 +
 arch/tile/include/asm/compat.h    |  1 +
 arch/x86/include/asm/compat.h     |  2 ++
 include/linux/compat.h            | 66 ++++++++++++++++++++++++++++++++++++++-
 9 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 7fbed69..ff4e294 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -155,6 +155,8 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
+#define HAVE_ARCH_COMPAT_SIGINFO_T
+
 typedef struct compat_siginfo {
 	int si_signo;
 	int si_errno;
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index c4bd54a..5f1f816 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -130,6 +130,7 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
+#define HAVE_ARCH_COMPAT_SIGINFO_T
 #define SI_PAD_SIZE32	(128/sizeof(int) - 3)
 
 typedef struct compat_siginfo {
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index 94710cf..e0be05f 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -134,6 +134,8 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
+#define HAVE_ARCH_COMPAT_SIGINFO_T
+
 typedef struct compat_siginfo {
 	int si_signo;
 	int si_errno;
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 4f2df58..75b25ff 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -124,6 +124,7 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
+#define HAVE_ARCH_COMPAT_SIGINFO_T
 #define SI_PAD_SIZE32	(128/sizeof(int) - 3)
 
 typedef struct compat_siginfo {
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index d350ed9..ac73ac7 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -192,6 +192,8 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
+#define HAVE_ARCH_COMPAT_SIGINFO_T
+
 typedef struct compat_siginfo {
 	int	si_signo;
 	int	si_errno;
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 830502fe..0c80f59 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -153,6 +153,7 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
+#define HAVE_ARCH_COMPAT_SIGINFO_T
 #define SI_PAD_SIZE32	(128/sizeof(int) - 3)
 
 typedef struct compat_siginfo {
diff --git a/arch/tile/include/asm/compat.h b/arch/tile/include/asm/compat.h
index c14e36f..f9bba8d 100644
--- a/arch/tile/include/asm/compat.h
+++ b/arch/tile/include/asm/compat.h
@@ -115,6 +115,7 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
+#define HAVE_ARCH_COMPAT_SIGINFO_T
 #define COMPAT_SI_PAD_SIZE	(128/sizeof(int) - 3)
 
 typedef struct compat_siginfo {
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index acdee09..69176b4 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -130,6 +130,8 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
+#define HAVE_ARCH_COMPAT_SIGINFO_T
+
 typedef struct compat_siginfo {
 	int si_signo;
 	int si_errno;
diff --git a/include/linux/compat.h b/include/linux/compat.h
index a76c917..e51574c 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -196,7 +196,71 @@ struct compat_rusage {
 extern int put_compat_rusage(const struct rusage *,
 			     struct compat_rusage __user *);
 
-struct compat_siginfo;
+#ifndef HAVE_ARCH_COMPAT_SIGINFO_T
+typedef struct compat_siginfo {
+	int si_signo;
+	int si_errno;
+	int si_code;
+
+	union {
+		int _pad[128 / sizeof(int) - 3];
+
+		/* kill() */
+		struct {
+			compat_pid_t _pid;	/* sender's pid */
+			compat_uid_t _uid;	/* sender's uid */
+		} _kill;
+
+		/* POSIX.1b timers */
+		struct {
+			compat_timer_t _tid;	/* timer id */
+			int _overrun;		/* overrun count */
+			compat_sigval_t _sigval;	/* same as below */
+		} _timer;
+
+		/* POSIX.1b signals */
+		struct {
+			compat_pid_t _pid;	/* sender's pid */
+			compat_uid_t _uid;	/* sender's uid */
+			compat_sigval_t _sigval;
+		} _rt;
+
+		/* SIGCHLD */
+		struct {
+			compat_pid_t _pid;	/* which child */
+			compat_uid_t _uid;	/* sender's uid */
+			int _status;		/* exit code */
+			compat_clock_t _utime;
+			compat_clock_t _stime;
+		} _sigchld;
+
+		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+		struct {
+			compat_uptr_t _addr;	/* faulting insn/memory ref. */
+#ifdef __ARCH_SI_TRAPNO
+			int _trapno;	/* TRAP # which caused the signal */
+#endif
+			short _addr_lsb; /* LSB of the reported address */
+			struct {
+				compat_uptr_t _lower;
+				compat_uptr_t _upper;
+			} _addr_bnd;
+		} _sigfault;
+
+		/* SIGPOLL */
+		struct {
+			compat_long_t _band; /* POLL_IN, POLL_OUT, POLL_MSG */
+			int _fd;
+		} _sigpoll;
+
+		struct {
+			compat_uptr_t _call_addr; /* calling insn */
+			int _syscall;	/* triggering system call number */
+			compat_uint_t _arch;	/* AUDIT_ARCH_* of syscall */
+		} _sigsys;
+	} _sifields;
+} compat_siginfo_t;
+#endif
 
 extern asmlinkage long compat_sys_waitid(int, compat_pid_t,
 		struct compat_siginfo __user *, int,
-- 
2.6.2
