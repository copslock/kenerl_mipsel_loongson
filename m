Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2011 17:40:18 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45803 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491921Ab1F0PiE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jun 2011 17:38:04 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5RFc4dZ019411;
        Mon, 27 Jun 2011 16:38:04 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5RFc3DL019410;
        Mon, 27 Jun 2011 16:38:03 +0100
Message-Id: <f0b3d9a91be8dba5c45c14efebaa9c7800694f15.1309182743.git.ralf@linux-mips.org>
In-Reply-To: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alan Cox <alan@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Date:   Mon, 27 Jun 2011 14:26:56 +0100
Subject: [PATCH 10/12] SERIAL: SC26xx: Fix link error.
X-archive-position: 30526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21983

Kconfig allows enabling console support for the SC26xx driver even when
it's configured as a module resulting in a:

ERROR: "uart_console_device" [drivers/tty/serial/sc26xx.ko] undefined!

modpost error since the driver was merged in
eea63e0e8a60d00485b47fb6e75d9aa2566b989b [SC26XX: New serial driver for
SC2681 uarts] in 2.6.25.  Fixed by only allowing console support to be
enabled if the driver is builtin.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/tty/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 636144c..b3692e6 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1419,7 +1419,7 @@ config SERIAL_SC26XX
 
 config SERIAL_SC26XX_CONSOLE
 	bool "Console on SC2681/SC2692 serial port"
-	depends on SERIAL_SC26XX
+	depends on SERIAL_SC26XX=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  Support for Console on SC2681/SC2692 serial ports.
-- 
1.7.4.4
