Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 14:20:11 +0200 (CEST)
Received: from mail-px0-f182.google.com ([209.85.212.182]:45642 "EHLO
        mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491012Ab1EXMUH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2011 14:20:07 +0200
Received: by pxi20 with SMTP id 20so4513278pxi.27
        for <multiple recipients>; Tue, 24 May 2011 05:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=wBSEePNwtVpXoPKZRv4gPUOmVzTPsuKSDfibObidilg=;
        b=Ku9KUpvxv+AbWU6CSgQoUkQ/3fe7i/WuyAb3r1UmkCbfBHv/mNQwm5HLEnytkkJxeu
         hOq2aRd/xkhcpGX5RDUFeEA4TvTAcgI7UeNeZEwAgV0lLNOZBNvzAvLN8WLtfR5VthUM
         zn01y+0pBJUYN1Ba1nAk+SHZ2VuD10MU3eXRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pB2e3uModwfXet52A9tBMbrEOJ7q797l0WdstL3hOUc812xjXPDJYpC0be3aiEz0m5
         /Ro32oOAvuN0a5+2xAaVXYTrrExq7jfeNO3RYphyo3QSZ+T2P+3GGjraQbi/BOXrAljn
         ar5+cXDI6iwLcl2hTD/DxkcM0I/dHFSJwnG2Y=
Received: by 10.68.31.166 with SMTP id b6mr2766111pbi.198.1306239600133;
        Tue, 24 May 2011 05:20:00 -0700 (PDT)
Received: from localhost.localdomain ([182.32.187.185])
        by mx.google.com with ESMTPS id s1sm4977335pbq.54.2011.05.24.05.19.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2011 05:19:59 -0700 (PDT)
From:   Pengfei Zhang <zoppof.zhang@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Pengfei Zhang <zoppof.zhang@gmail.com>
Subject: [PATCH] MIPS:i8259.c remove resume and shutdown to syscore_ops
Date:   Tue, 24 May 2011 20:19:18 +0800
Message-Id: <1306239558-4997-1-git-send-email-zoppof.zhang@gmail.com>
X-Mailer: git-send-email 1.7.4.1
Return-Path: <zoppof.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zoppof.zhang@gmail.com
Precedence: bulk
X-list: linux-mips

Remove the resume and shutdown of i8259A from the sysdev_class
to the syscore_ops since these members had removed from the
structure sysdev_class.

Signed-off-by: Pengfei Zhang <zoppof.zhang@gmail.com>
---
 arch/mips/kernel/i8259.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index c018696..a74a8ea 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/sysdev.h>
 #include <linux/irq.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/i8259.h>
 #include <asm/io.h>
@@ -215,14 +216,13 @@ spurious_8259A_irq:
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
@@ -232,15 +232,17 @@ static int i8259A_shutdown(struct sys_device *dev)
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
 
+static struct sysdev_class i8259_sysdev_class = {
+	.name = "i8259",
+};
+
 static struct sys_device device_i8259A = {
 	.id	= 0,
 	.cls	= &i8259_sysdev_class,
@@ -248,7 +250,11 @@ static struct sys_device device_i8259A = {
 
 static int __init i8259A_init_sysfs(void)
 {
-	int error = sysdev_class_register(&i8259_sysdev_class);
+	int error;
+
+	register_syscore_ops(&i8259_syscore_ops);
+
+	error = sysdev_class_register(&i8259_sysdev_class);
 	if (!error)
 		error = sysdev_register(&device_i8259A);
 	return error;
-- 
1.7.4.1
