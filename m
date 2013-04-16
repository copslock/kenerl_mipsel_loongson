Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 10:34:28 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:40329 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835149Ab3DPIcUubQUI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 10:32:20 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V4 08/14] MIPS: ralink: make the RT305x pinmuxing structure static
Date:   Tue, 16 Apr 2013 10:28:03 +0200
Message-Id: <1366100889-21072-8-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1366100889-21072-1-git-send-email-blogic@openwrt.org>
References: <1366100889-21072-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36216
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

These structures are exported via struct ralink_pinmux rt_gpio_pinmux and can
hence be static.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/rt305x.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index f1a6c33..5b42078 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -22,7 +22,7 @@
 
 enum rt305x_soc_type rt305x_soc;
 
-struct ralink_pinmux_grp mode_mux[] = {
+static struct ralink_pinmux_grp mode_mux[] = {
 	{
 		.name = "i2c",
 		.mask = RT305X_GPIO_MODE_I2C,
@@ -61,7 +61,7 @@ struct ralink_pinmux_grp mode_mux[] = {
 	}, {0}
 };
 
-struct ralink_pinmux_grp uart_mux[] = {
+static struct ralink_pinmux_grp uart_mux[] = {
 	{
 		.name = "uartf",
 		.mask = RT305X_GPIO_MODE_UARTF,
@@ -103,7 +103,7 @@ struct ralink_pinmux_grp uart_mux[] = {
 	}, {0}
 };
 
-void rt305x_wdt_reset(void)
+static void rt305x_wdt_reset(void)
 {
 	u32 t;
 
-- 
1.7.10.4
