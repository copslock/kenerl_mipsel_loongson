Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2004 19:38:28 +0100 (BST)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:32767 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8226077AbUE0SiP>; Thu, 27 May 2004 19:38:15 +0100
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc12) with ESMTP
          id <20040527183806014007vkape>
          (Authid: kumba12345);
          Thu, 27 May 2004 18:38:07 +0000
Message-ID: <40B635FA.3080807@gentoo.org>
Date: Thu, 27 May 2004 14:39:54 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Fix for 2.6.5/2.6.6 Swap issue
Content-Type: multipart/mixed;
 boundary="------------040709090100010107080006"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040709090100010107080006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Peter Horton wrote this patch up several weeks ago for Cobalt, but it's 
applicable for all MIPS machines I've seen thus far (atleast SGI and 
Cobalt).  It fixes the kernel panic resulting from trying to activate 
swap on a system running 2.6.5 and up.  It's been in Gentoo's 
mips-sources for quite some time, and I've had no problems with it on my 
O2 or Cobalt.

--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond

--------------040709090100010107080006
Content-Type: text/plain;
 name="mipscvs-2.6.5-swapbug-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mipscvs-2.6.5-swapbug-fix.patch"

diff -urN include/asm-mips/pgtable-32.h include/asm-mips/pgtable-32.h
--- include/asm-mips/pgtable-32.h	2004-03-11 16:46:57.000000000 +0000
+++ include/asm-mips/pgtable-32.h	2004-04-17 09:06:02.000000000 +0100
@@ -203,14 +203,18 @@
 /* Swap entries must have VALID and GLOBAL bits cleared. */
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
-#define __swp_type(x)		(((x).val >> 1) & 0x7f)
-#define __swp_offset(x)		((x).val >> 10)
-#define __swp_entry(type,offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 10) })
+/* offset is limited to 17 bits (512MB @ 4K page) */
+/* VALID & GLOBAL are bits 9 & 8 */
+#define __swp_type(x)		(((x).val >> 10) & 0x1f)
+#define __swp_offset(x)		((x).val >> 15)
+#define __swp_entry(type,offset)	((swp_entry_t) { ((type) << 10) | ((offset) << 15) })
 #else
 
-#define __swp_type(x)		(((x).val >> 1) & 0x1f)
-#define __swp_offset(x)		((x).val >> 8)
-#define __swp_entry(type,offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
+/* offset is limited to 19 bits (2GB @ 4K page) */
+/* VALID & GLOBAL are bits 7 & 6 */
+#define __swp_type(x)		(((x).val >> 8) & 0x1f)
+#define __swp_offset(x)		((x).val >> 13)
+#define __swp_entry(type,offset)	((swp_entry_t) { ((type) << 8) | ((offset) << 13) })
 #endif
 
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })

--------------040709090100010107080006--
