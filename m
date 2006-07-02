Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jul 2006 16:08:50 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:14836 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133546AbWGBPIl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Jul 2006 16:08:41 +0100
Received: from localhost (p6162-ipad210funabasi.chiba.ocn.ne.jp [58.88.125.162])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 439C2B49A; Mon,  3 Jul 2006 00:08:35 +0900 (JST)
Date:	Mon, 03 Jul 2006 00:09:47 +0900 (JST)
Message-Id: <20060703.000947.74752434.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] make SPARSEMEM selectable on QEMU
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This might be helpfull to debug sparsemem on mips.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 58e68ce..f151a7e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -554,6 +554,7 @@ config QEMU
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
+	select ARCH_SPARSEMEM_ENABLE
 	help
 	  Qemu is a software emulator which among other architectures also
 	  can simulate a MIPS32 4Kc system.  This patch adds support for the
@@ -1687,6 +1688,9 @@ config ARCH_DISCONTIGMEM_ENABLE
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa> for more.
 
+config ARCH_SPARSEMEM_ENABLE
+	bool
+
 config NUMA
 	bool "NUMA Support"
 	depends on SYS_SUPPORTS_NUMA
