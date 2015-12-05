Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Dec 2015 07:19:13 +0100 (CET)
Received: from conuserg009.nifty.com ([202.248.44.35]:42922 "EHLO
        conuserg009-v.nifty.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006555AbbLEGTL2sFCB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Dec 2015 07:19:11 +0100
Received: from grover.sesame (FL1-203-136-65-164.osk.mesh.ad.jp [203.136.65.164]) (authenticated)
        by conuserg009-v.nifty.com with ESMTP id tB56HwRs021501;
        Sat, 5 Dec 2015 15:18:01 +0900
X-Nifty-SrcIP: [203.136.65.164]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-clk@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Ryan Mallon <rmallon@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        adi-buildroot-devel@lists.sourceforge.net,
        Russell King <linux@arm.linux.org.uk>,
        linux-m68k@lists.linux-m68k.org, Roland Stigge <stigge@antcom.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH] clk: let clk_disable() return immediately if clk is NULL or error
Date:   Sat,  5 Dec 2015 15:17:56 +0900
Message-Id: <1449296276-32208-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

The clk_disable() in the common clock framework (drivers/clk/clk.c)
returns immediately if the given clk is NULL or an error pointer.
It allows drivers to call clk_disable() (and clk_disable_unprepare())
with a clock that might be NULL or an error pointer as long as the
drivers are only used along with the common clock framework.

Unfortunately, NULL/error checking is missing from some of non-common
clk_disable() implementations.  This prevents us from completely
dropping NULL/error from callers.  Let's add IS_ERR_OR_NULL(clk)
checks to all callees.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-ep93xx/clock.c     |  2 +-
 arch/arm/mach-lpc32xx/clock.c    |  3 +++
 arch/arm/mach-mmp/clock.c        |  3 +++
 arch/arm/mach-sa1100/clock.c     | 15 ++++++++-------
 arch/arm/mach-w90x900/clock.c    |  3 +++
 arch/blackfin/mach-bf609/clock.c |  3 +++
 arch/m68k/coldfire/clk.c         |  4 ++++
 arch/mips/bcm63xx/clk.c          |  3 +++
 arch/mips/lantiq/clk.c           |  3 +++
 drivers/sh/clk/core.c            |  2 +-
 10 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 39ef3b6..4e11f7d 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -293,7 +293,7 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
-	if (!clk)
+	if (IS_ERR_OR_NULL(clk))
 		return;
 
 	spin_lock_irqsave(&clk_lock, flags);
diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 661c8f4..07faac2 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -1125,6 +1125,9 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	spin_lock_irqsave(&global_clkregs_lock, flags);
 	local_clk_disable(clk);
 	spin_unlock_irqrestore(&global_clkregs_lock, flags);
diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
index 7c6f95f..7b33122 100644
--- a/arch/arm/mach-mmp/clock.c
+++ b/arch/arm/mach-mmp/clock.c
@@ -67,6 +67,9 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	WARN_ON(clk->enabled == 0);
 
 	spin_lock_irqsave(&clocks_lock, flags);
diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index cbf53bb..ea103fd 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -85,13 +85,14 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
-	if (clk) {
-		WARN_ON(clk->enabled == 0);
-		spin_lock_irqsave(&clocks_lock, flags);
-		if (--clk->enabled == 0)
-			clk->ops->disable(clk);
-		spin_unlock_irqrestore(&clocks_lock, flags);
-	}
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
+	WARN_ON(clk->enabled == 0);
+	spin_lock_irqsave(&clocks_lock, flags);
+	if (--clk->enabled == 0)
+		clk->ops->disable(clk);
+	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 EXPORT_SYMBOL(clk_disable);
 
diff --git a/arch/arm/mach-w90x900/clock.c b/arch/arm/mach-w90x900/clock.c
index 2c371ff..90ec250 100644
--- a/arch/arm/mach-w90x900/clock.c
+++ b/arch/arm/mach-w90x900/clock.c
@@ -46,6 +46,9 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	WARN_ON(clk->enabled == 0);
 
 	spin_lock_irqsave(&clocks_lock, flags);
diff --git a/arch/blackfin/mach-bf609/clock.c b/arch/blackfin/mach-bf609/clock.c
index 3783058..fed8015 100644
--- a/arch/blackfin/mach-bf609/clock.c
+++ b/arch/blackfin/mach-bf609/clock.c
@@ -97,6 +97,9 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	if (clk->ops && clk->ops->disable)
 		clk->ops->disable(clk);
 }
diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
index fddfdcc..eb0e8c1 100644
--- a/arch/m68k/coldfire/clk.c
+++ b/arch/m68k/coldfire/clk.c
@@ -101,6 +101,10 @@ EXPORT_SYMBOL(clk_enable);
 void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
+
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	spin_lock_irqsave(&clk_lock, flags);
 	if ((--clk->enabled == 0) && clk->clk_ops)
 		clk->clk_ops->disable(clk);
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 6375652..d6a39bf 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -326,6 +326,9 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	mutex_lock(&clocks_mutex);
 	clk_disable_unlocked(clk);
 	mutex_unlock(&clocks_mutex);
diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index a0706fd..c8d87b1 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -130,6 +130,9 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	if (unlikely(!clk_good(clk)))
 		return;
 
diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index be56b22..3dd20cf 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -252,7 +252,7 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
-	if (!clk)
+	if (IS_ERR_OR_NULL(clk))
 		return;
 
 	spin_lock_irqsave(&clock_lock, flags);
-- 
1.9.1
