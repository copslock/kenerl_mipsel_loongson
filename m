Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 14:02:00 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:2636 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825876Ab2JaM6wXrKtR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:58:52 +0100
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:57:26 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:58:04 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id D2C1640FE3; Wed, 31
 Oct 2012 05:58:32 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 07/15] MIPS: Netlogic: Fix DMA zone selection for 64-bit
Date:   Wed, 31 Oct 2012 18:31:33 +0530
Message-ID: <f54cffbc22457125b73267eccb21e98455019783.1351688140.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1351688140.git.jchandra@broadcom.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C8FFFBC2102191020-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Fix Kconfig for both XLR and XLP to select ZONE_DMA32 (instead of ZONE_DMA)
in case of 64-bit compilation. This can be used for devices that can only
do DMA to 32-bit address. ZONE_DMA is not useful on XLR or XLP.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 346b44d..890ae91 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -800,7 +800,7 @@ config NLM_XLR_BOARD
 	select CSRC_R4K
 	select IRQ_CPU
 	select ARCH_SUPPORTS_MSI
-	select ZONE_DMA if 64BIT
+	select ZONE_DMA32 if 64BIT
 	select SYNC_R4K
 	select SYS_HAS_EARLY_PRINTK
 	select USB_ARCH_HAS_OHCI if USB_SUPPORT
@@ -828,7 +828,7 @@ config NLM_XLP_BOARD
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_CPU
-	select ZONE_DMA if 64BIT
+	select ZONE_DMA32 if 64BIT
 	select SYNC_R4K
 	select SYS_HAS_EARLY_PRINTK
 	select USE_OF
-- 
1.7.9.5
