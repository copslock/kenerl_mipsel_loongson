Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2016 19:28:42 +0200 (CEST)
Received: from conuserg-12.nifty.com ([210.131.2.79]:18966 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbcHXR2e0f-SN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Aug 2016 19:28:34 +0200
Received: from grover.sesame (FL1-119-242-215-193.osk.mesh.ad.jp [119.242.215.193]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id u7OHR1nU023395;
        Thu, 25 Aug 2016 02:27:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com u7OHR1nU023395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1472059625;
        bh=4Yy85OpQGJ8YZusk7u04eMv9UZ4mwlBvVpR4E8GCCk4=;
        h=From:To:Cc:Subject:Date:From;
        b=N7aZcYhf4B5YOVvSMleMje187W7ZRInAEFsdWlzuF9qzjbnmXDv7WNPUrulQ5Th3+
         AGzFrJnjPq29cOYGuaZg7KyTf6fMJ8f0Bpas00hpzyjHcXb8Urt3wb8YuaS5n43ju/
         oKDXSGSoDC6KIgJFJg0PF2oM5LfRmcaznSdDZxN3d9nQmjgav5F+G2WSugHR+HuxO4
         9TBDGKrcq8V7ATyg3iSW/hhP6jIyFQVw+GpHY5dGEIRbC1ocORWtBr+vp0rv5K45c7
         K/CGKuDLozL8nbxh2EDgZANSojFiwtobSe42zf3mEI5jf69RT2Am7Opa+fEiMVC5Ud
         A6POT6GPd8Ckw==
X-Nifty-SrcIP: [119.242.215.193]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-clk@vger.kernel.org
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mips@linux-mips.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        bcm-kernel-feedback-list@broadcom.com,
        Wan ZongShun <mcuos.com@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] clk: let clk_disable() return immediately if clk is NULL
Date:   Thu, 25 Aug 2016 02:26:53 +0900
Message-Id: <1472059613-30551-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54744
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

Many of clk_disable() implementations just return for NULL pointer,
but this check is missing from some.  Let's make it tree-wide
consistent.  It will allow clock consumers to call clk_disable()
without NULL pointer check.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Greg Ungerer <gerg@uclinux.org>
Acked-by: Wan Zongshun <mcuos.com@gmail.com>
---

I came back after a long pause.
You can see the discussion about the previous version:
https://www.linux-mips.org/archives/linux-mips/2016-04/msg00063.html


Changes in v3:
  - Return only when clk is NULL.  Do not take care of error pointer.

Changes in v2:
  - Rebase on Linux 4.6-rc1

 arch/arm/mach-mmp/clock.c        | 3 +++
 arch/arm/mach-w90x900/clock.c    | 3 +++
 arch/blackfin/mach-bf609/clock.c | 3 +++
 arch/m68k/coldfire/clk.c         | 4 ++++
 arch/mips/bcm63xx/clk.c          | 3 +++
 5 files changed, 16 insertions(+)

diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
index ac6633d..28fe64c 100644
--- a/arch/arm/mach-mmp/clock.c
+++ b/arch/arm/mach-mmp/clock.c
@@ -67,6 +67,9 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
+	if (!clk)
+		return;
+
 	WARN_ON(clk->enabled == 0);
 
 	spin_lock_irqsave(&clocks_lock, flags);
diff --git a/arch/arm/mach-w90x900/clock.c b/arch/arm/mach-w90x900/clock.c
index 2c371ff..ac6fd1a 100644
--- a/arch/arm/mach-w90x900/clock.c
+++ b/arch/arm/mach-w90x900/clock.c
@@ -46,6 +46,9 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
+	if (!clk)
+		return;
+
 	WARN_ON(clk->enabled == 0);
 
 	spin_lock_irqsave(&clocks_lock, flags);
diff --git a/arch/blackfin/mach-bf609/clock.c b/arch/blackfin/mach-bf609/clock.c
index 3783058..392a59b 100644
--- a/arch/blackfin/mach-bf609/clock.c
+++ b/arch/blackfin/mach-bf609/clock.c
@@ -97,6 +97,9 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
+	if (!clk)
+		return;
+
 	if (clk->ops && clk->ops->disable)
 		clk->ops->disable(clk);
 }
diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
index fddfdcc..1e3c7e9 100644
--- a/arch/m68k/coldfire/clk.c
+++ b/arch/m68k/coldfire/clk.c
@@ -101,6 +101,10 @@ EXPORT_SYMBOL(clk_enable);
 void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
+
+	if (!clk)
+		return;
+
 	spin_lock_irqsave(&clk_lock, flags);
 	if ((--clk->enabled == 0) && clk->clk_ops)
 		clk->clk_ops->disable(clk);
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 6375652..b49fc9c 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -326,6 +326,9 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
+	if (!clk)
+		return;
+
 	mutex_lock(&clocks_mutex);
 	clk_disable_unlocked(clk);
 	mutex_unlock(&clocks_mutex);
-- 
1.9.1
