Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 16:28:25 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:31231 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225289AbSLEP2Y>;
	Thu, 5 Dec 2002 16:28:24 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB5FS8Nf029758;
	Thu, 5 Dec 2002 07:28:08 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA19806;
	Thu, 5 Dec 2002 07:28:07 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB5FS7b15260;
	Thu, 5 Dec 2002 16:28:07 +0100 (MET)
Message-ID: <3DEF7087.B6DEA7EC@mips.com>
Date: Thu, 05 Dec 2002 16:28:07 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>,
	Dominic Sweetman <dom@algor.co.uk>, chris@mips.com,
	kevink@mips.com, linux-mips@linux-mips.org
Subject: The 64-bit version of __access_ok is broken.
Content-Type: multipart/mixed;
 boundary="------------ED3149EB9F1B0424A5270285"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------ED3149EB9F1B0424A5270285
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I have addressed this issue before, and I do it again, because we have a
potential kernel crash situation, if this isn't fixed.

The __access_ok macro in include/asm-mips64/uaccess.h and the check_axs
macro in arch/mips64/kernel/unaligned.c need to be changed in order to
work correctly, it's a copy from the 32-bit kernel. It's not good enough
to simply check for the "sign bit" of the address.
The area between USEG (XUSEG) and KSEG0 will in 64-bit addressing mode
generate an address error, if accessed.
The size of the area depend on the number of virtual addressing bits
implemented in the CPU.

Please take a look at the patch below.
I think Ralf had some objection the last time I send it, about the fix,
not being efficient enough (performance vice), but I think we need to
consider stability and functionality over performance. So until someone
comes up with a better solution, I think we need this fix.

/Carsten




--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------ED3149EB9F1B0424A5270285
Content-Type: text/plain; charset=iso-8859-15;
 name="access_ok.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="access_ok.patch"

Index: arch/mips64/kernel/unaligned.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/unaligned.c,v
retrieving revision 1.6.2.7
diff -u -r1.6.2.7 unaligned.c
--- arch/mips64/kernel/unaligned.c	5 Dec 2002 03:09:58 -0000	1.6.2.7
+++ arch/mips64/kernel/unaligned.c	5 Dec 2002 15:06:59 -0000
@@ -89,11 +89,14 @@
 #define __STR(x)  #x
 
 /*
- * User code may only access USEG; kernel code may access the
- * entire address space.
+ * User code may only access USEG; 
+ * Kernel code may access the entire address space, except the area between
+ * USEG (XUSEG) and KSEG0.
  */
-#define check_axs(pc,a,s)				\
-	if ((long)(~(pc) & ((a) | ((a)+(s)))) < 0)	\
+#define check_axs(pc,a,s)						\
+        if (((pc < KUSIZE) && (((a) | ((a)+(s))) >= KUSIZE)) ||		\
+	    ((((a) | ((a)+(s))) < K0BASE) &&				\
+	     (((a) | ((a)+(s))) >= KUSIZE)))				\
 		goto sigbus;
 
 static inline int emulate_load_store_insn(struct pt_regs *regs,
Index: include/asm-mips64/uaccess.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/uaccess.h,v
retrieving revision 1.13.2.1
diff -u -r1.13.2.1 uaccess.h
--- include/asm-mips64/uaccess.h	1 Jul 2002 15:27:31 -0000	1.13.2.1
+++ include/asm-mips64/uaccess.h	5 Dec 2002 15:07:11 -0000
@@ -40,16 +40,23 @@
  * than tests.
  *
  * Address valid if:
- *  - "addr" doesn't have any high-bits set
- *  - AND "size" doesn't have any high-bits set
- *  - AND "addr+size" doesn't have any high-bits set
- *  - OR we are in kernel mode.
+ *  - In user mode and "addr" and "addr+size" in USEG (or XUSEG).
+ *  - OR we are in kernel mode and "addr" and "addr+size" isn't in the 
+ *    area between USEG (XUSEG) and KSEG0.
  */
 #define __ua_size(size)							\
 	(__builtin_constant_p(size) && (signed long) (size) > 0 ? 0 : (size))
 
-#define __access_ok(addr,size,mask)					\
-	(((signed long)((mask)&(addr | (addr + size) | __ua_size(size)))) >= 0)
+static inline int 
+__access_ok(unsigned long addr, unsigned long size, long mask)
+{
+	if (((mask) && ((addr | (addr+size)) >= KUSIZE)) ||     
+	    (((addr | (addr+size)) < K0BASE) &&
+	     ((addr | (addr+size)) >= KUSIZE)))
+		return 0;
+	else
+		return 1;
+}
 
 #define __access_mask ((long)(get_fs().seg))

--------------ED3149EB9F1B0424A5270285--
