Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 16:47:42 +0100 (BST)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:44816 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225211AbTDXPrm>; Thu, 24 Apr 2003 16:47:42 +0100
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.2)); Thu, 24 Apr 2003 08:47:39 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id IAA09945; Thu, 24 Apr 2003 08:47:12 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.4/SSF) with ESMTP id
 h3OFlVml029053; Thu, 24 Apr 2003 08:47:31 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id IAA29953; Thu,
 24 Apr 2003 08:47:31 -0700
Message-ID: <3EA80713.268F0CD6@broadcom.com>
Date: Thu, 24 Apr 2003 08:47:31 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ralf Baechle" <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: patch: mm/init.c warning
X-WSS-ID: 12B6D8912093120-01-01
Content-Type: multipart/mixed;
 boundary=------------A4CBB619A6A1F2EDF513ACF6
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------A4CBB619A6A1F2EDF513ACF6
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

I know I'm not the first to send something like this... can we please
apply this warning fix for arch/mips/mm/init.c in the non-HIGHMEM case?

thanks,
Kip
--------------A4CBB619A6A1F2EDF513ACF6
Content-Type: text/plain;
 charset=us-ascii;
 name=mm_init.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=mm_init.diff

Index: arch/mips/mm/init.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/init.c,v
retrieving revision 1.38.2.11
diff -u -r1.38.2.11 init.c
--- arch/mips/mm/init.c	23 Apr 2003 15:30:16 -0000	1.38.2.11
+++ arch/mips/mm/init.c	24 Apr 2003 15:46:36 -0000
@@ -151,6 +151,7 @@
 extern char _ftext, _etext, _fdata, _edata;
 extern char __init_begin, __init_end;
 
+#ifdef CONFIG_HIGHMEM
 static void __init fixrange_init (unsigned long start, unsigned long end,
 	pgd_t *pgd_base)
 {
@@ -179,22 +180,25 @@
 		j = 0;
 	}
 }
+#endif
 
 void __init pagetable_init(void)
 {
+#ifdef CONFIG_HIGHMEM
 	unsigned long vaddr;
 	pgd_t *pgd, *pgd_base;
 	pmd_t *pmd;
 	pte_t *pte;
+#endif
 
 	/* Initialize the entire pgd.  */
 	pgd_init((unsigned long)swapper_pg_dir);
 	pgd_init((unsigned long)swapper_pg_dir +
 	         sizeof(pgd_t ) * USER_PTRS_PER_PGD);
 
+#ifdef CONFIG_HIGHMEM
 	pgd_base = swapper_pg_dir;
 
-#ifdef CONFIG_HIGHMEM
 	/*
 	 * Fixed mappings:
 	 */

--------------A4CBB619A6A1F2EDF513ACF6--
