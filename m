Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 17:55:53 +0200 (CEST)
Received: from mout.kundenserver.de ([217.72.192.73]:57227 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993156AbdIRPzpv3QrW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 17:55:45 +0200
Received: from wuerfel.lan ([95.208.190.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MOlGA-1dnwFQ2CSk-006AWD; Mon, 18 Sep 2017 17:55:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: pmcs-msp71xx: include asm/setup.h
Date:   Mon, 18 Sep 2017 17:55:24 +0200
Message-Id: <20170918155537.1919207-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:2pGUJNJSXYO/jKPJ7ODsAeztkGwH4FP1xmV3XqlPCcK7LusGQYD
 8tP39sixEZ7cLdnpmVgmHsVbzahlIPXdlluw5H5XYkMpv01XzB66NerxV4QVG4I+0KZdyJ/
 SYDh/SpaEcZ/YfFeZ0GaL4heRDR34Uu2uLDPGOl7QgImwNicLeXblIAPDyDmDNQrQMU0sxX
 3fUfpE+sfyexwbJxPLqrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wIdotrWYwME=:1P3sX7tvyMko4fedJbcTAz
 85Jr3Lk5DzBHOocV2CD4pbtuBTtCDMnetWLBVCzVEfNicuRk7Bcm51FixhYMxTjrqPrCdgppf
 AQHyAS6KMQpWnstBofPnj9nElFn9Q44s1FQPsMy0yICoe7fi1mqvj+NSTSVUCHnS7My19q8RL
 74OJyk1UW+QsjSf/v7okKuQbN/ta84TWcLazyaR50DMmeaHps4EzlLNOUoFUPDxq3XoB3xkom
 mYw5PH2+Fx7h8IX0+uJ8RkS+8PZaW9XczMUiPjqedUvt3nN7PxrcGRzdbdSntBL77sMJEx4nx
 pVuCYxwHh3x/GxDYZEMl2qiF5VRmGYoEGGHpwzos1rw6SbzIE+tKJoHsy3IH2ldyiNpexjFgo
 xiK5yRFWmVeQRlMNialwJKTCQfKbRwYuGoVImudmK0X2bicxx/2PcPPKyS9b4XhCDWZADtO7D
 LsfE9nQzDbV483B5IIrnTTIFD8lCdhR3vooEkzbP1vnJyGTQO7d7MUIvum8PvbX+TP+Uj+maV
 jXX2TPlvfZxnLHYUKN2xLHv+I9JmV4vBSN1pAh/zt8I7An19bmmHcyYiNUUYiPqm16TY/9Hcb
 zNLl0LyeIXfamHCfQ7rDCAKSpw9yZOAIqQkrFRL/1iRhDHfPZSZXKOOrt0qJLBNCG7BdO80rJ
 ggYXDFh6JaWs/7J+FAGFJkAhio+PKqnzFFQqBGLSnYx+1+SCRKqYOv79qHGNAwf937Ixh5Qng
 rI1DTJ29VDVNeza+hjpC1ThTZNycyt3/4nBWuA==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

msp71xx_defconfig can not be built at the in v4.14-rc1

arch/mips/pmcs-msp71xx/msp_smp.c:72:2: error: implicit declaration of function 'set_vi_handler' [-Werror=implicit-function-declaration]

I don't know what caused the regression, but including the right
header is the obvious fix.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/pmcs-msp71xx/msp_smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/pmcs-msp71xx/msp_smp.c b/arch/mips/pmcs-msp71xx/msp_smp.c
index ffa0f7101a97..2b08242ade62 100644
--- a/arch/mips/pmcs-msp71xx/msp_smp.c
+++ b/arch/mips/pmcs-msp71xx/msp_smp.c
@@ -22,6 +22,8 @@
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 
+#include <asm/setup.h>
+
 #ifdef CONFIG_MIPS_MT_SMP
 #define MIPS_CPU_IPI_RESCHED_IRQ 0	/* SW int 0 for resched */
 #define MIPS_CPU_IPI_CALL_IRQ 1		/* SW int 1 for call */
-- 
2.9.0
