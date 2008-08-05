Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 00:16:41 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:52803 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20040752AbYHEXQc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Aug 2008 00:16:32 +0100
X-IronPort-AV: E=Sophos;i="4.31,312,1215388800"; 
   d="scan'208";a="61959677"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-1.cisco.com with ESMTP; 05 Aug 2008 23:16:23 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id m75NGNcc016959
	for <linux-mips@linux-mips.org>; Tue, 5 Aug 2008 16:16:23 -0700
Received: from sausatlsmtp2.sciatl.com ([192.133.217.159])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id m75NGMEV021417
	for <linux-mips@linux-mips.org>; Tue, 5 Aug 2008 23:16:23 GMT
Received: from default.com ([192.133.217.159]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 Aug 2008 19:16:22 -0400
Received: from sausatlbhs01.corp.sa.net ([192.133.216.76]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 Aug 2008 19:16:21 -0400
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155]) by sausatlbhs01.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 Aug 2008 19:16:20 -0400
Message-ID: <4898DF3C.5010000@cisco.com>
Date:	Tue, 05 Aug 2008 16:16:12 -0700
From:	David VomLehn <dvomlehn@cisco.com>
Reply-To: dvomlehn@cisco.com
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH 1/1]MIPS: Support DMA mapping of all kernel "unmapped" virtual
 address segments
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Aug 2008 23:16:20.0439 (UTC) FILETIME=[4522F670:01C8F751]
X-ST-MF-Message-Resent:	8/5/2008 19:16
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=3202; t=1217978183; x=1218842183;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20[PATCH=201/1]MIPS=3A=20Support=20DMA=20mapping=
	20of=20all=20kernel=20=22unmapped=22=20virtual=0A=20address=
	20segments
	|Sender:=20;
	bh=u9O6QVjt+fhtTs68SfweRTaZ2X9KGBndJ9XlYiKuv/E=;
	b=kjzrSlQG0i0OHX2zjKj91fe67MWdg8VWj1508b9u1hN+z/m0vZOWWhJgUV
	kg65gMEtNZF6vQMFdLx79xgHhCF7WMbbNklwmj1pcoeeyzrnf6HWPkxaxvIM
	TX2jx/Hyr+;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Support DMA mapping of all kernel "unmapped" virtual address segments
to the corresponding physical addresses for 32- and 64-bit architectures.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
The current virt_to_phys function does not map KSEG1 address to the correct
physical address, nor will it map most of the XKPHYS addresses correctly. This
patch addresses this problem.

Unfortunately, I don't have access to a 64-bit system, so I need to ask for
someone to perform additional verification. Any volunteers?

 addrspace.h |   18 +++++++++++-------
 io.h        |    2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

Index: linux/include/asm-mips/addrspace.h
===================================================================
--- linux.orig/include/asm-mips/addrspace.h
+++ linux/include/asm-mips/addrspace.h
@@ -75,6 +75,12 @@
 #define CKSEG2ADDR(a)		(CPHYSADDR(a) | CKSEG2)
 #define CKSEG3ADDR(a)		(CPHYSADDR(a) | CKSEG3)
 
+/*
+ * The ultimate limited of the 64-bit MIPS architecture:  2 bits for selecting
+ * the region, 3 bits for the CCA mode.  This leaves 59 bits of which the
+ * R8000 implements most with its 48-bit physical address space.
+ */
+#define TO_PHYS_MASK	_CONST64_(0x07ffffffffffffff)	/* 2^59 - 1 */
 #else
 
 #define CKSEG0ADDR(a)		(CPHYSADDR(a) | KSEG0)
@@ -106,6 +112,11 @@
 #define CKSEG2			0xc0000000
 #define CKSEG3			0xe0000000
 
+/*
+ * The ultimate limit of the 32-bit MIPS architecture. 3 bits for selecting
+ * the region, leaving 29 bits for the physical address spaces
+ */
+#define TO_PHYS_MASK		0x1fffffffl	/* 2^29 - 1 */
 #endif
 
 /*
@@ -129,13 +140,6 @@
 #define PHYS_TO_XKPHYS(cm, a)		(_CONST64_(0x8000000000000000) | \
 					 ((cm)<<59) | (a))
 
-/*
- * The ultimate limited of the 64-bit MIPS architecture:  2 bits for selecting
- * the region, 3 bits for the CCA mode.  This leaves 59 bits of which the
- * R8000 implements most with its 48-bit physical address space.
- */
-#define TO_PHYS_MASK	_CONST64_(0x07ffffffffffffff)	/* 2^^59 - 1 */
-
 #ifndef CONFIG_CPU_R8000
 
 /*
Index: linux/include/asm-mips/io.h
===================================================================
--- linux.orig/include/asm-mips/io.h
+++ linux/include/asm-mips/io.h
@@ -118,7 +118,7 @@ static inline void set_io_port_base(unsi
  */
 static inline unsigned long virt_to_phys(volatile const void *address)
 {
-	return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
+	return (unsigned long)address & TO_PHYS_MASK;
 }
 
 /*




     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
