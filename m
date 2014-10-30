Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 03:20:51 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:43491 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012246AbaJ3CTtVR8xv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 03:19:49 +0100
Received: by mail-pa0-f47.google.com with SMTP id kx10so4421728pab.34
        for <multiple recipients>; Wed, 29 Oct 2014 19:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dD2dKng+JChe7+VaRXdcWIoLxf6MYWCgjj83/vy/HKw=;
        b=iWiO5/U94Y1wNtuZWyMEArC1Cjdh0n0fPuANqN6y1wRQKiGyLdluf2cgNlfHQ2zKW1
         l26VE8NFZHSQWnTOvExZrGP/7+Vv50CcJCRqtaiy8NZngMnlWQx7o12jsSa5GDMq367J
         Wb4Xp6Vt95UUlvW4yiwP0Ib3h7UioyKoZdpDcS0+ATvU7nBydhClE/pODyKMjsZRG2L3
         y4HaosgU1bN0NDFojL/G7FpVkHhbjPKr+QolQFVBUa18evqTaN7pMDJifOyrAJpwtuPJ
         AXyVCtsdiXSkj/WM6N7OSFRcqYbS2vx+U8GTmsKrwymmyvpXfmpelPThPnYsV9wigXg2
         YSbg==
X-Received: by 10.70.109.169 with SMTP id ht9mr577617pdb.152.1414635582863;
        Wed, 29 Oct 2014 19:19:42 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id d17sm5524269pdj.32.2014.10.29.19.19.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 19:19:42 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V2 03/15] genirq: Generic chip: Move irq_reg_{readl,writel} accessors into generic-chip.c
Date:   Wed, 29 Oct 2014 19:17:56 -0700
Message-Id: <1414635488-14137-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

This allows us to implement per-irqchip behavior when necessary, instead
of hardcoding the behavior for all irqchip drivers at compile time.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 include/linux/irq.h       |  7 -------
 kernel/irq/generic-chip.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 03f48d9..8049e93 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -639,13 +639,6 @@ void arch_teardown_hwirq(unsigned int irq);
 void irq_init_desc(unsigned int irq);
 #endif
 
-#ifndef irq_reg_writel
-# define irq_reg_writel(val, addr)	writel(val, addr)
-#endif
-#ifndef irq_reg_readl
-# define irq_reg_readl(addr)		readl(addr)
-#endif
-
 /**
  * struct irq_chip_regs - register offsets for struct irq_gci
  * @enable:	Enable register offset to reg_base
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index cf80e7b..380595f 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -17,6 +17,16 @@
 static LIST_HEAD(gc_list);
 static DEFINE_RAW_SPINLOCK(gc_lock);
 
+static void irq_reg_writel(u32 val, void __iomem *addr)
+{
+	writel(val, addr);
+}
+
+static u32 irq_reg_readl(void __iomem *addr)
+{
+	return readl(addr);
+}
+
 /**
  * irq_gc_noop - NOOP function
  * @d: irq_data
-- 
2.1.1
