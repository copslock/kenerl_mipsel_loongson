Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2003 10:45:17 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.203.50]:64778 "EHLO
	pangolin.localnet") by linux-mips.org with ESMTP
	id <S8225351AbTLLKpQ>; Fri, 12 Dec 2003 10:45:16 +0000
Received: from spiral.localnet ([192.168.1.11] helo=bitbox.co.uk)
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1AUknG-0002dl-00
	for <linux-mips@linux-mips.org>; Fri, 12 Dec 2003 10:45:10 +0000
Message-ID: <3FD99C34.9090001@bitbox.co.uk>
Date: Fri, 12 Dec 2003 10:45:08 +0000
From: Peter Horton <phorton@bitbox.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.23 on Cobalt Qube2 - area of problem
Content-Type: multipart/mixed;
 boundary="------------000506020601060002050408"
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000506020601060002050408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

More info on the random segmentation faults and data corruption on my Qube2.

2.4.21 from CVS is the first kernel to exhibit the problem. I tracked it 
down to the cache handling changes that went in between 2.4.20 and 2.4.21.

By (not very scientifically) removing flush_dcache_page() and 
re-instating flush_page_to_ram() I managed to get the 2.4.21 kernel 
stable (see attached patch). Applying a similiar patch to 2.4.23 (CVS 
HEAD) allows me to run 2.4.23 too.

I don't know how to track the problem any further - the kernel's cache 
handling is a bit out of my league.

Anyone got a clue stick they can point me in the right direction with ?

P.







--------------000506020601060002050408
Content-Type: text/plain;
 name="cobalt-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cobalt-patch"

diff -urN linux-2.4.21-xxx/arch/mips/mm/c-r4k.c linux-2.4.21/arch/mips/mm/c-r4k.c
--- linux-2.4.21-xxx/arch/mips/mm/c-r4k.c	Thu Dec 11 20:20:28 2003
+++ linux-2.4.21/arch/mips/mm/c-r4k.c	Thu Dec 11 10:02:54 2003
@@ -1037,16 +1037,6 @@
 	return 1;
 }
 
-static void r4k_flush_page_to_ram_d16(struct page *page)
-{
-	blast_dcache16_page((unsigned long)page_address(page));
-}
-
-static void r4k_flush_page_to_ram_d32(struct page *page)
-{
-	blast_dcache32_page((unsigned long)page_address(page));
-}
-
 static void __init setup_noscache_funcs(void)
 {
 	unsigned int prid;
@@ -1059,7 +1049,6 @@
 			_clear_page = r4k_clear_page32_d16;
 		_copy_page = r4k_copy_page_d16;
 
-		_flush_page_to_ram = r4k_flush_page_to_ram_d16;
 		break;
 	case 32:
 		prid = read_c0_prid() & 0xfff0;
@@ -1076,8 +1065,6 @@
 				_clear_page = r4k_clear_page32_d32;
 			_copy_page = r4k_copy_page_d32;
 		}
-
-		_flush_page_to_ram = r4k_flush_page_to_ram_d32;
 		break;
 	}
 }
diff -urN linux-2.4.21-xxx/arch/mips/mm/cache.c linux-2.4.21/arch/mips/mm/cache.c
--- linux-2.4.21-xxx/arch/mips/mm/cache.c	Thu Dec 11 20:15:37 2003
+++ linux-2.4.21/arch/mips/mm/cache.c	Fri Jul 18 15:16:06 2003
@@ -20,8 +20,6 @@
 	return 0;
 }
 
-#if 0
-
 void flush_dcache_page(struct page *page)
 {
 	unsigned long addr;
@@ -67,5 +65,3 @@
 }
 
 EXPORT_SYMBOL(flush_dcache_page);
-
-#endif
diff -urN linux-2.4.21-xxx/arch/mips/mm/loadmmu.c linux-2.4.21/arch/mips/mm/loadmmu.c
--- linux-2.4.21-xxx/arch/mips/mm/loadmmu.c	Thu Dec 11 20:25:23 2003
+++ linux-2.4.21/arch/mips/mm/loadmmu.c	Thu Dec 11 10:02:54 2003
@@ -40,8 +40,6 @@
 void (*_flush_data_cache_page)(unsigned long addr);
 void (*_flush_icache_all)(void);
 
-void (*_flush_page_to_ram)(struct page * page);
-
 #ifdef CONFIG_NONCOHERENT_IO
 
 /* DMA cache operations. */
diff -urN linux-2.4.21-xxx/include/asm-mips/cacheflush.h linux-2.4.21/include/asm-mips/cacheflush.h
--- linux-2.4.21-xxx/include/asm-mips/cacheflush.h	Thu Dec 11 20:22:51 2003
+++ linux-2.4.21/include/asm-mips/cacheflush.h	Tue Apr  1 00:29:06 2003
@@ -46,16 +46,12 @@
 extern void (*_flush_icache_all)(void);
 extern void (*_flush_data_cache_page)(unsigned long addr);
 
-extern void (*_flush_page_to_ram)(struct page * page);
-
-#define flush_dcache_page(page)		do { } while(0)
-
 #define flush_cache_all()		_flush_cache_all()
 #define __flush_cache_all()		___flush_cache_all()
 #define flush_cache_mm(mm)		_flush_cache_mm(mm)
 #define flush_cache_range(mm,start,end)	_flush_cache_range(mm,start,end)
 #define flush_cache_page(vma,page)	_flush_cache_page(vma, page)
-#define flush_page_to_ram(page)		_flush_page_to_ram(page)
+#define flush_page_to_ram(page)		do { } while (0)
 
 #define flush_icache_range(start, end)	_flush_icache_range(start,end)
 #define flush_icache_user_range(vma, page, addr, len) \
diff -urN linux-2.4.21-xxx/include/asm-mips/pgtable.h linux-2.4.21/include/asm-mips/pgtable.h
--- linux-2.4.21-xxx/include/asm-mips/pgtable.h	Thu Dec 11 20:36:56 2003
+++ linux-2.4.21/include/asm-mips/pgtable.h	Thu Dec 11 10:04:27 2003
@@ -261,7 +261,7 @@
 	unsigned long address, pte_t pte)
 {
 	__update_tlb(vma, address, pte);
-//	__update_cache(vma, address, pte);
+	__update_cache(vma, address, pte);
 }
 
 /* Swap entries must have VALID and GLOBAL bits cleared. */

--------------000506020601060002050408--
