Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 10:33:14 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:40317 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835070Ab3DPIcS4cbGX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 10:32:18 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V4 04/14] MIPS: ralink: add missing comment in irq driver
Date:   Tue, 16 Apr 2013 10:27:59 +0200
Message-Id: <1366100889-21072-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1366100889-21072-1-git-send-email-blogic@openwrt.org>
References: <1366100889-21072-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Trivial patch that adds a comment that makes the code more readable.

Signed-off-by: John Crispin <blogic@openwrt.org>
Acked-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ralink/irq.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index d9807d0..320b1f1 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -166,6 +166,7 @@ static int __init intc_of_init(struct device_node *node,
 	irq_set_chained_handler(irq, ralink_intc_irq_handler);
 	irq_set_handler_data(irq, domain);
 
+	/* tell the kernel which irq is used for performance monitoring */
 	cp0_perfcount_irq = irq_create_mapping(domain, 9);
 
 	return 0;
-- 
1.7.10.4
