Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Apr 2011 23:57:28 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:60412 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491198Ab1DWV5X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Apr 2011 23:57:23 +0200
Received: by pwi8 with SMTP id 8so872149pwi.36
        for <multiple recipients>; Sat, 23 Apr 2011 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=KQqnBW5MpAvzVyAes1a/IXzomYv59NHyU2apFqBJvBI=;
        b=IhlmDgdQdtGlAfnxWWYN3OEY5PiSPzl0M42d87t1Djxh5ottiXE16R0wLnStry3cp8
         MQGdVGgZpcp3JYWJDdyQJ609aNxqwgEBbHPA3BLyapYvjZMo1Sd0Cnxj4TL9miC5XlUG
         wMx9hYp4i+AnuzkBpaharFDduYzfVT3M7Dg/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wVw2fDYmKMWLrfbZ9dUzDYPXAgKJyxTWYz0BSN2nYlcD8VbzwwW71S1dVeoobHypZN
         HExWULlC8e4xxNcgGsHv5sGvJbwwYwCBPQxv/Pjz0X+Dv3bnkaO/UpVeAEKjb5AYv1zl
         iws3woDEfbmSJZNGWOrBd5QsnITq7hI4Cl0Cc=
Received: by 10.68.2.1 with SMTP id 1mr4025742pbq.102.1303595833461;
        Sat, 23 Apr 2011 14:57:13 -0700 (PDT)
Received: from localhost.localdomain ([123.113.111.220])
        by mx.google.com with ESMTPS id i4sm2357428pbr.42.2011.04.23.14.57.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 14:57:12 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Hibernation: Fixes for PAGE_SIZE >= 64kb
Date:   Sun, 24 Apr 2011 05:56:59 +0800
Message-Id: <1303595819-19299-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

PAGE_SIZE >= 64kb (1 << 16) is too big to be the immediate of the
addiu/daddiu instruction, so, use addu/daddu instruction instead.

The following compiling error is fixed:

AS      arch/mips/power/hibernate.o
arch/mips/power/hibernate.S: Assembler messages:
arch/mips/power/hibernate.S:38: Error: expression out of range
make[2]: *** [arch/mips/power/hibernate.o] Error 1
make[1]: *** [arch/mips/power] Error 2

Reported-by: Roman Mamedov <rm@romanrm.ru>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/power/hibernate.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
index dbb5c7b..f8a751c 100644
--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate.S
@@ -35,7 +35,7 @@ LEAF(swsusp_arch_resume)
 0:
 	PTR_L t1, PBE_ADDRESS(t0)   /* source */
 	PTR_L t2, PBE_ORIG_ADDRESS(t0) /* destination */
-	PTR_ADDIU t3, t1, PAGE_SIZE
+	PTR_ADDU t3, t1, PAGE_SIZE
 1:
 	REG_L t8, (t1)
 	REG_S t8, (t2)
-- 
1.7.1
