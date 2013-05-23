Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 15:28:54 +0200 (CEST)
Received: from mail-we0-f170.google.com ([74.125.82.170]:61700 "EHLO
        mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827461Ab3EWN2s1Hdtj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 15:28:48 +0200
Received: by mail-we0-f170.google.com with SMTP id u59so1464455wes.15
        for <multiple recipients>; Thu, 23 May 2013 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=I4kCzT+ZNhM4RaxzbZTyb8QS6SKbwZye4fOqQ+iuEmE=;
        b=ICTfK77Ox2G6hTtZN453CNgZj6AB+mqQZKJSMjlfH5g7E/SsBA8+89D/jDfUu/9SaY
         j8ITd89vvKUBLlpYIgTpF4FYLO3z2HBEzhCtfP3a3cdUvSLoKgwwDLxMba4X5rfgaoWg
         D8CAUwo3c1ItjrBsRc8HfR/627jpkiQtPz45LegcMq9d5Ajndwg5Ws4Vvj6xD/vzvW8/
         rW9/rGQvJ1CaGppTSej9QfoFLerpRLci/3vwsjGLh9NJB9NteqNLuwmJmOyGJtAM1HV7
         ukhIrwVaJkFQRgLyzJbDRev6O346nyfSbiNhVX8aUTjoZ4sgD6kZfN3hh/JgD92RSosw
         /3MQ==
X-Received: by 10.180.189.41 with SMTP id gf9mr24495041wic.32.1369315723050;
        Thu, 23 May 2013 06:28:43 -0700 (PDT)
Received: from flagship.roarinelk.net (62-47-62-116.adsl.highway.telekom.at. [62.47.62.116])
        by mx.google.com with ESMTPSA id ff10sm17642106wib.10.2013.05.23.06.28.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 06:28:42 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2] MIPS: Alchemy: fix wait function
Date:   Thu, 23 May 2013 15:28:36 +0200
Message-Id: <1369315716-7408-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.2.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36552
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
Ralf made me aware of the race in between enabling interrupts and
entering wait.  While this patch does not eliminate it, it shrinks it
to 1 instruction.  It's not perfect, but lets Alchemy boot until a
more sophisticated solution (like __r4k_wait) can be implemented
without having to duplicate the interrupt exception handler.

 arch/mips/kernel/idle.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 3b09b88..1d37b4b 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -93,9 +93,9 @@ static void rm7k_wait_irqoff(void)
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
@@ -103,8 +103,10 @@ static void au1k_wait(void)
 	"	.set	mips3			\n"
 	"	cache	0x14, 0(%0)		\n"
 	"	cache	0x14, 32(%0)		\n"
+	"	mfc0	$8, $12			\n"
+	"	ori	$8, $8, 1		\n"
 	"	sync				\n"
-	"	nop				\n"
+	"	mtc0	$8, $12			\n"	/* enable irqs */
 	"	wait				\n"
 	"	nop				\n"
 	"	nop				\n"
@@ -112,7 +114,6 @@ static void au1k_wait(void)
 	"	nop				\n"
 	"	.set	mips0			\n"
 	: : "r" (au1k_wait));
-	local_irq_enable();
 }
 
 static int __initdata nowait;
-- 
1.8.2.1
