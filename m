Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 19:01:10 +0000 (GMT)
Received: from adsl-66-123-66-42.dsl.pltn13.pacbell.net ([IPv6:::ffff:66.123.66.42]:7821
	"EHLO stella-blue.herbertphamily.com") by linux-mips.org with ESMTP
	id <S8225467AbUAOTBK>; Thu, 15 Jan 2004 19:01:10 +0000
Received: from [192.168.1.8] (shakedown.herbertphamily.com [192.168.1.8])
	(authenticated bits=0)
	by stella-blue.herbertphamily.com (8.12.8/8.12.8) with ESMTP id i0FJ150M008130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mips@linux-mips.org>; Thu, 15 Jan 2004 11:01:06 -0800
Subject: [Patch] SB1 cache exception handler fails to compile
	[arch/mips/mm/cex-sb1.S]
From: Kevin Paul Herbert <kph@cisco.com>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Organization: cisco Systems, Inc.
Message-Id: <1074193246.24675.19.camel@shakedown>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jan 2004 11:00:58 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <kph@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kph@cisco.com
Precedence: bulk
X-list: linux-mips

The recent update to arch/mips/mm/cex-sb1.S (1.13) adds an include for
<asm/processor.h> unnecessarily. This include file defines C structs and
the like which the assembler chokes upon.

Kevin
-- 
Kevin Paul Herbert <kph@cisco.com>
cisco Systems, Inc.


Index: arch/mips/mm/cex-sb1.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/cex-sb1.S,v
retrieving revision 1.13
diff -u -r1.13 cex-sb1.S
--- arch/mips/mm/cex-sb1.S	14 Jan 2004 18:46:21 -0000	1.13
+++ arch/mips/mm/cex-sb1.S	15 Jan 2004 18:55:28 -0000
@@ -23,7 +23,6 @@
 #include <asm/mipsregs.h>
 #include <asm/stackframe.h>
 #include <asm/cacheops.h>
-#include <asm/processor.h>
 #include <asm/sibyte/board.h>
 
 #define C0_ERRCTL     $26             /* CP0: Error info */
