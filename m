Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2014 21:36:08 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:35586 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870582AbaAJUfyXvis4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jan 2014 21:35:54 +0100
X-IronPort-AV: E=Sophos;i="4.95,640,1384329600"; 
   d="scan'208";a="8464827"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 10 Jan 2014 12:40:13 -0800
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Fri, 10 Jan 2014 12:35:19 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.1.438.0; Fri, 10 Jan 2014 12:35:19 -0800
Received: from fainelli-desktop.broadcom.com (unknown [10.12.164.252])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 59968246A5;  Fri, 10 Jan
 2014 12:35:19 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <blogic@openwrt.org>, <jogo@openwrt.org>,
        <mbizon@freebox.fr>, <cernekee@gmail.com>, <dgcbueu@gmail.com>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/3] MIPS: update MIPS_L1_CACHE_SHIFT based on MIPS_L1_CACHE_SHIFT_<N>
Date:   Fri, 10 Jan 2014 12:35:13 -0800
Message-ID: <1389386114-31834-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1389386114-31834-1-git-send-email-florian@openwrt.org>
References: <1389386114-31834-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38930
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

All platforms that require a special MIPS_L1_CACHE_SHIFT value have been
updated, such that we can now make MIPS_L1_CACHE_SHIFT default to the
appropriate integer value based on the select MIPS_L1_CACHE_SHIFT_<N>
variable.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 753c5a3..123f7c0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1106,10 +1106,10 @@ config MIPS_L1_CACHE_SHIFT_7
 
 config MIPS_L1_CACHE_SHIFT
 	int
-	default "4" if MACH_DECSTATION || MIKROTIK_RB532 || PMC_MSP4200_EVAL || SOC_RT288X
-	default "6" if MIPS_CPU_SCACHE
-	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM || CPU_CAVIUM_OCTEON
-	default "5"
+	default "4" if MIPS_L1_CACHE_SHIFT_4
+	default "6" if MIPS_L1_CACHE_SHIFT_6
+	default "7" if MIPS_L1_CACHE_SHIFT_7
+	default "5" if MIPS_L1_CACHE_SHIFT_5
 
 config HAVE_STD_PC_SERIAL_PORT
 	bool
-- 
1.8.3.2
