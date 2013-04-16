Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 10:35:05 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:40334 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822674Ab3DPIcVyEKmP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 10:32:21 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V4 10/14] MIPS: ralink: add uart mask to struct ralink_pinmux
Date:   Tue, 16 Apr 2013 10:28:05 +0200
Message-Id: <1366100889-21072-10-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1366100889-21072-1-git-send-email-blogic@openwrt.org>
References: <1366100889-21072-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36218
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

Add a field for the uart muxing mask and set it inside the rt305x setup code.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/common.h |    1 +
 arch/mips/ralink/rt305x.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index bebd149..299119b 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -22,6 +22,7 @@ struct ralink_pinmux {
 	struct ralink_pinmux_grp *mode;
 	struct ralink_pinmux_grp *uart;
 	int uart_shift;
+	u32 uart_mask;
 	void (*wdt_reset)(void);
 	struct ralink_pinmux_grp *pci;
 	int pci_shift;
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index 5b42078..e9dbf8c 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -118,6 +118,7 @@ struct ralink_pinmux rt_gpio_pinmux = {
 	.mode = mode_mux,
 	.uart = uart_mux,
 	.uart_shift = RT305X_GPIO_MODE_UART0_SHIFT,
+	.uart_mask = RT305X_GPIO_MODE_GPIO,
 	.wdt_reset = rt305x_wdt_reset,
 };
 
-- 
1.7.10.4
