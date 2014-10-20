Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:06:49 +0200 (CEST)
Received: from mail-qg0-f73.google.com ([209.85.192.73]:47234 "EHLO
        mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011975AbaJTTERr0cbQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:17 +0200
Received: by mail-qg0-f73.google.com with SMTP id i50so472272qgf.2
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OdB/9Dap7xDRJWElpdVPHaOd1exNCAaCfnZAi9H7yWY=;
        b=Ih7OtTGy2t6L9RRBDPyagRVpt+s8vGHNcL/iZH6VM/M61ZLTaPzpM5uC7ncG57fU/p
         7Q2foUS/tD2TwgExPGYP5mbudNwvk82Hgpvfsck03jX+k9AaxaINyeE4kf4lRrruULZB
         v23t5Rj2CFpFgDFcNVAASyijNB/L8x3GW+a2XazrvjIaB9mJS1gXf4HpKjnt5BdPFzbg
         wAMDqX0JrGdm3OJbIk0/8S7ALMA3y1T58AwjQPSolGhEq+GSTo7mwAxhdwEQLbHrvMp7
         q481pu/C6EXDI93gm4nNWw9EQXvemOGs7sMLRze5dpgeIcdh3twGBkXVOEG+xUcW7j7S
         pJSg==
X-Gm-Message-State: ALoCoQm+Z2q2WyFeMdfBxQiMmknfWsAW4qnc3nFAxCqBtLVThkJyha3GCrNXlFa2e4+GNlQGRxO6
X-Received: by 10.224.56.9 with SMTP id w9mr19194194qag.5.1413831852101;
        Mon, 20 Oct 2014 12:04:12 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id l45si437898yha.2.2014.10.20.12.04.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:12 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id ezN2XdvX.3; Mon, 20 Oct 2014 12:04:12 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 3333E220D57; Mon, 20 Oct 2014 12:04:11 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/19] irqchip: mips-gic: Remove gic_{pending,itrmask}_regs
Date:   Mon, 20 Oct 2014 12:03:56 -0700
Message-Id: <1413831846-32100-10-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

There's no reason for the pending and masked interrupt bitmasks
to be global.  Just declare them on the stack in gic_get_int()
since they only consume (256*2)/8 = 64 bytes.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/irqchip/irq-mips-gic.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index a1ccde6..188760c 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -25,18 +25,8 @@ struct gic_pcpu_mask {
 	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
 };
 
-struct gic_pending_regs {
-	DECLARE_BITMAP(pending, GIC_MAX_INTRS);
-};
-
-struct gic_intrmask_regs {
-	DECLARE_BITMAP(intrmask, GIC_MAX_INTRS);
-};
-
 static void __iomem *gic_base;
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
-static struct gic_pending_regs pending_regs[NR_CPUS];
-static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static int gic_shared_intrs;
@@ -242,12 +232,12 @@ int gic_get_c0_perfcount_int(void)
 static unsigned int gic_get_int(void)
 {
 	unsigned int i;
-	unsigned long *pending, *intrmask, *pcpu_mask;
+	unsigned long *pcpu_mask;
 	unsigned long pending_reg, intrmask_reg;
+	DECLARE_BITMAP(pending, GIC_MAX_INTRS);
+	DECLARE_BITMAP(intrmask, GIC_MAX_INTRS);
 
 	/* Get per-cpu bitmaps */
-	pending = pending_regs[smp_processor_id()].pending;
-	intrmask = intrmask_regs[smp_processor_id()].intrmask;
 	pcpu_mask = pcpu_masks[smp_processor_id()].pcpu_mask;
 
 	pending_reg = GIC_REG(SHARED, GIC_SH_PEND);
-- 
2.1.0.rc2.206.gedb03e5
