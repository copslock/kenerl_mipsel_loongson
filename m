Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 16:36:03 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:34786 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022314AbXCMQf6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Mar 2007 16:35:58 +0000
Received: from localhost (p8240-ipad202funabasi.chiba.ocn.ne.jp [222.146.79.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C3EA09F86; Wed, 14 Mar 2007 01:34:36 +0900 (JST)
Date:	Wed, 14 Mar 2007 01:34:36 +0900 (JST)
Message-Id: <20070314.013436.123671678.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Add __user tags to {save,restore}_fp_context variants
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
X-archive-position: 14456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/traps.c            |   28 ++++++++++++++--------------
 arch/mips/math-emu/kernel_linkage.c |    8 ++++----
 include/asm-mips/fpu.h              |    8 ++++----
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 31c897b..7d76a85 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1249,24 +1249,24 @@ static inline void mips_srs_init(void)
 /*
  * This is used by native signal handling
  */
-asmlinkage int (*save_fp_context)(struct sigcontext *sc);
-asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
+asmlinkage int (*save_fp_context)(struct sigcontext __user *sc);
+asmlinkage int (*restore_fp_context)(struct sigcontext __user *sc);
 
-extern asmlinkage int _save_fp_context(struct sigcontext *sc);
-extern asmlinkage int _restore_fp_context(struct sigcontext *sc);
+extern asmlinkage int _save_fp_context(struct sigcontext __user *sc);
+extern asmlinkage int _restore_fp_context(struct sigcontext __user *sc);
 
-extern asmlinkage int fpu_emulator_save_context(struct sigcontext *sc);
-extern asmlinkage int fpu_emulator_restore_context(struct sigcontext *sc);
+extern asmlinkage int fpu_emulator_save_context(struct sigcontext __user *sc);
+extern asmlinkage int fpu_emulator_restore_context(struct sigcontext __user *sc);
 
 #ifdef CONFIG_SMP
-static int smp_save_fp_context(struct sigcontext *sc)
+static int smp_save_fp_context(struct sigcontext __user *sc)
 {
 	return raw_cpu_has_fpu
 	       ? _save_fp_context(sc)
 	       : fpu_emulator_save_context(sc);
 }
 
-static int smp_restore_fp_context(struct sigcontext *sc)
+static int smp_restore_fp_context(struct sigcontext __user *sc)
 {
 	return raw_cpu_has_fpu
 	       ? _restore_fp_context(sc)
@@ -1296,14 +1296,14 @@ static inline void signal_init(void)
 /*
  * This is used by 32-bit signal stuff on the 64-bit kernel
  */
-asmlinkage int (*save_fp_context32)(struct sigcontext32 *sc);
-asmlinkage int (*restore_fp_context32)(struct sigcontext32 *sc);
+asmlinkage int (*save_fp_context32)(struct sigcontext32 __user *sc);
+asmlinkage int (*restore_fp_context32)(struct sigcontext32 __user *sc);
 
-extern asmlinkage int _save_fp_context32(struct sigcontext32 *sc);
-extern asmlinkage int _restore_fp_context32(struct sigcontext32 *sc);
+extern asmlinkage int _save_fp_context32(struct sigcontext32 __user *sc);
+extern asmlinkage int _restore_fp_context32(struct sigcontext32 __user *sc);
 
-extern asmlinkage int fpu_emulator_save_context32(struct sigcontext32 *sc);
-extern asmlinkage int fpu_emulator_restore_context32(struct sigcontext32 *sc);
+extern asmlinkage int fpu_emulator_save_context32(struct sigcontext32 __user *sc);
+extern asmlinkage int fpu_emulator_restore_context32(struct sigcontext32 __user *sc);
 
 static inline void signal32_init(void)
 {
diff --git a/arch/mips/math-emu/kernel_linkage.c b/arch/mips/math-emu/kernel_linkage.c
index 5b3390f..ed49ef0 100644
--- a/arch/mips/math-emu/kernel_linkage.c
+++ b/arch/mips/math-emu/kernel_linkage.c
@@ -51,7 +51,7 @@ void fpu_emulator_init_fpu(void)
  * with appropriate macros from uaccess.h
  */
 
-int fpu_emulator_save_context(struct sigcontext *sc)
+int fpu_emulator_save_context(struct sigcontext __user *sc)
 {
 	int i;
 	int err = 0;
@@ -65,7 +65,7 @@ int fpu_emulator_save_context(struct sig
 	return err;
 }
 
-int fpu_emulator_restore_context(struct sigcontext *sc)
+int fpu_emulator_restore_context(struct sigcontext __user *sc)
 {
 	int i;
 	int err = 0;
@@ -84,7 +84,7 @@ int fpu_emulator_restore_context(struct
  * This is the o32 version
  */
 
-int fpu_emulator_save_context32(struct sigcontext32 *sc)
+int fpu_emulator_save_context32(struct sigcontext32 __user *sc)
 {
 	int i;
 	int err = 0;
@@ -98,7 +98,7 @@ int fpu_emulator_save_context32(struct s
 	return err;
 }
 
-int fpu_emulator_restore_context32(struct sigcontext32 *sc)
+int fpu_emulator_restore_context32(struct sigcontext32 __user *sc)
 {
 	int i;
 	int err = 0;
diff --git a/include/asm-mips/fpu.h b/include/asm-mips/fpu.h
index dfecb7b..4e12d1f 100644
--- a/include/asm-mips/fpu.h
+++ b/include/asm-mips/fpu.h
@@ -27,11 +27,11 @@
 struct sigcontext;
 struct sigcontext32;
 
-extern asmlinkage int (*save_fp_context)(struct sigcontext *sc);
-extern asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
+extern asmlinkage int (*save_fp_context)(struct sigcontext __user *sc);
+extern asmlinkage int (*restore_fp_context)(struct sigcontext __user *sc);
 
-extern asmlinkage int (*save_fp_context32)(struct sigcontext32 *sc);
-extern asmlinkage int (*restore_fp_context32)(struct sigcontext32 *sc);
+extern asmlinkage int (*save_fp_context32)(struct sigcontext32 __user *sc);
+extern asmlinkage int (*restore_fp_context32)(struct sigcontext32 __user *sc);
 
 extern void fpu_emulator_init_fpu(void);
 extern void _init_fpu(void);
