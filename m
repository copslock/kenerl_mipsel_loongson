Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:48:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24003 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993934AbdHMEqeX9bdd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:46:34 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 5A8E449107997;
        Sun, 13 Aug 2017 05:46:26 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:46:27 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 30/38] MIPS: Remove unnecessary inclusions of linux/irqchip/mips-gic.h
Date:   Sat, 12 Aug 2017 21:36:38 -0700
Message-ID: <20170813043646.25821-31-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813043646.25821-1-paul.burton@imgtec.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

linux/irqchip/mips-gic.h is included in a few files that don't actually
use it at all. Remove these unnecessary inclusions in preparation for
removing the header.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/smp-cmp.c | 1 -
 arch/mips/kernel/smp-cps.c | 1 -
 arch/mips/pistachio/irq.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index 04b21deea4f2..05295a4909f1 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -24,7 +24,6 @@
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/compiler.h>
-#include <linux/irqchip/mips-gic.h>
 
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index c316a0f9e6fb..0063122c85da 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -11,7 +11,6 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/hotplug.h>
 #include <linux/slab.h>
diff --git a/arch/mips/pistachio/irq.c b/arch/mips/pistachio/irq.c
index 0a6b24c24652..709a8219073a 100644
--- a/arch/mips/pistachio/irq.c
+++ b/arch/mips/pistachio/irq.c
@@ -10,7 +10,6 @@
 
 #include <linux/init.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/kernel.h>
 
 #include <asm/cpu-features.h>
-- 
2.14.0
