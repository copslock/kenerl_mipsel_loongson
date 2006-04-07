Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 22:10:31 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:7377 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133612AbWDGVKW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2006 22:10:22 +0100
Received: (qmail 20952 invoked from network); 8 Apr 2006 01:23:18 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 8 Apr 2006 01:23:18 -0000
Message-ID: <4436D793.6080701@ru.mvista.com>
Date:	Sat, 08 Apr 2006 01:20:19 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Bob Breuer <bbreuer@righthandtech.com>,
	Jordan Crouse <jordan.crouse@amd.com>,
	Konstantin Baidarov <kbaidarov@ru.mvista.com>
Subject: Re: [PATCH] Fix swap entry for MIPS32 36-bit physical address
References: <B482D8AA59BF244F99AFE7520D74BF9609D4F2@server1.RightHand.righthandtech.com> <4433C9EE.8030402@ru.mvista.com> <4436C301.2060001@ru.mvista.com>
In-Reply-To: <4436C301.2060001@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------090801050600050806060004"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090801050600050806060004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    With 64-bit physical address enabled, 'swapon' was causing kernel oops
on Alchemy CPUs (MIPS32) because of the swap entry type field corrupting the
_PAGE_FILE bit in pte_low. So, change layout of the swap entry to use all bits
except _PAGE_PRESENT and _PAGE_FILE (the harware protection bits are loaded
from pte_high which should be cleared by __swp_entry_to_pte() macro) -- which
gives 25 bits for the swap entry offset.

WBR, Sergei

Signed-off-by: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------090801050600050806060004
Content-Type: text/plain;
 name="MIPS32-36bit-phys-addr-swap-entry-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MIPS32-36bit-phys-addr-swap-entry-fix.patch"

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 4d6bc45..b0ad112 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -190,11 +190,27 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 
 #else
 
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+/*
+ * For 36-bit physical address we store swap entry in pte_low and 0 in pte_high,
+ * which gives us 25 bits available for the offset...
+ */
+#define __swp_type(x)		((x).val & 0x1f)
+#define __swp_offset(x) 	((((x).val >> 5) & 0x1) | \
+				 (((x).val >> 6) & 0xe) | \
+				 (((x).val >> 11) << 4))
+#define __swp_entry(type,offset)	\
+		((swp_entry_t) { ((type) & 0x1f) | \
+				 (((offset) & 0x1) << 5) | \
+				 (((offset) & 0xe) << 6) | \
+				 (((offset) >> 4 ) << 11) })
+#else
 /* Swap entries must have VALID and GLOBAL bits cleared. */
 #define __swp_type(x)		(((x).val >> 8) & 0x1f)
 #define __swp_offset(x)		((x).val >> 13)
 #define __swp_entry(type,offset)	\
 		((swp_entry_t) { ((type) << 8) | ((offset) << 13) })
+#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 
 /*
  * Bits 0, 1, 2, 7 and 8 are taken, split up the 27 bits of offset



--------------090801050600050806060004--
