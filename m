Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Oct 2002 09:34:51 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:55244 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123398AbSJUHeu>;
	Mon, 21 Oct 2002 09:34:50 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g9L7YRNf022742;
	Mon, 21 Oct 2002 00:34:31 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA25293;
	Mon, 21 Oct 2002 00:35:16 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g9L7YPb02749;
	Mon, 21 Oct 2002 09:34:28 +0200 (MEST)
Message-ID: <3DB3AE01.72BA1957@mips.com>
Date: Mon, 21 Oct 2002 09:34:25 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: 64 bit syscall wrapper.
Content-Type: multipart/mixed;
 boundary="------------850021AF6C4530B6EA325B07"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------850021AF6C4530B6EA325B07
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Here's yet another patch for the 64 bit syscall wrapper.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------850021AF6C4530B6EA325B07
Content-Type: text/plain; charset=iso-8859-15;
 name="syscall_wrapper.part6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscall_wrapper.part6.patch"

Index: arch/mips64/kernel/linux32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/linux32.c,v
retrieving revision 1.42.2.17
diff -u -r1.42.2.17 linux32.c
--- arch/mips64/kernel/linux32.c	10 Oct 2002 11:38:43 -0000	1.42.2.17
+++ arch/mips64/kernel/linux32.c	21 Oct 2002 07:30:54 -0000
@@ -2147,81 +2147,42 @@
 	unsigned int __unused[4];
 };
 
-asmlinkage long sys32_sysctl(struct sysctl_args32 *uargs32)
+asmlinkage long sys32_sysctl(struct sysctl_args32 *args)
 {
-	struct __sysctl_args kargs;
-	struct sysctl_args32 kargs32;
-	mm_segment_t old_fs;
-	int name[CTL_MAXNAME];
-	size_t oldlen[1];
-	int err, ret;
-
-	ret = -EFAULT;
-
-	memset(&kargs, 0, sizeof (kargs));
-
-	err = get_user(kargs32.name, &uargs32->name);
-	err |= __get_user(kargs32.nlen, &uargs32->nlen);
-	err |= __get_user(kargs32.oldval, &uargs32->oldval);
-	err |= __get_user(kargs32.oldlenp, &uargs32->oldlenp);
-	err |= __get_user(kargs32.newval, &uargs32->newval);
-	err |= __get_user(kargs32.newlen, &uargs32->newlen);
-	if (err)
-		goto out;
-
-	if (kargs32.nlen == 0 || kargs32.nlen >= CTL_MAXNAME) {
-		ret = -ENOTDIR;
-		goto out;
-	}
-
-	kargs.name = name;
-	kargs.nlen = kargs32.nlen;
-	if (copy_from_user(kargs.name, (int *)A(kargs32.name),
-			   kargs32.nlen * sizeof(name) / sizeof(name[0])))
-		goto out;
-
-	if (kargs32.oldval) {
-		if (!kargs32.oldlenp || get_user(oldlen[0],
-						 (int *)A(kargs32.oldlenp)))
+	struct sysctl_args32 tmp;
+	int error;
+	size_t oldlen, *oldlenp = NULL;
+	unsigned long addr = (((long)&args->__unused[0]) + 7) & ~7;
+
+	if (copy_from_user(&tmp, args, sizeof(tmp)))
+		return -EFAULT;
+
+	if (tmp.oldval && tmp.oldlenp) {
+		/* Duh, this is ugly and might not work if sysctl_args
+		   is in read-only memory, but do_sysctl does indirectly
+		   a lot of uaccess in both directions and we'd have to
+		   basically copy the whole sysctl.c here, and
+		   glibc's __sysctl uses rw memory for the structure
+		   anyway.  */
+		if (get_user(oldlen, (u32 *)A(tmp.oldlenp)) ||
+		    put_user(oldlen, (size_t *)addr))
 			return -EFAULT;
-		kargs.oldlenp = oldlen;
-		kargs.oldval = kmalloc(oldlen[0], GFP_KERNEL);
-		if (!kargs.oldval) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		oldlenp = (size_t *)addr;
 	}
 
-	if (kargs32.newval && kargs32.newlen) {
-		kargs.newval = kmalloc(kargs32.newlen, GFP_KERNEL);
-		if (!kargs.newval) {
-			ret = -ENOMEM;
-			goto out;
+	lock_kernel();
+	error = do_sysctl((int *)A(tmp.name), tmp.nlen, (void *)A(tmp.oldval),
+			  oldlenp, (void *)A(tmp.newval), tmp.newlen);
+	unlock_kernel();
+	if (oldlenp) {
+		if (!error) {
+			if (get_user(oldlen, (size_t *)addr) ||
+			    put_user(oldlen, (u32 *)A(tmp.oldlenp)))
+				error = -EFAULT;
 		}
-		if (copy_from_user(kargs.newval, (int *)A(kargs32.newval),
-				   kargs32.newlen))
-			goto out;
-	}
-
-	old_fs = get_fs(); set_fs (KERNEL_DS);
-	ret = sys_sysctl(&kargs);
-	set_fs (old_fs);
-
-	if (ret)
-		goto out;
-
-	if (kargs.oldval) {
-		if (put_user(oldlen[0], (int *)A(kargs32.oldlenp)) ||
-		    copy_to_user((int *)A(kargs32.oldval), kargs.oldval,
-				 oldlen[0]))
-			ret = -EFAULT;
+		copy_to_user(args->__unused, tmp.__unused, sizeof(tmp.__unused));
 	}
-out:
-	if (kargs.oldval)
-		kfree(kargs.oldval);
-	if (kargs.newval)
-		kfree(kargs.newval);
-	return ret;
+	return error;
 }
 
 asmlinkage long sys32_newuname(struct new_utsname * name)

--------------850021AF6C4530B6EA325B07--
