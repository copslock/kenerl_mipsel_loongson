Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Oct 2013 20:53:57 +0100 (CET)
Received: from mailout1.samsung.com ([203.254.224.24]:21662 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823060Ab3J2TxK7EecW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Oct 2013 20:53:10 +0100
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MVG00KQK4KKSZN0@mailout1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 30 Oct 2013 04:53:08 +0900 (KST)
X-AuditID: cbfee61a-b7f836d0000025d7-9f-5270122440c6
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm1.samsung.com (EPCPMTA) with SMTP id FE.32.09687.42210725; Wed,
 30 Oct 2013 04:53:08 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MVG00CM84HJ3H10@mmp1.samsung.com>; Wed,
 30 Oct 2013 04:53:08 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, mturquette@linaro.org
Cc:     linux@arm.linux.org.uk, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v7 3/5] clkdev: Fix race condition in clock lookup from device
 tree
Date:   Tue, 29 Oct 2013 20:51:06 +0100
Message-id: <1383076268-8984-4-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
In-reply-to: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsVy+t9jAV0VoYIgg0urxS16/lRanG16w27R
        OXEJu8Wmx9dYLS7vmsNmMWHqJHaLOX+mMFvcvsxr8XTCRTaLw2/aWS0WNnxhd+D2aGnuYfNY
        Od3bY3bHTFaPO9f2sHkcXbmWyWPzknqP3V+bGD36tqxi9Pi8SS6AM4rLJiU1J7MstUjfLoEr
        4/ub9UwF1/krbkz9w9TA+JWni5GTQ0LAROLigg/MELaYxIV769m6GLk4hAQWMUoc+L2MCSQh
        JNDBJHHrSCSIzSZgKNF7tI8RxBYRsJf4MeElC0gDs8A8Jok5Hw6wgSSEBUIl5r95C9bMIqAq
        sbBtNiuIzSvgKvHi9U+gGg6gbQoScybZgJicAm4S+xeLQqxylTh16zLzBEbeBYwMqxhFUwuS
        C4qT0nMN9YoTc4tL89L1kvNzNzGCQ/OZ1A7GlQ0WhxgFOBiVeHgNHuQHCbEmlhVX5h5ilOBg
        VhLhnX4cKMSbklhZlVqUH19UmpNafIhRmoNFSZz3QKt1oJBAemJJanZqakFqEUyWiYNTqoFx
        T+XLyoddbcbvHFvW7v/vf0Wnddb/vTvlPJtv9RcmP9pozxKxvHeXm+g2HtbsxSldEzPCNyv+
        Dp3ysVDtg+Gu7f82hs0Jubh+5pl3b154HdNk2pwwxevtVfGzjzW3vpBbZsDTec/q+jRfTzf2
        DNn5H1gudX2XCdqRnuc/LcJisdd/pqPb37ueUmIpzkg01GIuKk4EAB7inslJAgAA
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38404
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
invalid before __clk_get() call. E.g. due to the clock provider driver
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
Reviewed-by: Mike Turquette <mturquette@linaro.org>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Changes since v6:
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
