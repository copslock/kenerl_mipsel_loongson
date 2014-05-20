Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 12:51:09 +0200 (CEST)
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:61012 "EHLO
        cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822184AbaETKvBVvcT- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2014 12:51:01 +0200
Received: from cpsps-ews06.kpnxchange.com ([10.94.84.173]) by cpsmtpb-ews03.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Tue, 20 May 2014 12:50:55 +0200
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews06.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Tue, 20 May 2014 12:50:55 +0200
Received: from [192.168.10.106] ([195.240.213.44]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Tue, 20 May 2014 12:50:55 +0200
Message-ID: <1400583055.4912.28.camel@x220>
Subject: [PATCH] MIPS: remove check for CONFIG_CAVIUM_REPORT_SINGLE_BIT_ECC
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 May 2014 12:50:55 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-2.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2014 10:50:55.0314 (UTC) FILETIME=[6025FB20:01CF7419]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

A check for CONFIG_CAVIUM_REPORT_SINGLE_BIT_ECC was added in v2.6.29,
but without the related Kconfig symbol. Remove this check.

Also remove the test for an "ecc_verbose" kernel parameter. It is
undocumented and has no effect anyway.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

Note that __cvmx_interrupt_ecc_report_single_bit_errors doesn't exist.

 arch/mips/cavium-octeon/setup.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 331b837cec57..953ca85f84fa 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -779,12 +779,6 @@ void __init prom_init(void)
 				MAX_MEMORY = 32ull << 30;
 			if (*p == '@')
 				RESERVE_LOW_MEM = memparse(p + 1, &p);
-		} else if (strcmp(arg, "ecc_verbose") == 0) {
-#ifdef CONFIG_CAVIUM_REPORT_SINGLE_BIT_ECC
-			__cvmx_interrupt_ecc_report_single_bit_errors = 1;
-			pr_notice("Reporting of single bit ECC errors is "
-				  "turned on\n");
-#endif
 #ifdef CONFIG_KEXEC
 		} else if (strncmp(arg, "crashkernel=", 12) == 0) {
 			crashk_size = memparse(arg+12, &p);
-- 
1.9.0
