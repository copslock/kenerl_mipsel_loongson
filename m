Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2008 10:42:38 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:56786 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S28574331AbYHAJk3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2008 10:40:29 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 45A1EC8014;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id kVkD3Z9K+mzx; Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id F222FC8016;
	Fri,  1 Aug 2008 12:40:21 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id C02A710806E; Fri,  1 Aug 2008 12:40:21 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	rpjday@crashcourse.ca
Subject: [PATCH 3/7] [MIPS] Remove unused config variable ARCH_SUPPORTS_OPROFILE
Date:	Fri,  1 Aug 2008 12:40:17 +0300
Message-Id: <1217583621-4772-4-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The config variable ARCH_SUPPORTS_OPROFILE is defined but never used,
and this patch removes the fossil.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/Kconfig                        |    4 ----
 arch/mips/configs/bcm47xx_defconfig      |    1 -
 arch/mips/configs/bigsur_defconfig       |    1 -
 arch/mips/configs/ip28_defconfig         |    1 -
 arch/mips/configs/jmr3927_defconfig      |    1 -
 arch/mips/configs/rb532_defconfig        |    1 -
 arch/mips/configs/rbtx49xx_defconfig     |    1 -
 arch/mips/configs/sb1250-swarm_defconfig |    1 -
 arch/mips/configs/tb0219_defconfig       |    1 -
 arch/mips/configs/tb0226_defconfig       |    1 -
 arch/mips/configs/tb0287_defconfig       |    1 -
 11 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fced035..f5e8720 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -633,10 +633,6 @@ config ARCH_HAS_ILOG2_U64
 	bool
 	default n
 
-config ARCH_SUPPORTS_OPROFILE
-	bool
-	default y if !MIPS_MT_SMTC
-
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index 0a81d31..9a59bc5 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -44,7 +44,6 @@ CONFIG_BCM47XX=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 9aa8e6e..5034fd0 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -60,7 +60,6 @@ CONFIG_SIBYTE_HAS_ZBUS_PROFILING=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
diff --git a/arch/mips/configs/ip28_defconfig b/arch/mips/configs/ip28_defconfig
index 7f86d72..2f87189 100644
--- a/arch/mips/configs/ip28_defconfig
+++ b/arch/mips/configs/ip28_defconfig
@@ -44,7 +44,6 @@ CONFIG_SGI_IP28=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index f7e3527..cbacef0 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -47,7 +47,6 @@ CONFIG_PICMG_PCI_BACKPLANE_DEFAULT=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
index 75eee9a..a8ef6bc 100644
--- a/arch/mips/configs/rb532_defconfig
+++ b/arch/mips/configs/rb532_defconfig
@@ -47,7 +47,6 @@ CONFIG_MIKROTIK_RB532=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index c9633d7..15e8a9a 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -57,7 +57,6 @@ CONFIG_PCI_TX4927=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
diff --git a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
index 72cef77..d938f14 100644
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
@@ -62,7 +62,6 @@ CONFIG_SIBYTE_HAS_ZBUS_PROFILING=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
diff --git a/arch/mips/configs/tb0219_defconfig b/arch/mips/configs/tb0219_defconfig
index ebc3662..907a791 100644
--- a/arch/mips/configs/tb0219_defconfig
+++ b/arch/mips/configs/tb0219_defconfig
@@ -54,7 +54,6 @@ CONFIG_PCI_VR41XX=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
diff --git a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
index b8f6ce3..d06d745 100644
--- a/arch/mips/configs/tb0226_defconfig
+++ b/arch/mips/configs/tb0226_defconfig
@@ -54,7 +54,6 @@ CONFIG_PCI_VR41XX=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
diff --git a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
index b3dc2c8..7286994 100644
--- a/arch/mips/configs/tb0287_defconfig
+++ b/arch/mips/configs/tb0287_defconfig
@@ -54,7 +54,6 @@ CONFIG_PCI_VR41XX=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
-- 
1.5.6
