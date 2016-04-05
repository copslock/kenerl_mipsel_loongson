Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2016 03:52:38 +0200 (CEST)
Received: from conuserg-12.nifty.com ([210.131.2.79]:47491 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014043AbcDEBwdYu90Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Apr 2016 03:52:33 +0200
Received: from beagle.diag.org (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id u351p6f6010253;
        Tue, 5 Apr 2016 10:51:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com u351p6f6010253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1459821071;
        bh=UwBoRhALPeWj3ZjMBY+lFGw7ixCTor699j38hlub/tE=;
        h=From:To:Cc:Subject:Date:From;
        b=oqS8RNYy4b5zlP3OWseNVa3SgHk2Y2NS1LwFz71MKj/IO/TPcMCO3xfG5HmYtPohq
         8hhM1r435M0V+mGAcOgdMM2H13pG5ibd6Rt18hc4EiegFG6pfDgbfvfZaxFVFHUVd6
         3kFiZI23T/ytobBOSttmo+jg1ibFBZ+Bj9jYRzgl0fz97nqIzTplRwIziHEErH9y0f
         ol50+4zqmjE6FvuM9DJ8QgMZhSO0EANc0cClYm23rmZ/ohdCn1W9UzO3+9AT9nExps
         0sB35GG4Rha3za7BJ/YOBOvATmobVGVQ2IUAmO1ETBqQNaL0OBkVnWLi8CjHlzABkL
         I/9v+sW3kcoNA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-clk@vger.kernel.org
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        adi-buildroot-devel@lists.sourceforge.net,
        Russell King <linux@arm.linux.org.uk>,
        linux-m68k@lists.linux-m68k.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH v2] clk: let clk_disable() return immediately if clk is NULL or error
Date:   Tue,  5 Apr 2016 10:51:23 +0900
Message-Id: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52886
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
returns immediately if a given clk is NULL or an error pointer.  It
allows clock consumers to call clk_disable() without IS_ERR_OR_NULL
checking if drivers are only used with the common clock framework.

Unfortunately, NULL/error checking is missing from some of non-common
clk_disable() implementations.  This prevents us from completely
dropping NULL/error checking from callers.  Let's make it tree-wide
consistent by adding IS_ERR_OR_NULL(clk) to all callees.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Greg Ungerer <gerg@uclinux.org>
Acked-by: Wan Zongshun <mcuos.com@gmail.com>
---

Stephen,

This patch has been unapplied for a long time.

Please let me know if there is something wrong with this patch.

Thanks,


Changes in v2:
  - Rebase on Linux 4.6-rc1

 arch/arm/mach-ep93xx/clock.c     |  2 +-
 arch/arm/mach-mmp/clock.c        |  3 +++
 arch/arm/mach-sa1100/clock.c     | 15 ++++++++-------
 arch/arm/mach-w90x900/clock.c    |  3 +++
 arch/blackfin/mach-bf609/clock.c |  3 +++
 arch/m68k/coldfire/clk.c         |  4 ++++
 arch/mips/bcm63xx/clk.c          |  3 +++
 arch/mips/lantiq/clk.c           |  3 +++
 drivers/sh/clk/core.c            |  2 +-
 9 files changed, 29 insertions(+), 9 deletions(-)

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
diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
index ac6633d..39ad3896 100644
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
index 92863e3..9978fa4 100644
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
