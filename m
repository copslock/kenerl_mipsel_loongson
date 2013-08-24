Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Aug 2013 17:22:21 +0200 (CEST)
Received: from mail-ee0-f54.google.com ([74.125.83.54]:42197 "EHLO
        mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826039Ab3HXPVXN8F3z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Aug 2013 17:21:23 +0200
Received: by mail-ee0-f54.google.com with SMTP id e53so815928eek.27
        for <multiple recipients>; Sat, 24 Aug 2013 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FM06hsYPWbrugMm91NQNra3nHyzlm+tFxZ4ha9I+cBg=;
        b=QsLCe3z9Qj0y2dSehJxexl/eUb4pSLtKbOTp3w8mqy5xgo9ZtcOPRyDy7ruMX0F0d1
         0LTiInLHfH2Tqd+nhY1ouLJqgHua3j9cD/oLmVt+mJ83v0ioagEsNgax9TJTAcGekQqq
         6aG+f9nTFg4CVrTZTQ2K8PYBTjS0fqumjsqRaGvGv45Ds9BbPl8SsWxFZ+q5vQA9bXF7
         XQkQGGn+lAFI1uAAJtE8QBzqkwYG6Xf4NGHZH5Lne3VRJve+W9seHU9gsv0YRbYkYcb6
         0KxJ/rEPsMBeY6PPwCeziEpnwlbrwzUfd9ikhynwpRldtQnLN64ywDNAJO3WwA32jB8u
         vX9g==
X-Received: by 10.15.75.73 with SMTP id k49mr8581778eey.36.1377357677896;
        Sat, 24 Aug 2013 08:21:17 -0700 (PDT)
Received: from localhost.localdomain (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id x47sm7415825eea.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 08:21:17 -0700 (PDT)
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, shawn.guo@linaro.org,
        sebastian.hesselbarth@gmail.com, LW@KARO-electronics.de,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, s.nawrocki@samsung.com
Subject: [PATCH v4 4/5] clk: Assign module owner of a clock being registered
Date:   Sat, 24 Aug 2013 17:19:48 +0200
Message-Id: <1377357589-13242-5-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1377357589-13242-1-git-send-email-s.nawrocki@samsung.com>
References: <1377357589-13242-1-git-send-email-s.nawrocki@samsung.com>
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37678
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

Assign module owner of a driver of a device passed to _clk_register()
and __clk_register() functions so the module_{get,put} calls in
__clk_get(), __clk_put() can have required effect.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Initially I had an 'owner' field added to struct clk_init_data so it can
be set explicitly in clock providers.  But this required modifications
of all users of (devm_)clk_register() as struct clk_init_data instance
was in most cases an unitialized stack variable.  This would also require
adding yet another argument to various clk_register_* functions
registering the standard clocks.  So I went for assigning clk->owner from
dev->driver->owner.  The disadvantages are that dereferencing dev->driver
may be potentially unsafe when not holding struct device::mutex.  And
there might be cases where clk->owner will need to be NULL.  One option
is to set dev argument of clk_register_*() to NULL for that, but it
predates devm_*.

Presumably a requirement could be added that callers of clk_register*()
must ensure dev->driver won't change during a call to these functions ?
---
 drivers/clk/clk.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8ccc1cd..cf5765a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1799,6 +1799,10 @@ struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
 	clk->flags = hw->init->flags;
 	clk->parent_names = hw->init->parent_names;
 	clk->num_parents = hw->init->num_parents;
+	if (dev && dev->driver)
+		clk->owner = dev->driver->owner;
+	else
+		clk->owner = NULL;
 
 	ret = __clk_init(dev, clk);
 	if (ret)
@@ -1819,6 +1823,8 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
 		goto fail_name;
 	}
 	clk->ops = hw->init->ops;
+	if (dev && dev->driver)
+		clk->owner = dev->driver->owner;
 	clk->hw = hw;
 	clk->flags = hw->init->flags;
 	clk->num_parents = hw->init->num_parents;
-- 
1.7.4.1
