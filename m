Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Mar 2014 20:55:54 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:40758 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6818667AbaCYTzuysy99 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Mar 2014 20:55:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 14EB919BFFA;
        Tue, 25 Mar 2014 21:55:49 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id 53zacKWy7F4e; Tue, 25 Mar 2014 21:55:44 +0200 (EET)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 0AFCB5BC003;
        Tue, 25 Mar 2014 21:55:44 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, stable@vger.kernel.org
Subject: [PATCH] MIPS: OCTEON: fix EARLY_PRINTK_8250 build failure
Date:   Tue, 25 Mar 2014 21:58:45 +0200
Message-Id: <1395777525-28910-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.9.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Enabling EARLY_PRINTK_8250 breaks OCTEON builds because of multiple
prom_putchar() implementations. OCTEON provides its own prom_putchar()
(also used by the watchdog driver), so we should prevent user from
selecting EARLY_PRINTK_8250 on OCTEON.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: stable@vger.kernel.org
---
 arch/mips/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index b147e70..b27e65886 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -22,7 +22,7 @@ config EARLY_PRINTK
 
 config EARLY_PRINTK_8250
 	bool "8250/16550 and compatible serial early printk driver"
-	depends on EARLY_PRINTK
+	depends on EARLY_PRINTK && !CAVIUM_OCTEON_SOC
 	default n
 	help
 	  If you say Y here, it will be possible to use a 8250/16550 serial
-- 
1.9.0
