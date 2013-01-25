Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jan 2013 11:53:02 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:49209 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832244Ab3AYKw5OrXch (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Jan 2013 11:52:57 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Alan Cox <alan@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/2] serial: ralink: adds support for the serial core found on ralink wisoc
Date:   Fri, 25 Jan 2013 11:50:07 +0100
Message-Id: <1359111008-9998-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35553
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The MIPS based Ralink WiSoC platform has 1 or more 8250 compatible serial cores.
To make them work we require the same quirks that are used by AU1x00.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/8250/8250.c  |    6 +++---
 drivers/tty/serial/8250/Kconfig |    8 ++++++++
 include/linux/serial_core.h     |    2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index f932043..b727779 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -324,9 +324,9 @@ static void default_serial_dl_write(struct uart_8250_port *up, int value)
 	serial_out(up, UART_DLM, value >> 8 & 0xff);
 }
 
-#ifdef CONFIG_MIPS_ALCHEMY
+#if defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_SERIAL_8250_RT288X)
 
-/* Au1x00 UART hardware has a weird register layout */
+/* Au1x00 RT288x UART hardware has a weird register layout */
 static const u8 au_io_in_map[] = {
 	[UART_RX]  = 0,
 	[UART_IER] = 2,
@@ -506,7 +506,7 @@ static void set_io_from_upio(struct uart_port *p)
 		break;
 #endif
 
-#ifdef CONFIG_MIPS_ALCHEMY
+#if defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_SERIAL_8250_RT288X)
 	case UPIO_AU:
 		p->serial_in = au_serial_in;
 		p->serial_out = au_serial_out;
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index c31133a..c583799 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -249,6 +249,14 @@ config SERIAL_8250_ACORN
 	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
 	  cards.  If unsure, say N.
 
+config SERIAL_8250_RT288X
+	bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
+	depends on SERIAL_8250 != n && (SOC_RT288X || SOC_RT305X || SOC_RT3883)
+	help
+	  If you have a Ralink RT288x/RT305x SoC based board and want to use the
+	  serial port, say Y to this option. The driver can handle up to 2 serial
+	  ports. If unsure, say N.
+
 config SERIAL_8250_RM9K
 	bool "Support for MIPS RM9xxx integrated serial port"
 	depends on SERIAL_8250 != n && SERIAL_RM9000
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c6690a2..0b428d6 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -134,7 +134,7 @@ struct uart_port {
 #define UPIO_HUB6		(1)
 #define UPIO_MEM		(2)
 #define UPIO_MEM32		(3)
-#define UPIO_AU			(4)			/* Au1x00 type IO */
+#define UPIO_AU			(4)			/* Au1x00 and RT288x type IO */
 #define UPIO_TSI		(5)			/* Tsi108/109 type IO */
 #define UPIO_RM9000		(6)			/* RM9000 type IO */
 
-- 
1.7.10.4
