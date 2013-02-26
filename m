Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Feb 2013 00:23:46 +0100 (CET)
Received: from mail-da0-f50.google.com ([209.85.210.50]:43881 "EHLO
        mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825727Ab3BZXXnjPvYl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Feb 2013 00:23:43 +0100
Received: by mail-da0-f50.google.com with SMTP id h15so2064725dan.37
        for <multiple recipients>; Tue, 26 Feb 2013 15:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=HcSQJ/hVUgWLfJmNTO7bw32/1mMD8d+Tl3HN2TUTaGM=;
        b=K0TFPAPufG96xGweQn0eaWmdvcrA4vhhg/XG1hbVj/nM9jy8CbN2R5a//jUv4aAp9B
         NjT9e1h6eTfLxUCvOMitCan7gSizHNgbYIXTWfX/O57U6Mhj2SP5+GYnZak+XvTk2Jzi
         YI8dVnsstiMVa8nS8a3unqJQtzsWxbwNtZl189kUaOygvm27AzGcHuWcbHmh2oDw4bft
         Kt00F4zjej14ZJ7vKju3vKzqu2jchhLQvnUwz2L1C7loRvclizSOIoZu5GpVEvX4N8AN
         5f2/nMjU+ji8PfFzUwn7krwDGCyeJW6FsezClBUUmihOKAJjKFBKxf8Qb0OECd1lNONd
         +nEQ==
X-Received: by 10.66.217.164 with SMTP id oz4mr4281840pac.132.1361921017156;
        Tue, 26 Feb 2013 15:23:37 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id jp9sm2358209pbb.7.2013.02.26.15.23.35
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 26 Feb 2013 15:23:36 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r1QNMYQM019903;
        Tue, 26 Feb 2013 15:22:34 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r1QNMYf9019902;
        Tue, 26 Feb 2013 15:22:34 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Remove unneeded volatile from arch/mips/lib/bitops.c
Date:   Tue, 26 Feb 2013 15:22:33 -0800
Message-Id: <1361920953-19869-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
X-archive-position: 35829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

The operations on the bitmap pointers are protected by "memory"
clobbering raw_local_irq_{save,restore}(), so there is no need for
volatile here.  By removing the volatile we get better code generation
out of the compiler.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/lib/bitops.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/lib/bitops.c b/arch/mips/lib/bitops.c
index f3f7756..485846c 100644
--- a/arch/mips/lib/bitops.c
+++ b/arch/mips/lib/bitops.c
@@ -19,7 +19,7 @@
  */
 void __mips_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
-	volatile unsigned long *a = addr;
+	unsigned long *a = (unsigned long *)addr;
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
@@ -41,7 +41,7 @@ EXPORT_SYMBOL(__mips_set_bit);
  */
 void __mips_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
-	volatile unsigned long *a = addr;
+	unsigned long *a = (unsigned long *)addr;
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
@@ -63,7 +63,7 @@ EXPORT_SYMBOL(__mips_clear_bit);
  */
 void __mips_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
-	volatile unsigned long *a = addr;
+	unsigned long *a = (unsigned long *)addr;
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
@@ -86,7 +86,7 @@ EXPORT_SYMBOL(__mips_change_bit);
 int __mips_test_and_set_bit(unsigned long nr,
 			    volatile unsigned long *addr)
 {
-	volatile unsigned long *a = addr;
+	unsigned long *a = (unsigned long *)addr;
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
@@ -112,7 +112,7 @@ EXPORT_SYMBOL(__mips_test_and_set_bit);
 int __mips_test_and_set_bit_lock(unsigned long nr,
 				 volatile unsigned long *addr)
 {
-	volatile unsigned long *a = addr;
+	unsigned long *a = (unsigned long *)addr;
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
@@ -137,7 +137,7 @@ EXPORT_SYMBOL(__mips_test_and_set_bit_lock);
  */
 int __mips_test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
-	volatile unsigned long *a = addr;
+	unsigned long *a = (unsigned long *)addr;
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
@@ -162,7 +162,7 @@ EXPORT_SYMBOL(__mips_test_and_clear_bit);
  */
 int __mips_test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
-	volatile unsigned long *a = addr;
+	unsigned long *a = (unsigned long *)addr;
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
-- 
1.7.11.7
