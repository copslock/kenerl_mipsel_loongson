Received:  by oss.sgi.com id <S553767AbRCLLt4>;
	Mon, 12 Mar 2001 03:49:56 -0800
Received: from u-21-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.21]:64262
        "EHLO u-21-19.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553729AbRCLLtw>; Mon, 12 Mar 2001 03:49:52 -0800
Received: from dea ([193.98.169.28]:896 "EHLO dea.waldorf-gmbh.de")
	by bacchus.dhis.org with ESMTP id <S867210AbRCLLt2>;
	Mon, 12 Mar 2001 12:49:28 +0100
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2CBLYe06247;
	Mon, 12 Mar 2001 12:21:34 +0100
Date:	Mon, 12 Mar 2001 12:21:34 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Florian Lohoff <flo@rfc822.org>
Cc:	linux-mips@oss.sgi.com
Subject: Re: Illegal instruction - a workaround or fix ?
Message-ID: <20010312122134.B1235@bacchus.dhis.org>
References: <20010311191639.A8587@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010311191639.A8587@paradigm.rfc822.org>; from flo@rfc822.org on Sun, Mar 11, 2001 at 07:16:39PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Thanks, that was the hint I needed.  o32_ret_from_sys_call expects the
content of s-registers to be unchanged from userspace but sys_sysmips
clobbers them.

Below a patch from the famous ``Smoke This, It's Good For You (TM)''
series.  Lemme know if it helps.

  Ralf

--- arch/mips/kernel/sysmips.c	2001/02/09 21:05:46	1.17
+++ arch/mips/kernel/sysmips.c	2001/03/12 11:12:20
@@ -19,6 +19,7 @@
 
 #include <asm/cachectl.h>
 #include <asm/pgalloc.h>
+#include <asm/stackframe.h>
 #include <asm/sysmips.h>
 #include <asm/uaccess.h>
 
@@ -47,8 +48,9 @@
 	return address;
 }
 
-asmlinkage int
-sys_sysmips(int cmd, int arg1, int arg2, int arg3)
+save_static_function(sys_sysmips);
+static_unused int
+_sys_sysmips(int cmd, int arg1, int arg2, int arg3)
 {
 	int	*p;
 	char	*name;
@@ -114,7 +116,7 @@
 
 		__asm__ __volatile__(
 			"move\t$29, %0\n\t"
-			"j\to32_ret_from_sys_call"
+			"j\to32_ret_from_sys_call_restore_static"
 			: /* No outputs */
 			: "r" (&cmd));
 		/* Unreached */
--- arch/mips/kernel/scall_o32.S	2000/08/08 18:54:49	1.14
+++ arch/mips/kernel/scall_o32.S	2001/03/12 11:09:12
@@ -86,6 +86,10 @@
 	RESTORE_SOME
 	RESTORE_SP_AND_RET
 
+EXPORT(o32_ret_from_sys_call_restore_static)
+	RESTORE_STATIC
+	j	o32_ret_from_sys_call
+
 o32_handle_softirq:
 	jal	do_softirq
 	b	9b
