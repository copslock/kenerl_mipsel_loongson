Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Apr 2006 10:41:20 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:25052 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133380AbWDHJlK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Apr 2006 10:41:10 +0100
Received: (qmail 25267 invoked from network); 8 Apr 2006 13:54:13 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 8 Apr 2006 13:54:13 -0000
Message-ID: <4437878C.3000603@ru.mvista.com>
Date:	Sat, 08 Apr 2006 13:51:08 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Bob Breuer <bbreuer@righthandtech.com>,
	Jordan Crouse <jordan.crouse@amd.com>,
	Konstantin Baidarov <kbaidarov@ru.mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Pete Popov <ppopov@embeddedalley.com>,
	Manish Lachwani <mlachwani@mvista.com>
Subject: [PATCH] Fix swap entry for MIPS32 with 36-bit physical address
References: <B482D8AA59BF244F99AFE7520D74BF9609D4F2@server1.RightHand.righthandtech.com> <4433C9EE.8030402@ru.mvista.com> <4436C301.2060001@ru.mvista.com> <4436D793.6080701@ru.mvista.com> <4436E201.4090409@ru.mvista.com>
In-Reply-To: <4436E201.4090409@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------090903080109000601080707"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090903080109000601080707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


     With 64-bit physical address enabled, 'swapon' was causing kernel oops on
Alchemy CPUs (MIPS32) because of the swap entry type field corrupting the
_PAGE_FILE bit in 'pte_low' field. So, switch to storing the swap entry in
'pte_high' field using all its bits except _PAGE_GLOBAL and _PAGE_VALID which
gives 25 bits for the swap entry offset.

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------090903080109000601080707
Content-Type: text/plain;
 name="MIPS32-36bit-phys-addr-swap-entry-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MIPS32-36bit-phys-addr-swap-entry-fix.patch"

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 4d6bc45..a5ce3f1 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -191,10 +191,17 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 #else
 
 /* Swap entries must have VALID and GLOBAL bits cleared. */
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+#define __swp_type(x)		(((x).val >> 2) & 0x1f)
+#define __swp_offset(x) 	 ((x).val >> 7)
+#define __swp_entry(type,offset)	\
+		((swp_entry_t)  { ((type) << 2) | ((offset) << 7) })
+#else
 #define __swp_type(x)		(((x).val >> 8) & 0x1f)
-#define __swp_offset(x)		((x).val >> 13)
+#define __swp_offset(x) 	 ((x).val >> 13)
 #define __swp_entry(type,offset)	\
-		((swp_entry_t) { ((type) << 8) | ((offset) << 13) })
+		((swp_entry_t)  { ((type) << 8) | ((offset) << 13) })
+#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 
 /*
  * Bits 0, 1, 2, 7 and 8 are taken, split up the 27 bits of offset
@@ -218,7 +225,12 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 
 #endif
 
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+#define __pte_to_swp_entry(pte) ((swp_entry_t) { (pte).pte_high })
+#define __swp_entry_to_pte(x)	((pte_t) { 0, (x).val })
+#else
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+#endif
 
 #endif /* _ASM_PGTABLE_32_H */



--------------090903080109000601080707--
