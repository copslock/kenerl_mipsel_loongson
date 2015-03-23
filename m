Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 13:32:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27581 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008895AbbCWMcVxnHiD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2015 13:32:21 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D17CAF13AC28A;
        Mon, 23 Mar 2015 12:32:14 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 23 Mar 2015 12:32:16 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.138) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 23 Mar 2015 12:32:16 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] irqchip: irq-mips-gic: Add new functions to start/stop the GIC counter
Date:   Mon, 23 Mar 2015 12:32:01 +0000
Message-ID: <1427113923-9840-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1427113923-9840-1-git-send-email-markos.chandras@imgtec.com>
References: <1427113923-9840-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.138]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

We add new functions to start and stop the GIC counter since there are no
guarantees the counter will be running after a CPU reset. The GIC counter
is stopped by setting the 29th bit on the GIC Config register and it is
started by clearing that bit.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Qais Yousef <qais.yousef@imgtec.com>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 drivers/irqchip/irq-mips-gic.c   | 21 +++++++++++++++++++++
 include/linux/irqchip/mips-gic.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 9acdc080e7ec..f2d269bca789 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -166,6 +166,27 @@ cycle_t gic_read_compare(void)
 
 	return (((cycle_t) hi) << 32) + lo;
 }
+
+void gic_start_count(void)
+{
+	u32 gicconfig;
+
+	/* Start the counter */
+	gicconfig = gic_read(GIC_REG(SHARED, GIC_SH_CONFIG));
+	gicconfig &= ~(1 << GIC_SH_CONFIG_COUNTSTOP_SHF);
+	gic_write(GIC_REG(SHARED, GIC_SH_CONFIG), gicconfig);
+}
+
+void gic_stop_count(void)
+{
+	u32 gicconfig;
+
+	/* Stop the counter */
+	gicconfig = gic_read(GIC_REG(SHARED, GIC_SH_CONFIG));
+	gicconfig |= 1 << GIC_SH_CONFIG_COUNTSTOP_SHF;
+	gic_write(GIC_REG(SHARED, GIC_SH_CONFIG), gicconfig);
+}
+
 #endif
 
 static bool gic_local_irq_is_routable(int intr)
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index e6a6aac451db..3ea2e4754c40 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -240,6 +240,8 @@ extern unsigned int gic_get_count_width(void);
 extern cycle_t gic_read_compare(void);
 extern void gic_write_compare(cycle_t cnt);
 extern void gic_write_cpu_compare(cycle_t cnt, int cpu);
+extern void gic_start_count(void);
+extern void gic_stop_count(void);
 extern void gic_send_ipi(unsigned int intr);
 extern unsigned int plat_ipi_call_int_xlate(unsigned int);
 extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
-- 
2.3.3
