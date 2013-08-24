Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Aug 2013 20:29:28 +0200 (CEST)
Received: from mail-ea0-f182.google.com ([209.85.215.182]:33375 "EHLO
        mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825906Ab3HXS2iorAlM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Aug 2013 20:28:38 +0200
Received: by mail-ea0-f182.google.com with SMTP id o10so845105eaj.41
        for <linux-mips@linux-mips.org>; Sat, 24 Aug 2013 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dtrcORXBig6XUyQAzMMInh8ico4kRBNfaz6/dFsBpKA=;
        b=iQVgeP+qSbcoeLza9JfUDXQKpBx3xchr+O8As04feNf1mbpq0zkT49FS9815pG/c9X
         HDDgfVeJSQU+BdZUlapO5ACrrGg8CeP9pyEtEjEXniddUQ8pDZrss2TfHQzdgV/Ffsvo
         mC4A6piOw9XEjP5w2JtdrzGiTnqf6vlEesDOYn95DaK85qTBeIudokUs3J9p0Mdb6Qns
         yczkBs8DTM4qI+fG5ORjiFp7KyONoNMx1EuiUMJHX30+24bGbL6sK9+2S3eZ+j5WM96c
         3Q0YkcSK2Zxl+BJEVzWS1VKdQM+FkOlGtE/Dt5MJBtlIg7qgaIr91DOvgRXVujMsP+6i
         CYmw==
X-Received: by 10.14.88.65 with SMTP id z41mr9837510eee.38.1377368913400;
        Sat, 24 Aug 2013 11:28:33 -0700 (PDT)
Received: from localhost.localdomain (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id b45sm8446922eef.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 11:28:32 -0700 (PDT)
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, s.nawrocki@samsung.com,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH v5 2/5] clkdev: Fix race condition in clock lookup from device tree
Date:   Sat, 24 Aug 2013 20:27:02 +0200
Message-Id: <1377368825-30715-3-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1377368825-30715-1-git-send-email-s.nawrocki@samsung.com>
References: <1377368825-30715-1-git-send-email-s.nawrocki@samsung.com>
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sylvester.nawrocki@gmail.com
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
Changes since v2:
 - none.

Changes since v1:
 - include "clk.h".
---
 drivers/clk/clkdev.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

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
1.7.4.1
