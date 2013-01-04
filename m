Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 19:11:06 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:3914 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816521Ab3ADSLEvMkfP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Jan 2013 19:11:04 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 04 Jan 2013 10:07:14 -0800
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 4 Jan 2013 10:10:03 -0800
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 7C4C040FE9; Fri, 4 Jan 2013 10:10:15 -0800 (PST)
Received: from arend-vb-linux (unknown [10.177.252.106]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 0B919207C0; Fri, 4
 Jan 2013 10:10:14 -0800 (PST)
Received: from arend by arend-vb-linux with local (Exim 4.80) (
 envelope-from <arend@broadcom.com>) id 1TrBig-0007II-CZ; Fri, 04 Jan
 2013 19:10:14 +0100
From:   "Arend van Spriel" <arend@broadcom.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org, "Arend van Spriel" <arend@broadcom.com>,
        "Hauke Mehrtens" <hauke@hauke-m.de>
Subject: [PATCH] mips: bcm47xx: select GPIOLIB for BCMA on bcm47xx
 platform
Date:   Fri, 4 Jan 2013 19:10:05 +0100
Message-ID: <1357323005-28008-1-git-send-email-arend@broadcom.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
X-WSS-ID: 7CF9C5D83Q4639643-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
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

The Kconfig items BCM47XX_BCMA and BCM47XX_SSB selected
respectively BCMA_DRIVER_GPIO and SSB_DRIVER_GPIO. These
options depend on GPIOLIB without explicitly selecting it
so it results in a warning when GPIOLIB is not set:

scripts/kconfig/conf --oldconfig Kconfig
warning: (BCM47XX_BCMA) selects BCMA_DRIVER_GPIO ... unmet direct
	dependencies (BCMA_POSSIBLE && BCMA && GPIOLIB)
warning: (BCM47XX_SSB) selects SSB_DRIVER_GPIO ... unmet direct
	dependencies (SSB_POSSIBLE && SSB && GPIOLIB)

which subsequently results in compile errors.

Cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
Fixing a Kconfig issue in our nightly Jenkins build.

Gr. AvS
---
 arch/mips/bcm47xx/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index d7af29f..ba61192 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -8,8 +8,10 @@ config BCM47XX_SSB
 	select SSB_DRIVER_EXTIF
 	select SSB_EMBEDDED
 	select SSB_B43_PCI_BRIDGE if PCI
+	select SSB_DRIVER_PCICORE if PCI
 	select SSB_PCICORE_HOSTMODE if PCI
 	select SSB_DRIVER_GPIO
+	select GPIOLIB
 	default y
 	help
 	 Add support for old Broadcom BCM47xx boards with Sonics Silicon Backplane support.
@@ -25,6 +27,7 @@ config BCM47XX_BCMA
 	select BCMA_HOST_PCI if PCI
 	select BCMA_DRIVER_PCI_HOSTMODE if PCI
 	select BCMA_DRIVER_GPIO
+	select GPIOLIB
 	default y
 	help
 	 Add support for new Broadcom BCM47xx boards with Broadcom specific Advanced Microcontroller Bus.
-- 
1.7.10.4
