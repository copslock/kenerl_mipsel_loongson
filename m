Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2014 21:35:50 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:5250 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870578AbaAJUf2sszqK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jan 2014 21:35:28 +0100
X-IronPort-AV: E=Sophos;i="4.95,640,1384329600"; 
   d="scan'208";a="8852236"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 10 Jan 2014 12:48:04 -0800
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Fri, 10 Jan 2014 12:35:19 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.1.438.0; Fri, 10 Jan 2014 12:35:19 -0800
Received: from fainelli-desktop.broadcom.com (unknown [10.12.164.252])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 6CAB4246A6;  Fri, 10 Jan
 2014 12:35:19 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <blogic@openwrt.org>, <jogo@openwrt.org>,
        <mbizon@freebox.fr>, <cernekee@gmail.com>, <dgcbueu@gmail.com>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3/3] MIPS: BCM63XX: select correct MIPS_L1_CACHE_SHIFT value
Date:   Fri, 10 Jan 2014 12:35:14 -0800
Message-ID: <1389386114-31834-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1389386114-31834-1-git-send-email-florian@openwrt.org>
References: <1389386114-31834-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38929
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

Broadcom BCM63xx DSL SoCs have a L1-cache line size of 16 bytes (shift
value of 4) instead of the currently configured 32 bytes L1-cache line
size.

Reported-by: Daniel Gonzalez <dgcbueu@gmail.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 123f7c0..a3fec87 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -139,6 +139,7 @@ config BCM63XX
 	select SWAP_IO_SPACE
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
+	select MIPS_L1_CACHE_SHIFT_4
 	help
 	 Support for BCM63XX based boards
 
-- 
1.8.3.2
