Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Mar 2013 14:01:27 +0100 (CET)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:38141 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827485Ab3CLNBWrMn9j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Mar 2013 14:01:22 +0100
Received: by mail-pb0-f51.google.com with SMTP id un15so4932535pbc.24
        for <multiple recipients>; Tue, 12 Mar 2013 06:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=IvsKNNuhBqDviiLarbNpPJmpdUR81K+zQTjUbHC4+58=;
        b=SVj6+wHZwnb0I7QVb+q4T8TZzlbuzUEm79nLAQCCwF5rQ7E6tLGWULUA3AwQ+064L6
         rnmCAmbtGpj9fxTt4uUzkalD+JwPS2h62pgRD3gO16hy5be2gOZBH2eJCF55trnzSCOA
         huguvaraq0Q9Xc4LfwjPfX0zessntEXnp+avObb57OpKJhM6UwOiOjhLT9NOOsxQfMLk
         MPlr83bhi9pXh81lx/VWx9nMF/BlGCqDh8gXiCzPDZKy/R8sWDa24LxqqBVh/5FIJrBK
         NRopHIdfNsWkASKigygBh1NKsO9FMYUJpEFOMC/RHv7BR4k2NUXfuU5Mqxx+2GdxIgSE
         92IQ==
X-Received: by 10.68.129.163 with SMTP id nx3mr37644541pbb.13.1363093276098;
        Tue, 12 Mar 2013 06:01:16 -0700 (PDT)
Received: from localhost ([123.66.210.251])
        by mx.google.com with ESMTPS id qb10sm24962369pbb.43.2013.03.12.06.01.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:01:15 -0700 (PDT)
From:   Zhi-zhou Zhang <zhizhou.zh@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Zhi-zhou Zhang <zhizhou.zh@gmail.com>
Subject: [PATCH] mips: lib/bitops.c: fix wrong return type
Date:   Tue, 12 Mar 2013 21:00:53 +0800
Message-Id: <1363093253-17595-1-git-send-email-zhizhou.zh@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <n>
References: <n>
X-archive-position: 35877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhizhou.zh@gmail.com
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

Here should return 64-bit types rather than 32-bit types. Or we
may get wrong return value if high 32-bit isn't equal to zero.

Signed-off-by: Zhi-zhou Zhang <zhizhou.zh@gmail.com>
---
 arch/mips/include/asm/bitops.h |    8 ++++----
 arch/mips/lib/bitops.c         |   10 ++++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 71305a8..7502601 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -51,13 +51,13 @@
 void __mips_set_bit(unsigned long nr, volatile unsigned long *addr);
 void __mips_clear_bit(unsigned long nr, volatile unsigned long *addr);
 void __mips_change_bit(unsigned long nr, volatile unsigned long *addr);
-int __mips_test_and_set_bit(unsigned long nr,
+unsigned long __mips_test_and_set_bit(unsigned long nr,
 			    volatile unsigned long *addr);
-int __mips_test_and_set_bit_lock(unsigned long nr,
+unsigned long __mips_test_and_set_bit_lock(unsigned long nr,
 				 volatile unsigned long *addr);
-int __mips_test_and_clear_bit(unsigned long nr,
+unsigned long __mips_test_and_clear_bit(unsigned long nr,
 			      volatile unsigned long *addr);
-int __mips_test_and_change_bit(unsigned long nr,
+unsigned long __mips_test_and_change_bit(unsigned long nr,
 			       volatile unsigned long *addr);
 
 
diff --git a/arch/mips/lib/bitops.c b/arch/mips/lib/bitops.c
index 81f1dcf..f8d14fc 100644
--- a/arch/mips/lib/bitops.c
+++ b/arch/mips/lib/bitops.c
@@ -83,7 +83,7 @@ EXPORT_SYMBOL(__mips_change_bit);
  * @nr: Bit to set
  * @addr: Address to count from
  */
-int __mips_test_and_set_bit(unsigned long nr,
+unsigned long __mips_test_and_set_bit(unsigned long nr,
 			    volatile unsigned long *addr)
 {
 	volatile unsigned long *a = addr;
@@ -109,7 +109,7 @@ EXPORT_SYMBOL(__mips_test_and_set_bit);
  * @nr: Bit to set
  * @addr: Address to count from
  */
-int __mips_test_and_set_bit_lock(unsigned long nr,
+unsigned long __mips_test_and_set_bit_lock(unsigned long nr,
 				 volatile unsigned long *addr)
 {
 	volatile unsigned long *a = addr;
@@ -135,7 +135,8 @@ EXPORT_SYMBOL(__mips_test_and_set_bit_lock);
  * @nr: Bit to clear
  * @addr: Address to count from
  */
-int __mips_test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
+unsigned long __mips_test_and_clear_bit(unsigned long nr,
+				volatile unsigned long *addr)
 {
 	volatile unsigned long *a = addr;
 	unsigned bit = nr & SZLONG_MASK;
@@ -160,7 +161,8 @@ EXPORT_SYMBOL(__mips_test_and_clear_bit);
  * @nr: Bit to change
  * @addr: Address to count from
  */
-int __mips_test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
+unsigned long __mips_test_and_change_bit(unsigned long nr,
+				volatile unsigned long *addr)
 {
 	volatile unsigned long *a = addr;
 	unsigned bit = nr & SZLONG_MASK;
-- 
1.7.9.5
