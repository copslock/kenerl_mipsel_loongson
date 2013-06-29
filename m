Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 22:20:50 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44553 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824789Ab3F2USZbeTD8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 29 Jun 2013 22:18:25 +0200
Received: from shaker64.lan (unknown [IPv6:2001:470:9e39:0:a00:27ff:fee0:c7df])
        by mail.nanl.de (Postfix) with ESMTPSA id 4863E402E2;
        Sat, 29 Jun 2013 20:18:15 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 08/10] MIPS: BCM63XX: always register bmips smp ops
Date:   Sat, 29 Jun 2013 22:17:50 +0200
Message-Id: <1372537073-27370-9-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37230
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

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/prom.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index 8ac4e09..191936c 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -59,10 +59,10 @@ void __init prom_init(void)
 	/* do low level board init */
 	board_prom_init();
 
-	if (IS_ENABLED(CONFIG_CPU_BMIPS4350) && IS_ENABLED(CONFIG_SMP)) {
-		/* set up SMP */
-		register_smp_ops(&bmips_smp_ops);
+	/* set up SMP */
+	register_bmips_smp_ops();
 
+	if (IS_ENABLED(CONFIG_CPU_BMIPS4350) && IS_ENABLED(CONFIG_SMP)) {
 		/*
 		 * BCM6328 might not have its second CPU enabled, while BCM6358
 		 * needs special handling for its shared TLB, so disable SMP
-- 
1.7.10.4
