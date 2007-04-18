Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 15:40:24 +0100 (BST)
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:45461 "EHLO
	mail.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20021897AbXDROkX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Apr 2007 15:40:23 +0100
Received: from zeus.sw.starentnetworks.com (zeus.sw.starentnetworks.com [12.33.233.46])
	by mail.sw.starentnetworks.com (Postfix) with ESMTP id 24BB63E363;
	Wed, 18 Apr 2007 10:39:42 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17958.11693.953285.795311@zeus.sw.starentnetworks.com>
Date:	Wed, 18 Apr 2007 10:39:41 -0400
From:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Fix wrong checksum for split TCP packets on 64-bit MIPS
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linux-mips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips


I've traced down an off-by-one TCP checksum calculation error under
the following conditions:

1) The TCP code needs to split a full-sized packet due to a reduced
   MSS (typically due to the addition of TCP options mid-stream like
   SACK).
   _AND_
2) The checksum of the 2nd fragment is larger than the checksum of the
   original packet.  After subtraction this results in a checksum for
   the 1st fragment with bits 16..31 set to 1. (this is ok)
   _AND_
3) The checksum of the 1st fragment's TCP header plus the previously
   32bit checksum of the 1st fragment DOES NOT cause a 32bit overflow
   when added together.  This results in a checksum of the TCP header
   plus TCP data that still has the upper 16 bits as 1's.
   _THEN_
4) The TCP+data checksum is added to the checksum of the pseudo IP
   header with csum_tcpudp_nofold() incorrectly (the bug).

The problem is the checksum of the TCP+data is passed to
csum_tcpudp_nofold() as an 32bit unsigned value, however the assembly
code acts on it as if it is a 64bit unsigned value.

This causes an incorrect 32->64bit extension if the sum has bit 31
set.  The resulting checksum is off by one.

This problems is data and TCP header dependent due to #2 and #3
above so it doesn't occur on every TCP packet split.

Patch below is against 2.6.20, however this problem looks like it's
been around since at least Aug 2003 when the 64bit ASM was added to
csum_tcpudp_nofold().


Signed-off-by: Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>

--- old/include/asm-mips/checksum.h	2007-01-24 14:23:22 -05:00
+++ new/include/asm-mips/checksum.h	2007-04-18 10:31:27 -04:00
@@ -166,7 +166,7 @@
 #else
 	  "r" (proto + len),
 #endif
-	  "r" (sum));
+	  "r" ((__force unsigned long)sum));
 
 	return sum;
 }
