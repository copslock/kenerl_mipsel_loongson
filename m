Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Oct 2010 23:48:44 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:51626 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491161Ab0JaWsO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Oct 2010 23:48:14 +0100
Received: by wyf22 with SMTP id 22so4973737wyf.36
        for <multiple recipients>; Sun, 31 Oct 2010 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=XS2Brw6MkX3Btg7uwyUxcGKpTcw9PIxDN2NK/D9nIYs=;
        b=qUue5O1Mm5ndvzkHF9zXd8feElYzVC+GEHmD2w9yuwm+A3Ub6QjP5ofhh9vySInC72
         2fQTxA3E2KvEm53ryEh1OH8gzUi5PtgSdSjaqvwuQ9ZztUtZ6/D0F14QeBUKOSJ5NBp3
         yF2IGPOrA85gBRcnnZsedo09EbPih4sgWq6jU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=uvQ8eyWZzGzNJslhfPetoQRR0kzQfQfOmMr6STkEcn7Qq5M3VRvCdnuHxwzS2FBk3a
         kVyQeEyJ56HYPZvz1KUue7yyBz1CLCTPgRfdh2yyE9Z6sanf09fyOzaH6r0Qp88E/4pr
         hjr3DEX3Z8E4HkwJAiwlVA3QC2rx7qA0JZ0oY=
Received: by 10.216.176.8 with SMTP id a8mr1806555wem.93.1288565289069;
        Sun, 31 Oct 2010 15:48:09 -0700 (PDT)
Received: from localhost.localdomain (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id x59sm3405068weq.38.2010.10.31.15.48.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 15:48:06 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/2] AR7: fix loops per jiffies on TNETD7200 devices
Date:   Sun, 31 Oct 2010 23:49:58 +0100
Message-Id: <1288565398-30300-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1288565398-30300-1-git-send-email-florian@openwrt.org>
References: <1288565398-30300-1-git-send-email-florian@openwrt.org>
Return-Path: <>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

From: Florian Fainelli <florian@openwrt.org>

TNETD7200 run their CPU clock faster than the default CPU clock we assume.
In order to have the correct loops per jiffies settings, initialize clocks right
before setting mips_hpt_frequency. As a side effect, we can no longer use
msleep in clocks.c which requires other parts of the kernel to be initialized,
so replace these with mdelay.

Signed-off-by: Florian Fainelli <florian@openwrt.org>

diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
index fc0e715..2ca4ada 100644
--- a/arch/mips/ar7/clock.c
+++ b/arch/mips/ar7/clock.c
@@ -239,12 +239,12 @@ static void tnetd7300_set_clock(u32 shift, struct tnetd7300_clock *clock,
 	calculate(base_clock, frequency, &prediv, &postdiv, &mul);
 
 	writel(((prediv - 1) << PREDIV_SHIFT) | (postdiv - 1), &clock->ctrl);
-	msleep(1);
+	mdelay(1);
 	writel(4, &clock->pll);
 	while (readl(&clock->pll) & PLL_STATUS)
 		;
 	writel(((mul - 1) << MUL_SHIFT) | (0xff << 3) | 0x0e, &clock->pll);
-	msleep(75);
+	mdelay(75);
 }
 
 static void __init tnetd7300_init_clocks(void)
@@ -456,7 +456,7 @@ void clk_put(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_put);
 
-int __init ar7_init_clocks(void)
+void __init ar7_init_clocks(void)
 {
 	switch (ar7_chip_id()) {
 	case AR7_CHIP_7100:
@@ -472,7 +472,4 @@ int __init ar7_init_clocks(void)
 	}
 	/* adjust vbus clock rate */
 	vbus_clk.rate = bus_clk.rate / 2;
-
-	return 0;
 }
-arch_initcall(ar7_init_clocks);
diff --git a/arch/mips/ar7/time.c b/arch/mips/ar7/time.c
index 5fb8a01..22c9321 100644
--- a/arch/mips/ar7/time.c
+++ b/arch/mips/ar7/time.c
@@ -30,6 +30,9 @@ void __init plat_time_init(void)
 {
 	struct clk *cpu_clk;
 
+	/* Initialize ar7 clocks so the CPU clock frequency is correct */
+	ar7_init_clocks();
+
 	cpu_clk = clk_get(NULL, "cpu");
 	if (IS_ERR(cpu_clk)) {
 		printk(KERN_ERR "unable to get cpu clock\n");
diff --git a/arch/mips/include/asm/mach-ar7/ar7.h b/arch/mips/include/asm/mach-ar7/ar7.h
index 31c7ff5..07d3fad 100644
--- a/arch/mips/include/asm/mach-ar7/ar7.h
+++ b/arch/mips/include/asm/mach-ar7/ar7.h
@@ -201,5 +201,6 @@ static inline void ar7_device_off(u32 bit)
 }
 
 int __init ar7_gpio_init(void);
+void __init ar7_init_clocks(void);
 
 #endif /* __AR7_H__ */
-- 
1.7.2.3
