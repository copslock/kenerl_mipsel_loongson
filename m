Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 14:16:06 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35631 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867278Ab3LRNOE3XhDi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 14:14:04 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id E008A28A921;
        Wed, 18 Dec 2013 14:11:46 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 39F1E28026E;
        Wed, 18 Dec 2013 14:11:43 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH V2 06/13] MIPS: BMIPS: select CPU_HAS_PREFETCH
Date:   Wed, 18 Dec 2013 14:12:04 +0100
Message-Id: <1387372331-23474-7-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
References: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38739
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

As they are MIPS32 CPUs they do support the prefetch opcode.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bf741b2..9bdf11b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1392,6 +1392,7 @@ config CPU_BMIPS
 	select SWAP_IO_SPACE
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
+	select CPU_HAS_PREFETCH
 	help
 	  Support for BMIPS3300/4350/4380 and BMIPS5000 processors.
 
-- 
1.8.5.1
