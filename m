Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 22:16:02 +0200 (CEST)
Received: from mail-ea0-f180.google.com ([209.85.215.180]:58191 "EHLO
        mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825726Ab3FHUPv1npgc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 22:15:51 +0200
Received: by mail-ea0-f180.google.com with SMTP id k10so4519705eaj.11
        for <multiple recipients>; Sat, 08 Jun 2013 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=MllJeR3SJxmYl82U4rnBYJ4pm+vhfH3Rsam9Hc55m3o=;
        b=tRR3AOBvFxfa4RVt48uFfOI4WLy6piCEBKhO1lBmrebgjamP+VNsXEaYL2U4Dd1H4X
         wKd9W2cZ6mJALQfWZ3p616YmiQyzlhNDeXTzqapnppCu8hGzQK0JALyjlMMo+o2fTx4T
         3w4XxpxzoumsS5ZeuGYUNzJ5IHM2pc+HauNEuKFjGefwKb869YLaD1XNDRmqJd457w8d
         FNwHSUdUolNAK32soxlD1lTUYI5IEApbbPE8Y2iq4qhEtpOzV6nbRmAN5SO8MPScFDNl
         IWzkMDxymq/KS97CKt/ZEP+HsANo65nIg2iC4d+24o2qeG2UPgwdWj5p6BrV30eN9z4r
         MpHg==
X-Received: by 10.15.54.4 with SMTP id s4mr4308396eew.49.1370722545086;
        Sat, 08 Jun 2013 13:15:45 -0700 (PDT)
Received: from dargo.roarinelk.net (62-47-61-241.adsl.highway.telekom.at. [62.47.61.241])
        by mx.google.com with ESMTPSA id y2sm9247655eeu.2.2013.06.08.13.15.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 13:15:44 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v3] MIPS: Alchemy: fix wait function
Date:   Sat,  8 Jun 2013 22:15:41 +0200
Message-Id: <1370722541-25407-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.2.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Only an interrupt can wake the core from 'wait', enable interrupts
locally before executing 'wait'.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v3: add constraint for additional register used, as per Maciej's feedback
v2: enable interrupts immediately before executing 'wait', to minimize chance
    of interrupts occurring.


 arch/mips/kernel/idle.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 3b09b88..0c655de 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -93,26 +93,27 @@ static void rm7k_wait_irqoff(void)
 }
 
 /*
- * The Au1xxx wait is available only if using 32khz counter or
- * external timer source, but specifically not CP0 Counter.
- * alchemy/common/time.c may override cpu_wait!
+ * Au1 'wait' is only useful when the 32kHz counter is used as timer,
+ * since coreclock (and the cp0 counter) stops upon executing it. Only an
+ * interrupt can wake it, so they must be enabled before entering idle modes.
  */
 static void au1k_wait(void)
 {
+	unsigned long c0status = read_c0_status() | 1;	/* irqs on */
+
 	__asm__(
 	"	.set	mips3			\n"
 	"	cache	0x14, 0(%0)		\n"
 	"	cache	0x14, 32(%0)		\n"
 	"	sync				\n"
-	"	nop				\n"
+	"	mtc0	%1, $12			\n" /* wr c0status */
 	"	wait				\n"
 	"	nop				\n"
 	"	nop				\n"
 	"	nop				\n"
 	"	nop				\n"
 	"	.set	mips0			\n"
-	: : "r" (au1k_wait));
-	local_irq_enable();
+	: : "r" (au1k_wait), "r" (c0status));
 }
 
 static int __initdata nowait;
-- 
1.8.2.1
