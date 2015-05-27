Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 19:50:09 +0200 (CEST)
Received: from mail.o-t.ch ([217.197.209.32]:41925 "EHLO mail.o-t.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007267AbbE0RuHjiBp9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 May 2015 19:50:07 +0200
Received: from [10.0.2.16] (84-75-126-50.dclient.hispeed.ch [84.75.126.50])
        (Authenticated sender: lf@o-t.ch)
        by mail.o-t.ch (Postfix) with ESMTPSA id A51371803F1;
        Wed, 27 May 2015 19:50:00 +0200 (CEST)
Message-ID: <556603C8.5010502@libres.ch>
Date:   Wed, 27 May 2015 19:50:00 +0200
From:   Laurent Fasnacht <l@libres.ch>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
CC:     trivial@kernel.org
Subject: [PATCH] MIPS: ath79: fix build problem if CONFIG_BLK_DEV_INITRD is
 not set
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <l@libres.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: l@libres.ch
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

initrd_start is defined in init/do_mounts_initrd.c, which is only
included in kernel if CONFIG_BLK_DEV_INITRD=y.

Signed-off-by: Laurent Fasnacht <l@libres.ch>
---
 arch/mips/ath79/prom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/ath79/prom.c b/arch/mips/ath79/prom.c
index e1fe630..597899a 100644
--- a/arch/mips/ath79/prom.c
+++ b/arch/mips/ath79/prom.c
@@ -1,6 +1,7 @@
 /*
  *  Atheros AR71XX/AR724X/AR913X specific prom routines
  *
+ *  Copyright (C) 2015 Laurent Fasnacht <l@libres.ch>
  *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
@@ -25,12 +26,14 @@ void __init prom_init(void)
 {
 	fw_init_cmdline();
 +#ifdef CONFIG_BLK_DEV_INITRD
 	/* Read the initrd address from the firmware environment */
 	initrd_start = fw_getenvl("initrd_start");
 	if (initrd_start) {
 		initrd_start = KSEG0ADDR(initrd_start);
 		initrd_end = initrd_start + fw_getenvl("initrd_size");
 	}
+#endif
 }
  void __init prom_free_prom_memory(void)
-- 
2.0.4
