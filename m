Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 14:01:49 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:22285 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225202AbTDONBr>;
	Tue, 15 Apr 2003 14:01:47 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 195Q9M-0000kA-00; Tue, 15 Apr 2003 14:07:00 +0100
Received: from angel.algor.co.uk ([192.168.192.234] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 195Q41-0001Ax-00; Tue, 15 Apr 2003 14:01:29 +0100
Message-ID: <3E9C02A8.4090008@mips.com>
Date: Tue, 15 Apr 2003 14:01:28 +0100
From: Chris Dearman <chris@mips.com>
Organization: MIPS Technologies (UK) Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Subject: [PATCH] waybit not set for MIPS32/MIPS64 caches
Content-Type: multipart/mixed;
 boundary="------------000008030401030400010504"
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-1.4, required 4.5, AWL,
	NOSPAM_INC, PATCH_UNIFIED_DIFF, SPAM_PHRASE_00_01, USER_AGENT,
	USER_AGENT_MOZILLA_UA, X_ACCEPT_LANG)
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000008030401030400010504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ralf,
   The unified cache code (c-r4k.c) does not set the waybit for 
MIPS32/MIPS64 processors.  This patch needs to be applied to 
{mips,mips64}/mm/c-r4k.c in 2.4 and 2.5.

	Chris

-- 
Chris Dearman          The Fruit Farm, Ely Road    voice +44 1223 706206
MIPS Technologies (UK) Chittering, Cambs, CB5 9PH  fax   +44 1223 706250

--------------000008030401030400010504
Content-Type: text/plain;
 name="cache.diffs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cache.diffs"

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.40
diff -u -r1.3.2.40 c-r4k.c
--- arch/mips/mm/c-r4k.c	14 Apr 2003 03:49:59 -0000	1.3.2.40
+++ arch/mips/mm/c-r4k.c	15 Apr 2003 12:47:58 -0000
@@ -738,6 +738,7 @@
 		icache_size = c->icache.sets *
 		              c->icache.ways *
 		              c->icache.linesz;
+		c->icache.waybit = ffs(icache_size/c->icache.ways) - 1;
 
 		/*
 		 * Now probe the MIPS32 / MIPS64 data cache.
@@ -754,6 +755,7 @@
 		dcache_size = c->dcache.sets *
 		              c->dcache.ways *
 		              c->dcache.linesz;
+		c->dcache.waybit = ffs(dcache_size/c->dcache.ways) - 1;
 		break;
 	}
 

--------------000008030401030400010504--
