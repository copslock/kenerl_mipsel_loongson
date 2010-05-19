Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 23:17:17 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18934 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491982Ab0ESVRM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 May 2010 23:17:12 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bf455660001>; Wed, 19 May 2010 14:17:26 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 19 May 2010 14:16:38 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 19 May 2010 14:16:37 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o4JLGZj4010231;
        Wed, 19 May 2010 14:16:35 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o4JLGZUr010230;
        Wed, 19 May 2010 14:16:35 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Octeon: Get rid of early serial.
Date:   Wed, 19 May 2010 14:16:31 -0700
Message-Id: <1274303792-10190-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1274303792-10190-1-git-send-email-ddaney@caviumnetworks.com>
References: <1274303792-10190-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 19 May 2010 21:16:37.0998 (UTC) FILETIME=[916670E0:01CAF798]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Get rid of early_serial_setup, we use CONFIG_EARLY_PRINTK instead.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/setup.c |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 4ac78a6..8640af3 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -403,7 +403,6 @@ void __init prom_init(void)
 	const int coreid = cvmx_get_core_num();
 	int i;
 	int argc;
-	struct uart_port octeon_port;
 #ifdef CONFIG_CAVIUM_RESERVE32
 	int64_t addr = -1;
 #endif
@@ -615,30 +614,6 @@ void __init prom_init(void)
 	_machine_restart = octeon_restart;
 	_machine_halt = octeon_halt;
 
-	memset(&octeon_port, 0, sizeof(octeon_port));
-	/*
-	 * For early_serial_setup we don't set the port type or
-	 * UPF_FIXED_TYPE.
-	 */
-	octeon_port.flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ;
-	octeon_port.iotype = UPIO_MEM;
-	/* I/O addresses are every 8 bytes */
-	octeon_port.regshift = 3;
-	/* Clock rate of the chip */
-	octeon_port.uartclk = mips_hpt_frequency;
-	octeon_port.fifosize = 64;
-	octeon_port.mapbase = 0x0001180000000800ull + (1024 * octeon_uart);
-	octeon_port.membase = cvmx_phys_to_ptr(octeon_port.mapbase);
-	octeon_port.serial_in = octeon_serial_in;
-	octeon_port.serial_out = octeon_serial_out;
-#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
-	octeon_port.line = 0;
-#else
-	octeon_port.line = octeon_uart;
-#endif
-	octeon_port.irq = 42 + octeon_uart;
-	early_serial_setup(&octeon_port);
-
 	octeon_user_io_init();
 	register_smp_ops(&octeon_smp_ops);
 }
-- 
1.6.6.1
