Received:  by oss.sgi.com id <S553772AbQLaLnm>;
	Sun, 31 Dec 2000 03:43:42 -0800
Received: from mail.ivm.net ([62.204.1.4]:10608 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553768AbQLaLnV>;
	Sun, 31 Dec 2000 03:43:21 -0800
Received: from franz.no.dom (port203.duesseldorf.ivm.de [195.247.65.203])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id MAA30831;
	Sun, 31 Dec 2000 12:43:05 +0100
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.001231124111.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date:   Sun, 31 Dec 2000 12:41:11 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     ralf@uni-koblenz.de, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: SGI/ARCS related fixes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

wanting to bring my O2 patches up to date I stumbled over some minor hickups.

I don't have the appropriate hardware to test, ok to commit?

-- 
Regards,
Harald

diff -ruN /nfs/cvs/linux-2.3/linux/arch/mips/arc/memory.c
linux/arch/mips/arc/memory.c
--- /nfs/cvs/linux-2.3/linux/arch/mips/arc/memory.c     Mon Dec 11 18:07:34 2000
+++ linux/arch/mips/arc/memory.c        Sat Dec 30 21:49:32 2000
@@ -124,7 +124,7 @@
                size = p->pages << PAGE_SHIFT;
                type = prom_memtype_classify(p->type);
 
-               add_memory_region(base, pages, type);
+               add_memory_region(base, size, type);
        }
 }
 
@@ -143,12 +143,13 @@
                addr = boot_mem_map.map[i].addr;
                while (addr < boot_mem_map.map[i].addr
                              + boot_mem_map.map[i].size) {
-                       ClearPageReserved(virt_to_page(__va(addr)));
-                       set_page_count(virt_to_page(__va(addr)), 1);
-                       free_page(__va(addr));
+                       ClearPageReserved(virt_to_page(addr));
+                       set_page_count(virt_to_page(addr), 1);
+                       free_page(addr);
                        addr += PAGE_SIZE;
                        freed += PAGE_SIZE;
                }
        }
        printk("Freeing prom memory: %ldkb freed\n", freed >> 10);
 }
+
diff -ruN /nfs/cvs/linux-2.3/linux/drivers/char/misc.c linux/drivers/char/misc.c
--- /nfs/cvs/linux-2.3/linux/drivers/char/misc.c        Fri Nov 24 11:17:05 2000
+++ linux/drivers/char/misc.c   Sat Dec 30 21:42:45 2000
@@ -283,9 +283,6 @@
 #ifdef CONFIG_SGI_NEWPORT_GFX
        gfx_register ();
 #endif
-#ifdef CONFIG_SGI
-       streamable_init ();
-#endif
 #ifdef CONFIG_TOSHIBA
        tosh_init();
 #endif
@@ -296,3 +293,4 @@
        }
        return 0;
 }
+
diff -ruN /nfs/cvs/linux-2.3/linux/include/asm-mips/sgialib.h
linux/include/asm-mips/sgialib.h
--- /nfs/cvs/linux-2.3/linux/include/asm-mips/sgialib.h Mon Dec 11 18:08:10 2000
+++ linux/include/asm-mips/sgialib.h    Sat Dec 30 21:40:40 2000
@@ -20,7 +20,7 @@
  * Init the PROM library and it's internal data structures.  Called
  * at boot time from head.S before start_kernel is invoked.
  */
-extern int prom_init(int argc, char **argv, char **envp, int *prom_vec);
+extern void prom_init(int argc, char **argv, char **envp, int *prom_vec);
 
 /* Simple char-by-char console I/O. */
 extern void prom_putchar(char c);
@@ -104,3 +104,4 @@
 extern void prom_cacheflush(void);
 
 #endif /* _ASM_SGIALIB_H */
+
