Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2008 10:42:12 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:57298 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S28574330AbYHAJk3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2008 10:40:29 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 2BB87C8011;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id Vu7xFvbgzI7z; Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id EEBA8C8014;
	Fri,  1 Aug 2008 12:40:21 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id BB68A10806D; Fri,  1 Aug 2008 12:40:21 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	rpjday@crashcourse.ca
Subject: [PATCH 1/7] [MIPS] Remove unused config variable MIPS_INSANE_LARGE
Date:	Fri,  1 Aug 2008 12:40:15 +0300
Message-Id: <1217583621-4772-2-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The config variable MIPS_INSANE_LARGE is not used and can be removed.

Build-tested using ip27_defconfig.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/Kconfig                |   10 ----------
 arch/mips/configs/ip27_defconfig |    1 -
 arch/mips/configs/ip28_defconfig |    1 -
 3 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b4c4eaa..8429773 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1831,16 +1831,6 @@ config HZ
 
 source "kernel/Kconfig.preempt"
 
-config MIPS_INSANE_LARGE
-	bool "Support for large 64-bit configurations"
-	depends on CPU_R10000 && 64BIT
-	help
-	  MIPS R10000 does support a 44 bit / 16TB address space as opposed to
-	  previous 64-bit processors which only supported 40 bit / 1TB. If you
-	  need processes of more than 1TB virtual address space, say Y here.
-	  This will result in additional memory usage, so it is not
-	  recommended for normal users.
-
 config KEXEC
 	bool "Kexec system call (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 138c575..bed6016 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -145,7 +145,6 @@ CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
 CONFIG_PREEMPT_BKL=y
-# CONFIG_MIPS_INSANE_LARGE is not set
 # CONFIG_KEXEC is not set
 CONFIG_SECCOMP=y
 CONFIG_LOCKDEP_SUPPORT=y
diff --git a/arch/mips/configs/ip28_defconfig b/arch/mips/configs/ip28_defconfig
index 822b01f..3540707 100644
--- a/arch/mips/configs/ip28_defconfig
+++ b/arch/mips/configs/ip28_defconfig
@@ -160,7 +160,6 @@ CONFIG_HZ=250
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
 # CONFIG_RCU_TRACE is not set
-# CONFIG_MIPS_INSANE_LARGE is not set
 # CONFIG_KEXEC is not set
 CONFIG_SECCOMP=y
 CONFIG_LOCKDEP_SUPPORT=y
-- 
1.5.6
