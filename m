Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 19:08:27 +0000 (GMT)
Received: from adsl-66-123-66-42.dsl.pltn13.pacbell.net ([IPv6:::ffff:66.123.66.42]:8077
	"EHLO stella-blue.herbertphamily.com") by linux-mips.org with ESMTP
	id <S8225467AbUAOTI1>; Thu, 15 Jan 2004 19:08:27 +0000
Received: from [192.168.1.8] (shakedown.herbertphamily.com [192.168.1.8])
	(authenticated bits=0)
	by stella-blue.herbertphamily.com (8.12.8/8.12.8) with ESMTP id i0FJ8N0M008154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mips@linux-mips.org>; Thu, 15 Jan 2004 11:08:25 -0800
Subject: [PATCH][2.6]Fix compiler warnings on long long constants in SB1250
	build
From: Kevin Paul Herbert <kph@cisco.com>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Organization: cisco Systems, Inc.
Message-Id: <1074193693.24675.22.camel@shakedown>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jan 2004 11:08:16 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <kph@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kph@cisco.com
Precedence: bulk
X-list: linux-mips

The following patch corrects warnings in arch/mips/mm/cerr-sb1.c and
arch/mips/sibyte/sb1250/irq.c for "long long" constants.

Kevin
-- 
Kevin Paul Herbert <kph@cisco.com>
cisco Systems, Inc.

Index: arch/mips/mm/cerr-sb1.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/cerr-sb1.c,v
retrieving revision 1.11
diff -u -r1.11 cerr-sb1.c
--- arch/mips/mm/cerr-sb1.c	18 Nov 2003 01:17:46 -0000	1.11
+++ arch/mips/mm/cerr-sb1.c	15 Jan 2004 19:05:31 -0000
@@ -251,14 +251,14 @@
 
 /* Masks to select bits for Hamming parity, mask_72_64[i] for bit[i] */
 static const uint64_t mask_72_64[8] = {
-	0x0738C808099264FFL,
-	0x38C808099264FF07L,
-	0xC808099264FF0738L,
-	0x08099264FF0738C8L,
-	0x099264FF0738C808L,
-	0x9264FF0738C80809L,
-	0x64FF0738C8080992L,
-	0xFF0738C808099264L
+	0x0738C808099264FFLL,
+	0x38C808099264FF07LL,
+	0xC808099264FF0738LL,
+	0x08099264FF0738C8LL,
+	0x099264FF0738C808LL,
+	0x9264FF0738C80809LL,
+	0x64FF0738C8080992LL,
+	0xFF0738C808099264LL
 };
 
 /* Calculate the parity on a range of bits */
@@ -330,9 +330,9 @@
 				    ((lru >> 4) & 0x3),
 				    ((lru >> 6) & 0x3));
 		}
-		va = (taglo & 0xC0000FFFFFFFE000) | addr;
+		va = (taglo & 0xC0000FFFFFFFE000LL) | addr;
 		if ((taglo & (1 << 31)) && (((taglo >> 62) & 0x3) == 3))
-			va |= 0x3FFFF00000000000;
+			va |= 0x3FFFF00000000000LL;
 		valid = ((taghi >> 29) & 1);
 		if (valid) {
 			tlo_tmp = taglo & 0xfff3ff;
@@ -473,7 +473,7 @@
 		: "r" ((way << 13) | addr));
 
 		taglo = ((unsigned long long)taglohi << 32) | taglolo;
-		pa = (taglo & 0xFFFFFFE000) | addr;
+		pa = (taglo & 0xFFFFFFE000LL) | addr;
 		if (way == 0) {
 			lru = (taghi >> 14) & 0xff;
 			prom_printf("[Bank %d Set 0x%02x]  LRU > %d %d %d %d > MRU\n",
Index: arch/mips/sibyte/sb1250/irq.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sibyte/sb1250/irq.c,v
retrieving revision 1.26
diff -u -r1.26 irq.c
--- arch/mips/sibyte/sb1250/irq.c	10 Nov 2003 17:51:49 -0000	1.26
+++ arch/mips/sibyte/sb1250/irq.c	15 Jan 2004 19:05:32 -0000
@@ -365,9 +365,9 @@
 					 (K_INT_MBOX_0 << 3)));
 
 	/* Clear the mailboxes.  The firmware may leave them dirty */
-	__raw_writeq(0xffffffffffffffff,
+	__raw_writeq(0xffffffffffffffffLL,
 		     IOADDR(A_IMR_REGISTER(0, R_IMR_MAILBOX_CLR_CPU)));
-	__raw_writeq(0xffffffffffffffff,
+	__raw_writeq(0xffffffffffffffffLL,
 		     IOADDR(A_IMR_REGISTER(1, R_IMR_MAILBOX_CLR_CPU)));
 
 	/* Mask everything except the mailbox registers for both cpus */
