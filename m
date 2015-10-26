Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2015 21:10:19 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:47606 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011403AbbJZUKRMyhQe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Oct 2015 21:10:17 +0100
Received: from hauke-desktop.fritz.box (pD9F60F2D.dip0.t-ipconnect.de [217.246.15.45])
        by hauke-m.de (Postfix) with ESMTPSA id 535A5100029;
        Mon, 26 Oct 2015 21:10:16 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        sergei.shtylyov@cogentembedded.com,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "# 4 . 1+" <stable@vger.kernel.org>
Subject: [PATCH v2] MIPS: lantiq: add clk_round_rate()
Date:   Mon, 26 Oct 2015 21:10:12 +0100
Message-Id: <1445890212-5649-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This adds a basic implementation of clk_round_rate()
The clk_round_rate() function is called by multiple drivers and
subsystems now and the lantiq clk driver is supposed to export this,
but doesn't do so, this causes linking problems like this one:
ERROR: "clk_round_rate" [drivers/media/v4l2-core/videodev.ko] undefined!

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: John Crispin <blogic@openwrt.org>
Cc: <stable@vger.kernel.org> # 4.1+
---
 arch/mips/lantiq/clk.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index 3fc2e6d..fe86c50 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -99,6 +99,22 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL(clk_set_rate);
 
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (unlikely(!clk_good(clk)))
+		return 0;
+	if (clk->rates && *clk->rates) {
+		unsigned long *r = clk->rates;
+
+		while (*r && (*r != rate))
+			r++;
+		if (!*r)
+			return clk->rate;
+	}
+	return rate;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
 int clk_enable(struct clk *clk)
 {
 	if (unlikely(!clk_good(clk)))
-- 
2.6.1
