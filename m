Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 13:24:19 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:40102 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023622AbXJAMYL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 13:24:11 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 893BE400F9;
	Mon,  1 Oct 2007 14:24:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id jw-SqJE5WLew; Mon,  1 Oct 2007 14:24:05 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id D559C40040;
	Mon,  1 Oct 2007 14:24:05 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l91CO81V000438;
	Mon, 1 Oct 2007 14:24:08 +0200
Date:	Mon, 1 Oct 2007 13:24:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH][URGENT] kernel/vmlinux.lds.S: Handle note sections
Message-ID: <Pine.LNX.4.64N.0710011310120.27280@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4445/Mon Oct  1 10:32:46 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Store any note sections after the exception tables like the other 
architectures do.  This is required for .note.gnu.build-id emitted from 
binutils 2.18 onwards if nothing else.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 Without it a binary with a layout like this is created:

$ readelf -l vmlinux

Elf file type is EXEC (Executable file)
Entry point 0xffffffff804cc000
There are 3 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x00000000000000e8 0x0000000000000000 0x0000000000000000
                 0x0000000000000024 0x0000000000000024  R      4
  LOAD           0x0000000000004000 0xffffffff80040000 0xffffffff80040000
                 0x00000000004bead8 0x0000000000642980  RWE    4000
  NOTE           0x00000000000000e8 0x0000000000000000 0x0000000000000000
                 0x0000000000000024 0x0000000000000024  R      4

 Section to Segment mapping:
  Segment Sections...
   00     .note.gnu.build-id 
   01     .text __ex_table __dbe_table .rodata __ksymtab __ksymtab_gpl __ksymtab_strings __param .data .data.cacheline_aligned .init.text .init.data .init.setup .initcall.init .con_initcall.init .exit.text .bss 
   02     .note.gnu.build-id 

which does not quite work as the first segment is in the KUSEG.

 Please apply ASAP.

  Maciej

patch-mips-2.6.23-rc5-20070904-mips-notes-0
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/kernel/vmlinux.lds.S linux-mips-2.6.23-rc5-20070904/arch/mips/kernel/vmlinux.lds.S
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/kernel/vmlinux.lds.S	2007-09-04 04:55:19.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/kernel/vmlinux.lds.S	2007-10-01 04:16:44.000000000 +0000
@@ -45,6 +45,8 @@ SECTIONS
   __dbe_table : { *(__dbe_table) }
   __stop___dbe_table = .;
 
+  NOTES
+
   RODATA
 
   /* writeable */
