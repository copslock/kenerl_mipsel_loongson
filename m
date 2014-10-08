Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:10:20 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:53913
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010974AbaJIPIJALZye (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:08:09 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 08/10] MIPS: ralink: add rt2880 wmac clock
Date:   Thu,  9 Oct 2014 01:53:03 +0200
Message-Id: <1412812385-64820-9-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
References: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43144
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

Register the wireleass mac clock on rt2880. This is required by the wifi driver.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/rt288x.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index f87de1a..90e8934 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -76,7 +76,7 @@ struct ralink_pinmux rt_gpio_pinmux = {
 
 void __init ralink_clk_init(void)
 {
-	unsigned long cpu_rate;
+	unsigned long cpu_rate, wmac_rate = 40000000;
 	u32 t = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG);
 	t = ((t >> SYSTEM_CONFIG_CPUCLK_SHIFT) & SYSTEM_CONFIG_CPUCLK_MASK);
 
@@ -101,6 +101,7 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("300500.uart", cpu_rate / 2);
 	ralink_clk_add("300c00.uartlite", cpu_rate / 2);
 	ralink_clk_add("400000.ethernet", cpu_rate / 2);
+	ralink_clk_add("480000.wmac", wmac_rate);
 }
 
 void __init ralink_of_remap(void)
-- 
1.7.10.4
