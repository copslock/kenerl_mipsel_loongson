Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jun 2013 17:40:40 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:40404 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827503Ab3FCPkiMN0wv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Jun 2013 17:40:38 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-012-093.pools.arcor-ip.net [88.73.12.93])
        by arrakis.dune.hu (Postfix) with ESMTPSA id B32CC28016C;
        Mon,  3 Jun 2013 17:39:18 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/3] MIPS: BCM63XX: Handle SW IRQs 0-1
Date:   Mon,  3 Jun 2013 17:39:34 +0200
Message-Id: <1370273975-12373-3-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370273975-12373-1-git-send-email-jogo@openwrt.org>
References: <1370273975-12373-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

From: Kevin Cernekee <cernekee@gmail.com>

MIPS software IRQs 0 and 1 are used for interprocessor signaling (IPI)
on BMIPS SMP.  Make the board support code aware of them.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
[jogo@openwrt.org: move sw irqs behind timer irq]
Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/irq.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index c0ab388..d744606 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -294,6 +294,10 @@ asmlinkage void plat_irq_dispatch(void)
 
 		if (cause & CAUSEF_IP7)
 			do_IRQ(7);
+		if (cause & CAUSEF_IP0)
+			do_IRQ(0);
+		if (cause & CAUSEF_IP1)
+			do_IRQ(1);
 		if (cause & CAUSEF_IP2)
 			dispatch_internal();
 		if (!is_ext_irq_cascaded) {
-- 
1.7.10.4
