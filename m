Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB66iCi17384
	for linux-mips-outgoing; Wed, 5 Dec 2001 22:44:12 -0800
Received: from surfers.oz.agile.tv (fw.oz.agile.tv [210.9.52.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB66hvo17381;
	Wed, 5 Dec 2001 22:43:57 -0800
Received: from agile.tv (IDENT:ldavies@tugun.oz.agile.tv [192.168.16.20])
	by surfers.oz.agile.tv (8.11.2/8.11.2) with ESMTP id fB65hsv11606;
	Thu, 6 Dec 2001 15:43:54 +1000
Message-ID: <3C0F059A.30709@agile.tv>
Date: Thu, 06 Dec 2001 15:43:54 +1000
From: Liam Davies <ldavies@agile.tv>
Reply-To: ldavies@agile.tv, ldavies@agile.tv
Organization: AgileTV Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
CC: ralf@oss.sgi.com
Subject: [PATCH] mips_atomic_set fixups (with LLSC)
Content-Type: multipart/mixed;
 boundary="------------080604090303020704070407"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------080604090303020704070407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


The kernel can be caused to crash when making the following syscall
sysmips(MIPS_ATOMIC_SET, [unaligned addr], value, 0);

The latest mips_atomic_set does not use the fixups that are defined
for the ll/sc instructions.

If an unaligned address is passed in we take the exception and
unaligned.c:emulate_load_store_insn ignores the fixups for the
ll/sc and sends a SIGBUS instead, thus causing the kernel to die.

The patch is to make the ll/sc instructions lookup the fixup table
and do them if present.

Also the fixup for the instructions in scall_o32.S appears to be
inappropriate, so the fixup is set to be bad_addr and an -EFAULT
is returned from the syscall.

Cheers


----
Liam Davies
ldavies@agile.tv


--------------080604090303020704070407
Content-Type: text/plain;
 name="atomic_set.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic_set.patch"

--- ../sgi-cvs/arch/mips/kernel/unaligned.c	Mon Dec  3 10:49:23 2001
+++ arch/mips/kernel/unaligned.c	Thu Dec  6 15:07:00 2001
@@ -114,12 +114,14 @@
 	 * These are instructions that a compiler doesn't generate.  We
 	 * can assume therefore that the code is MIPS-aware and
 	 * really buggy.  Emulating these instructions would break the
-	 * semantics anyway.
+	 * semantics anyway. However, we do want to look at the exception
+	 * table to see if we can exit gracefully.
 	 */
 	case ll_op:
 	case lld_op:
 	case sc_op:
 	case scd_op:
+		goto fault;
 
 	/*
 	 * For these instructions the only way to create an address
--- ../sgi-cvs/arch/mips/kernel/scall_o32.S	Mon Oct  8 09:56:02 2001
+++ arch/mips/kernel/scall_o32.S	Thu Dec  6 15:34:47 2001
@@ -201,7 +201,7 @@
 	or	a0, a0, a1
 	li	v0, -EFAULT
 	and	a0, a0, v1
-	bltz	a0, 8f
+	bltz	a0, bad_address
 
 #ifdef CONFIG_CPU_HAS_LLSC
 	/* Ok, this is the ll/sc case.  World is sane :-)  */
@@ -211,8 +211,8 @@
 	beqz	a0, 1b
 
 	.section __ex_table,"a"
-	PTR	1b, bad_stack
-	PTR	2b, bad_stack
+	PTR	1b, bad_address
+	PTR	2b, bad_address
 	.previous
 #else
 	sw	a1, 16(sp)
@@ -256,8 +256,9 @@
 no_mem:	li	v0, -ENOMEM
 	jr	ra
 
-8:	li	v0, -EFAULT
-9:	jr	ra
+bad_address:
+	li	v0, -EFAULT
+	jr	ra
 	END(mips_atomic_set)	
 
 	LEAF(sys_sysmips)


--------------080604090303020704070407--
