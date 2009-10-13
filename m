Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 20:26:44 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:50679 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493409AbZJMS0h (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 20:26:37 +0200
Received: by ewy12 with SMTP id 12so2849363ewy.0
        for <multiple recipients>; Tue, 13 Oct 2009 11:26:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=0wl621iMbzVSsaVED6i9HqaMeIKQVCsvj0QQOMb4Wa0=;
        b=H0ieA5rPcGwy0NeaEfclVda4I3DI/ctCzweQXgJsLjh1AcgzuxeqKg/26cA2LRBD62
         tdTsvdEOeeSKSciJLpczA0nzrLHF9fy/R6o0JijqI2t1uYvKB8Wfg/0EtQwBvKjul/vJ
         UAwRNzgvYPqhqx98DEq/UCvh/ctyjxbJ/Hxwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TaTVwcLYbeG010ZkaFlIPh5TL/2jW6haHUSy7uEQRhJ3YyDArlxlLYWq7NNFaXCdix
         YsFEunY7Pr6btXIG6Bt80ZXUbmydm8meVobrpbbGRMcM2qagQbOhdiI2Cwbpbl8cH/m+
         rm7Ymx62ER7JIYMHdK2ZCmPm0E8lJZKaH8eDc=
Received: by 10.216.85.65 with SMTP id t43mr2477509wee.92.1255458391916;
        Tue, 13 Oct 2009 11:26:31 -0700 (PDT)
Received: from localhost.localdomain (p5496C133.dip.t-dialin.net [84.150.193.51])
        by mx.google.com with ESMTPS id t12sm3372946gvd.22.2009.10.13.11.26.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 11:26:30 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: reduce size of irq dispatcher
Date:	Tue, 13 Oct 2009 20:26:31 +0200
Message-Id: <1255458391-14544-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

By replacing an extra do_IRQ with a goto, the assembly shrinks
from 260 to 212 bytes (gcc-4.3.4).

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 Applies on top of the irq changes in -queue.

 arch/mips/alchemy/common/irq.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index ab65997..b2a1e4e 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -501,8 +501,8 @@ asmlinkage void plat_irq_dispatch(void)
 	unsigned long s, off;
 
 	if (pending & CAUSEF_IP7) {
-		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
-		return;
+		off = MIPS_CPU_IRQ_BASE + 7;
+		goto handle;
 	} else if (pending & CAUSEF_IP2) {
 		s = IC0_REQ0INT;
 		off = AU1000_INTC0_INT_BASE;
@@ -524,7 +524,9 @@ spurious:
 		spurious_interrupt();
 		return;
 	}
-	do_IRQ(__ffs(s) + off);
+	off += __ffs(s);
+handle:
+	do_IRQ(off);
 }
 
 /* setup edge/level and assign request 0/1 */
-- 
1.6.5.rc2
