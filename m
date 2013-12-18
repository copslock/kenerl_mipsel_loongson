Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 14:18:11 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35669 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867284Ab3LRNOLbVr1k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 14:14:11 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 0594928026E;
        Wed, 18 Dec 2013 14:11:54 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 01902284516;
        Wed, 18 Dec 2013 14:11:44 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH V2 09/13] MIPS: BCM63XX: always register bmips smp ops
Date:   Wed, 18 Dec 2013 14:12:07 +0100
Message-Id: <1387372331-23474-10-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
References: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38745
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

Use the return value for guarding further SMP setup.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/prom.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index f93f4fc..e1f27d6 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -59,10 +59,8 @@ void __init prom_init(void)
 	/* do low level board init */
 	board_prom_init();
 
-	if (IS_ENABLED(CONFIG_CPU_BMIPS4350) && IS_ENABLED(CONFIG_SMP)) {
-		/* set up SMP */
-		register_bmips_smp_ops();
-
+	/* set up SMP */
+	if (!register_bmips_smp_ops()) {
 		/*
 		 * BCM6328 might not have its second CPU enabled, while BCM3368
 		 * and BCM6358 need special handling for their shared TLB, so
-- 
1.8.5.1
