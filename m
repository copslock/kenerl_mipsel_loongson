Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2016 23:28:42 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:50090 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27042735AbcFFV2l2Jjkf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2016 23:28:41 +0200
Received: from hauke-desktop.lan (p2003008B2F74F40009B15C866DCE0411.dip0.t-ipconnect.de [IPv6:2003:8b:2f74:f400:9b1:5c86:6dce:411])
        by hauke-m.de (Postfix) with ESMTPSA id 7F691100061;
        Mon,  6 Jun 2016 23:28:40 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     john@phrozen.org, linux-mips@linux-mips.org,
        thomas.langer@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: lantiq: register IRQ handler for virtual IRQ number
Date:   Mon,  6 Jun 2016 23:28:33 +0200
Message-Id: <1465248513-26604-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.8.1
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

We used the hardware IRQ number to register the IRQ handler and not the
virtual one. This probably caused some problems because the hardware
IRQ numbers are only unique for each IRQ controller and not in the
system. The virtual IRQ number is managed by Linux and unique in the
system. This was probably the reason there was a gab of 8 IRQ numbers added
before the numbers used for the lantiq IRQ controller. With the current
setup the hardware and the virtual IRQ numbers are the same.

Reported-by: Thomas Langer <thomas.langer@intel.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index ff17669e..56a1703 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -344,7 +344,7 @@ static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 		if (hw == ltq_eiu_irq[i].start)
 			chip = &ltq_eiu_type;
 
-	irq_set_chip_and_handler(hw, chip, handle_level_irq);
+	irq_set_chip_and_handler(irq, chip, handle_level_irq);
 
 	return 0;
 }
-- 
2.8.1
