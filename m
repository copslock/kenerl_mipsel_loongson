Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2015 01:52:40 +0100 (CET)
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34770 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012556AbbKEAvsqnv1s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2015 01:51:48 +0100
Received: by wmnn186 with SMTP id n186so1095503wmn.1;
        Wed, 04 Nov 2015 16:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aiWtVIc+Yz9UBRjJIm/xB0mUemrf3nxzVXMC2j+WzTI=;
        b=iK1W5gLa8Cvgj+IovkB3HsN1ouAFH6cl56Uwr+97+zzx0NOsu7ZPi5/GaZl7oysWae
         NFuuvIvYNqVOV2N185MeiDACSVuRnBsSr5o9N6/fLSK8fJ+E64kDH6oKpBhkzrB8RVrp
         TEZqkYkT+ghkP/FFu1tPG1YJDnmtnBU6afsNjSE9VliAl+Ofn+Dk+H6CQ4Hr0SYibaZE
         EdKxBSSqHiBWTUIBzarxbGAXHA9ak5bxF8x9ZcOkuSoo7+5zmOIqpOehNQ4g4xLghP6G
         26AHhvOhj7xu16ZcXMubVNz51VRGxvvpiaY6Cx/X+i8EemE0IIDHcCryT2glc5+lndJ2
         nwXg==
X-Received: by 10.28.135.13 with SMTP id j13mr79194wmd.48.1446684703587;
        Wed, 04 Nov 2015 16:51:43 -0800 (PST)
Received: from amanieu-laptop.wireless.ropemaker.crm.lan ([31.205.92.76])
        by smtp.gmail.com with ESMTPSA id 194sm5558927wmh.19.2015.11.04.16.51.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Nov 2015 16:51:42 -0800 (PST)
From:   Amanieu d'Antras <amanieu@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Amanieu d'Antras <amanieu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v2 05/20] mips: Clean up compat_siginfo_t
Date:   Thu,  5 Nov 2015 00:50:24 +0000
Message-Id: <1446684640-4112-6-git-send-email-amanieu@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
References: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
Return-Path: <amanieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49846
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

While mips can't use the generic compat_siginfo_t directly because
its si_code and si_errno are inverted, we can still make it as
close to the generic version as possible. This makes it easier
to update when new members are added to siginfo_t.

The main changes are adding a missing _sigsys union member and
eliminating the unused _irix_sigchld one.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
---
 arch/mips/include/asm/compat.h | 61 +++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 1e5ba38..29ca129 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -130,6 +130,7 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
+/* Can't use the generic version because si_code and si_errno are swapped */
 #define HAVE_ARCH_COMPAT_SIGINFO_T
 #define HAVE_ARCH_COPY_SIGINFO_TO_USER32
 #define HAVE_ARCH_COPY_SIGINFO_FROM_USER32
@@ -141,57 +142,61 @@ typedef struct compat_siginfo {
 	int si_errno;
 
 	union {
-		int _pad[SI_PAD_SIZE32];
+		int _pad[128 / sizeof(int) - 3];
 
 		/* kill() */
 		struct {
 			compat_pid_t _pid;	/* sender's pid */
-			__compat_uid_t _uid;	/* sender's uid */
+			__compat_uid32_t _uid;	/* sender's uid */
 		} _kill;
 
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
+			__compat_uid32_t _uid;	/* sender's uid */
+			compat_sigval_t _sigval;
+		} _rt;
+
 		/* SIGCHLD */
 		struct {
 			compat_pid_t _pid;	/* which child */
-			__compat_uid_t _uid;	/* sender's uid */
+			__compat_uid32_t _uid;	/* sender's uid */
 			int _status;		/* exit code */
 			compat_clock_t _utime;
 			compat_clock_t _stime;
 		} _sigchld;
 
-		/* IRIX SIGCHLD */
-		struct {
-			compat_pid_t _pid;	/* which child */
-			compat_clock_t _utime;
-			int _status;		/* exit code */
-			compat_clock_t _stime;
-		} _irix_sigchld;
-
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
 		struct {
-			s32 _addr; /* faulting insn/memory ref. */
+			compat_uptr_t _addr;	/* faulting insn/memory ref. */
+#ifdef __ARCH_SI_TRAPNO
+			int _trapno;	/* TRAP # which caused the signal */
+#endif
+			short _addr_lsb; /* LSB of the reported address */
+			struct {
+				compat_uptr_t _lower;
+				compat_uptr_t _upper;
+			} _addr_bnd;
 		} _sigfault;
 
-		/* SIGPOLL, SIGXFSZ (To do ...)	 */
+		/* SIGPOLL */
 		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+			compat_long_t _band; /* POLL_IN, POLL_OUT, POLL_MSG */
 			int _fd;
 		} _sigpoll;
 
-		/* POSIX.1b timers */
-		struct {
-			timer_t _tid;		/* timer id */
-			int _overrun;		/* overrun count */
-			compat_sigval_t _sigval;/* same as below */
-			int _sys_private;	/* not to be passed to user */
-		} _timer;
-
-		/* POSIX.1b signals */
 		struct {
-			compat_pid_t _pid;	/* sender's pid */
-			__compat_uid_t _uid;	/* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
+			compat_uptr_t _call_addr; /* calling insn */
+			int _syscall;	/* triggering system call number */
+			compat_uint_t _arch;	/* AUDIT_ARCH_* of syscall */
+		} _sigsys;
 	} _sifields;
 } compat_siginfo_t;
 
-- 
2.6.2
