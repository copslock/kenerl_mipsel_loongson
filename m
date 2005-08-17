Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Aug 2005 07:08:34 +0100 (BST)
Received: from mms1.broadcom.com ([IPv6:::ffff:216.31.210.17]:51727 "EHLO
	MMS1.broadcom.com") by linux-mips.org with ESMTP
	id <S8224790AbVHQGIG>; Wed, 17 Aug 2005 07:08:06 +0100
Received: from 10.10.64.121 by MMS1.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.1.0)); Tue, 16 Aug 2005 23:12:28 -0700
X-Server-Uuid: 146C3151-C1DE-4F71-9D02-C3BE503878DD
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Tue, 16 Aug 2005 23:12:33 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id BPG37336; Tue, 16 Aug 2005 23:12:33 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id XAA15801 for <linux-mips@linux-mips.org>; Tue, 16 Aug 2005 23:12:33
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j7H6CWov007705 for <linux-mips@linux-mips.org>; Tue, 16 Aug 2005
 23:12:32 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j7H6CW716499 for linux-mips@linux-mips.org; Tue, 16 Aug 2005
 23:12:32 -0700
Date:	Tue, 16 Aug 2005 23:12:32 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] fix pfn_pte for 64BIT_PHYS_ADDR
Message-ID: <20050817061232.GN24444@broadcom.com>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F1C0AC626C3649460-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

On CONFIG_64BIT_PHYS_ADDR, pfn always fits in 'unsigned long', but
pfn<<PAGE_SHIFT sometimes extends beyond.  The pte is big enough to hold
'long long', but the shift in pfn_pte() needs to do its calculation with
enough bits to hold the result.

Signed-off-by: Andrew Isaacson <adi@broadcom.com>

Index: lmo-1480/include/asm-mips/pgtable-32.h
===================================================================
--- lmo-1480.orig/include/asm-mips/pgtable-32.h	2005-08-16 23:00:19.000000000 -0700
+++ lmo-1480/include/asm-mips/pgtable-32.h	2005-08-16 23:01:39.000000000 -0700
@@ -137,7 +137,7 @@
 #define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_val(prot))
 #else
 #define pte_pfn(x)		((unsigned long)((x).pte >> PAGE_SHIFT))
-#define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pfn_pte(pfn, prot)	__pte(((unsigned long long)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #endif
 #endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1) */
 
