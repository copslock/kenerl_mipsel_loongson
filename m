Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jul 2010 03:23:11 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:49317 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492620Ab0GXBWf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jul 2010 03:22:35 +0200
Received: by pzk3 with SMTP id 3so361690pzk.36
        for <multiple recipients>; Fri, 23 Jul 2010 18:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=aDJmgQECmx2bOvvfpaORKJjjc/7X+AH/IAHONJxuiW8=;
        b=X/aXk+DKgle6XpH0Ln6G7CMRYz3SSOxvnwUmjQSmQIHNVYco5/fVz+O5HJxslQN106
         byp8xVVgKTMtlesSn1jNh7IqTKZiXRbtkDg+d48n+JwjHS7UoxiXzEySeHaARd9ZGjYf
         zBkddzTxdxV+Jxh+OF1nJb6J23wgBLtwR3044=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PmyJcvYS3pC2k7ilW4Hte7Fqz81sY9gM/hoRULsRg4EmVrDrhYyuZH6+yeRDieRXRg
         qIPX4mekCcxArcKpOTIM8mQz8dnyy6sTow5CHYanROxhTicoU8dGeDagFpy3fxbE1zdw
         h1skaAWcAl5hpwrr3m3+haVfpBn6ELx3DO6rE=
Received: by 10.142.156.14 with SMTP id d14mr5072623wfe.248.1279934545844;
        Fri, 23 Jul 2010 18:22:25 -0700 (PDT)
Received: from localhost.localdomain ([182.18.29.11])
        by mx.google.com with ESMTPS id f2sm936892wfp.11.2010.07.23.18.22.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 18:22:24 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 1/3] MIPS: Loongson: Remove set_irq_trigger_mode()
Date:   Sat, 24 Jul 2010 09:22:13 +0800
Message-Id: <881c93ee3de32e7809f5ac05d0086bc525af57a9.1279934355.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1279934355.git.wuzhangjin@gmail.com>
References: <cover.1279934355.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

set_irq_trigger_mode() is not needed by all of the platforms, remove it
and put the related source code into mach_init_irq().

This will let gdium share the common irq.c without adding an empty
set_irq_trigger_mode().

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    1 -
 arch/mips/loongson/common/irq.c                |    3 ---
 arch/mips/loongson/fuloong-2e/irq.c            |   11 ++++-------
 arch/mips/loongson/lemote-2f/irq.c             |   11 ++++-------
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 8b10cfc..ef81d9c 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -51,7 +51,6 @@ extern char loongson_cmdline[COMMAND_LINE_SIZE];
 /* irq operation functions */
 extern void bonito_irqdispatch(void);
 extern void __init bonito_irq_init(void);
-extern void __init set_irq_trigger_mode(void);
 extern void __init mach_init_irq(void);
 extern void mach_irq_dispatch(unsigned int pending);
 extern int mach_i8259_irq(void);
diff --git a/arch/mips/loongson/common/irq.c b/arch/mips/loongson/common/irq.c
index 20e7328..987feeb 100644
--- a/arch/mips/loongson/common/irq.c
+++ b/arch/mips/loongson/common/irq.c
@@ -56,9 +56,6 @@ void __init arch_init_irq(void)
 	 */
 	clear_c0_status(ST0_IM | ST0_BEV);
 
-	/* setting irq trigger mode */
-	set_irq_trigger_mode();
-
 	/* no steer */
 	LOONGSON_INTSTEER = 0;
 
diff --git a/arch/mips/loongson/fuloong-2e/irq.c b/arch/mips/loongson/fuloong-2e/irq.c
index 320e937..99e08c3 100644
--- a/arch/mips/loongson/fuloong-2e/irq.c
+++ b/arch/mips/loongson/fuloong-2e/irq.c
@@ -44,13 +44,6 @@ static struct irqaction cascade_irqaction = {
 	.name = "cascade",
 };
 
-void __init set_irq_trigger_mode(void)
-{
-	/* most bonito irq should be level triggered */
-	LOONGSON_INTEDGE = LOONGSON_ICU_SYSTEMERR | LOONGSON_ICU_MASTERERR |
-	    LOONGSON_ICU_RETRYERR | LOONGSON_ICU_MBOXES;
-}
-
 void __init mach_init_irq(void)
 {
 	/* init all controller
@@ -59,6 +52,10 @@ void __init mach_init_irq(void)
 	 *   32-63        ------> bonito irq
 	 */
 
+	/* most bonito irq should be level triggered */
+	LOONGSON_INTEDGE = LOONGSON_ICU_SYSTEMERR | LOONGSON_ICU_MASTERERR |
+	    LOONGSON_ICU_RETRYERR | LOONGSON_ICU_MBOXES;
+
 	/* Sets the first-level interrupt dispatcher. */
 	mips_cpu_irq_init();
 	init_i8259_irqs();
diff --git a/arch/mips/loongson/lemote-2f/irq.c b/arch/mips/loongson/lemote-2f/irq.c
index 1d8b4d2..c6db7e7 100644
--- a/arch/mips/loongson/lemote-2f/irq.c
+++ b/arch/mips/loongson/lemote-2f/irq.c
@@ -91,13 +91,6 @@ void mach_irq_dispatch(unsigned int pending)
 		spurious_interrupt();
 }
 
-void __init set_irq_trigger_mode(void)
-{
-	/* setup cs5536 as high level trigger */
-	LOONGSON_INTPOL = LOONGSON_INT_BIT_INT0 | LOONGSON_INT_BIT_INT1;
-	LOONGSON_INTEDGE &= ~(LOONGSON_INT_BIT_INT0 | LOONGSON_INT_BIT_INT1);
-}
-
 static irqreturn_t ip6_action(int cpl, void *dev_id)
 {
 	return IRQ_HANDLED;
@@ -122,6 +115,10 @@ void __init mach_init_irq(void)
 	 *   32-63        ------> bonito irq
 	 */
 
+	/* setup cs5536 as high level trigger */
+	LOONGSON_INTPOL = LOONGSON_INT_BIT_INT0 | LOONGSON_INT_BIT_INT1;
+	LOONGSON_INTEDGE &= ~(LOONGSON_INT_BIT_INT0 | LOONGSON_INT_BIT_INT1);
+
 	/* Sets the first-level interrupt dispatcher. */
 	mips_cpu_irq_init();
 	init_i8259_irqs();
-- 
1.7.0.4
