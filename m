Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3TJ65C11414
	for linux-mips-outgoing; Sun, 29 Apr 2001 12:06:05 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3TJ63M11411
	for <linux-mips@oss.sgi.com>; Sun, 29 Apr 2001 12:06:04 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14twWA-0005W8-00; Sun, 29 Apr 2001 21:06:02 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14twW9-0004LI-00; Sun, 29 Apr 2001 21:06:01 +0200
Date: Sun, 29 Apr 2001 21:06:01 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-mips@oss.sgi.com
Cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: shm ipc broken 
Message-ID: <20010429210601.A16687@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com,
	Ralf Baechle <ralf@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch fixes a problem with shm ipc. The structs ipc_perm in
/u/i/bits/ipc.h and ipc64_perm in include/asm/ipcbuf.h had different sizes
and so caused the copy_shminfo_to_user in ipc/shm.c to corrupt user space(the
kernel structure was 8 bytes larger). This is probably not the correct fix,
since the other arches have this padding, so maybe glibc must be fixed.
There's still a small problem since shm_nattch is a short in glibc and a long
in the kernel, so the attach-numbers are wrong(which I'm also not sure where
it has to be fixed).  
 -- Guido

P.S.: this fixes the X server crashes some people were seeing.

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="shm_fix-2001-04-29.diff"

--- include/asm-mips/ipcbuf.h.orig	Sun Apr 29 19:55:41 2001
+++ include/asm-mips/ipcbuf.h	Sun Apr 29 20:23:00 2001
@@ -2,13 +2,12 @@
 #define _ASM_IPCBUF_H
 
 /* 
- * The ipc64_perm structure for alpha architecture.
+ * The ipc64_perm structure for mips architecture.
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
  *
  * Pad space is left for:
  * - 32-bit seq
- * - 2 miscellaneous 64-bit values
  */
 
 struct ipc64_perm
@@ -21,8 +20,6 @@
 	__kernel_mode_t	mode; 
 	unsigned short	seq;
 	unsigned short	__pad1;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
 };
 
 #endif /* _ASM_IPCBUF_H */

--RnlQjJ0d97Da+TV1--
