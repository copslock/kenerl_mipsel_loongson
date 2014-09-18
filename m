Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:50:12 +0200 (CEST)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:39970 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009241AbaIRVrp6bvXm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:45 +0200
Received: by mail-ie0-f202.google.com with SMTP id tr6so44478ieb.5
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qL2r923qXCXCK8LrvNsE1WM+bz94y9sFcUX/6T+NcB8=;
        b=VJ5Fcx+tYUUuOWSzRVLM3H+hVasd5LCXcf8voQfzlsu198R5CJu1CvwUF9Vp3eGqs+
         8CHFsJ0CNAq8h/Jix8L6bfxlql5KFhmD/6j5uqsd7PgijCFCoQdJUqhYuw0DgH/k8doh
         PdFNjlpFAdeI+slAZR+m8nNFZXFJE1iazt/aGbOtfm5EEUp+/znVtTYbnDYqRQmQxb2D
         AbUhgTkjoBNCKM6P9oyxgCseomy8ivK9F8CTi8mf/pwxVuT5xu7ozWW+5bn1TmWkOCvf
         /tHxtbhoxc51wgGolRo4U17L/mPE5qkB8r03kWR3w/1iMSUJTO4BlFIWkm7mn1y0THY9
         QSXw==
X-Gm-Message-State: ALoCoQlMk3jScLysbwBTKL5h1tu3afzQTRmVN7qpEJJm6LTnbEPqy39CLH6m0UEl3vx3m+uAoomM
X-Received: by 10.50.122.72 with SMTP id lq8mr17466512igb.0.1411076860173;
        Thu, 18 Sep 2014 14:47:40 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id l45si4207yha.2.2014.09.18.14.47.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:40 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id mCkhyaue.1; Thu, 18 Sep 2014 14:47:39 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id CCA15220D21; Thu, 18 Sep 2014 14:47:38 -0700 (PDT)
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
Subject: [PATCH V2 08/24] MIPS: Remove gic_{enable,disable}_interrupt()
Date:   Thu, 18 Sep 2014 14:47:14 -0700
Message-Id: <1411076851-28242-9-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42688
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
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
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
