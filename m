Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 11:52:38 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37398 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011211AbbKDKuiM00Ow (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Nov 2015 11:50:38 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id E28BD280351;
        Wed,  4 Nov 2015 11:48:47 +0100 (CET)
Received: from localhost.localdomain (p548C90D8.dip0.t-ipconnect.de [84.140.144.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  4 Nov 2015 11:48:47 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 9/9] arch: mips: ralink: add missing clock on rt305x
Date:   Wed,  4 Nov 2015 11:50:14 +0100
Message-Id: <1446634214-11564-9-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
References: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49835
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

The rt305x support is missing a clock required by the ethernet driver.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/rt305x.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index 7e11f00..9e45725 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -199,6 +199,7 @@ void __init ralink_clk_init(void)
 	}
 
 	ralink_clk_add("cpu", cpu_rate);
+	ralink_clk_add("sys", sys_rate);
 	ralink_clk_add("10000b00.spi", sys_rate);
 	ralink_clk_add("10000100.timer", wdt_rate);
 	ralink_clk_add("10000120.watchdog", wdt_rate);
-- 
1.7.10.4
