Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Apr 2010 17:07:09 +0200 (CEST)
Received: from mail-bw0-f219.google.com ([209.85.218.219]:65078 "EHLO
        mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492248Ab0DCPHD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Apr 2010 17:07:03 +0200
Received: by bwz19 with SMTP id 19so379803bwz.24
        for <multiple recipients>; Sat, 03 Apr 2010 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=LGPA32gkF6u7Ruil7jjWVOgNA6YA0IyP3Iybl3PGrFk=;
        b=PuW4LrpfZpwrGc61P2pPvgkGAAo6lAJnuTQSU7t3kEGtpXRQjUVqOxgrMgLF6gAx9D
         thJLCzxk9r0XbucVHcw9E0u8qciFo+ci+ogH+mRx7V3GXor644ViAGYvr3g+7yHZlzgz
         z+obs4J2CJyn+ARrLhP9Au1uvqtrNs8dtvXqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZSEv+hrKYXBNJ7JlwfRlcO9gQQ6XoEGNq3x/rkI92oIcguldxh00VHKZgxSAFHvGgY
         D18c3SLlxL2gvxwokDYj+uON8lsApZbf8XvVMSIWvckSKlaf8Kzaai6ZjMnT3rk1eXUX
         RImax9VgqkBQHXuxGVn//zCRTNgONnC/8BQOg=
Received: by 10.204.132.214 with SMTP id c22mr4566294bkt.60.1270307216168;
        Sat, 03 Apr 2010 08:06:56 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 14sm4961538bwz.6.2010.04.03.08.06.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 Apr 2010 08:06:55 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: db1200: remove custom wait implementation
Date:   Sat,  3 Apr 2010 17:07:03 +0200
Message-Id: <1270307223-3825-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

While playing with the out-of-tree MAE driver module, the system
would panic after a while in the db1200 custom wait code after
wakeup due to a clobbered k0 register being used as target address
of a store op.

Remove the custom wait implementation and revert back to the
Alchemy-recommended implementation already set as default.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
I've played a few hours worth of video from a SD card now without
a hitch; usually the panic would occur after ~10 minutes.

Please add this to the 2.6.34 queue, Thanks!

 arch/mips/alchemy/devboards/db1200/setup.c |   40 ----------------------------
 1 files changed, 0 insertions(+), 40 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200/setup.c b/arch/mips/alchemy/devboards/db1200/setup.c
index 379536e..be7e92e 100644
--- a/arch/mips/alchemy/devboards/db1200/setup.c
+++ b/arch/mips/alchemy/devboards/db1200/setup.c
@@ -60,43 +60,6 @@ void __init board_setup(void)
 	wmb();
 }
 
-/* use the hexleds to count the number of times the cpu has entered
- * wait, the dots to indicate whether the CPU is currently idle or
- * active (dots off = sleeping, dots on = working) for cases where
- * the number doesn't change for a long(er) period of time.
- */
-static void db1200_wait(void)
-{
-	__asm__("	.set	push			\n"
-		"	.set	mips3			\n"
-		"	.set	noreorder		\n"
-		"	cache	0x14, 0(%0)		\n"
-		"	cache	0x14, 32(%0)		\n"
-		"	cache	0x14, 64(%0)		\n"
-		/* dots off: we're about to call wait */
-		"	lui	$26, 0xb980		\n"
-		"	ori	$27, $0, 3		\n"
-		"	sb	$27, 0x18($26)		\n"
-		"	sync				\n"
-		"	nop				\n"
-		"	wait				\n"
-		"	nop				\n"
-		"	nop				\n"
-		"	nop				\n"
-		"	nop				\n"
-		"	nop				\n"
-		/* dots on: there's work to do, increment cntr */
-		"	lui	$26, 0xb980		\n"
-		"	sb	$0, 0x18($26)		\n"
-		"	lui	$26, 0xb9c0		\n"
-		"	lb	$27, 0($26)		\n"
-		"	addiu	$27, $27, 1		\n"
-		"	sb	$27, 0($26)		\n"
-		"	sync				\n"
-		"	.set	pop			\n"
-		: : "r" (db1200_wait));
-}
-
 static int __init db1200_arch_init(void)
 {
 	/* GPIO7 is low-level triggered CPLD cascade */
@@ -110,9 +73,6 @@ static int __init db1200_arch_init(void)
 	irq_to_desc(DB1200_SD0_INSERT_INT)->status |= IRQ_NOAUTOEN;
 	irq_to_desc(DB1200_SD0_EJECT_INT)->status |= IRQ_NOAUTOEN;
 
-	if (cpu_wait)
-		cpu_wait = db1200_wait;
-
 	return 0;
 }
 arch_initcall(db1200_arch_init);
-- 
1.7.0.4
