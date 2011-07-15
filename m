Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2011 23:52:57 +0200 (CEST)
Received: from ogre.sisk.pl ([217.79.144.158]:57558 "EHLO ogre.sisk.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490945Ab1GOVwv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Jul 2011 23:52:51 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by ogre.sisk.pl (Postfix) with ESMTP id 50E161B0824;
        Fri, 15 Jul 2011 23:24:16 +0200 (CEST)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19052-08; Fri, 15 Jul 2011 23:23:55 +0200 (CEST)
Received: from ferrari.rjw.lan (220-bem-13.acn.waw.pl [82.210.184.220])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ogre.sisk.pl (Postfix) with ESMTP id EC2601B06B5;
        Fri, 15 Jul 2011 23:23:54 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@sisk.pl>
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Convert i8259.c to using syscore_ops (was: Re: Status of MIPS on 3.0.0-rc6 kernel)
Date:   Fri, 15 Jul 2011 23:53:37 +0200
User-Agent: KMail/1.13.6 (Linux/3.0.0-rc7+; KDE/4.6.0; x86_64; ; )
Cc:     "Roland Vossen" <rvossen@broadcom.com>,
        "Jonas Gorski" <jonas.gorski@gmail.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Linux PM mailing list <linux-pm@lists.linux-foundation.org>
References: <4E1ECE3B.10308@broadcom.com> <201107142151.24763.rjw@sisk.pl> <4E2032D7.9000704@broadcom.com>
In-Reply-To: <4E2032D7.9000704@broadcom.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201107152353.38004.rjw@sisk.pl>
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
X-archive-position: 30630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@sisk.pl
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11462

On Friday, July 15, 2011, Roland Vossen wrote:
> > Please check if the appended patch helps.
> 
> It does, I am able to build a big endian MIPS kernel now. Can you notify 
> me if you submit this patch ?

Well, it's been submitted already. :-)

Ralf, the appended patch is necessary to fix build on MIPS due to a
missing conversion to syscore_ops.  Please take it to your tree or
let me know if you want me to push it myself.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: MIPS: Convert i8259.c to using syscore_ops

The code in arch/mips/kernel/i8259.c still hasn't been converted to
using struct syscore_ops instead of a sysdev for resume and shutdown.
As a result, this code doesn't build any more after suspend, resume
and shutdown callbacks have been removed from struct sysdev_class.
Fix this problem by converting i8259.c to using syscore_ops.

Reported-and-tested-by: Roland Vossen <rvossen@broadcom.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/mips/kernel/i8259.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

Index: linux-2.6/arch/mips/kernel/i8259.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/i8259.c
+++ linux-2.6/arch/mips/kernel/i8259.c
@@ -14,7 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/irq.h>
 
 #include <asm/i8259.h>
@@ -215,14 +215,13 @@ spurious_8259A_irq:
 	}
 }
 
-static int i8259A_resume(struct sys_device *dev)
+static void i8259A_resume(void)
 {
 	if (i8259A_auto_eoi >= 0)
 		init_8259A(i8259A_auto_eoi);
-	return 0;
 }
 
-static int i8259A_shutdown(struct sys_device *dev)
+static void i8259A_shutdown(void)
 {
 	/* Put the i8259A into a quiescent state that
 	 * the kernel initialization code can get it
@@ -232,26 +231,17 @@ static int i8259A_shutdown(struct sys_de
 		outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
 		outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-1 */
 	}
-	return 0;
 }
 
-static struct sysdev_class i8259_sysdev_class = {
-	.name = "i8259",
+static struct syscore_ops i8259_syscore_ops = {
 	.resume = i8259A_resume,
 	.shutdown = i8259A_shutdown,
 };
 
-static struct sys_device device_i8259A = {
-	.id	= 0,
-	.cls	= &i8259_sysdev_class,
-};
-
 static int __init i8259A_init_sysfs(void)
 {
-	int error = sysdev_class_register(&i8259_sysdev_class);
-	if (!error)
-		error = sysdev_register(&device_i8259A);
-	return error;
+	register_syscore_ops(&i8259_syscore_ops);
+	return 0;
 }
 
 device_initcall(i8259A_init_sysfs);
 
