Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Oct 2002 19:23:29 +0200 (CEST)
Received: from 12-234-88-146.client.attbi.com ([12.234.88.146]:40168 "EHLO
	lucon.org") by linux-mips.org with ESMTP id <S1122961AbSJJRX2>;
	Thu, 10 Oct 2002 19:23:28 +0200
Received: by lucon.org (Postfix, from userid 1000)
	id 8C6052C4EC; Thu, 10 Oct 2002 10:23:17 -0700 (PDT)
Date: Thu, 10 Oct 2002 10:23:17 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux-mips@linux-mips.org
Subject: PATCH: Support strace
Message-ID: <20021010102317.A20613@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

strace includes <asm/system.h>. gcc doesn't like asmlinkage. This patch
helps strace.


H.J.
--- include/asm-mips/system.h.kernel	Sat Oct  5 10:39:23 2002
+++ include/asm-mips/system.h	Thu Oct 10 09:47:51 2002
@@ -24,6 +24,8 @@
 #include <asm/addrspace.h>
 #include <asm/ptrace.h>
 
+#ifdef __KERNEL__
+
 __asm__ (
 	".macro\t__sti\n\t"
 	".set\tpush\n\t"
@@ -322,4 +324,6 @@ extern void __die_if_kernel(const char *
 #define die_if_kernel(msg, regs)					\
 	__die_if_kernel(msg, regs, __FILE__ ":", __FUNCTION__, __LINE__)
 
+#endif /* __KERNEL__ */
+
 #endif /* _ASM_SYSTEM_H */
