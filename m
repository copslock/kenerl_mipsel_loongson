Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2007 16:49:05 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:30203 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023488AbXEQPtD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2007 16:49:03 +0100
Received: from localhost (p7084-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.84])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A867EB957; Fri, 18 May 2007 00:47:42 +0900 (JST)
Date:	Fri, 18 May 2007 00:47:59 +0900 (JST)
Message-Id: <20070518.004759.59650774.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, kraj@mvista.com, libc-ports@sourceware.org
Subject: Re: [PATCH] Fix some system calls with long long arguments
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070518.004613.128618652.anemo@mba.ocn.ne.jp>
References: <20070315.103511.89758184.nemoto@toshiba-tops.co.jp>
	<20070316.015325.118975069.anemo@mba.ocn.ne.jp>
	<20070518.004613.128618652.anemo@mba.ocn.ne.jp>
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
X-archive-position: 15079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 18 May 2007 00:46:13 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> I fixed N32/O32 readahead, sync_file_range, fadvise, fadvise64
> syscalls on both kernel and glibc side.
> 
> Here is a kernel side fixes.

And here is glibc side fixes for posix_fadvise, posix_fadvise64,
readahead, sync_file_range.  For O32, add a padding before a long long
argument pair.  For N32, pass a long long value by one argument.  O32
readahead borrows ARM EABI implementation.  N32 posix_fadvise64 use C
implementation (instead of syscalls.list) for versioned symbols.


2007-05-18  Atsushi Nemoto  <anemo@mba.ocn.ne.jp>

	* sysdeps/unix/sysv/linux/mips/mips32/posix_fadvise.c: New file.
	* sysdeps/unix/sysv/linux/mips/mips32/posix_fadvise64.c: New file.
	* sysdeps/unix/sysv/linux/mips/mips32/readahead.c: New file.
	* sysdeps/unix/sysv/linux/mips/mips32/sync_file_range.c: New file.
	* sysdeps/unix/sysv/linux/mips/mips64/n32/posix_fadvise64.c: New file.
	* sysdeps/unix/sysv/linux/mips/mips64/n32/syscalls.list: New file.

diff -urNp glibc-ports.org/sysdeps/unix/sysv/linux/mips/mips32/posix_fadvise.c glibc-ports/sysdeps/unix/sysv/linux/mips/mips32/posix_fadvise.c
--- glibc-ports.org/sysdeps/unix/sysv/linux/mips/mips32/posix_fadvise.c	1970-01-01 09:00:00.000000000 +0900
+++ glibc-ports/sysdeps/unix/sysv/linux/mips/mips32/posix_fadvise.c	2007-05-17 11:06:49.000000000 +0900
@@ -0,0 +1,42 @@
+/* Copyright (C) 2007 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <sysdep.h>
+
+/* Advice the system about the expected behaviour of the application with
+   respect to the file associated with FD.  */
+
+int
+posix_fadvise (int fd, off_t offset, off_t len, int advise)
+{
+/* MIPS kernel only has NR_fadvise64 which acts as NR_fadvise64_64 */
+#ifdef __NR_fadvise64
+  INTERNAL_SYSCALL_DECL (err);
+  int ret = INTERNAL_SYSCALL (fadvise64, err, 7, fd, 0,
+			      __LONG_LONG_PAIR (offset >> 31, offset),
+			      __LONG_LONG_PAIR (offset >> 31, len),
+			      advise);
+  if (INTERNAL_SYSCALL_ERROR_P (ret, err))
+    return INTERNAL_SYSCALL_ERRNO (ret, err);
+  return 0;
+#else
+  return ENOSYS;
+#endif
+}
diff -urNp glibc-ports.org/sysdeps/unix/sysv/linux/mips/mips32/posix_fadvise64.c glibc-ports/sysdeps/unix/sysv/linux/mips/mips32/posix_fadvise64.c
--- glibc-ports.org/sysdeps/unix/sysv/linux/mips/mips32/posix_fadvise64.c	1970-01-01 09:00:00.000000000 +0900
+++ glibc-ports/sysdeps/unix/sysv/linux/mips/mips32/posix_fadvise64.c	2007-05-17 13:05:31.000000000 +0900
@@ -0,0 +1,61 @@
+/* Copyright (C) 2007 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <sysdep.h>
+
+/* Advice the system about the expected behaviour of the application with
+   respect to the file associated with FD.  */
+
+int
+__posix_fadvise64_l64 (int fd, off64_t offset, off64_t len, int advise)
+{
+/* MIPS kernel only has NR_fadvise64 which acts as NR_fadvise64_64 */
+#ifdef __NR_fadvise64
+  INTERNAL_SYSCALL_DECL (err);
+  int ret = INTERNAL_SYSCALL (fadvise64, err, 7, fd, 0,
+			      __LONG_LONG_PAIR ((long) (offset >> 32),
+						(long) offset),
+			      __LONG_LONG_PAIR ((long) (len >> 32),
+						(long) len),
+			      advise);
+  if (INTERNAL_SYSCALL_ERROR_P (ret, err))
+    return INTERNAL_SYSCALL_ERRNO (ret, err);
+  return 0;
+#else
+  return ENOSYS;
+#endif
+}
+
+#include <shlib-compat.h>
+
+#if SHLIB_COMPAT(libc, GLIBC_2_2, GLIBC_2_3_3)
+
+int
+attribute_compat_text_section
+__posix_fadvise64_l32 (int fd, off64_t offset, size_t len, int advise)
+{
+  return __posix_fadvise64_l64 (fd, offset, len, advise);
+}
+
+versioned_symbol (libc, __posix_fadvise64_l64, posix_fadvise64, GLIBC_2_3_3);
+compat_symbol (libc, __posix_fadvise64_l32, posix_fadvise64, GLIBC_2_2);
+#else
+strong_alias (__posix_fadvise64_l64, posix_fadvise64);
+#endif
diff -urNp glibc-ports.org/sysdeps/unix/sysv/linux/mips/mips32/readahead.c glibc-ports/sysdeps/unix/sysv/linux/mips/mips32/readahead.c
--- glibc-ports.org/sysdeps/unix/sysv/linux/mips/mips32/readahead.c	1970-01-01 09:00:00.000000000 +0900
+++ glibc-ports/sysdeps/unix/sysv/linux/mips/mips32/readahead.c	2007-05-17 11:06:43.000000000 +0900
@@ -0,0 +1 @@
+#include <sysdeps/unix/sysv/linux/arm/eabi/readahead.c>
diff -urNp glibc-ports.org/sysdeps/unix/sysv/linux/mips/mips32/sync_file_range.c glibc-ports/sysdeps/unix/sysv/linux/mips/mips32/sync_file_range.c
--- glibc-ports.org/sysdeps/unix/sysv/linux/mips/mips32/sync_file_range.c	1970-01-01 09:00:00.000000000 +0900
+++ glibc-ports/sysdeps/unix/sysv/linux/mips/mips32/sync_file_range.c	2007-05-17 11:06:37.000000000 +0900
@@ -0,0 +1,47 @@
+/* Selective file content synch'ing.
+   Copyright (C) 2006, 2007 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/types.h>
+
+#include <sysdep.h>
+#include <sys/syscall.h>
+
+
+#ifdef __NR_sync_file_range
+int
+sync_file_range (int fd, __off64_t from, __off64_t to, unsigned int flags)
+{
+  return INLINE_SYSCALL (sync_file_range, 7, fd, 0,
+			 __LONG_LONG_PAIR ((long) (from >> 32), (long) from),
+			 __LONG_LONG_PAIR ((long) (to >> 32), (long) to),
+			 flags);
+}
+#else
+int
+sync_file_range (int fd, __off64_t from, __off64_t to, unsigned int flags)
+{
+  __set_errno (ENOSYS);
+  return -1;
+}
+stub_warning (sync_file_range)
+
+# include <stub-tag.h>
+#endif
diff -urNp glibc-ports.org/sysdeps/unix/sysv/linux/mips/mips64/n32/posix_fadvise64.c glibc-ports/sysdeps/unix/sysv/linux/mips/mips64/n32/posix_fadvise64.c
--- glibc-ports.org/sysdeps/unix/sysv/linux/mips/mips64/n32/posix_fadvise64.c	1970-01-01 09:00:00.000000000 +0900
+++ glibc-ports/sysdeps/unix/sysv/linux/mips/mips64/n32/posix_fadvise64.c	2007-05-17 16:05:25.000000000 +0900
@@ -0,0 +1,56 @@
+/* Copyright (C) 2007 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <sysdep.h>
+
+/* Advice the system about the expected behaviour of the application with
+   respect to the file associated with FD.  */
+
+int
+__posix_fadvise64_l64 (int fd, off64_t offset, off64_t len, int advise)
+{
+/* MIPS kernel only has NR_fadvise64 which acts as NR_fadvise64_64 */
+#ifdef __NR_fadvise64
+  INTERNAL_SYSCALL_DECL (err);
+  int ret = INTERNAL_SYSCALL (fadvise64, err, 4, fd, offset, len, advise);
+  if (INTERNAL_SYSCALL_ERROR_P (ret, err))
+    return INTERNAL_SYSCALL_ERRNO (ret, err);
+  return 0;
+#else
+  return ENOSYS;
+#endif
+}
+
+#include <shlib-compat.h>
+
+#if SHLIB_COMPAT(libc, GLIBC_2_2, GLIBC_2_3_3)
+
+int
+attribute_compat_text_section
+__posix_fadvise64_l32 (int fd, off64_t offset, size_t len, int advise)
+{
+  return __posix_fadvise64_l64 (fd, offset, len, advise);
+}
+
+versioned_symbol (libc, __posix_fadvise64_l64, posix_fadvise64, GLIBC_2_3_3);
+compat_symbol (libc, __posix_fadvise64_l32, posix_fadvise64, GLIBC_2_2);
+#else
+strong_alias (__posix_fadvise64_l64, posix_fadvise64);
+#endif
diff -urNp glibc-ports.org/sysdeps/unix/sysv/linux/mips/mips64/n32/syscalls.list glibc-ports/sysdeps/unix/sysv/linux/mips/mips64/n32/syscalls.list
--- glibc-ports.org/sysdeps/unix/sysv/linux/mips/mips64/n32/syscalls.list	1970-01-01 09:00:00.000000000 +0900
+++ glibc-ports/sysdeps/unix/sysv/linux/mips/mips64/n32/syscalls.list	2007-05-17 15:08:16.000000000 +0900
@@ -0,0 +1,5 @@
+# File name	Caller	Syscall name	# args	Strong name	Weak names
+
+readahead	-	readahead	i:iii	__readahead	readahead
+sync_file_range	-	sync_file_range	i:iiii	sync_file_range
+posix_fadvise	-	fadvise64	i:iiii	posix_fadvise
