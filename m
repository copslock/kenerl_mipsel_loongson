Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 11:58:36 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:58791 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823033Ab2KVK6fQda-6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Nov 2012 11:58:35 +0100
Received: by mail-bk0-f49.google.com with SMTP id jm19so2105150bkc.36
        for <multiple recipients>; Thu, 22 Nov 2012 02:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cN+seQ87APb+Urz7JCGflnit4Y+X2ST6jzUD8O4dty0=;
        b=rhiigt6KXHnUxwg+6CQNtwVktCNBTdkszL2XiuKGMWrWz0tcqpI3fo/nno87nbaUt9
         4JzKp/yFbeNP2Lhw04SdwuRyhb7zVSM+/9o/Qj/XCHVkECFv1n+eFz10wLjSloD9phI/
         s/+qXfC1ObruHitNTrrvIThB32Jp+fOLYGv5oHuiUTugciAgOBcdspAHetm2oY9kJJyr
         icn5fwUtoMZe7J3H139F5Nk1LTbj8J6W8aSTEPsglSANThF3xGOShjjfdQk+C5ioZDL0
         2/lggSQMzxdePTIVDMXrBmxktZcW+wHdq/kQewkSj15SHS0OCfGy1261PjBJoNMzkwae
         IwCw==
Received: by 10.204.3.213 with SMTP id 21mr37335bko.121.1353581909785;
        Thu, 22 Nov 2012 02:58:29 -0800 (PST)
Received: from flagship.roarinelk.net (178-191-6-87.adsl.highway.telekom.at. [178.191.6.87])
        by mx.google.com with ESMTPS id u3sm1950243bkw.9.2012.11.22.02.58.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 02:58:28 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@intel.com>,
        James Morris <jmorris@namei.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH] MPI: Fix compilation on MIPS with GCC 4.4 and newer
Date:   Thu, 22 Nov 2012 11:58:22 +0100
Message-Id: <1353581902-18938-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.8.0
X-archive-position: 35094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Manuel Lauss <manuel.lauss@gmail.com>

Since 4.4 GCC on MIPS no longer recognizes the "h" constraint,
leading to this build failure:

  CC      lib/mpi/generic_mpih-mul1.o
lib/mpi/generic_mpih-mul1.c: In function 'mpihelp_mul_1':
lib/mpi/generic_mpih-mul1.c:50:3: error: impossible constraint in 'asm'

This patch updates MPI with the latest umul_ppm implementations for MIPS.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Compile-tested on 32bit only.

 lib/mpi/longlong.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
index 678ce4f..095ab15 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -641,7 +641,14 @@ do { \
 	**************  MIPS  *****************
 	***************************************/
 #if defined(__mips__) && W_TYPE_SIZE == 32
-#if __GNUC__ > 2 || __GNUC_MINOR__ >= 7
+#if __GNUC__ >= 4 && __GNUC_MINOR__ >= 4
+#define umul_ppmm(w1, w0, u, v)			\
+do {						\
+	UDItype __ll = (UDItype)(u) * (v);	\
+	w1 = __ll >> 32;			\
+	w0 = __ll;				\
+} while (0)
+#elif __GNUC__ > 2 || __GNUC_MINOR__ >= 7
 #define umul_ppmm(w1, w0, u, v) \
 	__asm__ ("multu %2,%3" \
 	: "=l" ((USItype)(w0)), \
@@ -666,7 +673,15 @@ do { \
 	**************  MIPS/64  **************
 	***************************************/
 #if (defined(__mips) && __mips >= 3) && W_TYPE_SIZE == 64
-#if __GNUC__ > 2 || __GNUC_MINOR__ >= 7
+#if __GNUC__ >= 4 && __GNUC_MINOR__ >= 4
+#define umul_ppmm(w1, w0, u, v) \
+do {									\
+	typedef unsigned int __ll_UTItype __attribute__((mode(TI)));	\
+	__ll_UTItype __ll = (__ll_UTItype)(u) * (v);			\
+	w1 = __ll >> 64;						\
+	w0 = __ll;							\
+} while (0)
+#elif __GNUC__ > 2 || __GNUC_MINOR__ >= 7
 #define umul_ppmm(w1, w0, u, v) \
 	__asm__ ("dmultu %2,%3" \
 	: "=l" ((UDItype)(w0)), \
-- 
1.8.0
