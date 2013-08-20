Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Aug 2013 19:36:37 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:27349 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6836943Ab3HTRgZBE65T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Aug 2013 19:36:25 +0200
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRU009ESBK92DO0@mailout2.samsung.com>; Wed,
 21 Aug 2013 02:36:09 +0900 (KST)
X-AuditID: cbfee61b-b7efe6d000007b11-f2-5213a908aa32
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2.samsung.com (EPCPMTA)
 with SMTP id 88.88.31505.809A3125; Wed, 21 Aug 2013 02:36:09 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MRU005WMBHD9970@mmp2.samsung.com>; Wed,
 21 Aug 2013 02:36:08 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, robherring2@gmail.com,
        grant.likely@linaro.org, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, kyungmin.park@samsung.com,
        shawn.guo@linaro.org, sebastian.hesselbarth@gmail.com,
        LW@KARO-electronics.de, t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 4/4] clkdev: Fix race condition in clock lookup from device
 tree
Date:   Tue, 20 Aug 2013 19:34:23 +0200
Message-id: <1377020063-30213-5-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
In-reply-to: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com>
References: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsVy+t9jQV3OlcJBBrMPsFlMffiEzeL9xnlM
        Fgf+7GC06PlTaXG26Q27RefEJewWmx5fY7W4vGsOm8WEqZPYLeb8mcJscfsyr8WBJ8vZLJ5O
        uMhmcWmPisX3b9/YLA6/aWe1eP/T0eLpuiXMFutnvGaxWNjwhd3i5oQfzA6iHi3NPWweK6d7
        e1z+/obZY+esu+weHz7GeczumMnqMX/6I2aPTas62TzuXNvD5nF05Vomj81L6j12f21i9Ojb
        sorR4/MmuQC+KC6blNSczLLUIn27BK6MnTflCv7wVfy4cpqpgXE9TxcjJ4eEgInErmuXWSBs
        MYkL99azdTFycQgJTGeUuLm5gRHC6WCSaOpYywhSxSZgKNF7tA/MFhHQkJjS9ZgdpIhZYDGL
        xLbNi5i7GDk4hAVCJY60SYPUsAioShw72ssKYvMKuEl07vnOClIiIaAgMWeSDUiYU8BdYsLJ
        HWAlQkAljybMY53AyLuAkWEVo2hqQXJBcVJ6rpFecWJucWleul5yfu4mRnCsPJPewbiqweIQ
        owAHoxIP74ZC4SAh1sSy4srcQ4wSHMxKIrzbMoBCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQ+2
        WgcKCaQnlqRmp6YWpBbBZJk4OKUaGB1nlBsovNWWU3VpFSqpTU47aHz+iEbGG8/rdmccnp3O
        5Z7xyeChe1/EpYS3dnMD89rL9bwKFS41Wj4zETzOsfhb23fG7UuurcrpXxDTUtYpwL5zVuHn
        7yKJsvbdR8/82qZ55NnE5sYf1tqcvGWnYux8D+1jWG06zcY1meuJx49S0yIBdwEnJZbijERD
        Leai4kQAgiMggZECAAA=
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37598
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
Reviewed-by: Mike Turquette <mturquette@linaro.org>
---
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
