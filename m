Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 16:56:54 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37312 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861346AbaGHOyEmHCEa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Jul 2014 16:54:04 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 4A42728B44E;
        Tue,  8 Jul 2014 16:52:00 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (p5081183E.dip0.t-ipconnect.de [80.129.24.62])
        by arrakis.dune.hu (Postfix) with ESMTPSA id D430428BB83;
        Tue,  8 Jul 2014 16:51:31 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 7/8] MIPS: BCM63XX: remove !RUNTIME_DETECT in cpu-feature-overrides
Date:   Tue,  8 Jul 2014 16:53:23 +0200
Message-Id: <1404831204-30659-8-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
References: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41082
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

All three SoCs have in common they have a BMIPS32/BMIPS3300 CPU, so
we can replace this as no SoC with BMIPS4350 support enabled.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
index e9c408e..bc1167d 100644
--- a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
@@ -24,7 +24,7 @@
 #define cpu_has_smartmips		0
 #define cpu_has_vtag_icache		0
 
-#if !defined(BCMCPU_RUNTIME_DETECT) && (defined(CONFIG_BCM63XX_CPU_6348) || defined(CONFIG_BCM63XX_CPU_6345) || defined(CONFIG_BCM63XX_CPU_6338))
+#if !defined(CONFIG_SYS_HAS_CPU_BMIPS4350)
 #define cpu_has_dc_aliases		0
 #endif
 
-- 
2.0.0
