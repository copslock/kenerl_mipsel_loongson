Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Aug 2013 16:56:04 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:44969 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6826530Ab3H3OyV4e9sl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Aug 2013 16:54:21 +0200
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MSC002TJMQ4N5M0@mailout3.samsung.com> for
 linux-mips@linux-mips.org; Fri, 30 Aug 2013 23:54:16 +0900 (KST)
X-AuditID: cbfee61a-b7f7a6d00000235f-06-5220b218c2e9
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm1.samsung.com (EPCPMTA) with SMTP id 48.1F.09055.812B0225; Fri,
 30 Aug 2013 23:54:16 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MSC00KB2MP05U90@mmp1.samsung.com>; Fri,
 30 Aug 2013 23:54:16 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, t.figa@samsung.com,
        g.liakhovetski@gmx.de, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v6 2/5] clkdev: Fix race condition in clock lookup from device
 tree
Date:   Fri, 30 Aug 2013 16:53:19 +0200
Message-id: <1377874402-2944-3-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
In-reply-to: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsVy+t9jAV2JTQpBBtcnmlq83ziPyaLnT6XF
        2aY37BadE5ewW2x6fI3V4vKuOWwWE6ZOYreY82cKs8Xty7wWTydcZLO43biCzeLwm3ZWi/Uz
        XrM48Hq0NPeweXz4GOcxu2Mmq8eda3vYPI6uXMvksXlJvcfur02MHn1bVjF6fN4kF8AZxWWT
        kpqTWZZapG+XwJUx651DwSL+ik+db5kaGI/ydDFyckgImEgcb7vJBGGLSVy4t56ti5GLQ0hg
        EaPEtWWtzBBOB5PElzPzGUGq2AQMJXqP9oHZIgIaElO6HrODFDELXGaS2PSlix0kISwQKnHl
        314wm0VAVeLu4/vMIDavgKvEnNuvWbsYOYDWKUjMmWQDEuYUcJO4MA1kMyfQMqCSE6sYJzDy
        LmBkWMUomlqQXFCclJ5rqFecmFtcmpeul5yfu4kRHLDPpHYwrmywOMQowMGoxMObsFQhSIg1
        say4MvcQowQHs5II78fFQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8B1qtA4UE0hNLUrNTUwtS
        i2CyTBycUg2MknMY6idxyhl+ed1ctXaVzjI3a8ZNS/f98XRhKU+Pt5rHOLn0l+q727UpVzy6
        H5fKRPH3SfDcD/DsYuNnfNiUGWaf9eOn6Ertb0e78v40iZsLn9kwz9/W29FNdUGkjaHuZ+cn
        Oz5obLJrsLhjkrFnCrtwb8eqXayrNv1zaarhkFuvEbB50kIlluKMREMt5qLiRACJFLouVAIA        AA==
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37715
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
