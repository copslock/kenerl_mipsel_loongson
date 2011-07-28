Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jul 2011 01:45:06 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:62221 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491821Ab1G1XpA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jul 2011 01:45:00 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 28 Jul 2011 16:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,285,1309762800"; 
   d="scan'208";a="31552557"
Received: from tassilo.jf.intel.com ([10.7.201.108])
  by orsmga002.jf.intel.com with ESMTP; 28 Jul 2011 16:44:53 -0700
Received: by tassilo.jf.intel.com (Postfix, from userid 501)
        id 299DF2403FF; Thu, 28 Jul 2011 16:44:53 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
References: <20110728444.299940435@firstfloor.org>
In-Reply-To: <20110728444.299940435@firstfloor.org>
To:     ralf@linux-mips.org, linux-serial@vger.kernel.org,
        linux-mips@linux-mips.org, alan@linux.intel.com, gregkh@suse.de,
        ak@linux.intel.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, tim.bird@am.sony.com
Subject: [PATCH] [48/50] SERIAL: SC26xx: Fix link error.
Message-Id: <20110728234453.299DF2403FF@tassilo.jf.intel.com>
Date:   Thu, 28 Jul 2011 16:44:53 -0700 (PDT)
X-archive-position: 30758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andi@firstfloor.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21221

2.6.35-longterm review patch.  If anyone has any objections, please let me know.

------------------
From: Ralf Baechle <ralf@linux-mips.org>

[ upstream commit f2eb3cdf14457fccb14ae8c4d7d7cee088cd3957 ]

Kconfig allows enabling console support for the SC26xx driver even when
it's configured as a module resulting in a:

ERROR: "uart_console_device" [drivers/tty/serial/sc26xx.ko] undefined!

modpost error since the driver was merged in
eea63e0e8a60d00485b47fb6e75d9aa2566b989b [SC26XX: New serial driver for
SC2681 uarts] in 2.6.25.  Fixed by only allowing console support to be
enabled if the driver is builtin.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: stable <stable@kernel.org>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Andi Kleen <ak@linux.intel.com>

Index: linux-2.6.35.y/drivers/serial/Kconfig
===================================================================
--- linux-2.6.35.y.orig/drivers/serial/Kconfig
+++ linux-2.6.35.y/drivers/serial/Kconfig
@@ -1417,7 +1417,7 @@ config SERIAL_SC26XX
 
 config SERIAL_SC26XX_CONSOLE
 	bool "Console on SC2681/SC2692 serial port"
-	depends on SERIAL_SC26XX
+	depends on SERIAL_SC26XX=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  Support for Console on SC2681/SC2692 serial ports.
