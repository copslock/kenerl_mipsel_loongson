Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jul 2010 03:43:31 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16613 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492570Ab0GXBmT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jul 2010 03:42:19 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c4a45140000>; Fri, 23 Jul 2010 18:42:44 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 18:42:17 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 18:42:17 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6O1gB4U004062;
        Fri, 23 Jul 2010 18:42:11 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6O1gBrX004061;
        Fri, 23 Jul 2010 18:42:11 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, wim@iguana.be
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/7] MIPS: Octeon: Export prom_putchar().
Date:   Fri, 23 Jul 2010 18:41:44 -0700
Message-Id: <1279935707-3997-5-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Jul 2010 01:42:17.0187 (UTC) FILETIME=[72BF6B30:01CB2AD1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The forthcoming watchdog driver will use it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/setup.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 6f36bc1..85a615a 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -691,7 +691,10 @@ void __init plat_mem_setup(void)
 		      "cvmx_bootmem_phy_alloc\n");
 }
 
-
+/*
+ * Emit one character to the boot UART.  Exported for use by the
+ * watchdog timer.
+ */
 int prom_putchar(char c)
 {
 	uint64_t lsrval;
@@ -705,6 +708,7 @@ int prom_putchar(char c)
 	cvmx_write_csr(CVMX_MIO_UARTX_THR(octeon_uart), c & 0xffull);
 	return 1;
 }
+EXPORT_SYMBOL(prom_putchar);
 
 void prom_free_prom_memory(void)
 {
-- 
1.7.1.1
