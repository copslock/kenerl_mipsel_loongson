Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2008 17:58:19 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:41653 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28575438AbYCTR6Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Mar 2008 17:58:16 +0000
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 6CC408816; Thu, 20 Mar 2008 22:58:33 +0400 (SAMT)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Make KGDB compile on UP
Date:	Thu, 20 Mar 2008 20:59:34 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803202059.37857.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Building UP kernel with KGDB enabled produces the following errors and warning
(fatal due to -Werror in arch/mips/kernel/Makefile):

In file included from arch/mips/kernel/gdb-stub.c:142:
include/asm/smp.h:25:1: "raw_smp_processor_id" redefined
In file included from include/linux/sched.h:69,
                 from arch/mips/kernel/gdb-stub.c:126:
include/linux/smp.h:88:1: this is the location of the previous definition
In file included from arch/mips/kernel/gdb-stub.c:142:
include/asm/smp.h:62: error: redefinition of 'smp_send_reschedule'
include/linux/smp.h:102: error: previous definition of 'smp_send_reschedule' was here
include/asm/smp.h: In function `smp_send_reschedule':
include/asm/smp.h:65: error: dereferencing pointer to incomplete type
arch/mips/kernel/gdb-stub.c: At top level:
arch/mips/kernel/gdb-stub.c:660: warning: 'kgdb_wait' defined but not used

Fix the errors by not directly including <asm/smp.h> (which is already included
by <linux/smp.h>) and the warning by enclosing kgdb_wait() in #ifdef CONFIG_SMP.

---
This should be applied to 2.6.23+ stable branches since -Werror was introduced
in 2.6.23-rc2; the errors only started occuring after 2.6.24...

 arch/mips/kernel/gdb-stub.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/mips/kernel/gdb-stub.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/gdb-stub.c
+++ linux-2.6/arch/mips/kernel/gdb-stub.c
@@ -139,7 +139,6 @@
 #include <asm/system.h>
 #include <asm/gdb-stub.h>
 #include <asm/inst.h>
-#include <asm/smp.h>
 
 /*
  * external low-level support routines
@@ -656,6 +655,7 @@ void set_async_breakpoint(unsigned long 
 	*epc = (unsigned long)async_breakpoint;
 }
 
+#ifdef CONFIG_SMP
 static void kgdb_wait(void *arg)
 {
 	unsigned flags;
@@ -668,6 +668,7 @@ static void kgdb_wait(void *arg)
 
 	local_irq_restore(flags);
 }
+#endif
 
 /*
  * GDB stub needs to call kgdb_wait on all processor with interrupts
