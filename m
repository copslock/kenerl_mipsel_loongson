Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 15:09:13 +0200 (CEST)
Received: from baptiste.telenet-ops.be ([IPv6:2a02:1800:120:4::f00:13]:33500
        "EHLO baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993417AbdD1NJEJKnfb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 15:09:04 +0200
Received: from ayla.of.borg ([84.193.137.253])
        by baptiste.telenet-ops.be with bizsmtp
        id Dp8v1v0085UCtCs01p8vmm; Fri, 28 Apr 2017 15:08:58 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1d45dn-00037u-7s; Fri, 28 Apr 2017 15:08:55 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1d45dn-00089W-5v; Fri, 28 Apr 2017 15:08:55 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] clk: Provide dummy of_clk_get_from_provider() for compile-testing
Date:   Fri, 28 Apr 2017 15:08:53 +0200
Message-Id: <1493384933-31297-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert+renesas@glider.be
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

When CONFIG_ON=n, dummies are provided for of_clk_get() and
of_clk_get_by_name(), but not for of_clk_get_from_provider().

Provide a dummy for the latter, to improve the ability to do
compile-testing.  This requires removing the existing dummy in the
Lantiq clock code.

Fixes: 766e6a4ec602d0c1 ("clk: add DT clock binding support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Remove conflicting dummy in Lantiq clock code (reported by 0day).
---
 arch/mips/lantiq/clk.c | 5 -----
 include/linux/clk.h    | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index 149f0513c4f5d0d4..a263d1b751ffe48d 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -160,11 +160,6 @@ void clk_deactivate(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_deactivate);
 
-struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
-{
-	return NULL;
-}
-
 static inline u32 get_counter_resolution(void)
 {
 	u32 res;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index e9d36b3e49de5b1b..3ed97abb5cbb7f94 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -539,6 +539,10 @@ static inline struct clk *of_clk_get_by_name(struct device_node *np,
 {
 	return ERR_PTR(-ENOENT);
 }
+static inline struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
+{
+	return ERR_PTR(-ENOENT);
+}
 #endif
 
 #endif
-- 
2.7.4
