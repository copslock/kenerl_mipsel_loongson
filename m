Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2002 15:23:14 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:3015 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123915AbSJBNXN>;
	Wed, 2 Oct 2002 15:23:13 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g92DMxrZ006781;
	Wed, 2 Oct 2002 06:22:59 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA22127;
	Wed, 2 Oct 2002 06:23:28 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g92DMxb01621;
	Wed, 2 Oct 2002 15:23:00 +0200 (MEST)
Message-ID: <3D9AF333.BC304A34@mips.com>
Date: Wed, 02 Oct 2002 15:22:59 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: 64-bit kernel patch.
Content-Type: multipart/mixed;
 boundary="------------1D80166B5761164BECAD697A"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------1D80166B5761164BECAD697A
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I have a number of patches for the o32 syscall wrapper/conversion
routines, which is needed when running a 64-bit kernel on an o32
userland.
Here is the first one. Ralf, could you please apply it, so I can send
the next one.

/Carsten




--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------1D80166B5761164BECAD697A
Content-Type: text/plain; charset=iso-8859-15;
 name="syscall_wrapper.part1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscall_wrapper.part1.patch"

Index: arch/mips64/kernel/linux32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/linux32.c,v
retrieving revision 1.42.2.12
diff -u -r1.42.2.12 linux32.c
--- arch/mips64/kernel/linux32.c	27 Sep 2002 23:29:17 -0000	1.42.2.12
+++ arch/mips64/kernel/linux32.c	2 Oct 2002 13:13:42 -0000
@@ -179,7 +179,32 @@
 	return err;
 }
 
-asmlinkage int sys_mmap2(void) {return 0;}
+asmlinkage unsigned long
+sys32_mmap2(unsigned long addr, size_t len, unsigned long prot,
+         unsigned long flags, unsigned long fd, unsigned long pgoff)
+{
+	struct file * file = NULL;
+	unsigned long error;
+
+	error = -EINVAL;
+	if (!(flags & MAP_ANONYMOUS)) {
+		error = -EBADF;
+		file = fget(fd);
+		if (!file)
+			goto out;
+	}
+	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+
+	down_write(&current->mm->mmap_sem);
+	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	up_write(&current->mm->mmap_sem);
+	if (file)
+		fput(file);
+
+out:
+	return error;
+}
+
 
 asmlinkage long sys_truncate(const char * path, unsigned long length);
 
Index: arch/mips64/kernel/scall_o32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/scall_o32.S,v
retrieving revision 1.48.2.15
diff -u -r1.48.2.15 scall_o32.S
--- arch/mips64/kernel/scall_o32.S	11 Sep 2002 13:56:36 -0000	1.48.2.15
+++ arch/mips64/kernel/scall_o32.S	2 Oct 2002 13:13:42 -0000
@@ -522,7 +522,7 @@
 	sys	sys_sendfile	4
 	sys	sys_ni_syscall	0
 	sys	sys_ni_syscall	0
-	sys	sys_mmap2	6			/* 4210 */
+	sys	sys32_mmap2	6			/* 4210 */
 	sys	sys_truncate64	2
 	sys	sys_ftruncate64	2
 	sys	sys_newstat	2

--------------1D80166B5761164BECAD697A--
