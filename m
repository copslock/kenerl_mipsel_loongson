Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Apr 2013 17:28:56 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:50187 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835406Ab3DZP2rWGzzq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Apr 2013 17:28:47 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LuzbG_HnQv5z; Fri, 26 Apr 2013 17:27:49 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id F04DE28065A;
        Fri, 26 Apr 2013 17:27:47 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: ralink: add missing define for RT3883_GPIO_11
Date:   Fri, 26 Apr 2013 17:29:00 +0200
Message-Id: <1366990140-23596-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

The RT3883_GPIO_11 symbol is not declared anywhere and
this causes the following error:

  CC      arch/mips/ralink/rt3883.o
arch/mips/ralink/rt3883.c:101:17: error: 'RT3883_GPIO_11' undeclared here (not in a function)
make[6]: *** [arch/mips/ralink/rt3883.o] Error 1

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
John,

The error is introduced by the following change:
'MIPS: ralink: adds support for RT3883 SoC family'
in the mips-next-3.10 branch of your tree at lmo.

This change should be folded into that commit if
possible.

Regards,
Gabor
---
 arch/mips/include/asm/mach-ralink/rt3883.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/mach-ralink/rt3883.h b/arch/mips/include/asm/mach-ralink/rt3883.h
index e58e06f..058382f 100644
--- a/arch/mips/include/asm/mach-ralink/rt3883.h
+++ b/arch/mips/include/asm/mach-ralink/rt3883.h
@@ -152,6 +152,7 @@
 #define RT3883_GPIO_SPI_MISO		6
 #define RT3883_GPIO_7			7
 #define RT3883_GPIO_10			10
+#define RT3883_GPIO_11			11
 #define RT3883_GPIO_14			14
 #define RT3883_GPIO_UART1_TXD		15
 #define RT3883_GPIO_UART1_RXD		16
-- 
1.7.10
