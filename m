Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Mar 2007 16:03:05 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:19450 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022776AbXCQQDA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 Mar 2007 16:03:00 +0000
Received: from localhost (p4213-ipad32funabasi.chiba.ocn.ne.jp [221.189.136.213])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EF664B7DE; Sun, 18 Mar 2007 01:01:39 +0900 (JST)
Date:	Sun, 18 Mar 2007 01:01:39 +0900 (JST)
Message-Id: <20070318.010139.126141710.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix Symmetric Uniprocessor support for Qemu
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
X-archive-position: 14522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Might be useful for SMP debugging.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig      |    6 ++++--
 arch/mips/qemu/q-smp.c |    7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1f98b6c..c7c07a2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -542,6 +542,7 @@ config QEMU
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select ARCH_SPARSEMEM_ENABLE
 	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select SYS_SUPPORTS_SMP
 	help
 	  Qemu is a software emulator which among other architectures also
 	  can simulate a MIPS32 4Kc system.  This patch adds support for the
@@ -1824,9 +1825,10 @@ config NR_CPUS_DEFAULT_64
 	bool
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-64)"
-	range 2 64
+	int "Maximum number of CPUs (2-64)" if !QEMU
+	range 2 64 if !QEMU
 	depends on SMP
+	default "1" if QEMU
 	default "2" if NR_CPUS_DEFAULT_2
 	default "4" if NR_CPUS_DEFAULT_4
 	default "8" if NR_CPUS_DEFAULT_8
diff --git a/arch/mips/qemu/q-smp.c b/arch/mips/qemu/q-smp.c
index 5a12354..786bbfa 100644
--- a/arch/mips/qemu/q-smp.c
+++ b/arch/mips/qemu/q-smp.c
@@ -46,3 +46,10 @@ void __init prom_prepare_cpus(unsigned i
 void prom_boot_secondary(int cpu, struct task_struct *idle)
 {
 }
+
+void __init plat_smp_setup(void)
+{
+}
+void __init plat_prepare_cpus(unsigned int max_cpus)
+{
+}
