Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 18:59:10 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:42058 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904617Ab1KXR4e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Nov 2011 18:56:34 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id B6B6D140505;
        Thu, 24 Nov 2011 18:56:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WIV3u4wXP3Z8; Thu, 24 Nov 2011 18:56:33 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id A4CC114051D;
        Thu, 24 Nov 2011 18:56:24 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?q?Ren=C3=A9=20Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2 12/12] MIPS: ath79: update copyright headers of PCI related files
Date:   Thu, 24 Nov 2011 18:56:07 +0100
Message-Id: <1322157367-31089-13-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1322157367-31089-1-git-send-email-juhosg@openwrt.org>
References: <1322157367-31089-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21014

Add copyright records according to the recent changes in
the PCI code. Also fix up the descriptions.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
v2: - no changes

Just in case if someone is curious about why 2008 and 2009 years are
present in this change:

The recent PCI specific changes were based on an existing
code which can be found in the OpenWrt repository, and we
are working on that since 2008.

 arch/mips/ath79/pci.c                  |    4 ++++
 arch/mips/ath79/pci.h                  |    4 +++-
 arch/mips/include/asm/mach-ath79/pci.h |    4 +++-
 arch/mips/pci/pci-ar724x.c             |    3 ++-
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index 253a382..bc40070 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -2,6 +2,10 @@
  *  Atheros AR71XX/AR724X specific PCI setup code
  *
  *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15 BSP
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
diff --git a/arch/mips/ath79/pci.h b/arch/mips/ath79/pci.h
index 5ebed21..51c6625 100644
--- a/arch/mips/ath79/pci.h
+++ b/arch/mips/ath79/pci.h
@@ -1,7 +1,9 @@
 /*
- *  Atheros 724x PCI support
+ *  Atheros AR71XX/AR724X PCI support
  *
  *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
diff --git a/arch/mips/include/asm/mach-ath79/pci.h b/arch/mips/include/asm/mach-ath79/pci.h
index a3d0655..58d065f 100644
--- a/arch/mips/include/asm/mach-ath79/pci.h
+++ b/arch/mips/include/asm/mach-ath79/pci.h
@@ -1,7 +1,9 @@
 /*
- *  Atheros 724x PCI support
+ *  Atheros AR71XX/AR724X PCI support
  *
  *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 04f433a..414a745 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -1,7 +1,8 @@
 /*
- *  Atheros 724x PCI support
+ *  Atheros AR724X PCI host controller driver
  *
  *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
+ *  Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
-- 
1.7.2.1
