Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2007 16:46:01 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:20176 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023487AbXEQPp7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2007 16:45:59 +0100
Received: from localhost (p7084-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.84])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D95FEBA46; Fri, 18 May 2007 00:45:55 +0900 (JST)
Date:	Fri, 18 May 2007 00:46:13 +0900 (JST)
Message-Id: <20070518.004613.128618652.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, kraj@mvista.com, libc-ports@sourceware.org
Subject: Re: [PATCH] Fix some system calls with long long arguments
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070316.015325.118975069.anemo@mba.ocn.ne.jp>
References: <20070309.003749.39154822.anemo@mba.ocn.ne.jp>
	<20070315.103511.89758184.nemoto@toshiba-tops.co.jp>
	<20070316.015325.118975069.anemo@mba.ocn.ne.jp>
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
X-archive-position: 15078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 16 Mar 2007 01:53:25 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > Anyway we should take some action while current implementation is
> > broken (except N64).
> > 
> > Which is a way to go?
> 
> Here is a sample fix for N32 readahead and sync_file_range.

I fixed N32/O32 readahead, sync_file_range, fadvise, fadvise64
syscalls on both kernel and glibc side.

Here is a kernel side fixes.


Subject: [PATCH] Fix some system calls with long long arguments

* O32 fadvise64() pass long long arguments by register pairs.  Add
  sys32 version for 64 bit kernel.
* N32 readahead() can pass a long long argument by one register.  No
  need to use sys32_readahead.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/linux32.c     |   10 ++++++++++
 arch/mips/kernel/scall64-n32.S |    2 +-
 arch/mips/kernel/scall64-o32.S |    2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 37849ed..06e04da 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -556,6 +556,16 @@ asmlinkage long sys32_sync_file_range(int fd, int __pad,
 			flags);
 }
 
+asmlinkage long sys32_fadvise64_64(int fd, int __pad,
+	unsigned long a2, unsigned long a3,
+	unsigned long a4, unsigned long a5,
+	int flags)
+{
+	return sys_fadvise64_64(fd,
+			merge_64(a2, a3), merge_64(a4, a5),
+			flags);
+}
+
 save_static_function(sys32_clone);
 __attribute_used__ noinline static int
 _sys32_clone(nabi_no_regargs struct pt_regs regs)
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 6eac283..1631035 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -299,7 +299,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_ni_syscall			/* res. for afs_syscall */
 	PTR	sys_ni_syscall			/* res. for security */
 	PTR	sys_gettid
-	PTR	sys32_readahead
+	PTR	sys_readahead
 	PTR	sys_setxattr			/* 6180 */
 	PTR	sys_lsetxattr
 	PTR	sys_fsetxattr
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 7e74b41..2aa9942 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -459,7 +459,7 @@ sys_call_table:
 	PTR	sys_remap_file_pages
 	PTR	sys_set_tid_address
 	PTR	sys_restart_syscall
-	PTR	sys_fadvise64_64
+	PTR	sys32_fadvise64_64
 	PTR	compat_sys_statfs64		/* 4255 */
 	PTR	compat_sys_fstatfs64
 	PTR	compat_sys_timer_create
