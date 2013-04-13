Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 10:53:59 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54337 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823038Ab3DMIw3GalKG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 10:52:29 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V3 07/14] MIPS: ralink: rename gpio_pinmux to rt_gpio_pinmux
Date:   Sat, 13 Apr 2013 10:48:18 +0200
Message-Id: <1365842905-10906-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365842905-10906-1-git-send-email-blogic@openwrt.org>
References: <1365842905-10906-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36127
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

Add proper namespacing to the variable.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/common.h |    2 +-
 arch/mips/ralink/rt305x.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index 3009903..f4b19c6 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -24,7 +24,7 @@ struct ralink_pinmux {
 	int uart_shift;
 	void (*wdt_reset)(void);
 };
-extern struct ralink_pinmux gpio_pinmux;
+extern struct ralink_pinmux rt_gpio_pinmux;
 
 struct ralink_soc_info {
 	unsigned char sys_type[RAMIPS_SYS_TYPE_LEN];
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index 5d49a54..f1a6c33 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -114,7 +114,7 @@ void rt305x_wdt_reset(void)
 	rt_sysc_w32(t, SYSC_REG_SYSTEM_CONFIG);
 }
 
-struct ralink_pinmux gpio_pinmux = {
+struct ralink_pinmux rt_gpio_pinmux = {
 	.mode = mode_mux,
 	.uart = uart_mux,
 	.uart_shift = RT305X_GPIO_MODE_UART0_SHIFT,
-- 
1.7.10.4
