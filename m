Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 09:00:23 +0200 (CEST)
Received: from mo32.po.2iij.net ([210.128.50.17]:2371 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133461AbWEaHAM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2006 09:00:12 +0200
Received: by mo.po.2iij.net (mo32) id k4V708pg063174; Wed, 31 May 2006 16:00:08 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id k4V705pk018446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-mips@linux-mips.org>; Wed, 31 May 2006 16:00:06 +0900 (JST)
Date:	Wed, 31 May 2006 16:00:05 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: [RFC] remove unused define from addrspace.h
Message-Id: <20060531160005.3303a91e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi all,

This patch removes unused definitions from addrspace.h .
If these definitions are needed, please let me know.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/addrspace.h mips/include/asm-mips/addrspace.h
--- mips-orig/include/asm-mips/addrspace.h	2006-05-31 11:31:45.061315500 +0900
+++ mips/include/asm-mips/addrspace.h	2006-05-31 13:23:25.617377750 +0900
@@ -133,57 +133,22 @@
     || defined (CONFIG_CPU_NEVADA)					\
     || defined (CONFIG_CPU_TX49XX)					\
     || defined (CONFIG_CPU_MIPS64)
-#define KUSIZE		_LLCONST_(0x0000010000000000)	/* 2^^40 */
-#define KUSIZE_64	_LLCONST_(0x0000010000000000)	/* 2^^40 */
-#define K0SIZE		_LLCONST_(0x0000001000000000)	/* 2^^36 */
-#define K1SIZE		_LLCONST_(0x0000001000000000)	/* 2^^36 */
-#define K2SIZE		_LLCONST_(0x000000ff80000000)
-#define KSEGSIZE	_LLCONST_(0x000000ff80000000)	/* max syssegsz */
 #define TO_PHYS_MASK	_LLCONST_(0x0000000fffffffff)	/* 2^^36 - 1 */
 #endif
 
 #if defined (CONFIG_CPU_R8000)
 /* We keep KUSIZE consistent with R4000 for now (2^^40) instead of (2^^48) */
-#define KUSIZE		_LLCONST_(0x0000010000000000)	/* 2^^40 */
-#define KUSIZE_64	_LLCONST_(0x0000010000000000)	/* 2^^40 */
-#define K0SIZE		_LLCONST_(0x0000010000000000)	/* 2^^40 */
-#define K1SIZE		_LLCONST_(0x0000010000000000)	/* 2^^40 */
-#define K2SIZE		_LLCONST_(0x0001000000000000)
-#define KSEGSIZE	_LLCONST_(0x0000010000000000)	/* max syssegsz */
 #define TO_PHYS_MASK	_LLCONST_(0x000000ffffffffff)	/* 2^^40 - 1 */
 #endif
 
 #if defined (CONFIG_CPU_R10000)
-#define KUSIZE		_LLCONST_(0x0000010000000000)	/* 2^^40 */
-#define KUSIZE_64	_LLCONST_(0x0000010000000000)	/* 2^^40 */
-#define K0SIZE		_LLCONST_(0x0000010000000000)	/* 2^^40 */
-#define K1SIZE		_LLCONST_(0x0000010000000000)	/* 2^^40 */
-#define K2SIZE		_LLCONST_(0x00000fff80000000)
-#define KSEGSIZE	_LLCONST_(0x00000fff80000000)	/* max syssegsz */
 #define TO_PHYS_MASK	_LLCONST_(0x000000ffffffffff)	/* 2^^40 - 1 */
 #endif
 
 #if defined(CONFIG_CPU_SB1) || defined(CONFIG_CPU_SB1A)
-#define KUSIZE		_LLCONST_(0x0000100000000000)	/* 2^^44 */
-#define KUSIZE_64	_LLCONST_(0x0000100000000000)	/* 2^^44 */
-#define K0SIZE		_LLCONST_(0x0000100000000000)	/* 2^^44 */
-#define K1SIZE		_LLCONST_(0x0000100000000000)	/* 2^^44 */
-#define K2SIZE		_LLCONST_(0x0000ffff80000000)
-#define KSEGSIZE	_LLCONST_(0x0000ffff80000000)	/* max syssegsz */
 #define TO_PHYS_MASK	_LLCONST_(0x00000fffffffffff)	/* 2^^44 - 1 */
 #endif
 
-/*
- * Further names for SGI source compatibility.  These are stolen from
- * IRIX's <sys/mips_addrspace.h>.
- */
-#define KUBASE		_LLCONST_(0)
-#define KUSIZE_32	_LLCONST_(0x0000000080000000)	/* KUSIZE
-							   for a 32 bit proc */
-#define K0BASE_EXL_WR	_LLCONST_(0xa800000000000000)	/* exclusive on write */
-#define K0BASE_NONCOH	_LLCONST_(0x9800000000000000)	/* noncoherent */
-#define K0BASE_EXL	_LLCONST_(0xa000000000000000)	/* exclusive */
-
 #ifndef CONFIG_CPU_R8000
 
 /*
