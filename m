Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 15:24:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51476 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026035AbbDXNYiNgNIo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2015 15:24:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7E5BB47A6A9E6;
        Fri, 24 Apr 2015 14:24:31 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 24 Apr 2015 14:24:34 +0100
Received: from localhost (192.168.159.76) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 24 Apr
 2015 14:24:32 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v4 20/37] MIPS: JZ4740: support newer SoC interrupt controllers
Date:   Fri, 24 Apr 2015 14:17:20 +0100
Message-ID: <1429881457-16016-21-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.76]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47054
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

Allow the interrupt controllers of the JZ4770, JZ4775 & JZ4780 SoCs to
be probed via devicetree, supporting the 64 interrupts they provide.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Changes in v4:
  - None.

Changes in v3:
  - Support JZ4775, and use a more generic "2chip" probe function name
    for doing so whilst sharing code with the JZ4780.

Changes in v2:
  - None.
---
 arch/mips/jz4740/irq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 65b27c8..5f4ec08 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -161,3 +161,12 @@ static int __init intc_1chip_of_init(struct device_node *node,
 	return ingenic_intc_of_init(node, 1);
 }
 IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", intc_1chip_of_init);
+
+static int __init intc_2chip_of_init(struct device_node *node,
+	struct device_node *parent)
+{
+	return ingenic_intc_of_init(node, 2);
+}
+IRQCHIP_DECLARE(jz4770_intc, "ingenic,jz4770-intc", intc_2chip_of_init);
+IRQCHIP_DECLARE(jz4775_intc, "ingenic,jz4775-intc", intc_2chip_of_init);
+IRQCHIP_DECLARE(jz4780_intc, "ingenic,jz4780-intc", intc_2chip_of_init);
-- 
2.3.5
