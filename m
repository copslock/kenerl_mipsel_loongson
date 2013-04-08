Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Apr 2013 20:51:21 +0200 (CEST)
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:52115 "EHLO
        cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823908Ab3DHSvUIhsdN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Apr 2013 20:51:20 +0200
Received: from cpsps-ews30.kpnxchange.com ([10.94.84.196]) by cpsmtpb-ews03.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 8 Apr 2013 20:51:14 +0200
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews30.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 8 Apr 2013 20:51:14 +0200
Received: from [192.168.1.103] ([212.123.139.93]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 8 Apr 2013 20:51:13 +0200
Message-ID: <1365447073.1830.128.camel@x61.thuisdomein>
Subject: [PATCH] MIPS: Kconfig: remove "config MIPS_DISABLE_OBSOLETE_IDE"
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Apr 2013 20:51:13 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4 (3.4.4-2.fc17) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2013 18:51:13.0660 (UTC) FILETIME=[0B185BC0:01CE348A]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36034
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

The Kconfig symbol MIPS_DISABLE_OBSOLETE_IDE was added in v2.6.10. It
has never been used. Let's remove it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "git grep" (on current and historic trees).

 arch/mips/Kconfig         | 3 ---
 arch/mips/alchemy/Kconfig | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7b38bf8..27a4bfa 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -981,9 +981,6 @@ config MIPS_MSC
 config MIPS_NILE4
 	bool
 
-config MIPS_DISABLE_OBSOLETE_IDE
-	bool
-
 config SYNC_R4K
 	bool
 
diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index c8862bd..7032ac7 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -31,7 +31,6 @@ config MIPS_DB1000
 	select ALCHEMY_GPIOINT_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
@@ -41,7 +40,6 @@ config MIPS_DB1235
 	select ARCH_REQUIRE_GPIOLIB
 	select HW_HAS_PCI
 	select DMA_COHERENT
-	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
@@ -57,7 +55,6 @@ config MIPS_GPR
 	select ALCHEMY_GPIOINT_AU1000
 	select HW_HAS_PCI
 	select DMA_NONCOHERENT
-	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
-- 
1.7.11.7
