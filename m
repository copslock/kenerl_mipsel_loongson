Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fASDbBn20128
	for linux-mips-outgoing; Wed, 28 Nov 2001 05:37:11 -0800
Received: from hermes.fachschaften.tu-muenchen.de (hermes.fachschaften.tu-muenchen.de [129.187.176.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fASDaxo20110
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 05:37:00 -0800
Received: (qmail 13941 invoked from network); 28 Nov 2001 12:36:18 -0000
Received: from mimas.fachschaften.tu-muenchen.de (HELO mimas) (129.187.176.26)
  by hermes.fachschaften.tu-muenchen.de with SMTP; 28 Nov 2001 12:36:18 -0000
Date: Wed, 28 Nov 2001 13:36:48 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-mips@oss.sgi.com
Subject: [patch] NONCOHERENT compile fix for r3k
Message-ID: <Pine.NEB.4.42.0111281332370.19003-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from QUOTED-PRINTABLE to 8bit by oss.sgi.com id fASDb0o20111
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I got the following erros while compiling a kernel for my 5000/240:

gcc -I /home/bunk/linux/include/asm/gcc -D__KERNEL__ -I/home/bunk/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -mcpu=r3000 -mips1 -pipe    -c -o c-r3k.o c-r3k.c
Assembler messages:
Warning: The -mcpu option is deprecated.  Please use -march and -mtune instead.
c-r3k.c: In function `ld_mmu_r23000':
c-r3k.c:334: `_dma_cache_wback_inv' undeclared (first use in this function)
     c-r3k.c:334: (Each undeclared identifier is reported only once
		   c-r3k.c:334: for each function it appears in.)
     c-r3k.c:317: warning: unused variable `config'
make[2]: *** [c-r3k.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/arch/mips/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/bunk/linux/arch/mips/mm'
make: *** [_dir_arch/mips/mm] Error 2


gcc -I /home/bunk/linux/include/asm/gcc -D__KERNEL__ -I/home/bunk/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -mcpu=r3000 -mips1 -pipe    -c -o c-tx39.o c-tx39.c
Assembler messages:
Warning: The -mcpu option is deprecated.  Please use -march and -mtune instead.
c-tx39.c: In function `ld_mmu_tx39':
c-tx39.c:298: `_dma_cache_wback_inv' undeclared (first use in this function)
     c-tx39.c:298: (Each undeclared identifier is reported only once
		    c-tx39.c:298: for each function it appears in.)
     c-tx39.c:320: `_dma_cache_wback' undeclared (first use in this function)
c-tx39.c:321: `_dma_cache_inv' undeclared (first use in this function)
     make[2]: *** [c-tx39.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/arch/mips/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/bunk/linux/arch/mips/mm'
make: *** [_dir_arch/mips/mm] Error 2


The following patches fix these compile errors:

--- arch/mips/mm/c-r3k.c.old	Wed Nov 28 11:30:01 2001
+++ arch/mips/mm/c-r3k.c	Wed Nov 28 11:38:07 2001
@@ -331,7 +331,11 @@
 	_flush_icache_page = r3k_flush_icache_page;
 	_flush_icache_range = r3k_flush_icache_range;

+#ifdef CONFIG_NONCOHERENT_IO
+
 	_dma_cache_wback_inv = r3k_dma_cache_wback_inv;
+
+#endif /* CONFIG_NONCOHERENT_IO */

 	printk("Primary instruction cache %dkb, linesize %d bytes\n",
 		(int) (icache_size >> 10), (int) icache_lsize);

--- arch/mips/mm/c-tx39.c.old	Wed Nov 28 12:08:37 2001
+++ arch/mips/mm/c-tx39.c	Wed Nov 28 12:56:28 2001
@@ -295,7 +295,12 @@
 		_flush_icache_page	= (void *) tx39h_flush_icache_all;
 		_flush_icache_range	= (void *) tx39h_flush_icache_all;

+#ifdef CONFIG_NONCOHERENT_IO
+
 		_dma_cache_wback_inv = tx39h_dma_cache_wback_inv;
+
+#endif /* CONFIG_NONCOHERENT_IO */
+
 		break;

 	case CPU_TX3922:
@@ -316,9 +321,13 @@
 		_flush_icache_page = tx39_flush_icache_page;
 		_flush_icache_range = tx39_flush_icache_range;

+#ifdef CONFIG_NONCOHERENT_IO
+
 		_dma_cache_wback_inv = tx39_dma_cache_wback_inv;
 		_dma_cache_wback = tx39_dma_cache_wback;
 		_dma_cache_inv = tx39_dma_cache_inv;
+
+#endif /* CONFIG_NONCOHERENT_IO */

 		break;
 	}




While booting the kernel I had the same problem Flo already reported:

scsi0 : ESP236 (NCR53C9x)
scsi: unknown type 16
  Vendor:  . ... .  Model:     à. .  *!      Rev: ,. .
  Type:   Unknown                            ANSI SCSI revision: 04
resize_dma_pool: unknown device type 16
resize_dma_pool: unknown device type 16


cu
Adrian
