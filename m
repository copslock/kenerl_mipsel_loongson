Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 01:10:19 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18320 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491761Ab0JGXFJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 01:05:09 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cae50e00000>; Thu, 07 Oct 2010 18:59:44 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:22 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:22 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o97N49t2026976;
        Thu, 7 Oct 2010 16:04:09 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o97N49Uv026975;
        Thu, 7 Oct 2010 16:04:09 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 11/14] MIPS: Octeon: Use I/O clock rate for calculations.
Date:   Thu,  7 Oct 2010 16:03:50 -0700
Message-Id: <1286492633-26885-12-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2010 23:04:22.0699 (UTC) FILETIME=[FAE847B0:01CB6673]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The I2C and UARTS are clocked by the I/O clock, use its rate for these
devices.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-platform.c |    2 +-
 arch/mips/cavium-octeon/serial.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index c32d40d..49c3320 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -199,7 +199,7 @@ static int __init octeon_i2c_device_init(void)
 		num_ports = 1;
 
 	for (port = 0; port < num_ports; port++) {
-		octeon_i2c_data[port].sys_freq = octeon_get_clock_rate();
+		octeon_i2c_data[port].sys_freq = octeon_get_io_clock_rate();
 		/*FIXME: should be examined. At the moment is set for 100Khz */
 		octeon_i2c_data[port].i2c_freq = 100000;
 
diff --git a/arch/mips/cavium-octeon/serial.c b/arch/mips/cavium-octeon/serial.c
index 638adab..3075324 100644
--- a/arch/mips/cavium-octeon/serial.c
+++ b/arch/mips/cavium-octeon/serial.c
@@ -65,7 +65,7 @@ static void __init octeon_uart_set_common(struct plat_serial8250_port *p)
 		/* Make simulator output fast*/
 		p->uartclk = 115200 * 16;
 	else
-		p->uartclk = mips_hpt_frequency;
+		p->uartclk = octeon_get_io_clock_rate();
 	p->serial_in = octeon_serial_in;
 	p->serial_out = octeon_serial_out;
 }
-- 
1.7.2.3
