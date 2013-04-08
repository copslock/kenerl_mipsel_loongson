Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Apr 2013 20:06:42 +0200 (CEST)
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:64139 "EHLO
        cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827536Ab3DHSGh6ybJu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Apr 2013 20:06:37 +0200
Received: from cpsps-ews12.kpnxchange.com ([10.94.84.179]) by cpsmtpb-ews01.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 8 Apr 2013 20:06:32 +0200
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews12.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 8 Apr 2013 20:06:32 +0200
Received: from [192.168.1.103] ([212.123.139.93]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 8 Apr 2013 20:06:31 +0200
Message-ID: <1365444391.1830.125.camel@x61.thuisdomein>
Subject: [PATCH] MIPS: Kconfig: remove "config MIPS_BOARDS_GEN"
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Apr 2013 20:06:31 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4 (3.4.4-2.fc17) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2013 18:06:32.0141 (UTC) FILETIME=[CCC907D0:01CE3483]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36033
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

The Kconfig symbol MIPS_BOARDS_GEN is unused since v2.6.27. It should
now be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested, unsurprisingly.

 arch/mips/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 51244bf..7b38bf8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -306,7 +306,6 @@ config MIPS_MALTA
 	select HW_HAS_PCI
 	select I8253
 	select I8259
-	select MIPS_BOARDS_GEN
 	select MIPS_BONITO64
 	select MIPS_CPU_SCACHE
 	select PCI_GT64XXX_PCI0
@@ -342,7 +341,6 @@ config MIPS_SEAD3
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select IRQ_GIC
-	select MIPS_BOARDS_GEN
 	select MIPS_CPU_SCACHE
 	select MIPS_MSC
 	select SYS_HAS_CPU_MIPS32_R1
@@ -1079,9 +1077,6 @@ config IRQ_GT641XX
 config IRQ_GIC
 	bool
 
-config MIPS_BOARDS_GEN
-	bool
-
 config PCI_GT64XXX_PCI0
 	bool
 
-- 
1.7.11.7
