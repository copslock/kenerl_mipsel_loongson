Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2002 08:50:17 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:34525 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123921AbSJCGuQ>;
	Thu, 3 Oct 2002 08:50:16 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g936nOrZ010440;
	Wed, 2 Oct 2002 23:49:24 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA05740;
	Wed, 2 Oct 2002 23:49:55 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g936nQb12953;
	Thu, 3 Oct 2002 08:49:27 +0200 (MEST)
Message-ID: <3D9BE875.BF5C15AD@mips.com>
Date: Thu, 03 Oct 2002 08:49:26 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: 64-bit kernel patch.
References: <Pine.GSO.3.96.1021002153025.8947A-100000@delta.ds2.pg.gda.pl> <3D9AFD0E.84BA5100@mips.com> <20021002160948.F16482@linux-mips.org>
Content-Type: multipart/mixed;
 boundary="------------595386A547C6B133862FA84D"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------595386A547C6B133862FA84D
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Here is the next patch in line.

/Carsten



Ralf Baechle wrote:

> On Wed, Oct 02, 2002 at 04:05:02PM +0200, Carsten Langgaard wrote:
>
> > Ok, here is the next patch.
> > It fixes the sys32_sendmsg and sys32_recvmsg.
>
> Ok, in.  Maciej, you can start the chainsawing ;-)
>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------595386A547C6B133862FA84D
Content-Type: text/plain; charset=iso-8859-15;
 name="syscall_wrapper.part4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscall_wrapper.part4.patch"

Index: arch/mips64/kernel/linux32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/linux32.c,v
retrieving revision 1.42.2.15
diff -u -r1.42.2.15 linux32.c
--- arch/mips64/kernel/linux32.c	2 Oct 2002 14:40:23 -0000	1.42.2.15
+++ arch/mips64/kernel/linux32.c	3 Oct 2002 06:44:51 -0000
@@ -2803,6 +2803,27 @@
 	return len;
 }
 
+extern asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset, size_t count);
+
+asmlinkage int sys32_sendfile(int out_fd, int in_fd, __kernel_off_t32 *offset, s32 count)
+{
+	mm_segment_t old_fs = get_fs();
+	int ret;
+	off_t of;
+	
+	if (offset && get_user(of, offset))
+		return -EFAULT;
+		
+	set_fs(KERNEL_DS);
+	ret = sys_sendfile(out_fd, in_fd, offset ? &of : NULL, count);
+	set_fs(old_fs);
+	
+	if (offset && put_user(of, offset))
+		return -EFAULT;
+		
+	return ret;
+}
+
 asmlinkage ssize_t sys_readahead(int fd, loff_t offset, size_t count);
 
 asmlinkage ssize_t sys32_readahead(int fd, u32 pad0, u64 a2, u64 a3,
Index: arch/mips64/kernel/scall_o32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/scall_o32.S,v
retrieving revision 1.48.2.16
diff -u -r1.48.2.16 scall_o32.S
--- arch/mips64/kernel/scall_o32.S	2 Oct 2002 13:32:45 -0000	1.48.2.16
+++ arch/mips64/kernel/scall_o32.S	3 Oct 2002 06:44:51 -0000
@@ -519,7 +519,7 @@
 	sys	sys_capget	2
 	sys	sys_capset	2			/* 4205 */
 	sys	sys32_sigaltstack	0
-	sys	sys_sendfile	4
+	sys	sys32_sendfile	4
 	sys	sys_ni_syscall	0
 	sys	sys_ni_syscall	0
 	sys	sys32_mmap2	6			/* 4210 */

--------------595386A547C6B133862FA84D--
