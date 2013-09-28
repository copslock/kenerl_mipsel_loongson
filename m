Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2013 21:51:02 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:40789 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6820116Ab3I1TvAW2aXV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Sep 2013 21:51:00 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id C691E19BD68;
        Sat, 28 Sep 2013 22:50:57 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id vXkvRDi0pPls; Sat, 28 Sep 2013 22:50:52 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with ESMTP id BFD485BC003;
        Sat, 28 Sep 2013 22:50:52 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Daney <david.daney@cavium.com>
Cc:     richard@nod.at, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/2] staging: octeon-ethernet: allow to use only 1 CPU for packet processing
Date:   Sat, 28 Sep 2013 22:50:34 +0300
Message-Id: <1380397834-14286-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi>
References: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38051
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

Module parameter max_rx_cpus has off-by-one error. Fix that.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon/ethernet-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index de831c1..fe1ee49 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -513,7 +513,7 @@ void cvm_oct_rx_initialize(void)
 	if (NULL == dev_for_napi)
 		panic("No net_devices were allocated.");
 
-	if (max_rx_cpus > 1  && max_rx_cpus < num_online_cpus())
+	if (max_rx_cpus >= 1 && max_rx_cpus < num_online_cpus())
 		atomic_set(&core_state.available_cores, max_rx_cpus);
 	else
 		atomic_set(&core_state.available_cores, num_online_cpus());
-- 
1.8.4.rc3
