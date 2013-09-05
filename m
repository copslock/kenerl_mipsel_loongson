Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2013 20:46:25 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:45364 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837145Ab3IESpnqJJLY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Sep 2013 20:45:43 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id A1B0321B888;
        Thu,  5 Sep 2013 21:45:41 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id 4PdsoJbNSZL1; Thu,  5 Sep 2013 21:45:36 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with ESMTP id A7B015BC009;
        Thu,  5 Sep 2013 21:45:36 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, richard@nod.at,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/3] staging: octeon-ethernet: remove skb alloc failure warnings
Date:   Thu,  5 Sep 2013 21:44:00 +0300
Message-Id: <1378406641-16530-3-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1378406641-16530-1-git-send-email-aaro.koskinen@iki.fi>
References: <1378406641-16530-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37767
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

Remove skb allocation failure warnings. They will trigger a page
allocation warning already. Also, one of the warnings was not ratelimited,
causing the box to lock up under heavy traffic & low memory.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon/ethernet-mem.c | 7 +------
 drivers/staging/octeon/ethernet-rx.c  | 3 ---
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mem.c b/drivers/staging/octeon/ethernet-mem.c
index 78b6cb7..199059d 100644
--- a/drivers/staging/octeon/ethernet-mem.c
+++ b/drivers/staging/octeon/ethernet-mem.c
@@ -48,13 +48,8 @@ static int cvm_oct_fill_hw_skbuff(int pool, int size, int elements)
 	while (freed) {
 
 		struct sk_buff *skb = dev_alloc_skb(size + 256);
-		if (unlikely(skb == NULL)) {
-			pr_warning
-			    ("Failed to allocate skb for hardware pool %d\n",
-			     pool);
+		if (unlikely(skb == NULL))
 			break;
-		}
-
 		skb_reserve(skb, 256 - (((unsigned long)skb->data) & 0x7f));
 		*(struct sk_buff **)(skb->data - sizeof(void *)) = skb;
 		cvmx_fpa_free(skb->data, pool, DONT_WRITEBACK(size / 128));
diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 10e5416..e14a1bb 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -337,9 +337,6 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 			 */
 			skb = dev_alloc_skb(work->len);
 			if (!skb) {
-				printk_ratelimited("Port %d failed to allocate "
-						   "skbuff, packet dropped\n",
-						   work->ipprt);
 				cvm_oct_free_work(work);
 				continue;
 			}
-- 
1.8.3.2
