Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 20:59:07 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:39690 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225229AbTGaT7E>;
	Thu, 31 Jul 2003 20:59:04 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id h6VJx3Z02660
	for <linux-mips@linux-mips.org>; Thu, 31 Jul 2003 15:59:03 -0400
Received: from mx.hsv.redhat.com (IDENT:root@spot.hsv.redhat.com [172.16.16.7])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h6VJx2I19672
	for <linux-mips@linux-mips.org>; Thu, 31 Jul 2003 15:59:02 -0400
Received: from redhat.com (slurm.hsv.redhat.com [172.16.16.102])
	by mx.hsv.redhat.com (8.11.6/8.11.0) with ESMTP id h6VJx1m09471
	for <linux-mips@linux-mips.org>; Thu, 31 Jul 2003 14:59:01 -0500
Message-ID: <3F297585.6030900@redhat.com>
Date: Thu, 31 Jul 2003 15:01:09 -0500
From: Louis Hamilton <hamilton@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [patch] include/asm-mips{64}/war.h
Content-Type: multipart/mixed;
 boundary="------------050200060903080700020907"
Return-Path: <hamilton@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hamilton@redhat.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050200060903080700020907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Small typo fix in war.h
-Louis

Louis Hamilton     hamilton@redhat.com



--------------050200060903080700020907
Content-Type: text/plain;
 name="warpatch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warpatch"

--- war.h.base	2003-07-31 14:43:19.000000000 -0500
+++ war.h	2003-07-31 14:05:51.000000000 -0500
@@ -168,7 +168,7 @@
 #define MIPS4K_ICACHE_REFILL_WAR	0
 #endif
 #ifndef MIPS_CACHE_SYNC_WAR
-#deifne MIPS_CACHE_SYNC_WAR		0
+#define MIPS_CACHE_SYNC_WAR		0
 #endif
 
 #endif /* _ASM_WAR_H */

--------------050200060903080700020907--
