Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Oct 2013 20:52:23 +0100 (CET)
Received: from mailout1.samsung.com ([203.254.224.24]:21633 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817537Ab3J2TwTV5rF1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Oct 2013 20:52:19 +0100
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MVG00GTT4IYYNR0@mailout1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 30 Oct 2013 04:52:10 +0900 (KST)
X-AuditID: cbfee61a-b7f836d0000025d7-59-527011ea812b
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm1.samsung.com (EPCPMTA) with SMTP id 01.32.09687.AE110725; Wed,
 30 Oct 2013 04:52:10 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MVG00CM84HJ3H10@mmp1.samsung.com>; Wed,
 30 Oct 2013 04:52:10 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, mturquette@linaro.org
Cc:     linux@arm.linux.org.uk, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v7 1/5] omap3isp: Modify clocks registration to avoid circular
 references
Date:   Tue, 29 Oct 2013 20:51:04 +0100
Message-id: <1383076268-8984-2-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
In-reply-to: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsVy+t9jAd1XggVBBssPKVj0/Km0ONv0ht2i
        c+ISdotNj6+xWlzeNYfNYsLUSewWc/5MYba4fZnX4umEi2wWh9+0s1osbPjC7sDt0dLcw+ax
        crq3x+yOmawed67tYfM4unItk8fmJfUeu782MXr0bVnF6PF5k1wAZxSXTUpqTmZZapG+XQJX
        xrY7+1kKGiQqHs4KaGC8KNzFyMkhIWAi8eLNeiYIW0ziwr31bF2MXBxCAosYJR60/INyOpgk
        tn3fA1bFJmAo0Xu0jxHEFhGwl/gx4SULSBGzwDwmiTkfDrCBJIQFoiUO7NsFZrMIqEoce3Wd
        HcTmFXCV2PVzMlADB9A6BYk5k2xATE4BN4n9i0VBKoSAKk7dusw8gZF3ASPDKkbR1ILkguKk
        9FxDveLE3OLSvHS95PzcTYzg0HwmtYNxZYPFIUYBDkYlHl6DB/lBQqyJZcWVuYcYJTiYlUR4
        px8HCvGmJFZWpRblxxeV5qQWH2KU5mBREuc90GodKCSQnliSmp2aWpBaBJNl4uCUamB0sHz1
        5uSKP1O9Uw1dWI595ZwuWtzakuKjKN3at9LJ8u3Kju1pX3d4ut3g/yj138eyMWRT6JZrtoLe
        PNySTC+5MuuXLvuuff1/+2qmk2bHP8/bdsnvcP7jgIIHNb6LO2Til93JtFxynt/VT2JG9iMD
        v6Z/K9lP1a3u/hwmInf5z/tFL7128XEpsRRnJBpqMRcVJwIAZpMGvkkCAAA=
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38402
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

The clock core code is going to be modified so clk_get() takes
reference on the clock provider module. Until the potential circular
reference issue is properly addressed, we pass NULL as as the first
argument to clk_register(), in order to disallow sub-devices taking
a reference on the ISP module back trough clk_get(). This should
prevent locking the modules in memory.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
This patch has been "compile tested" only.

---
 drivers/media/platform/omap3isp/isp.c |   22 ++++++++++++++++------
 drivers/media/platform/omap3isp/isp.h |    1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index df3a0ec..286027a 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -290,9 +290,11 @@ static int isp_xclk_init(struct isp_device *isp)
 	struct clk_init_data init;
 	unsigned int i;

+	for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i)
+		isp->xclks[i].clk = ERR_PTR(-EINVAL);
+
 	for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i) {
 		struct isp_xclk *xclk = &isp->xclks[i];
-		struct clk *clk;

 		xclk->isp = isp;
 		xclk->id = i == 0 ? ISP_XCLK_A : ISP_XCLK_B;
@@ -305,10 +307,15 @@ static int isp_xclk_init(struct isp_device *isp)
 		init.num_parents = 1;

 		xclk->hw.init = &init;
-
-		clk = devm_clk_register(isp->dev, &xclk->hw);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
+		/*
+		 * The first argument is NULL in order to avoid circular
+		 * reference, as this driver takes reference on the
+		 * sensor subdevice modules and the sensors would take
+		 * reference on this module through clk_get().
+		 */
+		xclk->clk = clk_register(NULL, &xclk->hw);
+		if (IS_ERR(xclk->clk))
+			return PTR_ERR(xclk->clk);

 		if (pdata->xclks[i].con_id == NULL &&
 		    pdata->xclks[i].dev_id == NULL)
@@ -320,7 +327,7 @@ static int isp_xclk_init(struct isp_device *isp)

 		xclk->lookup->con_id = pdata->xclks[i].con_id;
 		xclk->lookup->dev_id = pdata->xclks[i].dev_id;
-		xclk->lookup->clk = clk;
+		xclk->lookup->clk = xclk->clk;

 		clkdev_add(xclk->lookup);
 	}
@@ -335,6 +342,9 @@ static void isp_xclk_cleanup(struct isp_device *isp)
 	for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i) {
 		struct isp_xclk *xclk = &isp->xclks[i];

+		if (!IS_ERR(xclk->clk))
+			clk_unregister(xclk->clk);
+
 		if (xclk->lookup)
 			clkdev_drop(xclk->lookup);
 	}
diff --git a/drivers/media/platform/omap3isp/isp.h b/drivers/media/platform/omap3isp/isp.h
index cd3eff4..1498f2b 100644
--- a/drivers/media/platform/omap3isp/isp.h
+++ b/drivers/media/platform/omap3isp/isp.h
@@ -135,6 +135,7 @@ struct isp_xclk {
 	struct isp_device *isp;
 	struct clk_hw hw;
 	struct clk_lookup *lookup;
+	struct clk *clk;
 	enum isp_xclk_id id;

 	spinlock_t lock;	/* Protects enabled and divider */
--
1.7.9.5
