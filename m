Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2014 11:10:29 +0200 (CEST)
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:49774 "EHLO
        cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816676AbaDCJK0acYdj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Apr 2014 11:10:26 +0200
Received: from cpsps-ews08.kpnxchange.com ([10.94.84.175]) by cpsmtpb-ews07.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 3 Apr 2014 11:10:21 +0200
Received: from CPSMTPM-TLF103.kpnxchange.com ([195.121.3.6]) by cpsps-ews08.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 3 Apr 2014 11:10:20 +0200
Received: from [192.168.10.106] ([195.240.213.44]) by CPSMTPM-TLF103.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 3 Apr 2014 11:10:20 +0200
Message-ID: <1396516220.31985.16.camel@x220>
Subject: [PATCH] MIPS: Loongson: No need to select
 GENERIC_HARDIRQS_NO__DO_IRQ
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Apr 2014 11:10:20 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-2.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Apr 2014 09:10:20.0627 (UTC) FILETIME=[89C79230:01CF4F1C]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39619
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

Commit 0e476d91244e ("MIPS: Loongson: Add Loongson-3 Kconfig options")
added "select GENERIC_HARDIRQS_NO__DO_IRQ". But the Kconfig symbol
GENERIC_HARDIRQS_NO__DO_IRQ was already removed in v2.6.38, so that
select is a nop. Drop it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with git grep only.

 arch/mips/loongson/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 7397be2..603d79a 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -64,7 +64,6 @@ config LEMOTE_MACH3A
 	bool "Lemote Loongson 3A family machines"
 	select ARCH_SPARSEMEM_ENABLE
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 	select BOOT_ELF32
 	select BOARD_SCACHE
 	select CSRC_R4K
-- 
1.9.0
