Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 18:26:47 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:53280 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011947AbbILQ0iqOYei (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Sep 2015 18:26:38 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 2721528C088;
        Sat, 12 Sep 2015 18:25:23 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-016-160.088.073.pools.vodafone-ip.de [88.73.16.160])
        by arrakis.dune.hu (Postfix) with ESMTPSA id D957828C12D;
        Sat, 12 Sep 2015 18:25:16 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>
Subject: [PATCH 1/3] MIPS: use USE_OF as the guard for appended dtb
Date:   Sat, 12 Sep 2015 18:26:12 +0200
Message-Id: <1442075174-30414-2-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1442075174-30414-1-git-send-email-jogo@openwrt.org>
References: <1442075174-30414-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49173
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

Since OF is now a user selectable symbol, the choice for appended dtb
support should only be visible when USE_OF is selected, as this
indicates actual machine support for device tree in MIPS.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 752acca..10fcd93 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2684,7 +2684,7 @@ config BUILTIN_DTB
 	bool
 
 choice
-	prompt "Kernel appended dtb support" if OF
+	prompt "Kernel appended dtb support" if USE_OF
 	default MIPS_NO_APPENDED_DTB
 
 	config MIPS_NO_APPENDED_DTB
-- 
2.1.4
