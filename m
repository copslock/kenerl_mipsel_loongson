Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:54:31 +0200 (CEST)
Received: from mail-qg0-f74.google.com ([209.85.192.74]:52907 "EHLO
        mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009267AbaIRVrxgunab (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:53 +0200
Received: by mail-qg0-f74.google.com with SMTP id q108so92905qgd.1
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zRMkD59BY9GQY9gw/26rMH3hEyDoRog5Or0QVz85Cog=;
        b=BhXisUKZF/QJ8d/sCZDQlNo1b/uRY/Fl6iVLEwfScFFMW4l1KRXOVK/h9T+UFKnjaQ
         cOnQx8gSkUMGZH5FIBZKfbRO4LYuS+uXRH/5k9QwfJb1qckTHbagsFmAQc1b8L3+uYst
         47HjNYpDbUzLiDKD9D2IaPIM4bYu4cEDtLUJqqBKilzldJDoLRUh32iwVtWY+N5v9HNu
         yW80KlJa5n0VP24eB1oTNIdaZYfbOkSg1rl8qa7pi/b355uOoIIj+/heWcXslt9sxptU
         WFubgwxlcKw2KV295B5rEWG7DwfLrviFxu3QenNmp8mA5/rEJOBWtekL/VD1NAIVVHAl
         HPkg==
X-Gm-Message-State: ALoCoQk3yZsQHn1AxTp7EivNR+7jzNCBRClcT98ySbQvkH4pa7PbQLKhQHCCX0FUOIdQaxGS0pYA
X-Received: by 10.52.181.200 with SMTP id dy8mr6269693vdc.8.1411076867811;
        Thu, 18 Sep 2014 14:47:47 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n22si4127yhd.1.2014.09.18.14.47.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:47 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id xE8T9pn4.6; Thu, 18 Sep 2014 14:47:47 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 9E44F220D1A; Thu, 18 Sep 2014 14:47:46 -0700 (PDT)
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
Subject: [PATCH V2 22/24] irqchip: mips-gic: Remove unnecessary globals
Date:   Thu, 18 Sep 2014 14:47:28 -0700
Message-Id: <1411076851-28242-23-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42702
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

Now that all GIC interrupt routing and handling logic is in the GIC
driver itself, un-export variables/functions which are no longer used
outside the GIC driver.  This also allows us to remove gic_compare_int
and combine gic_get_int_mask with gic_get_int since these interfaces
are no longer used.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
---
 arch/mips/include/asm/gic.h    |  5 -----
 drivers/irqchip/irq-mips-gic.c | 28 ++++------------------------
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 6b99610..727b7bf 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -364,13 +364,11 @@
 extern unsigned int gic_present;
 extern unsigned int gic_frequency;
 extern unsigned long _gic_base;
-extern unsigned int gic_cpu_pin;
 
 extern void gic_init(unsigned long gic_base_addr,
 	unsigned long gic_addrspace_size, unsigned int cpu_vec,
 	unsigned int irqbase);
 extern void gic_clocksource_init(unsigned int);
-extern unsigned int gic_compare_int (void);
 extern cycle_t gic_read_count(void);
 extern cycle_t gic_read_compare(void);
 extern void gic_write_compare(cycle_t cnt);
@@ -378,10 +376,7 @@ extern void gic_write_cpu_compare(cycle_t cnt, int cpu);
 extern void gic_send_ipi(unsigned int intr);
 extern unsigned int plat_ipi_call_int_xlate(unsigned int);
 extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
-extern void gic_bind_eic_interrupt(int irq, int set);
 extern unsigned int gic_get_timer_pending(void);
-extern void gic_get_int_mask(unsigned long *dst, const unsigned long *src);
-extern unsigned int gic_get_int(void);
 extern int gic_get_c0_compare_int(void);
 extern int gic_get_c0_perfcount_int(void);
 #endif /* _ASM_GICREGS_H */
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index b28f7ad..02c7d2a 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -24,7 +24,6 @@
 unsigned int gic_frequency;
 unsigned int gic_present;
 unsigned long _gic_base;
-unsigned int gic_cpu_pin;
 
 struct gic_pcpu_mask {
 	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
@@ -45,6 +44,7 @@ static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static int gic_shared_intrs;
 static int gic_vpes;
+static unsigned int gic_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 
 static void __gic_irq_dispatch(void);
@@ -129,7 +129,7 @@ unsigned int gic_get_timer_pending(void)
 	return (vpe_pending & GIC_VPE_PEND_TIMER_MSK);
 }
 
-void gic_bind_eic_interrupt(int irq, int set)
+static void gic_bind_eic_interrupt(int irq, int set)
 {
 	/* Convert irq vector # to hw int # */
 	irq -= GIC_PIN_TO_VEC_OFFSET;
@@ -143,17 +143,6 @@ void gic_send_ipi(unsigned int intr)
 	GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), 0x80000000 | intr);
 }
 
-unsigned int gic_compare_int(void)
-{
-	unsigned int pending;
-
-	GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_PEND), pending);
-	if (pending & GIC_VPE_PEND_CMP_MSK)
-		return 1;
-	else
-		return 0;
-}
-
 int gic_get_c0_compare_int(void)
 {
 	if (!gic_local_irq_is_routable(GIC_LOCAL_INT_TIMER))
@@ -174,7 +163,7 @@ int gic_get_c0_perfcount_int(void)
 				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_PERFCTR));
 }
 
-void gic_get_int_mask(unsigned long *dst, const unsigned long *src)
+static unsigned int gic_get_int(void)
 {
 	unsigned int i;
 	unsigned long *pending, *intrmask, *pcpu_mask;
@@ -199,17 +188,8 @@ void gic_get_int_mask(unsigned long *dst, const unsigned long *src)
 
 	bitmap_and(pending, pending, intrmask, gic_shared_intrs);
 	bitmap_and(pending, pending, pcpu_mask, gic_shared_intrs);
-	bitmap_and(dst, src, pending, gic_shared_intrs);
-}
-
-unsigned int gic_get_int(void)
-{
-	DECLARE_BITMAP(interrupts, GIC_MAX_INTRS);
-
-	bitmap_fill(interrupts, gic_shared_intrs);
-	gic_get_int_mask(interrupts, interrupts);
 
-	return find_first_bit(interrupts, gic_shared_intrs);
+	return find_first_bit(pending, gic_shared_intrs);
 }
 
 static void gic_mask_irq(struct irq_data *d)
-- 
2.1.0.rc2.206.gedb03e5
