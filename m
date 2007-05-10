Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 May 2007 17:02:31 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:54480 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022873AbXEJQC0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 May 2007 17:02:26 +0100
Received: from localhost (p2187-ipad03funabasi.chiba.ocn.ne.jp [219.160.82.187])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AF0CDB7E1; Fri, 11 May 2007 01:02:22 +0900 (JST)
Date:	Fri, 11 May 2007 01:02:34 +0900 (JST)
Message-Id: <20070511.010234.74566169.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sam@ravnborg.org
Subject: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
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
X-archive-position: 15018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On 64-bit MIPS, only N64 ABI is checked by default.  This patch adds
some rules for other ABIs.  This results in these warnings at the
moment:

  CALL-N32 /home/git/linux-mips/scripts/checksyscalls.sh
<stdin>:148:2: warning: #warning syscall time not implemented
<stdin>:424:2: warning: #warning syscall select not implemented
<stdin>:440:2: warning: #warning syscall uselib not implemented
<stdin>:856:2: warning: #warning syscall vfork not implemented
<stdin>:868:2: warning: #warning syscall truncate64 not implemented
<stdin>:872:2: warning: #warning syscall ftruncate64 not implemented
<stdin>:876:2: warning: #warning syscall stat64 not implemented
<stdin>:880:2: warning: #warning syscall lstat64 not implemented
<stdin>:884:2: warning: #warning syscall fstat64 not implemented
<stdin>:980:2: warning: #warning syscall getdents64 not implemented
<stdin>:1176:2: warning: #warning syscall fadvise64_64 not implemented
<stdin>:1284:2: warning: #warning syscall fstatat64 not implemented
<stdin>:1364:2: warning: #warning syscall utimensat not implemented
  CALL-O32 /home/git/linux-mips/scripts/checksyscalls.sh
<stdin>:424:2: warning: #warning syscall select not implemented
<stdin>:856:2: warning: #warning syscall vfork not implemented
<stdin>:1176:2: warning: #warning syscall fadvise64_64 not implemented
<stdin>:1364:2: warning: #warning syscall utimensat not implemented
  CALL    /home/git/linux-mips/scripts/checksyscalls.sh
<stdin>:148:2: warning: #warning syscall time not implemented
<stdin>:424:2: warning: #warning syscall select not implemented
<stdin>:440:2: warning: #warning syscall uselib not implemented
<stdin>:856:2: warning: #warning syscall vfork not implemented
<stdin>:980:2: warning: #warning syscall getdents64 not implemented
<stdin>:1364:2: warning: #warning syscall utimensat not implemented

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index a68d462..f450066 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -709,3 +709,25 @@ archclean:
 CLEAN_FILES += vmlinux.32 \
 	       vmlinux.64 \
 	       vmlinux.ecoff
+
+quiet_cmd_syscalls_n32 = CALL-N32 $<
+      cmd_syscalls_n32 = $(CONFIG_SHELL) $< $(CC) $(c_flags) -mabi=n32
+
+quiet_cmd_syscalls_o32 = CALL-O32 $<
+      cmd_syscalls_o32 = $(CONFIG_SHELL) $< $(CC) $(c_flags) -mabi=32
+
+PHONY += missing-syscalls-n32 missing-syscalls-o32
+
+missing-syscalls-n32: scripts/checksyscalls.sh FORCE
+	$(call cmd,syscalls_n32)
+
+missing-syscalls-o32: scripts/checksyscalls.sh FORCE
+	$(call cmd,syscalls_o32)
+
+archprepare:
+ifdef CONFIG_MIPS32_N32
+	$(Q)$(MAKE) $(build)=arch/mips missing-syscalls-n32
+endif
+ifdef CONFIG_MIPS32_O32
+	$(Q)$(MAKE) $(build)=arch/mips missing-syscalls-o32
+endif
