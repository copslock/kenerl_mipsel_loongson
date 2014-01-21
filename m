Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 19:02:18 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:63463 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826484AbaAUSCAABBLH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jan 2014 19:02:00 +0100
X-IronPort-AV: E=Sophos;i="4.95,696,1384329600"; 
   d="scan'208";a="10690753"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw1-out.broadcom.com with ESMTP; 21 Jan 2014 10:20:30 -0800
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Tue, 21 Jan 2014 10:01:49 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.1.438.0; Tue, 21 Jan 2014 10:01:49 -0800
Received: from fainelli-desktop.broadcom.com (unknown [10.12.164.252])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 65DAF246A4;  Tue, 21 Jan
 2014 10:01:49 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <blogic@openwrt.org>,
        <macro@linux-mips.org>, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/2] MIPS: add MIPS_L1_CACHE_SHIFT_2
Date:   Tue, 21 Jan 2014 10:01:33 -0800
Message-ID: <1390327294-2618-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Some older machines such as the DECStation use a L1 data-cache shift of
2 (value of 4), add a Kconfig symbol for this value so they can express
this requirement.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 03d0ed3..9ab4239 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1098,6 +1098,9 @@ config FW_SNIPROM
 config BOOT_ELF32
 	bool
 
+config MIPS_L1_CACHE_SHIFT_2
+	bool
+
 config MIPS_L1_CACHE_SHIFT_4
 	bool
 
@@ -1112,6 +1115,7 @@ config MIPS_L1_CACHE_SHIFT_7
 
 config MIPS_L1_CACHE_SHIFT
 	int
+	default "2" if MIPS_L1_CACHE_SHIFT_2
 	default "4" if MIPS_L1_CACHE_SHIFT_4
 	default "5" if MIPS_L1_CACHE_SHIFT_5
 	default "6" if MIPS_L1_CACHE_SHIFT_6
-- 
1.8.3.2
