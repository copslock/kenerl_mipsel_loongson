Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DDOBU07797
	for linux-mips-outgoing; Mon, 13 Aug 2001 06:24:11 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DDO8j07792
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 06:24:08 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA21203;
	Mon, 13 Aug 2001 15:26:24 +0200 (MET DST)
Date: Mon, 13 Aug 2001 15:26:23 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, Harald Koerfgen <hkoerfg@web.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux 2.4.5: Export mips_machtype
Message-ID: <Pine.GSO.3.96.1010813152457.18279F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 The following patch exports mips_machtype to modules.  Please apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.5-20010704-machtype-0
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/arch/mips/kernel/mips_ksyms.c linux-mips-2.4.5-20010704/arch/mips/kernel/mips_ksyms.c
--- linux-mips-2.4.5-20010704.macro/arch/mips/kernel/mips_ksyms.c	Thu Jun 14 04:26:19 2001
+++ linux-mips-2.4.5-20010704/arch/mips/kernel/mips_ksyms.c	Sat Aug 11 21:02:38 2001
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
+#include <asm/bootinfo.h>
 #include <asm/checksum.h>
 #include <asm/dma.h>
 #include <asm/io.h>
@@ -40,6 +41,7 @@ extern long __strlen_user_asm(const char
 extern long __strnlen_user_nocheck_asm(const char *s);
 extern long __strnlen_user_asm(const char *s);
 
+EXPORT_SYMBOL(mips_machtype);
 EXPORT_SYMBOL(EISA_bus);
 
 /*
