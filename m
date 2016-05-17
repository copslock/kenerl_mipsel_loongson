Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 16:32:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41211 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029652AbcEQOcUd-yno (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 16:32:20 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 4DA6391A7DACB;
        Tue, 17 May 2016 15:32:11 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 17 May 2016 15:32:14 +0100
Received: from localhost (10.100.200.141) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 17 May
 2016 15:32:13 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] irqchip: mips-gic: Setup EIC mode on each CPU if it's in use
Date:   Tue, 17 May 2016 15:31:06 +0100
Message-ID: <1463495466-29689-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463495466-29689-1-git-send-email-paul.burton@imgtec.com>
References: <1463495466-29689-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53489
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

When EIC mode is in use (cpu_has_veic is true) enable it on each CPU
during GIC initialisation. Otherwise there may be a mismatch between the
hardware default interrupt model & that expected by the kernel.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/irqchip/irq-mips-gic.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 4dffccf..bc23c92 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -956,7 +956,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
 			      unsigned int cpu_vec, unsigned int irqbase,
 			      struct device_node *node)
 {
-	unsigned int gicconfig;
+	unsigned int gicconfig, cpu;
 	unsigned int v[2];
 
 	__gic_base_addr = gic_base_addr;
@@ -973,6 +973,14 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	gic_vpes = gic_vpes + 1;
 
 	if (cpu_has_veic) {
+		/* Set EIC mode for all VPEs */
+		for_each_present_cpu(cpu) {
+			gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
+				  mips_cm_vp_id(cpu));
+			gic_write(GIC_REG(VPE_OTHER, GIC_VPE_CTL),
+				  GIC_VPE_CTL_EIC_MODE_MSK);
+		}
+
 		/* Always use vector 1 in EIC mode */
 		gic_cpu_pin = 0;
 		timer_cpu_pin = gic_cpu_pin;
-- 
2.8.2
