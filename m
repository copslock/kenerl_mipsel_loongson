Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Sep 2004 23:33:37 +0100 (BST)
Received: from 64-60-250-34.cust.telepacific.net ([IPv6:::ffff:64.60.250.34]:30504
	"EHLO panta-1.pantasys.com") by linux-mips.org with ESMTP
	id <S8225011AbUIMWdc>; Mon, 13 Sep 2004 23:33:32 +0100
Received: from [10.1.40.165] ([10.1.40.1]) by panta-1.pantasys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 13 Sep 2004 15:26:25 -0700
Message-ID: <41462025.9070607@pantasys.com>
Date: Mon, 13 Sep 2004 15:33:09 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Subject: [PATCH 2.6] fix mips atomic_lock declaration
Content-Type: multipart/mixed;
 boundary="------------090704080203070902000007"
X-OriginalArrivalTime: 13 Sep 2004 22:26:25.0718 (UTC) FILETIME=[B4BC4D60:01C499E0]
Return-Path: <peter@pantasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@pantasys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090704080203070902000007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ralf,

I modified the declaration of atomic_lock to be static. This means that 
I can now build and run SMP on the 1250. See attached patch.

peter

Signed-off-by: Peter Buckingham <peter@pantasys.com>

--------------090704080203070902000007
Content-Type: text/plain;
 name="p"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p"

? include/asm-mips/.atomic.h.swp
? include/asm-mips/agp.h
Index: include/asm-mips/atomic.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/atomic.h,v
retrieving revision 1.36
diff -u -r1.36 atomic.h
--- include/asm-mips/atomic.h	19 Aug 2004 09:54:23 -0000	1.36
+++ include/asm-mips/atomic.h	13 Sep 2004 21:51:56 -0000
@@ -26,7 +26,7 @@
 #include <asm/cpu-features.h>
 #include <asm/war.h>
 
-extern spinlock_t atomic_lock;
+static spinlock_t atomic_lock;
 
 typedef struct { volatile int counter; } atomic_t;
 

--------------090704080203070902000007--
