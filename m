Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18FYAp01127
	for linux-mips-outgoing; Fri, 8 Feb 2002 07:34:10 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18FY3A01123
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 07:34:03 -0800
Received: from sjhill by real.realitydiluted.com with local (Exim 3.22 #1 (Red Hat Linux))
	id 16ZD2B-0003iv-00
	for <linux-mips@oss.sgi.com>; Fri, 08 Feb 2002 09:33:55 -0600
To: linux-mips@oss.sgi.com
Subject: [PATCH] Removal of warning messages for gdb-stub.c
Message-Id: <E16ZD2B-0003iv-00@real.realitydiluted.com>
From: "Steven J. Hill" <sjhill@realitydiluted.com>
Date: Fri, 08 Feb 2002 09:33:55 -0600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Just more clean ups. I tested it, it works.

-Steve

diff -urN -X cvs-exc.txt mipslinux-2.4.17-xfs/arch/mips/kernel/gdb-stub.c settop/arch/mips/kernel/gdb-stub.c
--- mipslinux-2.4.17-xfs/arch/mips/kernel/gdb-stub.c	Thu Nov 29 09:13:08 2001
+++ settop/arch/mips/kernel/gdb-stub.c	Fri Feb  8 09:14:52 2002
@@ -306,7 +306,7 @@
 	unsigned char ch;
 
 	while (count-- > 0) {
-		if (kgdb_read_byte(mem++, &ch) != 0)
+		if (kgdb_read_byte((unsigned *) mem++, (unsigned *) &ch) != 0)
 			return 0;
 		*buf++ = hexchars[ch >> 4];
 		*buf++ = hexchars[ch & 0xf];
@@ -332,7 +332,7 @@
 	{
 		ch = hex(*buf++) << 4;
 		ch |= hex(*buf++);
-		if (kgdb_write_byte(ch, mem++) != 0)
+		if (kgdb_write_byte((unsigned) ch, (unsigned *) mem++) != 0)
 			return 0;
 	}
 
@@ -902,23 +902,21 @@
 	if (!initialized)
 		return;
 
-	__asm__ __volatile__("
-			.globl	breakinst
-			.set	noreorder
-			nop
-breakinst:		break
-			nop
-			.set	reorder
-	");
+	__asm__ __volatile__(
+		".globl\tbreakinst\n\t"
+		".set\tnoreorder\n\t"
+		"nop\n\t"
+		"breakinst:\tbreak\n\t"
+		"nop\n\t"
+		".set\treorder\n\t");
 }
 
 void adel(void)
 {
-	__asm__ __volatile__("
-			.globl	adel
-			la	$8,0x80000001
-			lw	$9,0($8)
-	");
+	__asm__ __volatile__(
+		".globl\tadel\n\t"
+		"la\t$8,0x80000001\n\t"
+		"lw\t$9,0($8)\n\t");
 }
 
 #ifdef CONFIG_GDB_CONSOLE
