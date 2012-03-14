Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:35:28 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:42756 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903730Ab2CNJbL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:31:11 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 125E823C00CA;
        Wed, 14 Mar 2012 10:00:10 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org,
        Imre Kaloz <kaloz@openwrt.org>
Subject: =?UTF-8?q?=5BPATCH=20v3=2012/12=5D=20MIPS=3A=20ath79=3A=20update=20copyright=20headers=20of=20PCI=20related=20files?=
Date:   Wed, 14 Mar 2012 11:36:14 +0100
Message-Id: <1331721374-4144-13-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
References: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add copyright records according to the recent changes in
the PCI code. Also fix up the descriptions.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>

Just in case if someone is curious about why 2008 and 2009 years are
present in this change:

The recent PCI specific changes were based on an existing
code which can be found in the OpenWrt repository, and we
are working on that since 2008.
---
v3: - no changes
v2: - no changes

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
index b12b087..4f2222d 100644
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
