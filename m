Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 15:09:41 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.238]:14986 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038755AbXBIPJg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Feb 2007 15:09:36 +0000
Received: by qb-out-0506.google.com with SMTP id e12so191984qba
        for <linux-mips@linux-mips.org>; Fri, 09 Feb 2007 07:08:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=ZeEj368E+h6+ZHvN0KVX2SPaIYyGtJHPHLWMzN+7GLb4oMM1jREGlfIPlhxMhvrIR7qQvT3tQ6MNOQz4WiVgizWyBL7g7u8yjIDVUpRbKc4vZcTQIl4LwsXiDReHGE4w1DvNccvB/G/exixYNeNfahMmVSIvOgaN1wRY23RXIWI=
Received: by 10.65.222.11 with SMTP id z11mr746830qbq.1171033714820;
        Fri, 09 Feb 2007 07:08:34 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id f18sm3718441qba.2007.02.09.07.08.33;
        Fri, 09 Feb 2007 07:08:34 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 9AF3323F76A; Fri,  9 Feb 2007 16:07:39 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 2/3] signals: make common _BLOCKABLE macro
Date:	Fri,  9 Feb 2007 16:07:37 +0100
Message-Id: <11710336593668-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <1171033658561-git-send-email-fbuihuu@gmail.com>
References: <1171033658561-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal-common.h |    2 ++
 arch/mips/kernel/signal.c        |    2 --
 arch/mips/kernel/signal32.c      |    2 --
 arch/mips/kernel/signal_n32.c    |    2 --
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index 9a8abd6..23fffb4 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -19,6 +19,8 @@
 #  define DEBUGP(fmt, args...)
 #endif
 
+#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
+
 /*
  * Horribly complicated - with the bloody RM9000 workarounds enabled
  * the signal trampolines is moving to the end of the structure so we can
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 464d34b..a3c04d0 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -34,8 +34,6 @@
 
 #include "signal-common.h"
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 #if ICACHE_REFILLS_WORKAROUND_WAR == 0
 
 struct rt_sigframe {
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 183fc7e..f603ff4 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -104,8 +104,6 @@ typedef struct compat_siginfo {
 #define __NR_O32_rt_sigreturn		4193
 #define __NR_O32_restart_syscall	4253
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 /* 32-bit compatibility types */
 
 #define _NSIG_BPW32	32
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 57456e6..51b114f 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -47,8 +47,6 @@
 #define __NR_N32_rt_sigreturn		6211
 #define __NR_N32_restart_syscall	6214
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 /* IRIX compatible stack_t  */
 typedef struct sigaltstack32 {
 	s32 ss_sp;
-- 
1.4.4.3.ge6d4
