Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Sep 2015 11:16:35 +0200 (CEST)
Received: from mail.base45.de ([80.241.61.77]:37477 "EHLO mail.base45.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006943AbbIIJQeIc2D7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Sep 2015 11:16:34 +0200
Received: from [2a02:8109:8c40:8f4:bd68:64f6:6ae5:6056] (helo=lazus.fritz.box)
        by mail.base45.de with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
        (Exim 4.82)
        (envelope-from <lynxis@fe80.eu>)
        id 1ZZbUT-00035c-01; Wed, 09 Sep 2015 11:16:29 +0200
From:   Alexander Couzens <lynxis@fe80.eu>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH v2 1/2] MIPS: ath79: set missing irq ack handler for ar7100-misc-intc irq chip
Date:   Wed,  9 Sep 2015 11:16:17 +0200
Message-Id: <1441790178-9573-2-git-send-email-lynxis@fe80.eu>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441790178-9573-1-git-send-email-lynxis@fe80.eu>
References: <1441790178-9573-1-git-send-email-lynxis@fe80.eu>
Return-Path: <lynxis@fe80.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lynxis@fe80.eu
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

The irq ack handler was forgotten while introducing OF support.
Only ar71xx and ar933x based devices require it.

Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
---
 arch/mips/ath79/irq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index afb0096..c9c0124 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -308,8 +308,16 @@ static int __init ath79_misc_intc_of_init(
 
 	return 0;
 }
-IRQCHIP_DECLARE(ath79_misc_intc, "qca,ar7100-misc-intc",
-		ath79_misc_intc_of_init);
+
+static int __init ar7100_misc_intc_of_init(
+	struct device_node *node, struct device_node *parent)
+{
+	ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
+	return ath79_misc_intc_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(ar7100_misc_intc, "qca,ar7100-misc-intc",
+		ar7100_misc_intc_of_init);
 
 static int __init ar79_cpu_intc_of_init(
 	struct device_node *node, struct device_node *parent)
-- 
2.4.0
