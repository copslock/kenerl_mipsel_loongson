Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NLrE424938
	for linux-mips-outgoing; Wed, 23 May 2001 14:53:14 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NLqwF24931
	for <linux-mips@oss.sgi.com>; Wed, 23 May 2001 14:53:13 -0700
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 152gYr-0003QK-00
	for <linux-mips@oss.sgi.com>; Wed, 23 May 2001 14:52:57 -0700
Date: Wed, 23 May 2001 14:52:57 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: linux-mips@oss.sgi.com
Subject: [PATCH] incorrect asm constraints for ll/sc constructs
Message-ID: <20010523145257.A13013@nevyn.them.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The ll/sc constructs in the kernel use ".set noat" to inhibit use of $at,
and proceed to use it themselves.  This is fine, except for one problem: the
constraints on memory operands are "o" and "=o", which means offsettable
memory references.  If I'm not mistaken, the assembler will (always?)
turn these into uses of $at if the offset is not 0 - at least, it certainly
seems to do that here (gcc 2.95.3, binutils 2.10.91.0.2).  Just being honest
with the compiler and asking for a real memory reference does the trick. 
Does this patch look right?

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mips-offset.diff"

Index: arch/mips/kernel/sysmips.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/sysmips.c,v
retrieving revision 1.18
diff -u -r1.18 sysmips.c
--- arch/mips/kernel/sysmips.c	2001/04/08 13:24:27	1.18
+++ arch/mips/kernel/sysmips.c	2001/05/23 21:49:29
@@ -99,8 +99,8 @@
 			".word\t1b, 3b\n\t"
 			".word\t2b, 3b\n\t"
 			".previous\n\t"
-			: "=&r" (tmp), "=o" (* (u32 *) p), "=r" (errno)
-			: "r" (arg2), "o" (* (u32 *) p), "2" (errno)
+			: "=&r" (tmp), "=m" (* (u32 *) p), "=r" (errno)
+			: "r" (arg2), "m" (* (u32 *) p), "2" (errno)
 			: "$1");
 
 		if (errno)
Index: include/asm-mips/system.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/system.h,v
retrieving revision 1.27
diff -u -r1.27 system.h
--- include/asm-mips/system.h	2001/03/28 01:35:12	1.27
+++ include/asm-mips/system.h	2001/05/23 21:49:29
@@ -219,8 +219,8 @@
 		" ll\t%0, %3\n\t"
 		".set\tat\n\t"
 		".set\treorder"
-		: "=r" (val), "=o" (*m), "=r" (dummy)
-		: "o" (*m), "2" (val)
+		: "=r" (val), "=m" (*m), "=r" (dummy)
+		: "m" (*m), "2" (val)
 		: "memory");
 
 	return val;

--17pEHd4RhPHOinZp--
