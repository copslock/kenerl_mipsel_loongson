Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2004 03:20:55 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:49927
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224989AbUKUDUv>; Sun, 21 Nov 2004 03:20:51 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CViHS-0004vW-00; Sun, 21 Nov 2004 04:20:50 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CViHS-0004tD-00; Sun, 21 Nov 2004 04:20:50 +0100
Date: Sun, 21 Nov 2004 04:20:50 +0100
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Canonicalize mmap addresses to unsigned long
Message-ID: <20041121032050.GN20986@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello All,

this patch canonicalizes address arguments and returns from a mixture
of "unsigned long", "long" and "size_t" to "unsigned long".


Thiemo


Index: arch/mips/kernel/syscall.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/syscall.c,v
retrieving revision 1.46
diff -u -p -r1.46 syscall.c
--- arch/mips/kernel/syscall.c	19 Sep 2004 12:30:04 -0000	1.46
+++ arch/mips/kernel/syscall.c	20 Nov 2004 16:46:39 -0000
@@ -116,7 +116,7 @@ unsigned long arch_get_unmapped_area(str
 }
 
 /* common code for old and new mmaps */
-static inline long
+static inline unsigned long
 do_mmap2(unsigned long addr, unsigned long len, unsigned long prot,
         unsigned long flags, unsigned long fd, unsigned long pgoff)
 {
@@ -140,8 +140,9 @@ out:
 	return error;
 }
 
-asmlinkage unsigned long old_mmap(unsigned long addr, size_t len, int prot,
-                                  int flags, int fd, off_t offset)
+asmlinkage unsigned long
+old_mmap(unsigned long addr, unsigned long len, int prot,
+	int flags, int fd, off_t offset)
 {
 	unsigned long result;
 
@@ -155,7 +156,7 @@ out:
 	return result;
 }
 
-asmlinkage long
+asmlinkage unsigned long
 sys_mmap2(unsigned long addr, unsigned long len, unsigned long prot,
           unsigned long flags, unsigned long fd, unsigned long pgoff)
 {
Index: arch/mips/kernel/linux32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/linux32.c,v
retrieving revision 1.21
diff -u -p -r1.21 linux32.c
--- arch/mips/kernel/linux32.c	13 Aug 2004 07:18:52 -0000	1.21
+++ arch/mips/kernel/linux32.c	20 Nov 2004 16:46:38 -0000
@@ -99,7 +99,7 @@ int cp_compat_stat(struct kstat *stat, s
 }
 
 asmlinkage unsigned long
-sys32_mmap2(unsigned long addr, size_t len, unsigned long prot,
+sys32_mmap2(unsigned long addr, unsigned long len, unsigned long prot,
          unsigned long flags, unsigned long fd, unsigned long pgoff)
 {
 	struct file * file = NULL;
