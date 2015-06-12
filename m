Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jun 2015 11:04:43 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33745 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007132AbbFLJEksPa00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jun 2015 11:04:40 +0200
Received: by pdjn11 with SMTP id n11so20937214pdj.0;
        Fri, 12 Jun 2015 02:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fTm02Kd6DUpPILdrDESYDRm56pSOFalT4z0lASg4hlA=;
        b=LZT+T6JtgNDFWRAxHTYDDHg9FtwwT5zH+Nt+AUTi9I9o7uUUJbZqVUYQKJwCoR2++7
         5u9lDCfN8T1/lkZSJg68mRO/SK6hF651OGpjWpGr8luhO6EvppHrQL7lHkALnLwGRzzT
         3MDQPlfMGAYMab+1bf6InesU9RuXVvdIV7jjn9n+OLsuIjOLytZ3R76EmuT/UjHgX0Zv
         Hw3PAtwhPt3rAFqIXSVnp+r9PLlqanWawXuxYw60OFpIdKP9hoylMaqqOkth+T1jsgL5
         tta8/AiaekmXQj7NBqjlyw3PqpAl4+EUnkSvQHxlDHfO+Z9gr1Ubf/72xZYvFUJsclwn
         W5IQ==
X-Received: by 10.68.57.209 with SMTP id k17mr21821379pbq.118.1434099874467;
        Fri, 12 Jun 2015 02:04:34 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by mx.google.com with ESMTPSA id nj7sm2963823pbc.36.2015.06.12.02.04.32
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Jun 2015 02:04:33 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] MPI: fix compilation error with GCC 5.1
Date:   Fri, 12 Jun 2015 18:04:14 +0900
Message-Id: <1434099854-52986-1-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.4.2
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

This patch fixes mips compilation error:

lib/mpi/generic_mpih-mul1.c: In function 'mpihelp_mul_1':
lib/mpi/longlong.h:651:2: error: impossible constraint in 'asm'

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 lib/mpi/longlong.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
index aac511417ad1..a89d041592c8 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -639,7 +639,7 @@ do { \
 	**************  MIPS  *****************
 	***************************************/
 #if defined(__mips__) && W_TYPE_SIZE == 32
-#if __GNUC__ >= 4 && __GNUC_MINOR__ >= 4
+#if (__GNUC__ >= 5) || (__GNUC__ >= 4 && __GNUC_MINOR__ >= 4)
 #define umul_ppmm(w1, w0, u, v)			\
 do {						\
 	UDItype __ll = (UDItype)(u) * (v);	\
@@ -671,7 +671,7 @@ do {						\
 	**************  MIPS/64  **************
 	***************************************/
 #if (defined(__mips) && __mips >= 3) && W_TYPE_SIZE == 64
-#if __GNUC__ >= 4 && __GNUC_MINOR__ >= 4
+#if (__GNUC__ >= 5) || (__GNUC__ >= 4 && __GNUC_MINOR__ >= 4)
 #define umul_ppmm(w1, w0, u, v) \
 do {									\
 	typedef unsigned int __ll_UTItype __attribute__((mode(TI)));	\
-- 
2.4.2
