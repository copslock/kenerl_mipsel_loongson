Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 00:31:13 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:60253 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006992AbbBYXbLojb2s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 00:31:11 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id AD8CD56F7C0;
        Thu, 26 Feb 2015 01:31:11 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id jLlTAoCkgANr; Thu, 26 Feb 2015 01:31:06 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id B5CB85BC017;
        Thu, 26 Feb 2015 01:31:06 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: mark prom_free_prom_memory() everywhere with __init
Date:   Thu, 26 Feb 2015 01:31:04 +0200
Message-Id: <1424907064-31621-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45980
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

Mark prom_free_prom_memory with() everywhere with __init.

On OCTEON the function is non-trivial and we can potentially even
save some memory.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/setup.c  | 2 +-
 arch/mips/lantiq/prom.c          | 2 +-
 arch/mips/mti-sead3/sead3-init.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a42110e..d0fa0bc 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1043,7 +1043,7 @@ int prom_putchar(char c)
 }
 EXPORT_SYMBOL(prom_putchar);
 
-void prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
 	if (CAVIUM_OCTEON_DCACHE_PREFETCH_WAR) {
 		/* Check for presence of Core-14449 fix.  */
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 39ab3e7..0db099e 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -41,7 +41,7 @@ int ltq_soc_type(void)
 	return soc_info.type;
 }
 
-void prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
 }
 
diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
index bfbd17b..3572ea3 100644
--- a/arch/mips/mti-sead3/sead3-init.c
+++ b/arch/mips/mti-sead3/sead3-init.c
@@ -147,6 +147,6 @@ void __init prom_init(void)
 #endif
 }
 
-void prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
 }
-- 
2.2.0
