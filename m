Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 20:05:51 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:38173 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825884AbaAOTFrZ23IU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jan 2014 20:05:47 +0100
X-IronPort-AV: E=Sophos;i="4.95,664,1384329600"; 
   d="scan'208";a="9271552"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 15 Jan 2014 11:11:09 -0800
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Wed, 15 Jan 2014 11:05:37 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.1.438.0; Wed, 15 Jan 2014 11:05:33 -0800
Received: from fainelli-desktop.broadcom.com (unknown [10.12.164.252])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 43E85246A3;  Wed, 15 Jan
 2014 11:05:33 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH mips-for-linux-next] MIPS: check for D$ line size and CONFIG_MIPS_L1_SHIFT
Date:   Wed, 15 Jan 2014 11:05:22 -0800
Message-ID: <1389812722-30035-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39012
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

When a platform overrides the dcache_line_size detection in its
cpu-features-override.h file, check that the value matches
(1 << CONFIG_MIPS_L1_SHIFT) to ensure both settings are correct.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/include/asm/cpu-features.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 6e70b03..9052fb9 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -279,6 +279,10 @@
 
 #ifndef cpu_dcache_line_size
 #define cpu_dcache_line_size()	cpu_data[0].dcache.linesz
+#else
+#if (cpu_dcache_line_size() != (1 << CONFIG_MIPS_L1_CACHE_SHIFT))
+#error "cpu_dcache_line_size does not match CONFIG_MIPS_L1_CACHE_SHIFT"
+#endif
 #endif
 #ifndef cpu_icache_line_size
 #define cpu_icache_line_size()	cpu_data[0].icache.linesz
-- 
1.8.3.2
