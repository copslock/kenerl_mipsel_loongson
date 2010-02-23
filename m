Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 18:57:00 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:41941 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491978Ab0BWR4y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2010 18:56:54 +0100
Received: by bwz7 with SMTP id 7so2739603bwz.24
        for <linux-mips@linux-mips.org>; Tue, 23 Feb 2010 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bFsm9mbrKoMa4lXpF7K0Ny52QiZonU8UxyN0wPnUe2o=;
        b=Bx/1myWzGp++odHmC92rVHkYBmKZguc2QcX41Vga7VGYyLfiEvRGPdVkHYlzxHxBJM
         BaOurU/k8eY5Ypx2wS/+sFQxNZ+1K84l5CtIINf2g436r8CsmbqjGsREFlYhcLl/+yKd
         Rw9zKtft9k/bIiPKMtoICC2mqXoPMcqMiOZYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DRk8fLx8KErJ1rCSuvZV20N3inE5zSMagifcqq4a01UzTb3FjFcf2OXfglEoWubzFn
         gksLuh6HN0Z8pqDyifz+Bm3nXDqL9AuVHpeP/yQYXkfUHCsRDtfAEYPhDvMSkKh/2d5W
         MK3My81+X67s7fYGfKHtMIyjqD9R+vFh+UBRI=
Received: by 10.204.32.198 with SMTP id e6mr1080159bkd.169.1266947807170;
        Tue, 23 Feb 2010 09:56:47 -0800 (PST)
Received: from localhost.localdomain (p5496C184.dip.t-dialin.net [84.150.193.132])
        by mx.google.com with ESMTPS id 15sm2025108bwz.12.2010.02.23.09.56.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 09:56:46 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH -queue] MIPS: Alchemy: devboard PM needs to save CPLD registers.
Date:   Tue, 23 Feb 2010 18:57:43 +0100
Message-Id: <1266947863-11738-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Save/restore CPLD registers when doing suspend-to-ram:  fixes
issues with harddisk and ethernet not working correctly when
resuming on DB1200.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/pm.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/devboards/pm.c b/arch/mips/alchemy/devboards/pm.c
index 632f986..4bbd313 100644
--- a/arch/mips/alchemy/devboards/pm.c
+++ b/arch/mips/alchemy/devboards/pm.c
@@ -10,6 +10,7 @@
 #include <linux/sysfs.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/gpio.h>
+#include <asm/mach-db1x00/bcsr.h>
 
 /*
  * Generic suspend userspace interface for Alchemy development boards.
@@ -26,6 +27,20 @@ static unsigned long db1x_pm_last_wakesrc;
 
 static int db1x_pm_enter(suspend_state_t state)
 {
+	unsigned short bcsrs[16];
+	int i, j, hasint;
+
+	/* save CPLD regs */
+	hasint = bcsr_read(BCSR_WHOAMI);
+	hasint = BCSR_WHOAMI_BOARD(hasint) >= BCSR_WHOAMI_DB1200;
+	j = (hasint) ? BCSR_MASKSET : BCSR_SYSTEM;
+
+	for (i = BCSR_STATUS; i <= j; i++)
+		bcsrs[i] = bcsr_read(i);
+
+	/* shut off hexleds */
+	bcsr_write(BCSR_HEXCLEAR, 3);
+
 	/* enable GPIO based wakeup */
 	alchemy_gpio1_input_enable();
 
@@ -52,6 +67,23 @@ static int db1x_pm_enter(suspend_state_t state)
 	/* ...and now the sandman can come! */
 	au_sleep();
 
+
+	/* restore CPLD regs */
+	for (i = BCSR_STATUS; i <= BCSR_SYSTEM; i++)
+		bcsr_write(i, bcsrs[i]);
+
+	/* restore CPLD int registers */
+	if (hasint) {
+		bcsr_write(BCSR_INTCLR, 0xffff);
+		bcsr_write(BCSR_MASKCLR, 0xffff);
+		bcsr_write(BCSR_INTSTAT, 0xffff);
+		bcsr_write(BCSR_INTSET, bcsrs[BCSR_INTSET]);
+		bcsr_write(BCSR_MASKSET, bcsrs[BCSR_MASKSET]);
+	}
+
+	/* light up hexleds */
+	bcsr_write(BCSR_HEXCLEAR, 0);
+
 	return 0;
 }
 
-- 
1.7.0
