Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2007 16:04:40 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:36833 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023178AbXKKQEb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2007 16:04:31 +0000
Received: from localhost (p5137-ipad310funabasi.chiba.ocn.ne.jp [123.217.207.137])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F38568EEB; Mon, 12 Nov 2007 01:03:09 +0900 (JST)
Date:	Mon, 12 Nov 2007 01:05:16 +0900 (JST)
Message-Id: <20071112.010516.126571959.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Move kernel/time/Kconfig menu to appropriate place
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
X-archive-position: 17463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

CONFIG_NO_HZ, CONFIG_HIGH_RES_TIMERS should be selected in "Kernel
type" menu, not in "CPU selection" menu.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2f2ce0c..2ee0330 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -961,8 +961,6 @@ config BOOT_ELF64
 
 menu "CPU selection"
 
-source "kernel/time/Kconfig"
-
 choice
 	prompt "CPU type"
 	default CPU_R4X00
@@ -1734,6 +1732,8 @@ config NR_CPUS
 	  performance should round up your number of processors to the next
 	  power of two.
 
+source "kernel/time/Kconfig"
+
 #
 # Timer Interrupt Frequency Configuration
 #
