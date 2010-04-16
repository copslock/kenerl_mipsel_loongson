Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Apr 2010 19:04:31 +0200 (CEST)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:36136 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492183Ab0DPRE2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Apr 2010 19:04:28 +0200
Received: by bwz26 with SMTP id 26so2890980bwz.27
        for <linux-mips@linux-mips.org>; Fri, 16 Apr 2010 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dr8TB6u6fIdLe3vQLBuuDw2g6rpcOfXRlc7Qta4vdlw=;
        b=Ytfx09RDlkY+/Jsg8+WopJJ39rT7S6/Dv1ctuZ6uykdi6R6fykWKDTp8mUD02rzhzW
         qNd3EipziTTcewR26FmkW2ChA1Cn/9/KcdZiXgVlxpiOmS0TOdhzrsbX7UyeN2gp+RGA
         4YEEg+xKc7G4PDjSj5Q+744wzQtEcgbQR34PU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wFoOoQyzPXrs9JZE3VTLp4UtKrUw3iEzfo5oNpTosmVFfYH/p0REJbXW73jyD5egMh
         x80V2PKnC0y1YvTFYwxX5bxii595nqloJq7Jltxbnm0HvuMpALqq7pnpDYtXEr6ZhIQc
         +O8JOU2rOopebdmVvV7hcqsvpM7SRV+0u/Qk8=
Received: by 10.204.146.148 with SMTP id h20mr1899972bkv.185.1271437462665;
        Fri, 16 Apr 2010 10:04:22 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 15sm1955345bwz.0.2010.04.16.10.04.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Apr 2010 10:04:21 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: db1200: PCMCIA carddetects must not be auto-enabled.
Date:   Fri, 16 Apr 2010 19:04:17 +0200
Message-Id: <1271437457-26716-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Same issues as SD carddetects:  One of both is always screaming,
and the handlers take care to shut one up and enable the other.
To avoid messages about "unbalanced interrupt enable/disable" they
must not be automatically enabled when initally requested.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
The error it fixes doesn't show with the defconfig but I believe this is
just because of fortunate timings.

Please apply to 2.6.34-rc if still possible!

 arch/mips/alchemy/devboards/db1200/setup.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200/setup.c b/arch/mips/alchemy/devboards/db1200/setup.c
index be7e92e..8876195 100644
--- a/arch/mips/alchemy/devboards/db1200/setup.c
+++ b/arch/mips/alchemy/devboards/db1200/setup.c
@@ -66,12 +66,16 @@ static int __init db1200_arch_init(void)
 	set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
 	bcsr_init_irq(DB1200_INT_BEGIN, DB1200_INT_END, AU1200_GPIO7_INT);
 
-	/* do not autoenable these: CPLD has broken edge int handling,
-	 * and the CD handler setup requires manual enabling to work
-	 * around that.
+	/* insert/eject pairs: one of both is always screaming.  To avoid
+	 * issues they must not be automatically enabled when initially
+	 * requested.
 	 */
 	irq_to_desc(DB1200_SD0_INSERT_INT)->status |= IRQ_NOAUTOEN;
 	irq_to_desc(DB1200_SD0_EJECT_INT)->status |= IRQ_NOAUTOEN;
+	irq_to_desc(DB1200_PC0_INSERT_INT)->status |= IRQ_NOAUTOEN;
+	irq_to_desc(DB1200_PC0_EJECT_INT)->status |= IRQ_NOAUTOEN;
+	irq_to_desc(DB1200_PC1_INSERT_INT)->status |= IRQ_NOAUTOEN;
+	irq_to_desc(DB1200_PC1_EJECT_INT)->status |= IRQ_NOAUTOEN;
 
 	return 0;
 }
-- 
1.7.0.4
