Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 14:29:21 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:40665 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20046699AbXAPO3Q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2007 14:29:16 +0000
Received: from localhost (p1128-ipad01funabasi.chiba.ocn.ne.jp [61.126.134.129])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 958ADA2BA; Tue, 16 Jan 2007 23:29:11 +0900 (JST)
Date:	Tue, 16 Jan 2007 23:29:11 +0900 (JST)
Message-Id: <20070116.232911.126576645.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] kconfig: move some entries to appropriate menu
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
X-archive-position: 13609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Currently KEXEC is in "Machine selection", SECCOMP, PM, APM are in
"Executable file formats" menu.  Move KEXEC and SECCOMP to "Kernel
type" and PM, APM to new "Power management options" menu.  Also
replace "config PM" with kernel/power/Kconfig.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 07f1b43..77a434b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -790,23 +790,6 @@ config TOSHIBA_RBTX4938
 
 endchoice
 
-config KEXEC
- 	bool "Kexec system call (EXPERIMENTAL)"
- 	depends on EXPERIMENTAL
- 	help
- 	  kexec is a system call that implements the ability to shutdown your
- 	  current kernel, and to start another kernel.  It is like a reboot
- 	  but it is indepedent of the system firmware.   And like a reboot
- 	  you can start any kernel with it, not just Linux.
-
- 	  The name comes from the similiarity to the exec system call.
-
- 	  It is an ongoing process to be certain the hardware in a machine
- 	  is properly shutdown, so do not be surprised if this code does not
- 	  initially work for you.  It may help to enable device hotplugging
- 	  support.  As of this writing the exact hardware interface is
- 	  strongly in flux, so no good recommendation can be made.
-
 source "arch/mips/ddb5xxx/Kconfig"
 source "arch/mips/gt64120/ev64120/Kconfig"
 source "arch/mips/jazz/Kconfig"
@@ -1845,6 +1828,40 @@ config MIPS_INSANE_LARGE
 	  This will result in additional memory usage, so it is not
 	  recommended for normal users.
 
+config KEXEC
+ 	bool "Kexec system call (EXPERIMENTAL)"
+ 	depends on EXPERIMENTAL
+ 	help
+ 	  kexec is a system call that implements the ability to shutdown your
+ 	  current kernel, and to start another kernel.  It is like a reboot
+ 	  but it is indepedent of the system firmware.   And like a reboot
+ 	  you can start any kernel with it, not just Linux.
+
+ 	  The name comes from the similiarity to the exec system call.
+
+ 	  It is an ongoing process to be certain the hardware in a machine
+ 	  is properly shutdown, so do not be surprised if this code does not
+ 	  initially work for you.  It may help to enable device hotplugging
+ 	  support.  As of this writing the exact hardware interface is
+ 	  strongly in flux, so no good recommendation can be made.
+
+config SECCOMP
+	bool "Enable seccomp to safely compute untrusted bytecode"
+	depends on PROC_FS && BROKEN
+	default y
+	help
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via /proc/<pid>/seccomp, it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
+
+	  If unsure, say Y. Only embedded should say N here.
+
 endmenu
 
 config RWSEM_GENERIC_SPINLOCK
@@ -2011,26 +2028,12 @@ config BINFMT_ELF32
 	bool
 	default y if MIPS32_O32 || MIPS32_N32
 
-config SECCOMP
-	bool "Enable seccomp to safely compute untrusted bytecode"
-	depends on PROC_FS && BROKEN
-	default y
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via /proc/<pid>/seccomp, it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
+endmenu
 
-	  If unsure, say Y. Only embedded should say N here.
+menu "Power management options (EXPERIMENTAL)"
+depends on EXPERIMENTAL && SOC_AU1X00
 
-config PM
-	bool "Power Management support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SOC_AU1X00
+source kernel/power/Kconfig
 
 config APM
         tristate "Advanced Power Management Emulation"
