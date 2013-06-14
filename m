Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 20:14:12 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:45936 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824758Ab3FNSOLpFY2C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jun 2013 20:14:11 +0200
Received: by mail-pd0-f177.google.com with SMTP id p10so812782pdj.22
        for <multiple recipients>; Fri, 14 Jun 2013 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=1YlE3CuHlCkS73Qkc4g4gbzx6zJgARz3X8tKR8gEKm8=;
        b=khzWZ/ndBH5Tm3E21XMPLuBj0q7Dsm9+OjFUDTtU+NBdsQqFH9DZFAHXbZ22KBU4/H
         r/4eRXtTuWjSoyz5t4K0Z044BvmEj/I2Ij2bE2TUo+prEc3xjQf776eHUI0V4wnkZTbx
         SLDD8aDOTxsedo41I5FEFDs9aJMdrTiQek/+oma/yAeSeWEwiB8g4UX4dMjQOaXH2WoX
         kANxPaUcZYxvcTnuBGE8U1tMqC8j1bgwXcgNUSOUM2XnRCTjtignpztp7kSLFjJ/V0uP
         rv0UpjcASe9KSlTUxAqJ3qJKeA4z2jUJ5GXibqil5Na8L2Bpa964SNrltr+BJJI+G/Ku
         8ZeQ==
X-Received: by 10.66.159.168 with SMTP id xd8mr3639967pab.146.1371233645257;
        Fri, 14 Jun 2013 11:14:05 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id i16sm3299101pag.18.2013.06.14.11.14.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 11:14:04 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5EIE1vx009277;
        Fri, 14 Jun 2013 11:14:02 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5EIE0ZU009276;
        Fri, 14 Jun 2013 11:14:00 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     ralf@linux-mips.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2] smp.h: Use local_irq_{save,restore}() in !SMP version of on_each_cpu().
Date:   Fri, 14 Jun 2013 11:13:59 -0700
Message-Id: <1371233639-9244-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Thanks to commit f91eb62f71b (init: scream bloody murder if interrupts
are enabled too early), "bloody murder" is now being screamed.

With a MIPS OCTEON config, we use on_each_cpu() in our
irq_chip.irq_bus_sync_unlock() function.  This gets called in early as
a result of the time_init() call.  Because the !SMP version of
on_each_cpu() unconditionally enables irqs, we get:

------------[ cut here ]------------
WARNING: at init/main.c:560 start_kernel+0x250/0x410()
Interrupts were enabled early
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.10.0-rc5-Cavium-Octeon+ #801
Stack : 0000000000000046 ffffffff808e0000 0000000000000006 0000000000000004
	  0000000000000001 0000000000000000 0000000000000046 0000000000000000
	  ffffffff80a90000 ffffffff8015c020 0000000000000000 ffffffff8015c020
	  ffffffff80a79f70 ffffffff80a80000 ffffffff8072b9c0 ffffffff808a7d77
	  ffffffff80a79f70 ffffffff808a8168 0000000000000000 00000004178a9948
	  0000000417801230 ffffffff805f7610 0000000010000078 ffffffff805fa01c
	  ffffffff8089bd18 ffffffff801595fc ffffffff8089bd28 ffffffff8015d384
	  ffffffff808a7e80 ffffffff8089bc30 0000000000000000 ffffffff80159710
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  0000000000000000 ffffffff80139520 0000000000000000 0000000000000009
	  ...
Call Trace:
[<ffffffff80139520>] show_stack+0x68/0x80
[<ffffffff80159710>] warn_slowpath_common+0x78/0xb0
[<ffffffff801597e8>] warn_slowpath_fmt+0x38/0x48
[<ffffffff8092b768>] start_kernel+0x250/0x410

---[ end trace 139ce121c98e96c9 ]---

Suggested fix: Do what we already do in the SMP version of
on_each_cpu(), and use local_irq_save/local_irq_restore.  Because we
need a flags variable, make it a static inline to avoid name space
issues.

Signed-off-by: David Daney <david.daney@cavium.com>
---

Change from v1: Convert on_each_cpu to a static inline function, add
#include <linux/irqflags.h> to avoid build breakage on some files.

on_each_cpu_mask() and on_each_cpu_cond() suffer the same problem as
on_each_cpu(), but they are not causing !SMP bugs for me, so I will
defer changing them to a less urgent patch.

Thanks,
David Daney

 include/linux/smp.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index e6564c1..c848876 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
+#include <linux/irqflags.h>
 
 extern void cpu_idle(void);
 
@@ -139,13 +140,17 @@ static inline int up_smp_call_function(smp_call_func_t func, void *info)
 }
 #define smp_call_function(func, info, wait) \
 			(up_smp_call_function(func, info))
-#define on_each_cpu(func,info,wait)		\
-	({					\
-		local_irq_disable();		\
-		func(info);			\
-		local_irq_enable();		\
-		0;				\
-	})
+
+static inline int on_each_cpu(smp_call_func_t func, void *info, int wait)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	func(info);
+	local_irq_restore(flags);
+	return 0;
+}
+
 /*
  * Note we still need to test the mask even for UP
  * because we actually can get an empty mask from
-- 
1.7.11.7
