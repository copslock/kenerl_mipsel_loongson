Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:53:57 +0200 (CEST)
Received: from mail-vc0-f201.google.com ([209.85.220.201]:45859 "EHLO
        mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009017AbaIOXvopXydK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:44 +0200
Received: by mail-vc0-f201.google.com with SMTP id hy4so485000vcb.2
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kAFOQHwsnqfsxv8GvNbfyG1po8Ab9LnGMLzlh9zMrzo=;
        b=S9AW4ymECXfIUJJB4i8LVGHiNzo8CDHFzw8K3S/xYTuLq6MQEgrt/kOKQkjWVqSYPR
         hUWbiGjsJSSDVUb9T1Q/FMZPvsbNeFvk83NNwaxFVWBAQflj1ho9+PSaoKyXoIFkYR3z
         TkXeJyv9A9fCuNSvxiIx2YJ2aXs9jHtmvym1pYQm/qYv33WA5TiFr48xqpCFG1ZdOM0U
         6PWi4hD9ZaJSMO8AnE1HfAPMlh91WIAkEKjJkMxYEB6VMib9MVMqVdPvzmq9ZraQEuA7
         syrPHYb+ku9ATzsg2F6lIbum1t+Yd5hKLsD1w675HrlCwoUIu//DygZfZ2Vh6WFiFXGS
         LiDw==
X-Gm-Message-State: ALoCoQn0SwPQG308nYonUyP8MUXwabTeQHlx8mqKF+g8IERLOTmDJcN7SOuwFoOMSdh8xj19mf4g
X-Received: by 10.224.37.6 with SMTP id v6mr5735603qad.9.1410825098777;
        Mon, 15 Sep 2014 16:51:38 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n63si629288yho.5.2014.09.15.16.51.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:38 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 1oB1jrOM.1; Mon, 15 Sep 2014 16:51:38 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 5F5472209AB; Mon, 15 Sep 2014 16:51:37 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/24] MIPS: Remove gic_{enable,disable}_interrupt()
Date:   Mon, 15 Sep 2014 16:51:11 -0700
Message-Id: <1410825087-5497-9-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42626
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

Nothing calls gic_{enable,disable}_interrupt() any more.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/include/asm/gic.h     |  2 --
 arch/mips/mti-malta/malta-int.c | 10 ----------
 arch/mips/mti-sead3/sead3-int.c | 34 ----------------------------------
 3 files changed, 46 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index d7699cf..022d831 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -376,8 +376,6 @@ extern void gic_bind_eic_interrupt(int irq, int set);
 extern unsigned int gic_get_timer_pending(void);
 extern void gic_get_int_mask(unsigned long *dst, const unsigned long *src);
 extern unsigned int gic_get_int(void);
-extern void gic_enable_interrupt(int irq_vec);
-extern void gic_disable_interrupt(int irq_vec);
 extern void gic_irq_ack(struct irq_data *d);
 extern void gic_finish_irq(struct irq_data *d);
 extern void gic_platform_init(int irqs, struct irq_chip *irq_controller);
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index e4f43ba..5c31208 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -715,16 +715,6 @@ int malta_be_handler(struct pt_regs *regs, int is_fixup)
 	return retval;
 }
 
-void gic_enable_interrupt(int irq_vec)
-{
-	GIC_SET_INTR_MASK(irq_vec);
-}
-
-void gic_disable_interrupt(int irq_vec)
-{
-	GIC_CLR_INTR_MASK(irq_vec);
-}
-
 void gic_irq_ack(struct irq_data *d)
 {
 	int irq = (d->irq - gic_irq_base);
diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
index 6a560ac..9d5b5bd 100644
--- a/arch/mips/mti-sead3/sead3-int.c
+++ b/arch/mips/mti-sead3/sead3-int.c
@@ -85,40 +85,6 @@ void __init arch_init_irq(void)
 			ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
 }
 
-void gic_enable_interrupt(int irq_vec)
-{
-	unsigned int i, irq_source;
-
-	/* enable all the interrupts associated with this vector */
-	for (i = 0; i < gic_shared_intr_map[irq_vec].num_shared_intr; i++) {
-		irq_source = gic_shared_intr_map[irq_vec].intr_list[i];
-		GIC_SET_INTR_MASK(irq_source);
-	}
-	/* enable all local interrupts associated with this vector */
-	if (gic_shared_intr_map[irq_vec].local_intr_mask) {
-		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), 0);
-		GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_SMASK),
-			gic_shared_intr_map[irq_vec].local_intr_mask);
-	}
-}
-
-void gic_disable_interrupt(int irq_vec)
-{
-	unsigned int i, irq_source;
-
-	/* disable all the interrupts associated with this vector */
-	for (i = 0; i < gic_shared_intr_map[irq_vec].num_shared_intr; i++) {
-		irq_source = gic_shared_intr_map[irq_vec].intr_list[i];
-		GIC_CLR_INTR_MASK(irq_source);
-	}
-	/* disable all local interrupts associated with this vector */
-	if (gic_shared_intr_map[irq_vec].local_intr_mask) {
-		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), 0);
-		GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_RMASK),
-			gic_shared_intr_map[irq_vec].local_intr_mask);
-	}
-}
-
 void gic_irq_ack(struct irq_data *d)
 {
 	GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
-- 
2.1.0.rc2.206.gedb03e5
