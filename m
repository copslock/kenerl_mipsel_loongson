Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2009 20:52:28 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:60824 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S21369890AbZCTUv5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2009 20:51:57 +0000
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Mar 2009 13:51:47 -0700
Received: from localhost.localdomain (unknown [10.8.0.60])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id 3B540EE76DA;
	Fri, 20 Mar 2009 14:11:47 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH v2 3/6] Alchemy: Au1300/DB1300 UART support
Date:	Fri, 20 Mar 2009 15:51:43 -0500
Message-Id: <1237582306-10800-4-git-send-email-khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1237582306-10800-3-git-send-email-khickey@rmicorp.com>
References: <>
 <1237582306-10800-1-git-send-email-khickey@rmicorp.com>
 <1237582306-10800-2-git-send-email-khickey@rmicorp.com>
 <1237582306-10800-3-git-send-email-khickey@rmicorp.com>
X-OriginalArrivalTime: 20 Mar 2009 20:51:48.0493 (UTC) FILETIME=[B00643D0:01C9A99D]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22105
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
