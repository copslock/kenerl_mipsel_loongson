Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g68IPARw000733
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Jul 2002 11:25:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g68IPAD1000732
	for linux-mips-outgoing; Mon, 8 Jul 2002 11:25:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sccrmhc02.attbi.com (sccrmhc02.attbi.com [204.127.202.62])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g68IOoRw000720;
	Mon, 8 Jul 2002 11:24:51 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by sccrmhc02.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020708182906.TMTA6023.sccrmhc02.attbi.com@ocean.lucon.org>;
          Mon, 8 Jul 2002 18:29:06 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id E7A86125D6; Mon,  8 Jul 2002 11:29:03 -0700 (PDT)
Date: Mon, 8 Jul 2002 11:29:03 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, Jun Sun <jsun@mvista.com>,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
Subject: PATCH: Fix SHMLBA for mips (Re: LTP testing (shmat01))
Message-ID: <20020708112903.A14451@lucon.org>
References: <3D246924.542682B2@mips.com> <20020704193414.A29570@dea.linux-mips.net> <3D249181.D9147AAE@mips.com> <20020704215614.B29422@dea.linux-mips.net> <3D29CC6B.5090004@mvista.com> <20020708194539.C2758@dea.linux-mips.net> <3D29D65C.84630789@mips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D29D65C.84630789@mips.com>; from carstenl@mips.com on Mon, Jul 08, 2002 at 08:13:48PM +0200
X-Spam-Status: No, hits=-9.4 required=5.0 tests=IN_REP_TO,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2002 at 08:13:48PM +0200, Carsten Langgaard wrote:
> I have no preferences of the value of SHMLBA, as long as the define in
> /usr/include/sys/shm.c and include/asm-mips/shmparam.h are in sync.
> 
> /Carsten
> 

How about this patch?


H.J.

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="glibc-mips-shm.patch"

2002-07-08  H.J. Lu  <hjl@gnu.org>

	* sysdeps/unix/sysv/linux/mips/sys/shm.h: New.

--- sysdeps/unix/sysv/linux/mips/sys/shm.h.mips	Mon Jul  8 11:27:12 2002
+++ sysdeps/unix/sysv/linux/mips/sys/shm.h	Mon Jul  8 11:27:06 2002
@@ -0,0 +1,67 @@
+/* Copyright (C) 2002 Free Software Foundation, Inc.
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
+#ifndef _SYS_SHM_H
+#define _SYS_SHM_H	1
+
+#include <features.h>
+
+#define __need_size_t
+#include <stddef.h>
+
+/* Get common definition of System V style IPC.  */
+#include <sys/ipc.h>
+
+/* Get system dependent definition of `struct shmid_ds' and more.  */
+#include <bits/shm.h>
+
+/* Define types required by the standard.  */
+#define __need_time_t
+#include <time.h>
+
+#ifdef __USE_XOPEN
+# ifndef __pid_t_defined
+typedef __pid_t pid_t;
+#  define __pid_t_defined
+# endif
+#endif	/* X/Open */
+
+__BEGIN_DECLS
+
+/* Segment low boundary address multiple.  */
+#define SHMLBA	0x40000
+
+/* The following System V style IPC functions implement a shared memory
+   facility.  The definition is found in XPG4.2.  */
+
+/* Shared memory control operation.  */
+extern int shmctl (int __shmid, int __cmd, struct shmid_ds *__buf) __THROW;
+
+/* Get shared memory segment.  */
+extern int shmget (key_t __key, size_t __size, int __shmflg) __THROW;
+
+/* Attach shared memory segment.  */
+extern void *shmat (int __shmid, __const void *__shmaddr, int __shmflg)
+     __THROW;
+
+/* Detach shared memory segment.  */
+extern int shmdt (__const void *__shmaddr) __THROW;
+
+__END_DECLS
+
+#endif /* sys/shm.h */

--82I3+IH0IqGh5yIs--
