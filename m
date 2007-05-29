Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 May 2007 16:37:50 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:33787 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022737AbXE2Phq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 May 2007 16:37:46 +0100
Received: from localhost (p1139-ipad32funabasi.chiba.ocn.ne.jp [221.189.133.139])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 25589A475; Wed, 30 May 2007 00:37:42 +0900 (JST)
Date:	Wed, 30 May 2007 00:38:07 +0900 (JST)
Message-Id: <20070530.003807.118974661.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070513.014713.74753298.anemo@mba.ocn.ne.jp>
References: <20070512.005905.26096031.anemo@mba.ocn.ne.jp>
	<cda58cb80705111223y5e94eafcy710b878517c48c48@mail.gmail.com>
	<20070513.014713.74753298.anemo@mba.ocn.ne.jp>
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
X-archive-position: 15187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 13 May 2007 01:47:13 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > But I still think that (a) you shouldn't put any command in
> > 'archprepare' multiple rule (b) you should move this rule from the
> > cleaning targets.
> 
> Oh, I missed those points.  Revised again.

Well, I changed my mind.  I suppose putting commands on archprepare in
arch's Makefile would be OK while the toplevel Makefile gives only a
dependency rule for the target.


Subject: [PATCH] MIPS: Simplify missing-syscalls for N32 and O32

Use standard missing-syscalls with EXTRA_CFLAGS instead of duplicating
the command.  And move the archprepare rule before the archclean rule.
Suggested by Franck Bui-Huu.  Also add "echo" to show the target ABI.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index f450066..2b19605 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -702,6 +702,16 @@ vmlinux.srec: $(vmlinux-32)
 CLEAN_FILES += vmlinux.ecoff \
 	       vmlinux.srec
 
+archprepare:
+ifdef CONFIG_MIPS32_N32
+	@echo '  Checking missing-syscalls for N32'
+	$(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=n32"
+endif
+ifdef CONFIG_MIPS32_O32
+	@echo '  Checking missing-syscalls for O32'
+	$(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=32"
+endif
+
 archclean:
 	@$(MAKE) $(clean)=arch/mips/boot
 	@$(MAKE) $(clean)=arch/mips/lasat
@@ -709,25 +719,3 @@ archclean:
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
