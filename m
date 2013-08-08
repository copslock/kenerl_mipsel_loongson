Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 13:15:43 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54741 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865306Ab3HHLPPeLfm3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 13:15:15 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/2] MIPS: ralink: probe clocksources from OF
Date:   Thu,  8 Aug 2013 13:08:07 +0200
Message-Id: <1375960087-31084-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1375960087-31084-1-git-send-email-blogic@openwrt.org>
References: <1375960087-31084-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Make plat_time_init() call clocksource_of_init() allowing the systick cevt
to load.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/clk.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index 8dfa22f..bba0cdf 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -69,4 +69,5 @@ void __init plat_time_init(void)
 	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
 	mips_hpt_frequency = clk_get_rate(clk) / 2;
 	clk_put(clk);
+	clocksource_of_init();
 }
-- 
1.7.10.4
