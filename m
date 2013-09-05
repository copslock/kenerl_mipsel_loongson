Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2013 20:45:44 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:37640 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822664Ab3IESpmXIjDP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Sep 2013 20:45:42 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 723995A6D43;
        Thu,  5 Sep 2013 21:45:41 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id UlVLQSt4kFWe; Thu,  5 Sep 2013 21:45:36 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with ESMTP id 858205BC008;
        Thu,  5 Sep 2013 21:45:36 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, richard@nod.at,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/3] staging: octeon-ethernet: make dropped packets to consume NAPI budget
Date:   Thu,  5 Sep 2013 21:43:59 +0300
Message-Id: <1378406641-16530-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1378406641-16530-1-git-send-email-aaro.koskinen@iki.fi>
References: <1378406641-16530-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37765
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

We should count also dropped packets, otherwise the NAPI handler may
end up running too long.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon/ethernet-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 34afc16..10e5416 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -303,6 +303,7 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 			if (backlog > budget * cores_in_use && napi != NULL)
 				cvm_oct_enable_one_cpu();
 		}
+		rx_count++;
 
 		skb_in_hw = USE_SKBUFFS_IN_HW && work->word2.s.bufs == 1;
 		if (likely(skb_in_hw)) {
@@ -429,7 +430,6 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 #endif
 				}
 				netif_receive_skb(skb);
-				rx_count++;
 			} else {
 				/* Drop any packet received for a device that isn't up */
 				/*
-- 
1.8.3.2
