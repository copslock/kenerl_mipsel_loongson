Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 04:28:42 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:39854 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8224833AbVITD2V>;
	Tue, 20 Sep 2005 04:28:21 +0100
Received: from drow by nevyn.them.org with local (Exim 4.52)
	id 1EHYnq-0001sR-Rt; Mon, 19 Sep 2005 23:28:18 -0400
Date:	Mon, 19 Sep 2005 23:28:18 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix TCP/UDP checksums on the Broadcom SB-1
Message-ID: <20050920032818.GA7199@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

The type of sum in csum_tcpudp_nofold is "unsigned int", so when we assign
to it in an asm() block, and we're running on a system with 64-bit
registers, it is vitally important that we sign extend it correctly before
returning to C.  Otherwise the stray high bits will be preserved into
csum_fold, and on the SB-1 processor, 32-bit arithmetic on a non
sign-extended register will yield surprising results.

This caused incorrect checksums in some UDP packets for NFS root.  The
problem was mild when using a 10.0.1.x IP address, but severe when
using 192.168.1.x.

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

Index: linux/include/asm-mips/checksum.h
===================================================================
--- linux.orig/include/asm-mips/checksum.h	2005-09-19 21:00:48.000000000 -0400
+++ linux/include/asm-mips/checksum.h	2005-09-19 21:52:11.000000000 -0400
@@ -149,7 +149,7 @@ static inline unsigned int csum_tcpudp_n
 	"	daddu	%0, %4		\n"
 	"	dsll32	$1, %0, 0	\n"
 	"	daddu	%0, $1		\n"
-	"	dsrl32	%0, %0, 0	\n"
+	"	dsra32	%0, %0, 0	\n"
 #endif
 	"	.set	pop"
 	: "=r" (sum)

-- 
Daniel Jacobowitz
CodeSourcery, LLC
