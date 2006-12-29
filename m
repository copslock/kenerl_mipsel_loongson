Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2006 15:44:13 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:26097 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28574835AbWL2PoH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2006 15:44:07 +0000
Received: from localhost (p5168-ipad03funabasi.chiba.ocn.ne.jp [219.160.85.168])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CC7DAB9CE; Sat, 30 Dec 2006 00:44:01 +0900 (JST)
Date:	Sat, 30 Dec 2006 00:43:59 +0900 (JST)
Message-Id: <20061230.004359.41198543.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] prom_free_prom_memory cleanup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Current prom_free_prom_memory() implementations are almost same as
free_init_pages(), or no-op.  Make free_init_pages() extern (again)
and make prom_free_prom_memory() use it.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/arc/memory.c                                    |   18 ++----------
 arch/mips/au1000/common/prom.c                            |    3 --
 arch/mips/cobalt/setup.c                                  |    3 --
 arch/mips/ddb5xxx/common/prom.c                           |    3 --
 arch/mips/dec/prom/memory.c                               |   17 ++---------
 arch/mips/gt64120/ev64120/setup.c                         |    3 --
 arch/mips/gt64120/momenco_ocelot/prom.c                   |    3 --
 arch/mips/gt64120/wrppmc/setup.c                          |    3 --
 arch/mips/jmr3927/common/prom.c                           |    3 --
 arch/mips/lasat/prom.c                                    |    3 --
 arch/mips/mips-boards/generic/memory.c                    |   18 ++----------
 arch/mips/mips-boards/sim/sim_mem.c                       |   16 ++--------
 arch/mips/mm/init.c                                       |   10 +-----
 arch/mips/momentum/jaguar_atx/prom.c                      |    3 --
 arch/mips/momentum/ocelot_3/prom.c                        |    3 --
 arch/mips/momentum/ocelot_c/prom.c                        |    3 --
 arch/mips/momentum/ocelot_g/prom.c                        |    3 --
 arch/mips/philips/pnx8550/common/prom.c                   |    3 --
 arch/mips/pmc-sierra/yosemite/prom.c                      |    3 --
 arch/mips/qemu/q-mem.c                                    |    3 --
 arch/mips/sgi-ip22/ip22-mc.c                              |    3 --
 arch/mips/sgi-ip27/ip27-memory.c                          |    3 --
 arch/mips/sgi-ip32/ip32-memory.c                          |    3 --
 arch/mips/sibyte/cfe/setup.c                              |    3 --
 arch/mips/sibyte/sb1250/prom.c                            |    3 --
 arch/mips/sni/sniprom.c                                   |    3 --
 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c |    3 --
 arch/mips/tx4938/toshiba_rbtx4938/prom.c                  |    3 --
 arch/mips/vr41xx/common/init.c                            |    3 --
 include/asm-mips/bootinfo.h                               |    4 ++
 include/asm-mips/mips-boards/prom.h                       |    1 
 31 files changed, 44 insertions(+), 112 deletions(-)

diff --git a/arch/mips/arc/memory.c b/arch/mips/arc/memory.c
index 8a9ef58..456cb81 100644
--- a/arch/mips/arc/memory.c
+++ b/arch/mips/arc/memory.c
@@ -141,30 +141,20 @@ #endif
 	}
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	unsigned long freed = 0;
 	unsigned long addr;
 	int i;
 
 	if (prom_flags & PROM_FLAG_DONT_FREE_TEMP)
-		return 0;
+		return;
 
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
 			continue;
 
 		addr = boot_mem_map.map[i].addr;
-		while (addr < boot_mem_map.map[i].addr
-			      + boot_mem_map.map[i].size) {
-			ClearPageReserved(virt_to_page(__va(addr)));
-			init_page_count(virt_to_page(__va(addr)));
-			free_page((unsigned long)__va(addr));
-			addr += PAGE_SIZE;
-			freed += PAGE_SIZE;
-		}
+		free_init_pages("prom memory",
+				addr, addr + boot_mem_map.map[i].size);
 	}
-	printk(KERN_INFO "Freeing prom memory: %ldkb freed\n", freed >> 10);
-
-	return freed;
 }
diff --git a/arch/mips/au1000/common/prom.c b/arch/mips/au1000/common/prom.c
index 6fce60a..a8637cd 100644
--- a/arch/mips/au1000/common/prom.c
+++ b/arch/mips/au1000/common/prom.c
@@ -149,9 +149,8 @@ #endif
 	return 0;
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
 
 EXPORT_SYMBOL(prom_getcmdline);
diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index e8f0f20..a4b69b5 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -204,8 +204,7 @@ void __init prom_init(void)
 	add_memory_region(0x0, memsz, BOOT_MEM_RAM);
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
 	/* Nothing to do! */
-	return 0;
 }
diff --git a/arch/mips/ddb5xxx/common/prom.c b/arch/mips/ddb5xxx/common/prom.c
index efef0f5..54a857b 100644
--- a/arch/mips/ddb5xxx/common/prom.c
+++ b/arch/mips/ddb5xxx/common/prom.c
@@ -59,9 +59,8 @@ #if defined(CONFIG_DDB5477)
 #endif
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
 
 #if defined(CONFIG_DDB5477)
diff --git a/arch/mips/dec/prom/memory.c b/arch/mips/dec/prom/memory.c
index 3027ce7..5a557e2 100644
--- a/arch/mips/dec/prom/memory.c
+++ b/arch/mips/dec/prom/memory.c
@@ -92,9 +92,9 @@ void __init prom_meminit(u32 magic)
 		rex_setup_memory_region();
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	unsigned long addr, end;
+	unsigned long end;
 
 	/*
 	 * Free everything below the kernel itself but leave
@@ -114,16 +114,5 @@ #if defined(CONFIG_DECLANCE) || defined(
 #endif
 		end = __pa(&_text);
 
-	addr = PAGE_SIZE;
-	while (addr < end) {
-		ClearPageReserved(virt_to_page(__va(addr)));
-		init_page_count(virt_to_page(__va(addr)));
-		free_page((unsigned long)__va(addr));
-		addr += PAGE_SIZE;
-	}
-
-	printk("Freeing unused PROM memory: %ldk freed\n",
-	       (end - PAGE_SIZE) >> 10);
-
-	return end - PAGE_SIZE;
+	free_init_pages("unused PROM memory", PAGE_SIZE, end);
 }
diff --git a/arch/mips/gt64120/ev64120/setup.c b/arch/mips/gt64120/ev64120/setup.c
index 99c8d42..477848c 100644
--- a/arch/mips/gt64120/ev64120/setup.c
+++ b/arch/mips/gt64120/ev64120/setup.c
@@ -59,9 +59,8 @@ extern void galileo_machine_power_off(vo
  */
 extern struct pci_ops galileo_pci_ops;
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
 
 /*
diff --git a/arch/mips/gt64120/momenco_ocelot/prom.c b/arch/mips/gt64120/momenco_ocelot/prom.c
index 8677b6d..78f393b 100644
--- a/arch/mips/gt64120/momenco_ocelot/prom.c
+++ b/arch/mips/gt64120/momenco_ocelot/prom.c
@@ -67,7 +67,6 @@ void __init prom_init(void)
 	add_memory_region(0, 64 << 20, BOOT_MEM_RAM);
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
diff --git a/arch/mips/gt64120/wrppmc/setup.c b/arch/mips/gt64120/wrppmc/setup.c
index 429afc4..121188d 100644
--- a/arch/mips/gt64120/wrppmc/setup.c
+++ b/arch/mips/gt64120/wrppmc/setup.c
@@ -93,9 +93,8 @@ void __init wrppmc_early_printk(const ch
 }
 #endif /* WRPPMC_EARLY_DEBUG */
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
 
 #ifdef CONFIG_SERIAL_8250
diff --git a/arch/mips/jmr3927/common/prom.c b/arch/mips/jmr3927/common/prom.c
index 5d5838f..aa481b7 100644
--- a/arch/mips/jmr3927/common/prom.c
+++ b/arch/mips/jmr3927/common/prom.c
@@ -75,7 +75,6 @@ void  __init prom_init_cmdline(void)
 	*cp = '\0';
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
diff --git a/arch/mips/lasat/prom.c b/arch/mips/lasat/prom.c
index 88c7ab8..d47692f 100644
--- a/arch/mips/lasat/prom.c
+++ b/arch/mips/lasat/prom.c
@@ -132,9 +132,8 @@ void __init prom_init(void)
 	add_memory_region(0, lasat_board_info.li_memsize, BOOT_MEM_RAM);
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
 
 const char *get_system_type(void)
diff --git a/arch/mips/mips-boards/generic/memory.c b/arch/mips/mips-boards/generic/memory.c
index eeed944..ebf0e16 100644
--- a/arch/mips/mips-boards/generic/memory.c
+++ b/arch/mips/mips-boards/generic/memory.c
@@ -166,9 +166,8 @@ #endif
 	}
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	unsigned long freed = 0;
 	unsigned long addr;
 	int i;
 
@@ -176,17 +175,8 @@ unsigned long __init prom_free_prom_memo
 		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
 			continue;
 
-		addr = PAGE_ALIGN(boot_mem_map.map[i].addr);
-		while (addr < boot_mem_map.map[i].addr
-			      + boot_mem_map.map[i].size) {
-			ClearPageReserved(virt_to_page(__va(addr)));
-			init_page_count(virt_to_page(__va(addr)));
-			free_page((unsigned long)__va(addr));
-			addr += PAGE_SIZE;
-			freed += PAGE_SIZE;
-		}
+		addr = boot_mem_map.map[i].addr;
+		free_init_pages("prom memory",
+				addr, addr + boot_mem_map.map[i].size);
 	}
-	printk("Freeing prom memory: %ldkb freed\n", freed >> 10);
-
-	return freed;
 }
diff --git a/arch/mips/mips-boards/sim/sim_mem.c b/arch/mips/mips-boards/sim/sim_mem.c
index f7ce769..46bc16f 100644
--- a/arch/mips/mips-boards/sim/sim_mem.c
+++ b/arch/mips/mips-boards/sim/sim_mem.c
@@ -99,10 +99,9 @@ void __init prom_meminit(void)
 	}
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
 	int i;
-	unsigned long freed = 0;
 	unsigned long addr;
 
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
@@ -110,16 +109,7 @@ unsigned long __init prom_free_prom_memo
 			continue;
 
 		addr = boot_mem_map.map[i].addr;
-		while (addr < boot_mem_map.map[i].addr
-			      + boot_mem_map.map[i].size) {
-			ClearPageReserved(virt_to_page(__va(addr)));
-			init_page_count(virt_to_page(__va(addr)));
-			free_page((unsigned long)__va(addr));
-			addr += PAGE_SIZE;
-			freed += PAGE_SIZE;
-		}
+		free_init_pages("prom memory",
+				addr, addr + boot_mem_map.map[i].size);
 	}
-	printk("Freeing prom memory: %ldkb freed\n", freed >> 10);
-
-	return freed;
 }
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 30245c0..98d7dec 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -467,7 +467,7 @@ #endif
 }
 #endif /* !CONFIG_NEED_MULTIPLE_NODES */
 
-static void free_init_pages(char *what, unsigned long begin, unsigned long end)
+void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 {
 	unsigned long pfn;
 
@@ -493,16 +493,10 @@ void free_initrd_mem(unsigned long start
 }
 #endif
 
-extern unsigned long prom_free_prom_memory(void);
 
 void free_initmem(void)
 {
-	unsigned long freed;
-
-	freed = prom_free_prom_memory();
-	if (freed)
-		printk(KERN_INFO "Freeing firmware memory: %ldk freed\n",freed);
-
+	prom_free_prom_memory();
 	free_init_pages("unused kernel memory",
 			__pa_symbol(&__init_begin),
 			__pa_symbol(&__init_end));
diff --git a/arch/mips/momentum/jaguar_atx/prom.c b/arch/mips/momentum/jaguar_atx/prom.c
index 400ef9d..5dd154e 100644
--- a/arch/mips/momentum/jaguar_atx/prom.c
+++ b/arch/mips/momentum/jaguar_atx/prom.c
@@ -180,9 +180,8 @@ #endif /* CONFIG_64BIT */
 	mips_machtype = MACH_MOMENCO_JAGUAR_ATX;
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
 
 void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
diff --git a/arch/mips/momentum/ocelot_3/prom.c b/arch/mips/momentum/ocelot_3/prom.c
index 6ce9b7f..8e02df6 100644
--- a/arch/mips/momentum/ocelot_3/prom.c
+++ b/arch/mips/momentum/ocelot_3/prom.c
@@ -180,9 +180,8 @@ #ifndef CONFIG_64BIT
 #endif
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
 
 void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
diff --git a/arch/mips/momentum/ocelot_c/prom.c b/arch/mips/momentum/ocelot_c/prom.c
index d0b77e1..b689cee 100644
--- a/arch/mips/momentum/ocelot_c/prom.c
+++ b/arch/mips/momentum/ocelot_c/prom.c
@@ -178,7 +178,6 @@ #ifndef CONFIG_64BIT
 #endif
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
diff --git a/arch/mips/momentum/ocelot_g/prom.c b/arch/mips/momentum/ocelot_g/prom.c
index 6509a9c..01b17c6 100644
--- a/arch/mips/momentum/ocelot_g/prom.c
+++ b/arch/mips/momentum/ocelot_g/prom.c
@@ -79,7 +79,6 @@ #endif
 	}
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
diff --git a/arch/mips/philips/pnx8550/common/prom.c b/arch/mips/philips/pnx8550/common/prom.c
index eb6ec11..8aeed6c 100644
--- a/arch/mips/philips/pnx8550/common/prom.c
+++ b/arch/mips/philips/pnx8550/common/prom.c
@@ -106,9 +106,8 @@ int get_ethernet_addr(char *ethernet_add
 	return 0;
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
 
 extern int pnx8550_console_port;
diff --git a/arch/mips/pmc-sierra/yosemite/prom.c b/arch/mips/pmc-sierra/yosemite/prom.c
index 9fe4973..1e1685e 100644
--- a/arch/mips/pmc-sierra/yosemite/prom.c
+++ b/arch/mips/pmc-sierra/yosemite/prom.c
@@ -132,9 +132,8 @@ #endif
 	prom_grab_secondary();
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
 
 void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
diff --git a/arch/mips/qemu/q-mem.c b/arch/mips/qemu/q-mem.c
index d174fac..dae39b5 100644
--- a/arch/mips/qemu/q-mem.c
+++ b/arch/mips/qemu/q-mem.c
@@ -1,6 +1,5 @@
 #include <linux/init.h>
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0UL;
 }
diff --git a/arch/mips/sgi-ip22/ip22-mc.c b/arch/mips/sgi-ip22/ip22-mc.c
index b58bd52..ddb6506 100644
--- a/arch/mips/sgi-ip22/ip22-mc.c
+++ b/arch/mips/sgi-ip22/ip22-mc.c
@@ -202,7 +202,6 @@ void __init sgimc_init(void)
 }
 
 void __init prom_meminit(void) {}
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 16e5682..0e3d535 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -498,10 +498,9 @@ void __init prom_meminit(void)
 	}
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
 	/* We got nothing to free here ...  */
-	return 0;
 }
 
 extern void pagetable_init(void);
diff --git a/arch/mips/sgi-ip32/ip32-memory.c b/arch/mips/sgi-ip32/ip32-memory.c
index d37d40a..849d392 100644
--- a/arch/mips/sgi-ip32/ip32-memory.c
+++ b/arch/mips/sgi-ip32/ip32-memory.c
@@ -43,7 +43,6 @@ void __init prom_meminit (void)
 }
 
 
-unsigned long __init prom_free_prom_memory (void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
diff --git a/arch/mips/sibyte/cfe/setup.c b/arch/mips/sibyte/cfe/setup.c
index 6e8952d..9e6099e 100644
--- a/arch/mips/sibyte/cfe/setup.c
+++ b/arch/mips/sibyte/cfe/setup.c
@@ -343,10 +343,9 @@ #endif /* CONFIG_BLK_DEV_INITRD */
 	prom_meminit();
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
 	/* Not sure what I'm supposed to do here.  Nothing, I think */
-	return 0;
 }
 
 void prom_putchar(char c)
diff --git a/arch/mips/sibyte/sb1250/prom.c b/arch/mips/sibyte/sb1250/prom.c
index 3c33a45..257c4e6 100644
--- a/arch/mips/sibyte/sb1250/prom.c
+++ b/arch/mips/sibyte/sb1250/prom.c
@@ -87,10 +87,9 @@ void __init prom_init(void)
 	prom_meminit();
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
 	/* Not sure what I'm supposed to do here.  Nothing, I think */
-	return 0;
 }
 
 void prom_putchar(char c)
diff --git a/arch/mips/sni/sniprom.c b/arch/mips/sni/sniprom.c
index d1d0f1f..1213d16 100644
--- a/arch/mips/sni/sniprom.c
+++ b/arch/mips/sni/sniprom.c
@@ -67,9 +67,8 @@ void prom_printf(char *fmt, ...)
 	va_end(args);
 }
 
-unsigned long prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
 
 /*
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
index efe5056..9a3a5ba 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
@@ -80,9 +80,8 @@ void __init prom_init(void)
 	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
 }
 
-unsigned long __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
 
 const char *get_system_type(void)
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/prom.c b/arch/mips/tx4938/toshiba_rbtx4938/prom.c
index e44daf3..7dc6a0a 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/prom.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/prom.c
@@ -56,9 +56,8 @@ #endif
 	return;
 }
 
-unsigned long  __init prom_free_prom_memory(void)
+void __init prom_free_prom_memory(void)
 {
-	return 0;
 }
 
 void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
index a2e285c..4f97e0b 100644
--- a/arch/mips/vr41xx/common/init.c
+++ b/arch/mips/vr41xx/common/init.c
@@ -81,7 +81,6 @@ void __init prom_init(void)
 	}
 }
 
-unsigned long __init prom_free_prom_memory (void)
+void __init prom_free_prom_memory(void)
 {
-	return 0UL;
 }
diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
index 8e321f5..c7c945b 100644
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -243,6 +243,10 @@ extern struct boot_mem_map boot_mem_map;
 extern void add_memory_region(phys_t start, phys_t size, long type);
 
 extern void prom_init(void);
+extern void prom_free_prom_memory(void);
+
+extern void free_init_pages(const char *what,
+			    unsigned long begin, unsigned long end);
 
 /*
  * Initial kernel command line, usually setup by prom_init()
diff --git a/include/asm-mips/mips-boards/prom.h b/include/asm-mips/mips-boards/prom.h
index 4168c7f..7bf6f5f 100644
--- a/include/asm-mips/mips-boards/prom.h
+++ b/include/asm-mips/mips-boards/prom.h
@@ -33,7 +33,6 @@ extern void prom_printf(char *fmt, ...);
 extern void prom_init_cmdline(void);
 extern void prom_meminit(void);
 extern void prom_fixup_mem_map(unsigned long start_mem, unsigned long end_mem);
-extern unsigned long prom_free_prom_memory (void);
 extern void mips_display_message(const char *str);
 extern void mips_display_word(unsigned int num);
 extern int get_ethernet_addr(char *ethernet_addr);
