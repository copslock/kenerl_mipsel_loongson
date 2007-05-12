Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 May 2007 17:47:10 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:10994 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022005AbXELQrH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 May 2007 17:47:07 +0100
Received: from localhost (p2128-ipad02funabasi.chiba.ocn.ne.jp [61.214.22.128])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9760A8637; Sun, 13 May 2007 01:47:00 +0900 (JST)
Date:	Sun, 13 May 2007 01:47:13 +0900 (JST)
Message-Id: <20070513.014713.74753298.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80705111223y5e94eafcy710b878517c48c48@mail.gmail.com>
References: <cda58cb80705110514g1098de81lec547e774eb76482@mail.gmail.com>
	<20070512.005905.26096031.anemo@mba.ocn.ne.jp>
	<cda58cb80705111223y5e94eafcy710b878517c48c48@mail.gmail.com>
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
X-archive-position: 15050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 11 May 2007 21:23:55 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> Well I'm not sure how revelant are the echos...

Without the echos, you can get something like this and it seems unlear
which ABI should be fixed.

  CALL    /home/git/linux-mips/scripts/checksyscalls.sh
  ...
  CALL    /home/git/linux-mips/scripts/checksyscalls.sh
  ...
  CALL    /home/git/linux-mips/scripts/checksyscalls.sh
  ...

> But I still think that (a) you shouldn't put any command in
> 'archprepare' multiple rule (b) you should move this rule from the
> cleaning targets.

Oh, I missed those points.  Revised again.


Subject: [PATCH] MIPS: Simplify missing-syscalls for N32 and O32

Use standard missing-syscalls with EXTRA_CFLAGS instead of duplicating
the command.  Suggested by Franck Bui-Huu.  Also add "echo" to show
the target ABI.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index f450066..5aa0f41 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -702,6 +702,19 @@ vmlinux.srec: $(vmlinux-32)
 CLEAN_FILES += vmlinux.ecoff \
 	       vmlinux.srec
 
+PHONY += arch-missing-syscalls
+arch-missing-syscalls: prepare1
+ifdef CONFIG_MIPS32_N32
+	@echo '  Checking missing-syscalls for N32'
+	$(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=n32"
+endif
+ifdef CONFIG_MIPS32_O32
+	@echo '  Checking missing-syscalls for O32'
+	$(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=32"
+endif
+
+archprepare: arch-missing-syscalls
+
 archclean:
 	@$(MAKE) $(clean)=arch/mips/boot
 	@$(MAKE) $(clean)=arch/mips/lasat
@@ -709,25 +722,3 @@ archclean:
 CLEAN_FILES += vmlinux.32 \
 	       vmlinux.64 \
 	       vmlinux.ecoff
-
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
-archprepare:
-ifdef CONFIG_MIPS32_N32
-	$(Q)$(MAKE) $(build)=arch/mips missing-syscalls-n32
-endif
-ifdef CONFIG_MIPS32_O32
-	$(Q)$(MAKE) $(build)=arch/mips missing-syscalls-o32
-endif
