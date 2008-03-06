Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 09:58:32 +0000 (GMT)
Received: from koto.vergenet.net ([210.128.90.7]:1415 "EHLO koto.vergenet.net")
	by ftp.linux-mips.org with ESMTP id S28603242AbYCFJ5l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2008 09:57:41 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 9FF91341BD;
	Thu,  6 Mar 2008 18:57:31 +0900 (JST)
Received: by tabatha.lab.ultramonkey.org (Postfix, from userid 7100)
	id 8E338505BC; Thu,  6 Mar 2008 18:57:30 +0900 (JST)
Message-Id: <20080306094758.578257076@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
User-Agent: quilt/0.46-1
Date:	Thu, 06 Mar 2008 18:46:39 +0900
From:	Simon Horman <horms@verge.net.au>
To:	kexec@lists.infradead.org, linux-mips@linux-mips.org,
	Tomasz Chmielewski <mangoo@wpkg.org>
Cc:	Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: [patch 02/12] kexec-tools: mipsel: Remove purgatory/arch/mipsel/include/stdint.h
Content-Disposition: inline; filename=mips-dup_stdint.patch
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

Remove purgatory/arch/mipsel/include/stdint.h as it just duplicates
things found in system header files.

Signed-off-by: Simon Horman <horms@verge.net.au>

---

 purgatory/arch/mipsel/include/stdint.h |   16 ----------------
 1 file changed, 16 deletions(-)

Index: kexec-tools-mips/purgatory/arch/mipsel/include/stdint.h
===================================================================
--- kexec-tools-mips.orig/purgatory/arch/mipsel/include/stdint.h	2008-02-27 19:02:34.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,16 +0,0 @@
-#ifndef STDINT_H
-#define STDINT_H
-
-typedef unsigned long      size_t;
-
-typedef unsigned char      uint8_t;
-typedef unsigned short     uint16_t;
-typedef unsigned int       uint32_t;
-typedef unsigned long long uint64_t;
-
-typedef signed char        int8_t;
-typedef signed short       int16_t;
-typedef signed int         int32_t;
-typedef signed long long   int64_t;
-
-#endif /* STDINT_H */

-- 

-- 
Horms
