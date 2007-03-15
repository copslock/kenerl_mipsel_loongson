Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2007 16:54:51 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:41417 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022457AbXCOQyq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2007 16:54:46 +0000
Received: from localhost (p4042-ipad27funabasi.chiba.ocn.ne.jp [220.107.195.42])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2C94EBA1C; Fri, 16 Mar 2007 01:53:26 +0900 (JST)
Date:	Fri, 16 Mar 2007 01:53:25 +0900 (JST)
Message-Id: <20070316.015325.118975069.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, kraj@mvista.com, libc-ports@sourceware.org
Subject: Re: [PATCH] Fix some system calls with long long arguments
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070315.103511.89758184.nemoto@toshiba-tops.co.jp>
References: <20070307.231410.15268922.anemo@mba.ocn.ne.jp>
	<20070309.003749.39154822.anemo@mba.ocn.ne.jp>
	<20070315.103511.89758184.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 14487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 15 Mar 2007 10:35:11 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> I think this patch has less maintainance cost but a little bit slow.
> 
> These syscalls can be a little bit faster, but needs more works on
> glibc (and uClibc, etc.) side.
> 
> Anyway we should take some action while current implementation is
> broken (except N64).
> 
> Which is a way to go?

Here is a sample fix for N32 readahead and sync_file_range.

For kernel:
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

For glibc:
--- glibc-ports-2.5.org/sysdeps/unix/sysv/linux/mips/mips64/n32/syscalls.list	1970-01-01 09:00:00.000000000 +0900
+++ glibc-ports-2.5/sysdeps/unix/sysv/linux/mips/mips64/n32/syscalls.list	2007-03-16 00:24:21.000000000 +0900
@@ -0,0 +1,4 @@
+# File name	Caller	Syscall name	# args	Strong name	Weak names
+
+readahead	-	readahead	i:iii	__readahead	readahead
+sync_file_range	-	sync_file_range	i:iiii	sync_file_range


Is this approach preferred?
