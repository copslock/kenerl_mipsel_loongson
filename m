Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2006 14:40:13 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:14066 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037591AbWIFNkL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2006 14:40:11 +0100
Received: from localhost (p4200-ipad31funabasi.chiba.ocn.ne.jp [221.189.128.200])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9FC05AB65; Wed,  6 Sep 2006 22:40:06 +0900 (JST)
Date:	Wed, 06 Sep 2006 22:42:02 +0900 (JST)
Message-Id: <20060906.224202.25912085.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, drow@false.org, kaz@zeugmasystems.com
Subject: [PATCH] Wire up set_robust_list(2) and get_robust_list(2)
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
X-archive-position: 12520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/kernel/scall32-o32.S |    2 ++
 arch/mips/kernel/scall64-64.S  |    2 ++
 arch/mips/kernel/scall64-n32.S |    4 +++-
 arch/mips/kernel/scall64-o32.S |    2 ++
 include/asm-mips/unistd.h      |   18 ++++++++++++------
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index ba1bcd8..e717851 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -662,6 +662,8 @@ #endif /* CONFIG_MIPS_MT_FPAFF */
 	sys	sys_tee			4
 	sys	sys_vmsplice		4
 	sys	sys_move_pages		6
+	sys	sys_set_robust_list	2
+	sys	sys_get_robust_list	3
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 939e172..4c22d0b 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -466,3 +466,5 @@ sys_call_table:
 	PTR	sys_tee				/* 5265 */
 	PTR	sys_vmsplice
 	PTR	sys_move_pages
+	PTR	sys_set_robust_list
+	PTR	sys_get_robust_list
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 549b4bc..f25c2a2 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -390,5 +390,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_splice
 	PTR	sys_sync_file_range
 	PTR	sys_tee
-	PTR	sys_vmsplice			/* 6271 */
+	PTR	sys_vmsplice			/* 6270 */
 	PTR	sys_move_pages
+	PTR	compat_sys_set_robust_list
+	PTR	compat_sys_get_robust_list
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 505c9ee..2ac0141 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -514,4 +514,6 @@ sys_call_table:
 	PTR	sys_tee
 	PTR	sys_vmsplice
 	PTR	compat_sys_move_pages
+	PTR	compat_sys_set_robust_list
+	PTR	compat_sys_get_robust_list	/* 4310 */
 	.size	sys_call_table,.-sys_call_table
diff --git a/include/asm-mips/unistd.h b/include/asm-mips/unistd.h
index 610ccb8..558e3cb 100644
--- a/include/asm-mips/unistd.h
+++ b/include/asm-mips/unistd.h
@@ -329,16 +329,18 @@ #define __NR_sync_file_range		(__NR_Linu
 #define __NR_tee			(__NR_Linux + 306)
 #define __NR_vmsplice			(__NR_Linux + 307)
 #define __NR_move_pages			(__NR_Linux + 308)
+#define __NR_set_robust_list		(__NR_Linux + 309)
+#define __NR_get_robust_list		(__NR_Linux + 310)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		308
+#define __NR_Linux_syscalls		310
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		308
+#define __NR_O32_Linux_syscalls		310
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -614,16 +616,18 @@ #define __NR_sync_file_range		(__NR_Linu
 #define __NR_tee			(__NR_Linux + 265)
 #define __NR_vmsplice			(__NR_Linux + 266)
 #define __NR_move_pages			(__NR_Linux + 267)
+#define __NR_set_robust_list		(__NR_Linux + 268)
+#define __NR_get_robust_list		(__NR_Linux + 269)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		267
+#define __NR_Linux_syscalls		269
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		267
+#define __NR_64_Linux_syscalls		269
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -903,16 +907,18 @@ #define __NR_sync_file_range		(__NR_Linu
 #define __NR_tee			(__NR_Linux + 269)
 #define __NR_vmsplice			(__NR_Linux + 270)
 #define __NR_move_pages			(__NR_Linux + 271)
+#define __NR_set_robust_list		(__NR_Linux + 272)
+#define __NR_get_robust_list		(__NR_Linux + 273)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		271
+#define __NR_Linux_syscalls		273
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		271
+#define __NR_N32_Linux_syscalls		273
 
 #ifdef __KERNEL__
 
