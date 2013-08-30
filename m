Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Aug 2013 16:58:24 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:37429 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827336Ab3H3OzWa1GE4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Aug 2013 16:55:22 +0200
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MSC004XNMRXSZK0@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Fri, 30 Aug 2013 23:55:18 +0900 (KST)
X-AuditID: cbfee61b-b7f776d0000016c8-46-5220b255bf82
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm2.samsung.com (EPCPMTA) with SMTP id 10.2A.05832.552B0225; Fri,
 30 Aug 2013 23:55:18 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MSC00KB2MP05U90@mmp1.samsung.com>; Fri,
 30 Aug 2013 23:55:17 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, t.figa@samsung.com,
        g.liakhovetski@gmx.de, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v6 4/5] clk: Assign module owner of a clock being registered
Date:   Fri, 30 Aug 2013 16:53:21 +0200
Message-id: <1377874402-2944-5-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
In-reply-to: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsVy+t9jAd2wTQpBBvcjLN5vnMdk0fOn0uJs
        0xt2i86JS9gtNj2+xmpxedccNosJUyexW8z5M4XZ4vZlXounEy6yWdxuXMFmcfhNO6vF+hmv
        WRx4PVqae9g8PnyM85jdMZPV4861PWweR1euZfLYvKTeY/fXJkaPvi2rGD0+b5IL4IzisklJ
        zcksSy3St0vgypj94hZ7wSrOilVzfrM1MF5g72Lk5JAQMJH4efsjK4QtJnHh3nq2LkYuDiGB
        RYwSz9Z0MkM4HUwSc/vmgnWwCRhK9B7tYwSxRQQ0JKZ0PWYHKWIWuMwkselLF1iRsICPxNqW
        V2wgNouAqsTXWa+YQGxeAVeJg59nA8U5gNYpSMyZZAMS5hRwk7gwbT1YuRBQyZwTqxgnMPIu
        YGRYxSiaWpBcUJyUnmukV5yYW1yal66XnJ+7iREcsM+kdzCuarA4xCjAwajEw7tzuUKQEGti
        WXFl7iFGCQ5mJRHej4uBQrwpiZVVqUX58UWlOanFhxilOViUxHkPtloHCgmkJ5akZqemFqQW
        wWSZODilGhgd5jUwHLWeXvOf+97H74q1Dhta1000/5K6dd7c1VP/FSrb2W50+zaJOcvyXdvx
        5SenrBE/NCvbQ+o4w8qaZTJCHlMLEmtPcDg+cVu0+GlDjlboxttvJR7/3PR7yaSTqj46uSee
        fQj+fVd/avzWZPmz4szfdFTtHH/s6Qg/O2O6wq6PnWrvuLOFlFiKMxINtZiLihMBwx91TFQC        AAA=
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37717
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

Use dev->driver->owner as the owner module of a clock, it ensures
reference on the module is taken in the __clk_get(), __clk_put()
helpers.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes since v5:
 - none.
---
 drivers/clk/clk.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index dcf061a..ac80e13 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1805,6 +1805,10 @@ struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
 	clk->flags = hw->init->flags;
 	clk->parent_names = hw->init->parent_names;
 	clk->num_parents = hw->init->num_parents;
+	if (dev && dev->driver)
+		clk->owner = dev->driver->owner;
+	else
+		clk->owner = NULL;
 
 	ret = __clk_init(dev, clk);
 	if (ret)
@@ -1825,6 +1829,8 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
 		goto fail_name;
 	}
 	clk->ops = hw->init->ops;
+	if (dev && dev->driver)
+		clk->owner = dev->driver->owner;
 	clk->hw = hw;
 	clk->flags = hw->init->flags;
 	clk->num_parents = hw->init->num_parents;
-- 
1.7.9.5
