Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f570wgp09750
	for linux-mips-outgoing; Wed, 6 Jun 2001 17:58:42 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f570wfh09745
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 17:58:41 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id B745A125BA; Wed,  6 Jun 2001 17:58:40 -0700 (PDT)
Date: Wed, 6 Jun 2001 17:58:40 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: binutils@sourceware.cygnus.com
Cc: linux-mips@oss.sgi.com
Subject: Patch: a testcase for bad mips reloc
Message-ID: <20010606175840.A31485@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I checked in the following testcase for the bad object files generated
by the mips assembler.


H.J.
----
2001-06-06  H.J. Lu  <hjl@gnu.org>

	* gas/mips/elf-rel3.s: New file.
	* gas/mips/elf-rel3.d: Likewise.
	* gas/mips/elfel-rel3.s: Likewise.
	* gas/mips/elfel-rel3.d: Likewise.

	* gas/mips/mips.exp: Run elf-rel3/elfel-rel3.

Index: gas/mips/mips.exp
===================================================================
RCS file: /cvs/src/src/gas/testsuite/gas/mips/mips.exp,v
retrieving revision 1.9
diff -u -p -r1.9 mips.exp
--- mips.exp	2001/05/25 18:39:02	1.9
+++ mips.exp	2001/06/07 00:55:30
@@ -126,6 +126,12 @@ if { [istarget mips*-*-*] } then {
 	}
 
 	if [istarget mips*el-*-*] { 
+	    run_dump_test "elfel-rel3"
+	} {
+	    run_dump_test "elf-rel3"
+	}
+
+	if [istarget mips*el-*-*] { 
 	    run_dump_test "${tmips}elempic"
 	} {
 	    run_dump_test "${tmips}empic"
--- /dev/null	Fri Mar 23 20:37:44 2001
+++ gas/mips/elf-rel3.s	Wed Jun  6 17:48:43 2001
@@ -0,0 +1,11 @@
+	.data
+	.type	 x,@object
+	.size	 x,4
+x:
+	.word	0x12121212
+	.globl	b
+	.type	 b,@object
+	.size	 b,8
+b:
+	.word	b-4
+	.word	x
--- /dev/null	Fri Mar 23 20:37:44 2001
+++ gas/mips/elf-rel3.d	Wed Jun  6 17:48:43 2001
@@ -0,0 +1,13 @@
+#objdump: -sr -j .data
+#name: MIPS ELF reloc 3
+
+.*:     file format elf.*mips
+
+RELOCATION RECORDS FOR \[\.data\]:
+OFFSET           TYPE              VALUE 
+0+0000004 R_MIPS_32         b
+0+0000008 R_MIPS_32         .data
+
+
+Contents of section .data:
+ 0000 12121212 fffffffc 00000000 00000000  ................
--- /dev/null	Fri Mar 23 20:37:44 2001
+++ gas/mips/elfel-rel3.s	Wed Jun  6 17:48:43 2001
@@ -0,0 +1,11 @@
+	.data
+	.type	 x,@object
+	.size	 x,4
+x:
+	.word	0x12121212
+	.globl	b
+	.type	 b,@object
+	.size	 b,8
+b:
+	.word	b+4
+	.word	x
--- /dev/null	Fri Mar 23 20:37:44 2001
+++ gas/mips/elfel-rel3.d	Wed Jun  6 17:48:43 2001
@@ -0,0 +1,13 @@
+#objdump: -sr -j .data
+#name: MIPS ELF reloc 3
+
+.*:     file format elf.*mips
+
+RELOCATION RECORDS FOR \[\.data\]:
+OFFSET           TYPE              VALUE 
+0+0000004 R_MIPS_32         b
+0+0000008 R_MIPS_32         .data
+
+
+Contents of section .data:
+ 0000 12121212 04000000 00000000 00000000  ................
