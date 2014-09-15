Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:58:01 +0200 (CEST)
Received: from mail-oa0-f73.google.com ([209.85.219.73]:49875 "EHLO
        mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009038AbaIOXvwLn-OB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:52 +0200
Received: by mail-oa0-f73.google.com with SMTP id jd19so747439oac.0
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bV1VrVJG0nzIdDM5EckDdt7NwTHMpgM7rGvs1FhH8uY=;
        b=iz9KXCnbfSPwR1vgEkeAJFlJKT9Xetkzv6MRhreEC+FKbZsRBu54bOveVs0pEiBCcp
         mEc2Out3VMPuSvM5+fEhXZesDyHH9C0KArK2GQzv4DwT7oZDlKgofFmy1dxJmy3bJms7
         Cherc4MYG4J/IZDbk4gqjcB0RQVuJ/nsDld3ssMBFx+IiiABs0uZ3D1bJp/VMCR8xGO9
         sQS20pJ99n/QKXNSpSPdot4TGd8vhFIhP5IaRJ+tUcnWJQS3XQTdVaLhi25UllEVbCXO
         HCkI0IKXNCHaiOF8r8+bV2mpybrbbqAc6aXJoq9AYU4po9GpU66YhA/xfu2aAU9jbzMy
         0kPw==
X-Gm-Message-State: ALoCoQlo0v1DhQSlyDcuneRuKgzIAQWoO95xmje0MIZrgs3u440xuRfiYEQ2ov5YWF/fTzq1wW/9
X-Received: by 10.182.68.17 with SMTP id r17mr16610607obt.26.1410825106402;
        Mon, 15 Sep 2014 16:51:46 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n22si631703yhd.1.2014.09.15.16.51.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:46 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id Mdj9PTay.6; Mon, 15 Sep 2014 16:51:46 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 30F4122093F; Mon, 15 Sep 2014 16:51:45 -0700 (PDT)
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
Subject: [PATCH 22/24] irqchip: mips-gic: Remove unnecessary globals
Date:   Mon, 15 Sep 2014 16:51:25 -0700
Message-Id: <1410825087-5497-23-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42640
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
index 3abe310..845affb 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -24,7 +24,6 @@
 unsigned int gic_frequency;
 unsigned int gic_present;
 unsigned long _gic_base;
-unsigned int gic_cpu_pin;
 
 struct gic_pcpu_mask {
 	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
@@ -44,6 +43,7 @@ static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
 static struct irq_domain *gic_irq_domain;
 static int gic_shared_intrs;
 static int gic_vpes;
+static unsigned int gic_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 
 static void __gic_irq_dispatch(void);
@@ -132,7 +132,7 @@ unsigned int gic_get_timer_pending(void)
 	return (vpe_pending & GIC_VPE_PEND_TIMER_MSK);
 }
 
-void gic_bind_eic_interrupt(int irq, int set)
+static void gic_bind_eic_interrupt(int irq, int set)
 {
 	/* Convert irq vector # to hw int # */
 	irq -= GIC_PIN_TO_VEC_OFFSET;
@@ -146,17 +146,6 @@ void gic_send_ipi(unsigned int intr)
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
@@ -177,7 +166,7 @@ int gic_get_c0_perfcount_int(void)
 				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_PERFCTR));
 }
 
-void gic_get_int_mask(unsigned long *dst, const unsigned long *src)
+static unsigned int gic_get_int(void)
 {
 	unsigned int i;
 	unsigned long *pending, *intrmask, *pcpu_mask;
@@ -202,17 +191,8 @@ void gic_get_int_mask(unsigned long *dst, const unsigned long *src)
 
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
