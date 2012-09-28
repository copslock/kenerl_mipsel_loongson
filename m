Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2012 20:34:29 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:39956 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903291Ab2I1SeW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Sep 2012 20:34:22 +0200
Received: by padbi5 with SMTP id bi5so2692746pad.36
        for <multiple recipients>; Fri, 28 Sep 2012 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=BkN1hs2kiKHlYbwBiGRNJvNYiphMuVKzJZ5dL6OtT0s=;
        b=YBHkshiQumTKt1XB10f/Wp71uKC3esSUvU5M/tCp9o3cNav1oY3jKUODdqiHNgQMnW
         RgK3Bnt0Lkv5O4iAT+zcsM5+2d/UlPas49SNCNxZWX1+0PVB/HkRKOvzLIROyWVYJyKd
         9OR2ehYCP/NPeHvzRxDeCLpI2SoOjdYMnfsZ/ekwkNP7kBu0hsbX58f/p5wRQkpTX60p
         BVDIz3YYRbn66L1qTs5SASc1c7MevGdX//FuiK1s9RDyz/KzW1DDBr2KenW5+ub1qtbb
         YDLplJ7RzxEq14eRhErZB7e8dsCPUsA4yioDdFZhCNOs4Y6EibB5QZXl5SVvHrd2+Nys
         7qEg==
Received: by 10.68.221.225 with SMTP id qh1mr22640317pbc.50.1348857255536;
        Fri, 28 Sep 2012 11:34:15 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id it6sm5966630pbc.14.2012.09.28.11.34.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2012 11:34:14 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q8SIYC5Z013838;
        Fri, 28 Sep 2012 11:34:12 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q8SIYBLQ013837;
        Fri, 28 Sep 2012 11:34:11 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Make __{,n,u}delay declarations agree with definitions and asm-generic/delay.h
Date:   Fri, 28 Sep 2012 11:34:10 -0700
Message-Id: <1348857250-13804-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.4
X-archive-position: 34557
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

At some recent point arch/mips/include/asm/delay.h has started being
included into csrc-octeon.c where the __?delay() functions are
defined.  This causes a compile failure due to conflicting
declarations and definitions of the functions.

It turns out that the generic definitions in arch/mips/lib/delay.c also
conflict.

Proposed fix: Declare the functions to take unsigned long parameters
just like asm-generic (and x86) does.  Update __delay to agree
(__ndelay and __udelay need no change).

Bonus: Get rid of 'inline' from __delay() definition, as it is globally
visible, and the compiler should be making this decision itself (it
does in fact inline the function without being told to).

Signed-off-by: David Daney <david.daney@cavium.com>
---

As seen on linux-next for 20120928

 arch/mips/include/asm/delay.h | 6 +++---
 arch/mips/lib/delay.c         | 6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/delay.h b/arch/mips/include/asm/delay.h
index e7cd782..dc0a5f7 100644
--- a/arch/mips/include/asm/delay.h
+++ b/arch/mips/include/asm/delay.h
@@ -13,9 +13,9 @@
 
 #include <linux/param.h>
 
-extern void __delay(unsigned int loops);
-extern void __ndelay(unsigned int ns);
-extern void __udelay(unsigned int us);
+extern void __delay(unsigned long loops);
+extern void __ndelay(unsigned long ns);
+extern void __udelay(unsigned long us);
 
 #define ndelay(ns) __ndelay(ns)
 #define udelay(us) __udelay(us)
diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
index 5995969..dc81ca8 100644
--- a/arch/mips/lib/delay.c
+++ b/arch/mips/lib/delay.c
@@ -15,13 +15,17 @@
 #include <asm/compiler.h>
 #include <asm/war.h>
 
-inline void __delay(unsigned int loops)
+void __delay(unsigned long loops)
 {
 	__asm__ __volatile__ (
 	"	.set	noreorder				\n"
 	"	.align	3					\n"
 	"1:	bnez	%0, 1b					\n"
+#if __SIZEOF_LONG__ == 4
 	"	subu	%0, 1					\n"
+#else
+	"	dsubu	%0, 1					\n"
+#endif
 	"	.set	reorder					\n"
 	: "=r" (loops)
 	: "0" (loops));
-- 
1.7.11.4
