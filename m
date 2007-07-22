Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2007 05:00:58 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:30281 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021888AbXGVEA4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Jul 2007 05:00:56 +0100
Received: by mo.po.2iij.net (mo30) id l6M40pr7004168; Sun, 22 Jul 2007 13:00:51 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox301) id l6M40kNt008666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 22 Jul 2007 13:00:47 +0900
Date:	Sun, 22 Jul 2007 13:00:46 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix section mismatch prom_free_prom_memory()
Message-Id: <20070722130046.085e0f8d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Fix section mismatch prom_free_prom_memory().

WARNING: vmlinux.o(.text+0xbf20): Section mismatch: reference to
.init.text:prom_free_prom_memory (between 'free_initmem' and 'copy_from_user_page')

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/arc/memory.c generic/arch/mips/arc/memory.c
--- generic-orig/arch/mips/arc/memory.c	2007-07-21 21:55:05.840953750 +0900
+++ generic/arch/mips/arc/memory.c	2007-07-21 21:43:42.742262750 +0900
@@ -141,7 +141,7 @@ void __init prom_meminit(void)
 	}
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 	unsigned long addr;
 	int i;
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/au1000/common/prom.c generic/arch/mips/au1000/common/prom.c
--- generic-orig/arch/mips/au1000/common/prom.c	2007-07-21 21:55:06.004964000 +0900
+++ generic/arch/mips/au1000/common/prom.c	2007-07-21 21:44:02.183477750 +0900
@@ -149,7 +149,7 @@ int get_ethernet_addr(char *ethernet_add
 	return 0;
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
 
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/basler/excite/excite_prom.c generic/arch/mips/basler/excite/excite_prom.c
--- generic-orig/arch/mips/basler/excite/excite_prom.c	2007-07-21 21:55:06.328984250 +0900
+++ generic/arch/mips/basler/excite/excite_prom.c	2007-07-21 21:44:27.721073750 +0900
@@ -141,7 +141,7 @@ void __init prom_init(void)
 }
 
 /* This is called from free_initmem(), so we need to provide it */
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 	/* Nothing to do */
 }
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/cobalt/setup.c generic/arch/mips/cobalt/setup.c
--- generic-orig/arch/mips/cobalt/setup.c	2007-07-21 21:55:06.520996250 +0900
+++ generic/arch/mips/cobalt/setup.c	2007-07-21 21:47:45.577439000 +0900
@@ -140,7 +140,7 @@ void __init prom_init(void)
 	add_memory_region(0x0, memsz, BOOT_MEM_RAM);
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 	/* Nothing to do! */
 }
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/ddb5xxx/common/prom.c generic/arch/mips/ddb5xxx/common/prom.c
--- generic-orig/arch/mips/ddb5xxx/common/prom.c	2007-07-21 21:55:07.069030500 +0900
+++ generic/arch/mips/ddb5xxx/common/prom.c	2007-07-21 21:48:03.670569750 +0900
@@ -59,7 +59,7 @@ void __init prom_init(void)
 #endif
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
 
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/dec/prom/memory.c generic/arch/mips/dec/prom/memory.c
--- generic-orig/arch/mips/dec/prom/memory.c	2007-07-21 21:55:07.417052250 +0900
+++ generic/arch/mips/dec/prom/memory.c	2007-07-21 21:48:25.511934750 +0900
@@ -92,7 +92,7 @@ void __init prom_meminit(u32 magic)
 		rex_setup_memory_region();
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 	unsigned long end;
 
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/emma2rh/common/prom.c generic/arch/mips/emma2rh/common/prom.c
--- generic-orig/arch/mips/emma2rh/common/prom.c	2007-07-21 21:55:07.597063500 +0900
+++ generic/arch/mips/emma2rh/common/prom.c	2007-07-21 21:48:44.073094750 +0900
@@ -71,6 +71,6 @@ void __init prom_init(void)
 
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/gt64120/momenco_ocelot/prom.c generic/arch/mips/gt64120/momenco_ocelot/prom.c
--- generic-orig/arch/mips/gt64120/momenco_ocelot/prom.c	2007-07-21 21:55:07.861080000 +0900
+++ generic/arch/mips/gt64120/momenco_ocelot/prom.c	2007-07-21 21:48:59.722072750 +0900
@@ -66,6 +66,6 @@ void __init prom_init(void)
 	add_memory_region(0, 64 << 20, BOOT_MEM_RAM);
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/gt64120/wrppmc/setup.c generic/arch/mips/gt64120/wrppmc/setup.c
--- generic-orig/arch/mips/gt64120/wrppmc/setup.c	2007-07-21 21:55:07.929084250 +0900
+++ generic/arch/mips/gt64120/wrppmc/setup.c	2007-07-21 21:49:13.826954250 +0900
@@ -94,7 +94,7 @@ void __init wrppmc_early_printk(const ch
 }
 #endif /* WRPPMC_EARLY_DEBUG */
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
 
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/jmr3927/common/prom.c generic/arch/mips/jmr3927/common/prom.c
--- generic-orig/arch/mips/jmr3927/common/prom.c	2007-07-21 21:55:08.109095500 +0900
+++ generic/arch/mips/jmr3927/common/prom.c	2007-07-21 21:49:37.516434750 +0900
@@ -67,6 +67,6 @@ void  __init prom_init_cmdline(void)
 	*cp = '\0';
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/lemote/lm2e/prom.c generic/arch/mips/lemote/lm2e/prom.c
--- generic-orig/arch/mips/lemote/lm2e/prom.c	2007-07-21 21:55:11.497307250 +0900
+++ generic/arch/mips/lemote/lm2e/prom.c	2007-07-21 21:50:40.540373500 +0900
@@ -94,7 +94,7 @@ do {									\
 	       bus_clock, cpu_clock, memsize, highmemsize);
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
 
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/mips-boards/generic/memory.c generic/arch/mips/mips-boards/generic/memory.c
--- generic-orig/arch/mips/mips-boards/generic/memory.c	2007-07-21 21:55:12.037341000 +0900
+++ generic/arch/mips/mips-boards/generic/memory.c	2007-07-21 21:50:59.673569250 +0900
@@ -167,7 +167,7 @@ void __init prom_meminit(void)
 	}
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 	unsigned long addr;
 	int i;
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/mipssim/sim_mem.c generic/arch/mips/mipssim/sim_mem.c
--- generic-orig/arch/mips/mipssim/sim_mem.c	2007-07-21 21:55:12.469368000 +0900
+++ generic/arch/mips/mipssim/sim_mem.c	2007-07-21 21:51:11.974338000 +0900
@@ -99,7 +99,7 @@ void __init prom_meminit(void)
 	}
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 	int i;
 	unsigned long addr;
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/philips/pnx8550/common/prom.c generic/arch/mips/philips/pnx8550/common/prom.c
--- generic-orig/arch/mips/philips/pnx8550/common/prom.c	2007-07-21 21:55:15.873580750 +0900
+++ generic/arch/mips/philips/pnx8550/common/prom.c	2007-07-21 21:47:23.496059000 +0900
@@ -106,7 +106,7 @@ int get_ethernet_addr(char *ethernet_add
 	return 0;
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
 
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/pmc-sierra/msp71xx/msp_prom.c generic/arch/mips/pmc-sierra/msp71xx/msp_prom.c
--- generic-orig/arch/mips/pmc-sierra/msp71xx/msp_prom.c	2007-07-21 21:55:16.069593000 +0900
+++ generic/arch/mips/pmc-sierra/msp71xx/msp_prom.c	2007-07-21 21:47:00.422617000 +0900
@@ -366,7 +366,7 @@ void __init prom_meminit(void)
 	}
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 	int	argc;
 	char	**argv;
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/pmc-sierra/yosemite/prom.c generic/arch/mips/pmc-sierra/yosemite/prom.c
--- generic-orig/arch/mips/pmc-sierra/yosemite/prom.c	2007-07-21 21:55:16.181600000 +0900
+++ generic/arch/mips/pmc-sierra/yosemite/prom.c	2007-07-21 21:46:41.413429000 +0900
@@ -132,7 +132,7 @@ void __init prom_init(void)
 	prom_grab_secondary();
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
 
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/qemu/q-mem.c generic/arch/mips/qemu/q-mem.c
--- generic-orig/arch/mips/qemu/q-mem.c	2007-07-21 21:55:16.345610250 +0900
+++ generic/arch/mips/qemu/q-mem.c	2007-07-21 21:46:27.480558250 +0900
@@ -1,5 +1,3 @@
-#include <linux/init.h>
-
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/sgi-ip22/ip22-mc.c generic/arch/mips/sgi-ip22/ip22-mc.c
--- generic-orig/arch/mips/sgi-ip22/ip22-mc.c	2007-07-21 21:55:16.437616000 +0900
+++ generic/arch/mips/sgi-ip22/ip22-mc.c	2007-07-21 21:46:06.331236500 +0900
@@ -202,6 +202,6 @@ void __init sgimc_init(void)
 }
 
 void __init prom_meminit(void) {}
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/sgi-ip27/ip27-memory.c generic/arch/mips/sgi-ip27/ip27-memory.c
--- generic-orig/arch/mips/sgi-ip27/ip27-memory.c	2007-07-21 21:55:16.729634250 +0900
+++ generic/arch/mips/sgi-ip27/ip27-memory.c	2007-07-21 21:45:44.141849750 +0900
@@ -499,7 +499,7 @@ void __init prom_meminit(void)
 	}
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 	/* We got nothing to free here ...  */
 }
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/sgi-ip32/ip32-memory.c generic/arch/mips/sgi-ip32/ip32-memory.c
--- generic-orig/arch/mips/sgi-ip32/ip32-memory.c	2007-07-21 21:55:16.805639000 +0900
+++ generic/arch/mips/sgi-ip32/ip32-memory.c	2007-07-21 21:45:26.680758500 +0900
@@ -43,6 +43,6 @@ void __init prom_meminit (void)
 }
 
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/sibyte/cfe/setup.c generic/arch/mips/sibyte/cfe/setup.c
--- generic-orig/arch/mips/sibyte/cfe/setup.c	2007-07-21 21:55:16.997651000 +0900
+++ generic/arch/mips/sibyte/cfe/setup.c	2007-07-21 21:45:05.535437000 +0900
@@ -343,7 +343,7 @@ void __init prom_init(void)
 	prom_meminit();
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 	/* Not sure what I'm supposed to do here.  Nothing, I think */
 }
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/sibyte/sb1250/prom.c generic/arch/mips/sibyte/sb1250/prom.c
--- generic-orig/arch/mips/sibyte/sb1250/prom.c	2007-07-21 21:55:17.093657000 +0900
+++ generic/arch/mips/sibyte/sb1250/prom.c	2007-07-21 21:44:47.234293250 +0900
@@ -87,7 +87,7 @@ void __init prom_init(void)
 	prom_meminit();
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 	/* Not sure what I'm supposed to do here.  Nothing, I think */
 }
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/sni/sniprom.c generic/arch/mips/sni/sniprom.c
--- generic-orig/arch/mips/sni/sniprom.c	2007-07-21 21:55:17.465680250 +0900
+++ generic/arch/mips/sni/sniprom.c	2007-07-21 21:43:12.208354500 +0900
@@ -49,7 +49,7 @@ char *prom_getenv (char *s)
 	return __prom_getenv(s);
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
 
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c generic/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
--- generic-orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c	2007-07-21 21:55:17.633690750 +0900
+++ generic/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c	2007-07-21 21:42:56.207354500 +0900
@@ -80,7 +80,7 @@ void __init prom_init(void)
 	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
 
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/tx4938/toshiba_rbtx4938/prom.c generic/arch/mips/tx4938/toshiba_rbtx4938/prom.c
--- generic-orig/arch/mips/tx4938/toshiba_rbtx4938/prom.c	2007-07-21 21:55:17.685694000 +0900
+++ generic/arch/mips/tx4938/toshiba_rbtx4938/prom.c	2007-07-21 21:42:04.080096750 +0900
@@ -56,7 +56,7 @@ void __init prom_init(void)
 	return;
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
 
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/vr41xx/common/init.c generic/arch/mips/vr41xx/common/init.c
--- generic-orig/arch/mips/vr41xx/common/init.c	2007-07-21 21:55:17.785700250 +0900
+++ generic/arch/mips/vr41xx/common/init.c	2007-07-21 21:41:40.994654000 +0900
@@ -81,6 +81,6 @@ void __init prom_init(void)
 	}
 }
 
-void __init prom_free_prom_memory(void)
+void prom_free_prom_memory(void)
 {
 }
