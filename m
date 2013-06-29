Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 22:21:08 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44558 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827514Ab3F2US00w9eI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 29 Jun 2013 22:18:26 +0200
Received: from shaker64.lan (unknown [IPv6:2001:470:9e39:0:a00:27ff:fee0:c7df])
        by mail.nanl.de (Postfix) with ESMTPSA id 1C98645FC0;
        Sat, 29 Jun 2013 20:18:16 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 09/10] MIPS: BCM63XX: change the guard to a BMIPS4350 check
Date:   Sat, 29 Jun 2013 22:17:51 +0200
Message-Id: <1372537073-27370-10-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37231
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
 arch/mips/bcm63xx/prom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index 191936c..1f01b84 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -62,7 +62,7 @@ void __init prom_init(void)
 	/* set up SMP */
 	register_bmips_smp_ops();
 
-	if (IS_ENABLED(CONFIG_CPU_BMIPS4350) && IS_ENABLED(CONFIG_SMP)) {
+	if (cpu_is_bmips4350()) {
 		/*
 		 * BCM6328 might not have its second CPU enabled, while BCM6358
 		 * needs special handling for its shared TLB, so disable SMP
-- 
1.7.10.4
