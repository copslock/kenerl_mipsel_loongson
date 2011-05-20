Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2011 15:41:58 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:60033 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491107Ab1ETNlx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 May 2011 15:41:53 +0200
Received: by pzk28 with SMTP id 28so1948721pzk.36
        for <multiple recipients>; Fri, 20 May 2011 06:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=e3zeDb7QFkdbAUieqebnMt7J0hbCaOlpJJbssPu0kQ0=;
        b=hN/86PD0SU4ZvMI3jiECl34uawneOjqCZlEBPSI/8WThcLA6BFCsG2gr8jyIhzE4Ao
         44ujI3R6wpGGE+52K2ztXXjsUgP6YVkY+NfrDIdcZsJSzWJ3Z3/i3tJxWZFXTjnHTYuh
         9x813Sc0+6hPjOVIAQaouuX9S1iFw23B8Ch4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Av/8skCfECFp/ID2xTPV1KYQzV7sTRsPz7fknJcDz9cYBSL+kK0FWGHDPmrndr5TOb
         7KZAgMnBgP1XSEq8UFi1HJYJ2Nsqevcv4zXjGVCqb5tLuB+jIvRPYBjGnzBI6wofYT2P
         ForjrxCtuVOmKLaqQc5P95yivicSfNO3awDyM=
Received: by 10.68.52.129 with SMTP id t1mr6566011pbo.525.1305898905893;
        Fri, 20 May 2011 06:41:45 -0700 (PDT)
Received: from stratos (sannin29007.nirai.ne.jp [203.160.29.7])
        by mx.google.com with ESMTPS id h7sm2459103pbl.94.2011.05.20.06.41.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 May 2011 06:41:44 -0700 (PDT)
Date:   Fri, 20 May 2011 22:41:41 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Use struct syscore_ops instead of sysdevs for i8259
Message-Id: <20110520224141.5eb118ff.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yyuasa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/kernel/i8259.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index c018696..5c74eb7 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
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
@@ -232,26 +231,17 @@ static int i8259A_shutdown(struct sys_device *dev)
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
-- 
1.7.3.4
