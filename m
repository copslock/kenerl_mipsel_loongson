Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2007 15:42:37 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:35780 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023610AbXEIOme (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 May 2007 15:42:34 +0100
Received: from localhost (p3015-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.15])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5DBA2B629; Wed,  9 May 2007 23:42:27 +0900 (JST)
Date:	Wed, 09 May 2007 23:42:38 +0900 (JST)
Message-Id: <20070509.234238.25909573.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: [PATCH] Remove unused CONFIG_TOSHIBA_BOARDS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig                     |    6 ------
 arch/mips/configs/jmr3927_defconfig   |    1 -
 arch/mips/configs/rbhma4500_defconfig |    1 -
 3 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4a4d94c..8959126 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -736,7 +736,6 @@ config TOSHIBA_JMR3927
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
-	select TOSHIBA_BOARDS
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config TOSHIBA_RBTX4927
@@ -752,7 +751,6 @@ config TOSHIBA_RBTX4927
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_KGDB
-	select TOSHIBA_BOARDS
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	  This Toshiba board is based on the TX4927 processor. Say Y here to
@@ -772,7 +770,6 @@ config TOSHIBA_RBTX4938
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_KGDB
-	select TOSHIBA_BOARDS
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	  This Toshiba board is based on the TX4938 processor. Say Y here to
@@ -1086,9 +1083,6 @@ config ARC64
 config BOOT_ELF64
 	bool
 
-config TOSHIBA_BOARDS
-	bool
-
 menu "CPU selection"
 
 choice
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index 068e48e..1b364cf 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -80,7 +80,6 @@ CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
 CONFIG_MIPS_TX3927=y
 CONFIG_SWAP_IO_SPACE=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
-CONFIG_TOSHIBA_BOARDS=y
 
 #
 # CPU selection
diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
index 7d0f217..41011f7 100644
--- a/arch/mips/configs/rbhma4500_defconfig
+++ b/arch/mips/configs/rbhma4500_defconfig
@@ -89,7 +89,6 @@ CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
 CONFIG_SWAP_IO_SPACE=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 CONFIG_HAVE_STD_PC_SERIAL_PORT=y
-CONFIG_TOSHIBA_BOARDS=y
 
 #
 # CPU selection
