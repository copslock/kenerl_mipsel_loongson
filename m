Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 00:36:48 +0100 (BST)
Received: from mx1.rmicorp.com ([12.239.216.72]:17511 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S20027245AbZDHXgR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 00:36:17 +0100
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 8 Apr 2009 16:36:09 -0700
Received: from localhost.localdomain (unknown [10.8.0.44])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id C60F67B7FC8;
	Sat,  4 Apr 2009 05:34:46 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH v3 3/5] Alchemy: Au1300/DB1300 UART support
Date:	Wed,  8 Apr 2009 18:36:06 -0500
Message-Id: <1239233768-11927-4-git-send-email-khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1239233768-11927-3-git-send-email-khickey@rmicorp.com>
References: <>
 <1239233768-11927-1-git-send-email-khickey@rmicorp.com>
 <1239233768-11927-2-git-send-email-khickey@rmicorp.com>
 <1239233768-11927-3-git-send-email-khickey@rmicorp.com>
X-OriginalArrivalTime: 08 Apr 2009 23:36:09.0368 (UTC) FILETIME=[CB69A180:01C9B8A2]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

Adds support for the UART on the Au1300 SOC and the DB1300 board.  This
includes enabling EARLY_PRINTK for Alchemy.

Signed-off-by: Kevin Hickey <khickey@rmicorp.com>
---
 arch/mips/Kconfig                          |    1 +
 arch/mips/alchemy/common/platform.c        |    5 +++++
 arch/mips/include/asm/mach-au1x00/au1000.h |    5 +++++
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e61465a..b030770 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -21,6 +21,7 @@ choice
 
 config MACH_ALCHEMY
 	bool "Alchemy processor based machines"
+	select SYS_HAS_EARLY_PRINTK
 
 config BASLER_EXCITE
 	bool "Basler eXcite smart camera"
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 5c76c64..78fd862 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -52,6 +52,11 @@ static struct plat_serial8250_port au1x00_uart_data[] = {
 #elif defined(CONFIG_SOC_AU1200)
 	PORT(UART0_ADDR, AU1200_UART0_INT),
 	PORT(UART1_ADDR, AU1200_UART1_INT),
+#elif defined(CONFIG_SOC_AU13XX)
+	PORT(UART2_ADDR, AU1300_IRQ_UART2 + GPINT_LINUX_IRQ_OFFSET),
+	PORT(UART0_ADDR, AU1300_IRQ_UART0 + GPINT_LINUX_IRQ_OFFSET),
+	PORT(UART1_ADDR, AU1300_IRQ_UART1 + GPINT_LINUX_IRQ_OFFSET),
+	PORT(UART3_ADDR, AU1300_IRQ_UART3 + GPINT_LINUX_IRQ_OFFSET),
 #endif
 #endif	/* CONFIG_SERIAL_8250_AU1X00 */
 	{ },
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index c7fe356..f669556 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -1277,7 +1277,12 @@ enum soc_au1200_ints {
 #define MAC_RX_BUFF3_ADDR	0x34
 
 /* UARTS 0-3 */
+#ifdef CONFIG_SOC_AU13XX
+#define UART_BASE		UART2_ADDR
+#else
 #define UART_BASE		UART0_ADDR
+#endif
+
 #ifdef	CONFIG_SOC_AU1200
 #define UART_DEBUG_BASE 	UART1_ADDR
 #else
-- 
1.5.4.3
