Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2017 14:56:19 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:55090 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990557AbdDYM4MW75pd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Apr 2017 14:56:12 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1d300s-0007QO-00; Tue, 25 Apr 2017 14:56:14 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 865FB508DA7; Tue, 25 Apr 2017 14:55:47 +0200 (CEST)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:   Tue, 25 Apr 2017 14:30:07 +0200
Subject: [PATCH] Fix returns of some CLK API calls, if !CONFIG_HAVE_CLOCK
To:     linux@armlinux.org.uk, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org
Message-Id: <20170425125547.865FB508DA7@solo.franken.de>
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

If CONFIG_HAVE_CLOCK is not set, return values of clk_get(),
devm_clk_get(), devm_get_clk_from_child(), clk_get_parent()
and clk_get_sys() are wrong. According to spec these functions
should either return a pointer to a struct clk or a valid IS_ERR
condition. NULL is neither, so returning ERR_PTR(-ENODEV) makes
more sense.

Without this change serial console on SNI RM400 machines (MIPS arch)
is broken, because sccnxp driver doesn't get a valid clock rate.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 include/linux/clk.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index e9d36b3..b844a65 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -442,18 +442,18 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id);
 
 static inline struct clk *clk_get(struct device *dev, const char *id)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline struct clk *devm_get_clk_from_child(struct device *dev,
 				struct device_node *np, const char *con_id)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline void clk_put(struct clk *clk) {}
@@ -494,12 +494,12 @@ static inline int clk_set_parent(struct clk *clk, struct clk *parent)
 
 static inline struct clk *clk_get_parent(struct clk *clk)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 #endif
 
-- 
2.1.4
