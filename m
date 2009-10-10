Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Oct 2009 17:27:03 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:54123 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492825AbZJJP04 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Oct 2009 17:26:56 +0200
Received: by pzk35 with SMTP id 35so2630159pzk.22
        for <multiple recipients>; Sat, 10 Oct 2009 08:26:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=slDZdfKOCimj0jr7n9lplAAJ5CROpHF4w1zS/vkHKMs=;
        b=mQ8A0QAifqpap9XCE4U9hS6w1+vyK3coO8YUSqJMA7dBaXUOhDyW3kTdvAYb54P0ML
         qRfTUEYdkdpU882ztm9/b0odRDYcGPjCaLH64viMxYwDgbyBFvA987rhsBBe8gEssl3+
         vqgdRbPlTVDHLloYiOyQqYQXVjRSWjKNDf98E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uN2lGMP2we1ZQor0FcBfinWH0x9fIGz7//eYN7g0Buqg5D7DGg02gtDApxpF5lAcmv
         6SSR/0RqTh4x+Cger9Ap0dgq0EyAchvNNujPE2wv2IGf9aMnOr5I2uvGFTpqJrzUjn6Q
         ltoC44Vbn2s/U0vm1wsA7iWELRd/dwPR00zGk=
Received: by 10.114.162.5 with SMTP id k5mr1864256wae.10.1255188407908;
        Sat, 10 Oct 2009 08:26:47 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm1428061pxi.12.2009.10.10.08.26.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 08:26:47 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue] MIPS: Add IRQF_TIMER flag for timer interrupts
Date:	Sat, 10 Oct 2009 23:26:35 +0800
Message-Id: <1255188395-6443-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

As the commit 3ee4c147 shows, we need to "Add IRQF_TIMER flag for timer
interrupts", Atsushi Nemoto have reported that some other timer
interrupts should be considered, Here it is.

(Hi, Ralf, if 3ee4c147 is not upstream yet, perhaps you can merge this
 in)

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/cevt-bcm1480.c     |    2 +-
 arch/mips/kernel/cevt-ds1287.c      |    2 +-
 arch/mips/kernel/cevt-sb1250.c      |    2 +-
 arch/mips/kernel/cevt-txx9.c        |    2 +-
 arch/mips/nxp/pnx8550/common/int.c  |    2 +-
 arch/mips/nxp/pnx8550/common/time.c |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/cevt-bcm1480.c b/arch/mips/kernel/cevt-bcm1480.c
index e02f79b..bfea327 100644
--- a/arch/mips/kernel/cevt-bcm1480.c
+++ b/arch/mips/kernel/cevt-bcm1480.c
@@ -144,7 +144,7 @@ void __cpuinit sb1480_clockevent_init(void)
 	bcm1480_unmask_irq(cpu, irq);
 
 	action->handler	= sibyte_counter_handler;
-	action->flags	= IRQF_DISABLED | IRQF_PERCPU;
+	action->flags	= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER;
 	action->name	= name;
 	action->dev_id	= cd;
 
diff --git a/arch/mips/kernel/cevt-ds1287.c b/arch/mips/kernel/cevt-ds1287.c
index 6996da4..00a4da2 100644
--- a/arch/mips/kernel/cevt-ds1287.c
+++ b/arch/mips/kernel/cevt-ds1287.c
@@ -107,7 +107,7 @@ static irqreturn_t ds1287_interrupt(int irq, void *dev_id)
 
 static struct irqaction ds1287_irqaction = {
 	.handler	= ds1287_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name		= "ds1287",
 };
 
diff --git a/arch/mips/kernel/cevt-sb1250.c b/arch/mips/kernel/cevt-sb1250.c
index ac5903d..da78eea 100644
--- a/arch/mips/kernel/cevt-sb1250.c
+++ b/arch/mips/kernel/cevt-sb1250.c
@@ -143,7 +143,7 @@ void __cpuinit sb1250_clockevent_init(void)
 	sb1250_unmask_irq(cpu, irq);
 
 	action->handler	= sibyte_counter_handler;
-	action->flags	= IRQF_DISABLED | IRQF_PERCPU;
+	action->flags	= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER;
 	action->name	= name;
 	action->dev_id	= cd;
 
diff --git a/arch/mips/kernel/cevt-txx9.c b/arch/mips/kernel/cevt-txx9.c
index 0037f21..218ee6b 100644
--- a/arch/mips/kernel/cevt-txx9.c
+++ b/arch/mips/kernel/cevt-txx9.c
@@ -146,7 +146,7 @@ static irqreturn_t txx9tmr_interrupt(int irq, void *dev_id)
 
 static struct irqaction txx9tmr_irq = {
 	.handler	= txx9tmr_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name		= "txx9tmr",
 	.dev_id		= &txx9_clock_event_device,
 };
diff --git a/arch/mips/nxp/pnx8550/common/int.c b/arch/mips/nxp/pnx8550/common/int.c
index f080f11..7aca7d5 100644
--- a/arch/mips/nxp/pnx8550/common/int.c
+++ b/arch/mips/nxp/pnx8550/common/int.c
@@ -172,7 +172,7 @@ static struct irqaction gic_action = {
 
 static struct irqaction timer_action = {
 	.handler =	no_action,
-	.flags =	IRQF_DISABLED,
+	.flags =	IRQF_DISABLED | IRQF_TIMER,
 	.name =		"Timer",
 };
 
diff --git a/arch/mips/nxp/pnx8550/common/time.c b/arch/mips/nxp/pnx8550/common/time.c
index d987a89..8836c62 100644
--- a/arch/mips/nxp/pnx8550/common/time.c
+++ b/arch/mips/nxp/pnx8550/common/time.c
@@ -72,7 +72,7 @@ static irqreturn_t monotonic_interrupt(int irq, void *dev_id)
 
 static struct irqaction monotonic_irqaction = {
 	.handler = monotonic_interrupt,
-	.flags = IRQF_DISABLED,
+	.flags = IRQF_DISABLED | IRQF_TIMER,
 	.name = "Monotonic timer",
 };
 
-- 
1.6.2.1
