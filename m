Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:43:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30472 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011786AbbARWmvNoVw6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:42:51 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7EB5B873D1E0;
        Sun, 18 Jan 2015 22:42:41 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:42:45 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:42:39 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 32/36] MIPS: jz4740: add jz4780 interrupt controller support
Date:   Sun, 18 Jan 2015 14:42:36 -0800
Message-ID: <1421620956-25578-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45281
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

Allow the jz4780 interrupt controller to be probed from devicetree,
supporting the 64 interrupts it provides.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/irq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 3e53a32..de1c03e 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -137,6 +137,13 @@ static int __init jz4740_intc_of_init(struct device_node *node,
 }
 IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", jz4740_intc_of_init);
 
+static int __init jz4780_intc_of_init(struct device_node *node,
+	struct device_node *parent)
+{
+	return jz47xx_intc_of_init(node, 2);
+}
+IRQCHIP_DECLARE(jz4780_intc, "ingenic,jz4780-intc", jz4780_intc_of_init);
+
 #ifdef CONFIG_DEBUG_FS
 
 static inline void intc_seq_reg(struct seq_file *s, const char *name,
-- 
2.2.1
