Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2006 21:07:16 +0200 (CEST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:14186 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133732AbWFATHJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Jun 2006 21:07:09 +0200
Received: from [192.168.5.10] ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k51J77s02204
	for <linux-mips@linux-mips.org>; Fri, 2 Jun 2006 00:07:07 +0500
Subject: [RFC] [PATCH] sys_shmat for 64-bits in 32-bit compat mode
From:	dmitry pervushin <dpervushin@ru.mvista.com>
Reply-To: dpervushin@ru.mvista.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Organization: montavista
Date:	Thu, 01 Jun 2006 23:07:04 +0400
Message-Id: <1149188824.6986.6.camel@diimka-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Return-Path: <dpervushin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dpervushin@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello all,

I would like you to comment the following patch. At the some moment, I
was faced to problem with syscall sys_shmat in 32-bit mode on 64-bit
platforms. I have fixed the function in the same manner as native
sys_shmat had been: sys_shmat expects pointer to memory as the return
value rather than put_user'ed to the memory pointed by 3rd parameter.

Signed-off-by: dmitry pervushin <dpervushin@ru.mvista.com>
 arch/mips/kernel/linux32.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-mips/arch/mips/kernel/linux32.c
===================================================================
--- linux-mips.orig/arch/mips/kernel/linux32.c
+++ linux-mips/arch/mips/kernel/linux32.c
@@ -36,6 +36,7 @@
 #include <linux/security.h>
 #include <linux/compat.h>
 #include <linux/vfs.h>
+#include <linux/ptrace.h>
 
 #include <net/sock.h>
 #include <net/scm.h>
@@ -978,7 +979,8 @@ asmlinkage long sys32_shmat(int shmid, c
 	if (err)
 		return err;
 
-	return put_user(raddr, addr);
+	force_successful_syscall_return();
+	return raddr;
 }
 
 struct sysctl_args32
