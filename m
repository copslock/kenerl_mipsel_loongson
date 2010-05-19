Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 23:17:42 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18932 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491903Ab0ESVRM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 May 2010 23:17:12 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bf455660004>; Wed, 19 May 2010 14:17:26 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 19 May 2010 14:16:38 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 19 May 2010 14:16:37 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o4JLGZL5010235;
        Wed, 19 May 2010 14:16:35 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o4JLGZxB010234;
        Wed, 19 May 2010 14:16:35 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Octeon: Serial port fixes for OCTEON simulator.
Date:   Wed, 19 May 2010 14:16:32 -0700
Message-Id: <1274303792-10190-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1274303792-10190-1-git-send-email-ddaney@caviumnetworks.com>
References: <1274303792-10190-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 19 May 2010 21:16:37.0998 (UTC) FILETIME=[916670E0:01CAF798]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

For the simulator, fake a slow clock to get fast output.

In prom_putchar we have to mask the value so the simulator doesn't
ASSERT when printing non-ASCII characters.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/serial.c |    6 +++++-
 arch/mips/cavium-octeon/setup.c  |    2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/serial.c b/arch/mips/cavium-octeon/serial.c
index 2110e68..9c7a8c6 100644
--- a/arch/mips/cavium-octeon/serial.c
+++ b/arch/mips/cavium-octeon/serial.c
@@ -114,7 +114,11 @@ static void __init octeon_uart_set_common(struct plat_serial8250_port *p)
 	p->type = PORT_OCTEON;
 	p->iotype = UPIO_MEM;
 	p->regshift = 3;	/* I/O addresses are every 8 bytes */
-	p->uartclk = mips_hpt_frequency;
+	if (octeon_is_simulation())
+		/* Make simulator output fast*/
+		p->uartclk = 115200 * 16;
+	else
+		p->uartclk = mips_hpt_frequency;
 	p->serial_in = octeon_serial_in;
 	p->serial_out = octeon_serial_out;
 }
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 8640af3..9fb5336 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -707,7 +707,7 @@ int prom_putchar(char c)
 	} while ((lsrval & 0x20) == 0);
 
 	/* Write the byte */
-	cvmx_write_csr(CVMX_MIO_UARTX_THR(octeon_uart), c);
+	cvmx_write_csr(CVMX_MIO_UARTX_THR(octeon_uart), c & 0xffull);
 	return 1;
 }
 
-- 
1.6.6.1
