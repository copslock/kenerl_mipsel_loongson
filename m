Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 07:09:06 +0200 (CEST)
Received: from exsmtp01.microchip.com ([198.175.253.37]:22124 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27029446AbcEQFI3hQrA6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 07:08:29 +0200
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Mon, 16 May 2016
 22:08:22 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Tue, 17 May 2016
 10:36:35 +0530
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 04/11] irqchip: irq-pic32-evic: Fix bug with external interrupts.
Date:   Tue, 17 May 2016 10:35:53 +0530
Message-ID: <1463461560-9629-4-git-send-email-purna.mandal@microchip.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
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

From: Joshua Henderson <digitalpeer@digitalpeer.com>

The wrong external interrupt bits are being set, offset by 1.

Signed-off-by: Joshua Henderson <digitalpeer@digitalpeer.com>
Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>

---

 drivers/irqchip/irq-pic32-evic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
index e7155db..73addb4 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -91,7 +91,7 @@ static int pic32_set_type_edge(struct irq_data *data,
 	/* set polarity for external interrupts only */
 	for (i = 0; i < ARRAY_SIZE(priv->ext_irqs); i++) {
 		if (priv->ext_irqs[i] == data->hwirq) {
-			ret = pic32_set_ext_polarity(i + 1, flow_type);
+			ret = pic32_set_ext_polarity(i, flow_type);
 			if (ret)
 				return ret;
 		}
-- 
1.8.3.1
