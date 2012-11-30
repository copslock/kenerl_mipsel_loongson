Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2012 03:04:16 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:48300 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6829664Ab2K3CEKCTGHa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Nov 2012 03:04:10 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi1so7265198pad.36
        for <linux-mips@linux-mips.org>; Thu, 29 Nov 2012 18:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:cc:from:date:message-id:mime-version:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=/kwhbjAd19kTXt2rO2OvW1bx61it3nTjMhOBAws9GF0=;
        b=K/OAnUNRcm+wmA2/dHt81z8WcdvfvMvrQq/36a/dLDNUn4bqTxBc8BclxVowyinZGi
         /L3cmZ8a++g5ITGVlS5Tr0e7JGKkISpBlwzrxRjM/pKGp1NW14PbYgAJSXB+2jlf03JV
         Qy+3BxiV2A7Z1JEQU5DIpSRG0UV0vv5lM80hjv3YSZAFTdqEwAuMWRrdrcQ5H7Vr27kU
         M0HtiijfcdIfCA1+8bPR7/PiYz+PkyW3680si146oBoz0tlAR6j4PVGnZVFy9loQsmIa
         lDpgd/Oo7ofsQ3D3d+9DOwwcWAE5bbn0kAH7PUSha2nzAMrdeJZV5Yqu+SB2naLjRbno
         HMwg==
Received: by 10.68.253.102 with SMTP id zz6mr1247689pbc.99.1354241043697;
        Thu, 29 Nov 2012 18:04:03 -0800 (PST)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net. [67.168.183.230])
        by mx.google.com with ESMTPS id p5sm1987805paz.22.2012.11.29.18.04.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 18:04:02 -0800 (PST)
Subject: Patch "MPI: Fix compilation on MIPS with GCC 4.4 and newer" has been added to the 3.6-stable tree
To:     manuel.lauss@gmail.com, dmitry.kasatkin@intel.com,
        gregkh@linuxfoundation.org, jmorris@namei.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org, shuah.khan@hp.com
Cc:     <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 29 Nov 2012 18:03:15 -0800
Message-ID: <13542409951790@kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
X-Gm-Message-State: ALoCoQkiayhIvL83EBdjkeKBBhiUbjBxcDwbH2mUbVEXwcp7G/mNCMcWWCnSeJ5UW2GeUgsTM2vS
X-archive-position: 35156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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


This is a note to let you know that I've just added the patch titled

    MPI: Fix compilation on MIPS with GCC 4.4 and newer

to the 3.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mpi-fix-compilation-on-mips-with-gcc-4.4-and-newer.patch
and it can be found in the queue-3.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From a3cea9894157c20a5b1ec08b7e0b5f2019740c10 Mon Sep 17 00:00:00 2001
From: Manuel Lauss <manuel.lauss@gmail.com>
Date: Thu, 22 Nov 2012 11:58:22 +0100
Subject: MPI: Fix compilation on MIPS with GCC 4.4 and newer

From: Manuel Lauss <manuel.lauss@gmail.com>

commit a3cea9894157c20a5b1ec08b7e0b5f2019740c10 upstream.

Since 4.4 GCC on MIPS no longer recognizes the "h" constraint,
leading to this build failure:

  CC      lib/mpi/generic_mpih-mul1.o
lib/mpi/generic_mpih-mul1.c: In function 'mpihelp_mul_1':
lib/mpi/generic_mpih-mul1.c:50:3: error: impossible constraint in 'asm'

This patch updates MPI with the latest umul_ppm implementations for MIPS.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Cc: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Cc: James Morris <jmorris@namei.org>
Patchwork: https://patchwork.linux-mips.org/patch/4612/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Shuah Khan <shuah.khan@hp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/mpi/longlong.h |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -703,7 +703,14 @@ do { \
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
@@ -728,7 +735,15 @@ do { \
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


Patches currently in stable-queue which might be from manuel.lauss@gmail.com are

queue-3.6/mpi-fix-compilation-on-mips-with-gcc-4.4-and-newer.patch
