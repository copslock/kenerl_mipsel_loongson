Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2004 22:57:19 +0000 (GMT)
Received: from one.ldsys.net ([IPv6:::ffff:208.176.63.109]:38958 "EHLO
	one.chi.ldsys.net") by linux-mips.org with ESMTP
	id <S8225299AbUCVW5S>; Mon, 22 Mar 2004 22:57:18 +0000
Received: from sex-machine.chi.ldsys.net (sex-machine.chi.ldsys.net [10.0.1.4])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by one.chi.ldsys.net (Postfix) with ESMTP id A8DCA4AA7B
	for <linux-mips@linux-mips.org>; Mon, 22 Mar 2004 16:57:14 -0600 (CST)
Subject: minor patches
From: "Christopher G. Stach II" <cgs@ldsys.net>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Message-Id: <1079996219.15310.60.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Mar 2004 16:56:59 -0600
Content-Transfer-Encoding: 7bit
Return-Path: <cgs@ldsys.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cgs@ldsys.net
Precedence: bulk
X-list: linux-mips

Index: arch/mips/kernel/head.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/head.S,v
retrieving revision 1.59
diff -u -b -B -r1.59 head.S
--- arch/mips/kernel/head.S     19 Jan 2004 19:54:14 -0000      1.59
+++ arch/mips/kernel/head.S     22 Mar 2004 22:52:40 -0000
@@ -27,6 +27,9 @@
 #include <asm/sn/sn0/hubni.h>
 #include <asm/sn/klkernvars.h>
 #endif
+#ifdef CONFIG_MAPPED_KERNEL
+# include <asm/pgtable-bits.h>
+#endif
  
        .macro  ARC64_TWIDDLE_PC
 #if defined(CONFIG_ARC64) || defined(CONFIG_MAPPED_KERNEL)
Index: arch/mips/mm/dma-ip27.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/dma-ip27.c,v
retrieving revision 1.5
diff -u -b -B -r1.5 dma-ip27.c
--- arch/mips/mm/dma-ip27.c     5 Jan 2004 23:29:13 -0000       1.5
+++ arch/mips/mm/dma-ip27.c     22 Mar 2004 22:52:40 -0000
@@ -188,7 +188,7 @@
        return (dma64_addr_t) pdev_to_baddr(pdev, addr);
 }
  
-EXPORT_SYMBOL(dma_cache_sync);
+EXPORT_SYMBOL(pci_dac_page_to_dma);
  
 struct page *pci_dac_dma_to_page(struct pci_dev *pdev,
        dma64_addr_t dma_addr)
Index: include/asm-mips/sn/mapped_kernel.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/sn/mapped_kernel.h,v
retrieving revision 1.1
diff -u -b -B -r1.1 mapped_kernel.h
--- include/asm-mips/sn/mapped_kernel.h 29 Jul 2003 03:21:48 -0000     
1.1
+++ include/asm-mips/sn/mapped_kernel.h 22 Mar 2004 22:52:46 -0000
@@ -29,9 +29,9 @@
 #define MAPPED_ADDR_RW_TO_PHYS(x)      (x - CKSSEG - 16777216)
  
 #define MAPPED_KERN_RO_PHYSBASE(n) \
-                       (PLAT_NODE_DATA(n)->kern_vars.kv_ro_baseaddr)
+                       (HUB_DATA(n)->kern_vars.kv_ro_baseaddr)
 #define MAPPED_KERN_RW_PHYSBASE(n) \
-                       (PLAT_NODE_DATA(n)->kern_vars.kv_rw_baseaddr)
+                       (HUB_DATA(n)->kern_vars.kv_rw_baseaddr)
  
 #define MAPPED_KERN_RO_TO_PHYS(x) \
                                ((unsigned
long)MAPPED_ADDR_RO_TO_PHYS(x) | \
