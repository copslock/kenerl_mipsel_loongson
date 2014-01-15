Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 20:06:50 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:18586 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825884AbaAOTGlMuGBu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jan 2014 20:06:41 +0100
X-IronPort-AV: E=Sophos;i="4.95,664,1384329600"; 
   d="scan'208";a="9271887"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw3-out.broadcom.com with ESMTP; 15 Jan 2014 11:12:06 -0800
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Wed, 15 Jan 2014 11:06:34 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.1.438.0; Wed, 15 Jan 2014 11:06:34 -0800
Received: from fainelli-desktop.broadcom.com (unknown [10.12.164.252])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 6AD48246A5;  Wed, 15 Jan
 2014 11:06:34 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <blogic@openwrt.org>,
        <david.daney@cavium.com>, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH mips-for-linux-next] MIPS: check for -mfix-cn63xxp1 compiler option
Date:   Wed, 15 Jan 2014 11:06:24 -0800
Message-ID: <1389812784-30085-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39013
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

Attempting to build for Cavium Octeon with an unpatched or old
toolchain will fail due to the -mfix-cn63xxp1 option being unrecognized.
Call cc-option on this option to make sure we can safely use it.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 873a0ca..f372b84 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -155,7 +155,7 @@ cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += $(call cc-option,-march=octeon) -Wa,--trap
 ifeq (,$(findstring march=octeon, $(cflags-$(CONFIG_CPU_CAVIUM_OCTEON))))
 cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -Wa,-march=octeon
 endif
-cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,-mfix-cn63xxp1
+cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,$(call cc-option,-mfix-cn63xxp1)
 cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,-mips32 -Wa,--trap
 
 cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)
-- 
1.8.3.2
