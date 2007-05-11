Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 16:59:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:46557 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28573712AbXEKP66 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 16:58:58 +0100
Received: from localhost (p6018-ipad206funabasi.chiba.ocn.ne.jp [222.145.80.18])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A5214A9EC; Sat, 12 May 2007 00:58:52 +0900 (JST)
Date:	Sat, 12 May 2007 00:59:05 +0900 (JST)
Message-Id: <20070512.005905.26096031.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80705110514g1098de81lec547e774eb76482@mail.gmail.com>
References: <20070511.010234.74566169.anemo@mba.ocn.ne.jp>
	<cda58cb80705110514g1098de81lec547e774eb76482@mail.gmail.com>
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
X-archive-position: 15044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 11 May 2007 14:14:47 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> or can't we do instead:
> 
> $(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=n32"
> 
> and get rid of "missing-syscalls-n32" rule. Thus this avoids to
> duplicate "missing-syscalls" command.

Thank you for suggestion.  How about this?


Subject: [PATCH] MIPS: Simplify missing-syscalls for N32 and O32

Use standard missing-syscalls with EXTRA_CFLAGS instead of duplicating
the command.  Suggested by Franck Bui-Huu.  Also add "echo" to show
the target ABI.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index f450066..25c7318 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -710,24 +710,12 @@ CLEAN_FILES += vmlinux.32 \
 	       vmlinux.64 \
 	       vmlinux.ecoff
 
-quiet_cmd_syscalls_n32 = CALL-N32 $<
-      cmd_syscalls_n32 = $(CONFIG_SHELL) $< $(CC) $(c_flags) -mabi=n32
-
-quiet_cmd_syscalls_o32 = CALL-O32 $<
-      cmd_syscalls_o32 = $(CONFIG_SHELL) $< $(CC) $(c_flags) -mabi=32
-
-PHONY += missing-syscalls-n32 missing-syscalls-o32
-
-missing-syscalls-n32: scripts/checksyscalls.sh FORCE
-	$(call cmd,syscalls_n32)
-
-missing-syscalls-o32: scripts/checksyscalls.sh FORCE
-	$(call cmd,syscalls_o32)
-
 archprepare:
 ifdef CONFIG_MIPS32_N32
-	$(Q)$(MAKE) $(build)=arch/mips missing-syscalls-n32
+	@echo '  Checking missing-syscalls for N32'
+	$(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=n32"
 endif
 ifdef CONFIG_MIPS32_O32
-	$(Q)$(MAKE) $(build)=arch/mips missing-syscalls-o32
+	@echo '  Checking missing-syscalls for O32'
+	$(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=32"
 endif
