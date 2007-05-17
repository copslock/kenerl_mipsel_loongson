Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2007 16:53:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:51192 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023489AbXEQPxc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2007 16:53:32 +0100
Received: from localhost (p7084-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.84])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D1ED4B971; Fri, 18 May 2007 00:53:29 +0900 (JST)
Date:	Fri, 18 May 2007 00:53:47 +0900 (JST)
Message-Id: <20070518.005347.82350805.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Drop __ARCH_WANT_SYS_FADVISE64
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

sys_fadvise64() is not used on MIPS.  The libc can implement
both posix_fadvise() and posix_fadvise64() using sys_fadvise64_64().

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/unistd.h b/include/asm-mips/unistd.h
index 2f1087b..91c306f 100644
--- a/include/asm-mips/unistd.h
+++ b/include/asm-mips/unistd.h
@@ -949,7 +949,6 @@
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
-#define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
 #define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
