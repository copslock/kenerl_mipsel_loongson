Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2005 13:59:39 +0100 (BST)
Received: from web25106.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.54]:27986
	"HELO web25106.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8225393AbVDHM7F>; Fri, 8 Apr 2005 13:59:05 +0100
Received: (qmail 26390 invoked by uid 60001); 8 Apr 2005 12:58:56 -0000
Message-ID: <20050408125856.26388.qmail@web25106.mail.ukl.yahoo.com>
Received: from [80.14.198.143] by web25106.mail.ukl.yahoo.com via HTTP; Fri, 08 Apr 2005 14:58:56 CEST
Date:	Fri, 8 Apr 2005 14:58:56 +0200 (CEST)
From:	moreau francis <francis_moreau2000@yahoo.fr>
Subject: [PATCH] Physical mem start different from 0 
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-754048015-1112965136=:26360"
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

--0-754048015-1112965136=:26360
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Ralf,

I'm sending to you a very trivial patch.
It's related to memory start address that does not
start at 0. This can easily be handled with uses of
"pfn_to_phys" and "virt_to_phys" macros. But some
parts of the kernel don't use them, and do for
instance
"addr << PAGE_SHIFT".
The patch deals with such cases in pgtable-32.h. If
you agree with, I'll send others patches to remove
them from every places I found.

     Francis


	

	
		
__________________________________________________________________
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
--0-754048015-1112965136=:26360
Content-Type: text/x-patch; name="pgtable-32.h.patch"
Content-Description: pgtable-32.h.patch
Content-Disposition: inline; filename="pgtable-32.h.patch"

--- pgtable-32.h.old	2005-04-08 14:37:00.231705720 +0200
+++ pgtable-32.h	2005-04-08 14:24:24.360615592 +0200
@@ -136,8 +136,8 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 #define pte_pfn(x)		((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_val(prot))
 #else
-#define pte_pfn(x)		((unsigned long)((x).pte >> PAGE_SHIFT))
-#define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pte_pfn(x)		((unsigned long)(phys_to_pfn((x).pte)))
+#define pfn_pte(pfn, prot)	__pte((pfn_to_phys(pfn) | pgprot_val(prot)))
 #endif
 #endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 

--0-754048015-1112965136=:26360--
