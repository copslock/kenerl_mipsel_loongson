Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 22:21:26 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44561 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827516Ab3F2US1WDvzN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 29 Jun 2013 22:18:27 +0200
Received: from shaker64.lan (unknown [IPv6:2001:470:9e39:0:a00:27ff:fee0:c7df])
        by mail.nanl.de (Postfix) with ESMTPSA id 0C16E402E2;
        Sat, 29 Jun 2013 20:18:16 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 10/10] MIPS: BCM63XX: disable SMP also on BCM3368
Date:   Sat, 29 Jun 2013 22:17:52 +0200
Message-Id: <1372537073-27370-11-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37232
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

BCM3368 has the same shared TLB as BCM6358.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/prom.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index 1f01b84..5701b931 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -64,9 +64,9 @@ void __init prom_init(void)
 
 	if (cpu_is_bmips4350()) {
 		/*
-		 * BCM6328 might not have its second CPU enabled, while BCM6358
-		 * needs special handling for its shared TLB, so disable SMP
-		 * for now.
+		 * BCM6328 might not have its second CPU enabled, while BCM3368
+		 * and BCM6358 need special handling for their shared TLB, so
+		 * disable SMP for now.
 		 */
 		if (BCMCPU_IS_6328()) {
 			reg = bcm_readl(BCM_6328_OTP_BASE +
@@ -74,7 +74,7 @@ void __init prom_init(void)
 
 			if (reg & OTP_6328_REG3_TP1_DISABLED)
 				bmips_smp_enabled = 0;
-		} else if (BCMCPU_IS_6358()) {
+		} else if (BCMCPU_IS_3368() || BCMCPU_IS_6358()) {
 			bmips_smp_enabled = 0;
 		}
 
-- 
1.7.10.4
