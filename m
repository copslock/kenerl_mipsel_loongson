Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Dec 2003 20:24:33 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:31881 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225279AbTL3UYc>;
	Tue, 30 Dec 2003 20:24:32 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBUKOTQF025990;
	Tue, 30 Dec 2003 21:24:29 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id VAA11136;
	Tue, 30 Dec 2003 21:24:29 +0100 (MET)
Date: Tue, 30 Dec 2003 21:24:29 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: [PATCH][2.6] VR41xx pte fix and VR413x cpu-probe fix
Message-ID: <20031230202429.GA11117@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

Hi,

  here are two patches related to the VR41xx series. The first patch
  fixes the pte calculation (pte_pfn and pfn_pte) for VR41xx. Second
  patch fixes the cpu detection for the VR413x cpu's (missing break).


--- linux-mips-2.6.orig/include/asm-mips/pgtable-32.h	2003-10-19 02:50:11.000000000 +0200
+++ linux.work/include/asm-mips/pgtable-32.h	2003-12-30 20:36:19.000000000 +0100
@@ -131,8 +131,15 @@
 static inline void pgd_clear(pgd_t *pgdp)	{ }
 
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
+
+
+#ifdef CONFIG_CPU_VR41XX
+#define pte_pfn(x)		((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
+#define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_val(prot))
+#else
 #define pte_pfn(x)		((unsigned long)((x).pte >> PAGE_SHIFT))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#endif
 
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 

  
--- linux-mips-2.6.orig/arch/mips/kernel/cpu-probe.c	2003-12-11 03:05:21.000000000 +0100
+++ linux.work/arch/mips/kernel/cpu-probe.c	2003-12-29 13:12:35.000000000 +0100
@@ -228,6 +228,7 @@
 				c->cputype = CPU_VR4131;
 			else
 				c->cputype = CPU_VR4133;
+			break;
 		default:
 			printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
 				c->cputype = CPU_VR41XX;


  

  Dimitri


-- 
Dimitri Torfs             |  NSCE 
dimitri.torfs@sonycom.com |  Sint Stevens Woluwestraat 55
tel: +32 2 2908451        |  1130 Brussel
fax: +32 2 7262686        |  Belgium
