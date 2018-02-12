Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2018 23:37:17 +0100 (CET)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:41425
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994559AbeBLWhLJTOax (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2018 23:37:11 +0100
Received: by mail-pl0-x244.google.com with SMTP id k8so5670284pli.8;
        Mon, 12 Feb 2018 14:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=bNbw5o21kCD+LtdmOOJY5z0RI933IirRkmzkmad/3Q4=;
        b=COT2y1E5y9obNeGp+xj0p7NpVovsivLxI0thaj7Elmmm/CGGWrVLg7qFJe/nkjwfWX
         xson7j7BZebGn5aCITyoQd7tIZMj+gF0INOaCkTh04zuW4JGmGebgEjGqSCE+JrvZ6bW
         LW4gYazgFqZgPB4oxJ1X43uTYMkv3a/G7yioyA7sKS5jL9jx4BKSuykJ3ydJqZaQE0OI
         uowsSIN4H4gBulvatf762eAfukPkUyb4zbzHNwFebJC9EnPPfkCz6w5JBxpwkShHzDRy
         +37em2fHbJc5moUup7J3h96Ao50pwpIkb6yCS8SSSerOBHRZtskWmO9Zi7ylCfv0xQK2
         p8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=bNbw5o21kCD+LtdmOOJY5z0RI933IirRkmzkmad/3Q4=;
        b=VWPK7zBvPrgbGZNLELbzOp83MXIneDrhSEAIhBjA5gqs7KoMFl6DVpTRgTMe2yJWe0
         pKqr9//JkUxUYjFqWbQhqCZXD5Aia39tDEZ+mF4ORgaZRQwLbpjVzDaClcXJ9AUGxF2B
         dpYIwm7DApxPxMzUjqueHRQZNTm89IDIg91OdgFo+nJ5cI/vuWJVBhI5xGzRCN5npfYH
         qyS4Y0hhEKXJDe8OWnJL1wo5e/yxfhsfYTgjVA4zoV0fPqxCVTTwjLuo1VAU22+GzBzy
         nNw/LJODFbL3ljOichlTlD3qPYECAtCJJayjHwCjzMcX5HSgfv8YrJOLwNTkD3yWDwDr
         xbJA==
X-Gm-Message-State: APf1xPC+KNk3es4TkwGUW5ssd8xmEAR5lTel5RQ7PcnJzthTb07Ci/Dj
        eiLgYLjFoTzwpcvp5TPpcMI=
X-Google-Smtp-Source: AH8x227tMN+Jydh3CZR9BNT4x9DGgBNCmAHjAipznS2/XXwGSBoNyvr5WruP/tCH66payG5SlHsw2w==
X-Received: by 2002:a17:902:6a16:: with SMTP id m22-v6mr12395725plk.142.1518475024053;
        Mon, 12 Feb 2018 14:37:04 -0800 (PST)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q68sm23492071pfb.104.2018.02.12.14.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 14:37:03 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
Date:   Mon, 12 Feb 2018 14:37:01 -0800
Message-Id: <1518475021-3337-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Since commit 60f481b970386 ("i40e: change flags to use 64 bits"),
the i40e driver uses cmpxchg64(). This causes mips:allmodconfig builds
to fail with

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
	In function 'i40e_set_priv_flags':
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4443:2: error:
	implicit declaration of function 'cmpxchg64'

Implement a poor-mans-version of cmpxchg64() to fix the problem for 32-bit
mips builds. The code is derived from sparc32, but only uses a single
spinlock.

Fixes: 60f481b970386 ("i40e: change flags to use 64 bits")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Compile-tested only.

 arch/mips/include/asm/cmpxchg.h |  3 +++
 arch/mips/kernel/cmpxchg.c      | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 89e9fb7976fe..9f7b1df95b99 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -206,6 +206,9 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
 #ifndef CONFIG_SMP
 #define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
+#else
+u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
+#define cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
 #endif
 #endif
 
diff --git a/arch/mips/kernel/cmpxchg.c b/arch/mips/kernel/cmpxchg.c
index 0b9535bc2c53..30216beb2334 100644
--- a/arch/mips/kernel/cmpxchg.c
+++ b/arch/mips/kernel/cmpxchg.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/spinlock.h>
 #include <asm/cmpxchg.h>
 
 unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
@@ -107,3 +108,19 @@ unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
 			return old;
 	}
 }
+
+static DEFINE_SPINLOCK(cmpxchg_lock);
+
+u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
+{
+	unsigned long flags;
+	u64 prev;
+
+	spin_lock_irqsave(&cmpxchg_lock, flags);
+	if ((prev = *ptr) == old)
+		*ptr = new;
+	spin_unlock_irqrestore(&cmpxchg_lock, flags);
+
+	return prev;
+}
+EXPORT_SYMBOL(__cmpxchg_u64);
-- 
2.7.4
