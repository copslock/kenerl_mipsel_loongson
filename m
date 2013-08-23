Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 17:05:33 +0200 (CEST)
Received: from mailout1.samsung.com ([203.254.224.24]:53903 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815748Ab3HWPFIun5Gd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Aug 2013 17:05:08 +0200
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRZ00IADOKCLPU0@mailout1.samsung.com>; Sat,
 24 Aug 2013 00:05:00 +0900 (KST)
X-AuditID: cbfee61b-b7f776d0000016c8-b4-52177a1b3077
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm2.samsung.com (EPCPMTA) with SMTP id 01.3C.05832.B1A77125; Sat,
 24 Aug 2013 00:05:00 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MRZ00M18OIHS210@mmp1.samsung.com>; Sat,
 24 Aug 2013 00:04:59 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, shawn.guo@linaro.org,
        sebastian.hesselbarth@gmail.com, LW@KARO-electronics.de,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 2/5] clkdev: Fix race condition in clock lookup from device
 tree
Date:   Fri, 23 Aug 2013 17:03:44 +0200
Message-id: <1377270227-1030-3-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
In-reply-to: <1377270227-1030-1-git-send-email-s.nawrocki@samsung.com>
References: <1377270227-1030-1-git-send-email-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t9jAV2ZKvEgg9YvPBZTHz5hs3i/cR6T
        Rc+fSouzTW/YLTonLmG32PT4GqvF5V1z2CwmTJ3EbjHnzxRmi9uXeS0OPFnOZvF0wkU2i9uN
        K9gsLu1RsTj8pp3V4v1PR4un65YwW6yf8ZrFYmHDF3aLmxN+MDuIeLQ097B5rJzu7XH5+xtm
        j52z7rJ7fPgY5zG7Yyarx/zpj5g9Nq3qZPO4c20Pm8fRlWuZPDYvqffY/bWJ0aNvyypGj8+b
        5AL4orhsUlJzMstSi/TtErgylk+Zw16wiL9i7t+XjA2MR3m6GDk5JARMJL42L2eFsMUkLtxb
        z9bFyMUhJLCIUaJh8R5GCKeDSeLV9kcsIFVsAoYSvUf7GEFsEQENiSldj9lBipgFelkkpky+
        CVYkLBAqsfDJdCYQm0VAVeJMfwtYA6+Aq8TePbeBajiA1ilIzJlkAxLmFHCTaF5zlgkkLARU
        8neL5gRG3gWMDKsYRVMLkguKk9JzjfSKE3OLS/PS9ZLzczcxgmPkmfQOxlUNFocYBTgYlXh4
        JziLBQmxJpYVV+YeYpTgYFYS4d2ZJx4kxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdgq3WgkEB6
        YklqdmpqQWoRTJaJg1OqgdHshNRVV63fTzY4nd/7fY9ofe0j9hXJJhFsi4XCaut3Ozipz1wv
        MW39mu5VWl9ateMX/d2gpKeeVNQZVPvYrmM2Qzjr9f+PEuedC5Fht3nz37zcurv3XK2m6/Tr
        b05PdlAWFPmU4b3jw54qg3D+HeevOiyWvdmoIPHvqa0j677JyjMZwsSOrFBiKc5INNRiLipO
        BAA9eQ9gjQIAAA==
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: s.nawrocki@samsung.com
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

There is currently a race condition in the device tree part of clk_get()
function, since the pointer returned from of_clk_get_by_name() may become
invalid before __clk_get() call. I.e. due to the clock provider driver
remove() callback being called in between of_clk_get_by_name() and
__clk_get().

Fix this by doing both the look up and __clk_get() operations with the
clock providers list mutex held. This ensures that the clock pointer
returned from __of_clk_get_from_provider() call and passed to __clk_get()
is valid, as long as the clock supplier module first removes its clock
provider instance and then does clk_unregister() on the corresponding
clocks.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Changes since v2:
 - none.

Changes since v1:
 - include "clk.h".
---
 drivers/clk/clkdev.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 442a313..48f6721 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -21,6 +21,8 @@
 #include <linux/clkdev.h>
 #include <linux/of.h>
 
+#include "clk.h"
+
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 
@@ -39,7 +41,13 @@ struct clk *of_clk_get(struct device_node *np, int index)
 	if (rc)
 		return ERR_PTR(rc);
 
-	clk = of_clk_get_from_provider(&clkspec);
+	of_clk_lock();
+	clk = __of_clk_get_from_provider(&clkspec);
+
+	if (!IS_ERR(clk) && !__clk_get(clk))
+		clk = ERR_PTR(-ENOENT);
+
+	of_clk_unlock();
 	of_node_put(clkspec.np);
 	return clk;
 }
@@ -157,7 +165,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 
 	if (dev) {
 		clk = of_clk_get_by_name(dev->of_node, con_id);
-		if (!IS_ERR(clk) && __clk_get(clk))
+		if (!IS_ERR(clk))
 			return clk;
 	}
 
-- 
1.7.9.5
