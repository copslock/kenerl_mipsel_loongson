Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 21:25:35 +0200 (CEST)
Received: from pyxis.i-cable.com ([203.83.115.105]:56574 "HELO
	pyxis.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S1492094AbZFQTZZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2009 21:25:25 +0200
Received: (qmail 13930 invoked by uid 104); 17 Jun 2009 19:23:46 -0000
Received: from 203.83.114.121 by pyxis (envelope-from <r0bertz@gentoo.org>, uid 101) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/7733.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.178724 secs); 17 Jun 2009 19:23:46 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 17 Jun 2009 19:23:46 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n5HJNi7J017679;
	Thu, 18 Jun 2009 03:23:45 +0800 (HKT)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	manuel.lauss@gmail.com, Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH v2] -git compile fixes for MIPS
Date:	Thu, 18 Jun 2009 03:23:10 +0800
Message-Id: <1245266590-31999-1-git-send-email-r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

Quick fixes for some compile failures which have cropped up
in linus-git in the last 24 hours:

   CC      arch/mips/kernel/time.o
In file included from linux-2.6.git/include/linux/bug.h:4,
                  from linux-2.6.git/arch/mips/kernel/time.c:13:
linux-2.6.git/arch/mips/include/asm/bug.h:10: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'BUG'
linux-2.6.git/arch/mips/include/asm/bug.h: In function '__BUG_ON':
linux-2.6.git/arch/mips/include/asm/bug.h:26: error: implicit declaration of function 'BUG'

  CC      arch/mips/kernel/traps.o
cc1: warnings being treated as errors
/home/zhangle/linux/arch/mips/kernel/traps.c: In function ‘set_uncached_handler’:
/home/zhangle/linux/arch/mips/kernel/traps.c:1604: error: format not a string literal and no format arguments

   CC      arch/mips/mm/uasm.o
In file included from linux-2.6.git/arch/mips/mm/uasm.c:21:
linux-2.6.git/arch/mips/include/asm/bugs.h: In function 'check_bugs':
linux-2.6.git/arch/mips/include/asm/bugs.h:34: error: implicit declaration of function 'smp_processor_id'
linux-2.6.git/arch/mips/mm/uasm.c: In function 'uasm_copy_handler':
linux-2.6.git/arch/mips/mm/uasm.c:514: error: implicit declaration of function 'memcpy'

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 arch/mips/include/asm/bug.h  |    1 +
 arch/mips/include/asm/bugs.h |    1 +
 arch/mips/kernel/traps.c     |    2 +-
 arch/mips/mm/uasm.c          |    1 +
 4 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
index 08ea468..974b161 100644
--- a/arch/mips/include/asm/bug.h
+++ b/arch/mips/include/asm/bug.h
@@ -6,6 +6,7 @@
 #ifdef CONFIG_BUG
 
 #include <asm/break.h>
+#include <linux/compiler.h>
 
 static inline void __noreturn BUG(void)
 {
diff --git a/arch/mips/include/asm/bugs.h b/arch/mips/include/asm/bugs.h
index 9dc10df..b160a70 100644
--- a/arch/mips/include/asm/bugs.h
+++ b/arch/mips/include/asm/bugs.h
@@ -11,6 +11,7 @@
 
 #include <linux/bug.h>
 #include <linux/delay.h>
+#include <linux/smp.h>
 
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 08f1edf..0e9922b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1601,7 +1601,7 @@ void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
 #endif
 
 	if (!addr)
-		panic(panic_null_cerr);
+		panic("%s", panic_null_cerr);
 
 	memcpy((void *)(uncached_ebase + offset), addr, size);
 }
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index f467199..ba538f7 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/string.h>
 
 #include <asm/inst.h>
 #include <asm/elf.h>
-- 
1.6.3.1
