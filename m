Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 21:44:36 +0200 (CEST)
Received: from tenor.i-cable.com ([203.83.115.107]:51814 "HELO
	tenor.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S1492005AbZFQToa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2009 21:44:30 +0200
Received: (qmail 12985 invoked by uid 508); 17 Jun 2009 19:42:55 -0000
Received: from 203.83.114.121 by tenor (envelope-from <r0bertz@gentoo.org>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7824.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.130851 secs); 17 Jun 2009 19:42:55 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 17 Jun 2009 19:42:54 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n5HJgobR018756;
	Thu, 18 Jun 2009 03:42:50 +0800 (HKT)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	manuel.lauss@gmail.com, ddaney@caviumnetworks.com,
	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH v3] -git compile fixes for MIPS
Date:	Thu, 18 Jun 2009 03:42:24 +0800
Message-Id: <1245267744-1669-1-git-send-email-r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23456
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

   CC      arch/mips/mm/uasm.o
In file included from linux-2.6.git/arch/mips/mm/uasm.c:21:
linux-2.6.git/arch/mips/include/asm/bugs.h: In function 'check_bugs':
linux-2.6.git/arch/mips/include/asm/bugs.h:34: error: implicit declaration of function 'smp_processor_id'
linux-2.6.git/arch/mips/mm/uasm.c: In function 'uasm_copy_handler':
linux-2.6.git/arch/mips/mm/uasm.c:514: error: implicit declaration of function 'memcpy'

Reviewed-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 arch/mips/include/asm/bug.h  |    2 ++
 arch/mips/include/asm/bugs.h |    1 +
 arch/mips/mm/uasm.c          |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
index 08ea468..49b20fe 100644
--- a/arch/mips/include/asm/bug.h
+++ b/arch/mips/include/asm/bug.h
@@ -5,6 +5,8 @@
 
 #ifdef CONFIG_BUG
 
+#include <linux/compiler.h>
+
 #include <asm/break.h>
 
 static inline void __noreturn BUG(void)
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
