Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Feb 2014 22:47:07 +0100 (CET)
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:62071 "EHLO
        cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822188AbaBHVrErPdKL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Feb 2014 22:47:04 +0100
Received: from cpsps-ews25.kpnxchange.com ([10.94.84.191]) by cpsmtpb-ews03.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 8 Feb 2014 22:46:59 +0100
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews25.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 8 Feb 2014 22:46:58 +0100
Received: from [192.168.1.105] ([82.169.24.127]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 8 Feb 2014 22:46:58 +0100
Message-ID: <1391896018.19595.12.camel@x220>
Subject: [PATCH] MIPS: no need to select ARCH_SUPPORTS_MSI
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jayachandran C <jchandra@broadcom.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 08 Feb 2014 22:46:58 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.3 (3.10.3-1.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Feb 2014 21:46:58.0653 (UTC) FILETIME=[4ACE18D0:01CF2517]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39252
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

Commit c24a8a7a9988 ("MIPS: Netlogic: Add MSI support for XLP") added
"select ARCH_SUPPORTS_MSI". But the Kconfig symbol ARCH_SUPPORTS_MSI was
already removed in v3.12, so that select is a nop. Drop it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

It was commit ebd97be635bf ("PCI: remove ARCH_SUPPORTS_MSI kconfig
option") that removed this Kconfig symbol.

 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dcae3a7..b3bf596 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -782,7 +782,6 @@ config NLM_XLP_BOARD
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_CPU
-	select ARCH_SUPPORTS_MSI
 	select ZONE_DMA32 if 64BIT
 	select SYNC_R4K
 	select SYS_HAS_EARLY_PRINTK
-- 
1.8.5.3
