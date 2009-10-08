Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 15:18:14 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.146]:23579 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493120AbZJHNSH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 15:18:07 +0200
Received: by ey-out-1920.google.com with SMTP id 13so1105689eye.52
        for <multiple recipients>; Thu, 08 Oct 2009 06:18:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=iAzcz2iDKpmSNUk4NX0P5zMIL8r+FEG+Fr/217g9RZg=;
        b=NKUQ8fKTYSmfwfH89lACjxMs2v1TsQDX1Rqnq+dt+z0aSGUITw9UxntRNpPuOWwoRY
         qiMgovS0iwwXPjIfSy4SnprZPL9+JANUC/RclKRzqiv2+o7DZV/Q0mMURx6j1PX40Nlo
         pCqAhT9UUvrRIdxAwrt0ToP+MSWtYSo9W7y4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=s5ZpN/SY2yE2Z5SC9bSxMQmpox6QmT0B0UQ1U7u5TbbFs9qiwCL+TO/+jrPQIa+Y3A
         3UOBJJhZpvHnJH/H+HM/4NEPdmHxPtIIS5WkCJSEMl2o14F3yZuHrJnIyzifmhbzEqeX
         HlqEIR8vPBkaKcphiNDPF56i1iQ12U0Zp9l/Y=
Received: by 10.216.87.143 with SMTP id y15mr389057wee.39.1255007885703;
        Thu, 08 Oct 2009 06:18:05 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id p37sm1721824gvf.24.2009.10.08.06.18.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 06:18:04 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org,
	pm list <linux-pm@lists.linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc:	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Yoichi Yuasa <yuasa@linux-mips.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: add IRQF_TIMER flag for Timer Interrupts
Date:	Thu,  8 Oct 2009 21:17:54 +0800
Message-Id: <1255007874-19574-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch add IRQF_TIMER flag for all Timer interrupts in linux-MIPS,
which will help to not disable the Timer IRQ when suspending to ensure
resuming normally(d6c585a4342a2ff627a29f9aea77c5ed4cd76023) and not
thread them when enabled PREEMPT_RT.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/jazz/irq.c                |    2 +-
 arch/mips/kernel/cevt-gt641xx.c     |    2 +-
 arch/mips/kernel/cevt-r4k.c         |    2 +-
 arch/mips/kernel/i8253.c            |    2 +-
 arch/mips/nxp/pnx8550/common/time.c |    2 +-
 arch/mips/sgi-ip27/ip27-timer.c     |    2 +-
 arch/mips/sni/time.c                |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
index 7fd170d..7bd32d0 100644
--- a/arch/mips/jazz/irq.c
+++ b/arch/mips/jazz/irq.c
@@ -134,7 +134,7 @@ static irqreturn_t r4030_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction r4030_timer_irqaction = {
 	.handler	= r4030_timer_interrupt,
-	.flags		= IRQF_DISABLED,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.name		= "R4030 timer",
 };
 
diff --git a/arch/mips/kernel/cevt-gt641xx.c b/arch/mips/kernel/cevt-gt641xx.c
index 92351e0..f5d265e 100644
--- a/arch/mips/kernel/cevt-gt641xx.c
+++ b/arch/mips/kernel/cevt-gt641xx.c
@@ -113,7 +113,7 @@ static irqreturn_t gt641xx_timer0_interrupt(int irq, void *dev_id)
 
 static struct irqaction gt641xx_timer0_irqaction = {
 	.handler	= gt641xx_timer0_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name		= "gt641xx_timer0",
 };
 
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 2652362..b469ad0 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -83,7 +83,7 @@ out:
 
 struct irqaction c0_compare_irqaction = {
 	.handler = c0_compare_interrupt,
-	.flags = IRQF_DISABLED | IRQF_PERCPU,
+	.flags = IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name = "timer",
 };
 
diff --git a/arch/mips/kernel/i8253.c b/arch/mips/kernel/i8253.c
index f7d8d5d..ed5c441 100644
--- a/arch/mips/kernel/i8253.c
+++ b/arch/mips/kernel/i8253.c
@@ -98,7 +98,7 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction irq0  = {
 	.handler = timer_interrupt,
-	.flags = IRQF_DISABLED | IRQF_NOBALANCING,
+	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_TIMER,
 	.name = "timer"
 };
 
diff --git a/arch/mips/nxp/pnx8550/common/time.c b/arch/mips/nxp/pnx8550/common/time.c
index 18b1927..d987a89 100644
--- a/arch/mips/nxp/pnx8550/common/time.c
+++ b/arch/mips/nxp/pnx8550/common/time.c
@@ -59,7 +59,7 @@ static irqreturn_t pnx8xxx_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction pnx8xxx_timer_irq = {
 	.handler	= pnx8xxx_timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name		= "pnx8xxx_timer",
 };
 
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 6d0e59f..d6802d6 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -105,7 +105,7 @@ static irqreturn_t hub_rt_counter_handler(int irq, void *dev_id)
 
 struct irqaction hub_rt_irqaction = {
 	.handler	= hub_rt_counter_handler,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name		= "hub-rt",
 };
 
diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index 62df6a5..f3b60e6 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -67,7 +67,7 @@ static irqreturn_t a20r_interrupt(int irq, void *dev_id)
 
 static struct irqaction a20r_irqaction = {
 	.handler	= a20r_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name		= "a20r-timer",
 };
 
-- 
1.6.2.1
