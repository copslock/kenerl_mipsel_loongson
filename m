Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Sep 2004 06:28:22 +0100 (BST)
Received: from one.ldsys.net ([IPv6:::ffff:208.176.63.109]:31244 "EHLO
	one.chi.ldsys.net") by linux-mips.org with ESMTP
	id <S8225074AbUIHF2L>; Wed, 8 Sep 2004 06:28:11 +0100
Received: from sex-machine.chi.ldsys.net (sex-machine.chi.ldsys.net [10.0.1.4])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by one.chi.ldsys.net (Postfix) with ESMTP id 8A6B834566
	for <linux-mips@linux-mips.org>; Wed,  8 Sep 2004 00:28:08 -0500 (CDT)
Subject: [PATCH] statfs64/fstatfs64 compat syscall and header fix
From: "Christopher G. Stach II" <cgs@ldsys.net>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Message-Id: <1094621285.8282.18.camel@sex-machine.chi.ldsys.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Sep 2004 00:28:06 -0500
Content-Transfer-Encoding: 7bit
Return-Path: <cgs@ldsys.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cgs@ldsys.net
Precedence: bulk
X-list: linux-mips

    This patch fixes the n32 and o32 syscall tables for compat statfs64
and fstatfs64.  This indirectly fixes statvfs in glibc, etc.

    The statfs.h reorganization (to align it with all of the other
arches and include/linux/statfs.h) isn't as important as the structure
size, which makes the syscalls bomb immediately.

    Also, for anyone interested, the accompanying glibc patch to update
for the updated structure order and size, as well as fix some other
problems for fstatfs64/statfs64, is at:

http://www.ldsys.net/~cgs/linux-mips/patches-20040827/usr/local/portage/sys-libs/glibc/files/2.3.4/glibc-2.3.4.20040808-mips-compat.patch

Index: arch/mips/kernel/scall64-n32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/scall64-n32.S,v
retrieving revision 1.12
diff -u -b -B -r1.12 scall64-n32.S
--- arch/mips/kernel/scall64-n32.S      8 Jun 2004 23:54:47 -0000      
1.12
+++ arch/mips/kernel/scall64-n32.S      8 Sep 2004 05:12:37 -0000
@@ -334,8 +334,8 @@
        PTR     sys_restart_syscall
        PTR     sys_semtimedop                  /* 6215 */
        PTR     sys_fadvise64_64
-       PTR     sys_statfs64
-       PTR     sys_fstatfs64
+       PTR     compat_statfs64
+       PTR     compat_fstatfs64
        PTR     sys_sendfile64
        PTR     sys_timer_create                /* 6220 */
        PTR     sys_timer_settime
Index: arch/mips/kernel/scall64-o32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/scall64-o32.S,v
retrieving revision 1.13
diff -u -b -B -r1.13 scall64-o32.S
--- arch/mips/kernel/scall64-o32.S      25 Aug 2004 15:08:23 -0000     
1.13
+++ arch/mips/kernel/scall64-o32.S      8 Sep 2004 05:12:37 -0000
@@ -496,8 +496,8 @@
        PTR     sys_set_tid_address
        PTR     sys_restart_syscall
        PTR     sys_fadvise64_64
-       PTR     sys_statfs64                    /* 4255 */
-       PTR     sys_fstatfs64
+       PTR     compat_statfs64                 /* 4255 */
+       PTR     compat_fstatfs64
        PTR     sys_timer_create
        PTR     sys_timer_settime
        PTR     sys_timer_gettime
Index: include/asm-mips/statfs.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/statfs.h,v
retrieving revision 1.5
diff -u -b -B -r1.5 statfs.h
--- include/asm-mips/statfs.h   10 Jan 2004 04:59:56 -0000      1.5
+++ include/asm-mips/statfs.h   8 Sep 2004 05:12:45 -0000
@@ -23,17 +23,17 @@
        long            f_type;
 #define f_fstyp f_type
        long            f_bsize;
-       long            f_frsize;       /* Fragment size - unsupported
*/
        long            f_blocks;
        long            f_bfree;
+       long            f_bavail;
        long            f_files;
        long            f_ffree;

        /* Linux specials */
-       long    f_bavail;
        __kernel_fsid_t f_fsid;
        long            f_namelen;
-       long            f_spare[6];
+       long            f_frsize;       /* Fragment size - unsupported
*/
+       long            f_spare[5];
 };

 #if (_MIPS_SIM == _MIPS_SIM_ABI32) || (_MIPS_SIM == _MIPS_SIM_NABI32)
@@ -62,17 +62,17 @@
 struct statfs64 {                      /* Same as struct statfs */
        long            f_type;
        long            f_bsize;
-       long            f_frsize;       /* Fragment size - unsupported
*/
        long            f_blocks;
        long            f_bfree;
+       long            f_bavail;
        long            f_files;
        long            f_ffree;

        /* Linux specials */
-       long    f_bavail;
        __kernel_fsid_t f_fsid;
        long            f_namelen;
-       long            f_spare[6];
+       long            f_frsize;       /* Fragment size - unsupported
*/
+       long            f_spare[5];
 };

 struct compat_statfs64 {
