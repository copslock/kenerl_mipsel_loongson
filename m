Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2009 16:20:39 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:35445 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S20808213AbZCFQUQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2009 16:20:16 +0000
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Mar 2009 08:20:09 -0800
Received: from localhost.localdomain (unknown [10.8.0.23])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id C78F0EE76A7;
	Fri,  6 Mar 2009 09:42:10 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH 03/10] Alchemy: Au1300/DB1300 UART support
Date:	Fri,  6 Mar 2009 10:20:02 -0600
Message-Id: <7afc5c84989c4bc0f94181397369f284f2bb6924.1236354153.git.khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
References: <>
 <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
 <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
 <0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
In-Reply-To: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
References: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
X-OriginalArrivalTime: 06 Mar 2009 16:20:09.0418 (UTC) FILETIME=[6B3C4AA0:01C99E77]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22017
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
index fd096d1..d53d3a0 100644
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
index ddebb84..debf896 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -1276,7 +1276,12 @@ enum soc_au1200_ints {
 #define MAC_RX_BUFF3_ADDR	0x34
 
 /* UARTS 0-3 */
+#ifdef  CONFIG_SOC_AU13XX
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
