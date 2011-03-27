Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Mar 2011 18:22:11 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:40546 "EHLO linutronix.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491890Ab1C0QWI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Mar 2011 18:22:08 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q3sj4-00054m-43; Sun, 27 Mar 2011 18:22:02 +0200
Message-Id: <20110327161118.540001576@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sun, 27 Mar 2011 16:22:01 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: [patch 1/5] MIPS: Fix syncfs syscall copy and paste failure
References: <20110327155637.623706071@linutronix.de>
Content-Disposition: inline; filename=mips-fix-syscall-conflict.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/include/asm/unistd.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-tip/arch/mips/include/asm/unistd.h
===================================================================
--- linux-2.6-tip.orig/arch/mips/include/asm/unistd.h
+++ linux-2.6-tip/arch/mips/include/asm/unistd.h
@@ -1005,7 +1005,7 @@
 #define __NR_name_to_handle_at		(__NR_Linux + 303)
 #define __NR_open_by_handle_at		(__NR_Linux + 304)
 #define __NR_clock_adjtime		(__NR_Linux + 305)
-#define __NR_clock_adjtime		(__NR_Linux + 306)
+#define __NR_syncfs			(__NR_Linux + 306)
 
 /*
  * Offset of the last N32 flavoured syscall
