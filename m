Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2008 10:44:17 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:61650 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S28574356AbYHAJkg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2008 10:40:36 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id B792CC8092;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id tZMOxOEub0Tb; Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 144D6C808B;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id D8DF8108073; Fri,  1 Aug 2008 12:40:21 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	rpjday@crashcourse.ca
Subject: [PATCH 7/7] [MIPS] Remove unused config variable MIPS_DISABLE_OBSOLETE_IDE
Date:	Fri,  1 Aug 2008 12:40:21 +0300
Message-Id: <1217583621-4772-8-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The config variable MIPS_DISABLE_OBSOLETE_IDE is never used
in the kernel code. Let's remove the superfluous variable.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/Kconfig                  |    3 ---
 arch/mips/au1000/Kconfig           |    5 -----
 arch/mips/configs/db1200_defconfig |    1 -
 arch/mips/configs/db1500_defconfig |    1 -
 arch/mips/configs/db1550_defconfig |    1 -
 arch/mips/configs/pb1550_defconfig |    1 -
 6 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a49863c..4b20f2e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -760,9 +760,6 @@ config MIPS_MSC
 config MIPS_NILE4
 	bool
 
-config MIPS_DISABLE_OBSOLETE_IDE
-	bool
-
 config SYNC_R4K
 	bool
 
diff --git a/arch/mips/au1000/Kconfig b/arch/mips/au1000/Kconfig
index 1fe97cc..9ad89cc 100644
--- a/arch/mips/au1000/Kconfig
+++ b/arch/mips/au1000/Kconfig
@@ -33,7 +33,6 @@ config MIPS_DB1200
 	bool "Alchemy DB1200 board"
 	select SOC_AU1200
 	select DMA_COHERENT
-	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_DB1500
@@ -41,7 +40,6 @@ config MIPS_DB1500
 	select SOC_AU1500
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -50,7 +48,6 @@ config MIPS_DB1550
 	select SOC_AU1550
 	select HW_HAS_PCI
 	select DMA_NONCOHERENT
-	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_MIRAGE
@@ -79,7 +76,6 @@ config MIPS_PB1200
 	bool "Alchemy PB1200 board"
 	select SOC_AU1200
 	select DMA_NONCOHERENT
-	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_PB1500
@@ -94,7 +90,6 @@ config MIPS_PB1550
 	select SOC_AU1550
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_XXS1500
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index 3842902..dd784cd 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -62,7 +62,6 @@ CONFIG_GENERIC_TIME=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 # CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
 CONFIG_DMA_COHERENT=y
-CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
diff --git a/arch/mips/configs/db1500_defconfig b/arch/mips/configs/db1500_defconfig
index 2c64da0..5514692 100644
--- a/arch/mips/configs/db1500_defconfig
+++ b/arch/mips/configs/db1500_defconfig
@@ -63,7 +63,6 @@ CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 # CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
-CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
diff --git a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
index becccf7..628314c 100644
--- a/arch/mips/configs/db1550_defconfig
+++ b/arch/mips/configs/db1550_defconfig
@@ -63,7 +63,6 @@ CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 # CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
-CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
diff --git a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
index 06ed223..d02dc2f 100644
--- a/arch/mips/configs/pb1550_defconfig
+++ b/arch/mips/configs/pb1550_defconfig
@@ -63,7 +63,6 @@ CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 # CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
-CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
-- 
1.5.6
