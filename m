Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 09:35:38 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55503 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827443Ab3DLHcHImfkH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 09:32:07 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 08/16] MIPS: ralink: make early_printk work on RT2880
Date:   Fri, 12 Apr 2013 09:27:35 +0200
Message-Id: <1365751663-5725-8-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36092
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

RT2880 has a different location for the early serial port.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/early_printk.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/ralink/early_printk.c b/arch/mips/ralink/early_printk.c
index c4ae47e..b46d041 100644
--- a/arch/mips/ralink/early_printk.c
+++ b/arch/mips/ralink/early_printk.c
@@ -11,7 +11,11 @@
 
 #include <asm/addrspace.h>
 
+#ifdef CONFIG_SOC_RT288X
+#define EARLY_UART_BASE         0x300c00
+#else
 #define EARLY_UART_BASE         0x10000c00
+#endif
 
 #define UART_REG_RX             0x00
 #define UART_REG_TX             0x04
-- 
1.7.10.4
