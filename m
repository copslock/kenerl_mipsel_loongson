Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 19:02:01 +0100 (CET)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:54715 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825891AbaAUSB6C-mWD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jan 2014 19:01:58 +0100
X-IronPort-AV: E=Sophos;i="4.95,696,1384329600"; 
   d="scan'208";a="10505005"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw2-out.broadcom.com with ESMTP; 21 Jan 2014 10:12:55 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Tue, 21 Jan 2014 10:01:49 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.1.438.0; Tue, 21 Jan 2014 10:01:49 -0800
Received: from fainelli-desktop.broadcom.com (unknown [10.12.164.252])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 81784246A7;  Tue, 21 Jan
 2014 10:01:49 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <blogic@openwrt.org>,
        <macro@linux-mips.org>, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/2] MIPS: fix DECStation build for L1_CACHE_SHIFT value
Date:   Tue, 21 Jan 2014 10:01:34 -0800
Message-ID: <1390327294-2618-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1390327294-2618-1-git-send-email-florian@openwrt.org>
References: <1390327294-2618-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39042
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

When support for the DECStation is enabled, it will default to use a
MIPS R3000 class processor. This will cause an intentional build failure
to popup because MIPS_L1_CACHE_SHIFT and cpu_dcache_line_size()
disagree. Fix this by selecting MIPS_L1_CACHE_SHIFT_2 when we build
targetting a MIPS R3000 CPU to fix that build failure and satisfy all
requirements.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9ab4239..33738f8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -184,7 +184,8 @@ config MACH_DECSTATION
 	select SYS_SUPPORTS_128HZ
 	select SYS_SUPPORTS_256HZ
 	select SYS_SUPPORTS_1024HZ
-	select MIPS_L1_CACHE_SHIFT_4
+	select MIPS_L1_CACHE_SHIFT_2 if CPU_R3000
+	select MIPS_L1_CACHE_SHIFT_4 if CPU_R4X00
 	help
 	  This enables support for DEC's MIPS based workstations.  For details
 	  see the Linux/MIPS FAQ on <http://www.linux-mips.org/> and the
-- 
1.8.3.2
