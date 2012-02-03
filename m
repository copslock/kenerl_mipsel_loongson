Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2012 08:52:17 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:56951 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903616Ab2BCHwK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2012 08:52:10 +0100
Received: by dakp5 with SMTP id p5so3044254dak.36
        for <multiple recipients>; Thu, 02 Feb 2012 23:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3byXzL6v/3lk8hnRfA2/8uhQTFQGHdoE1vLhJGnOfI8=;
        b=PxA/OXoo0MTEu53w3OpMEW9u87+U9v15eK746Y58djvbWRqwwgbpWjN9CWXUjNf1xj
         RoOYnCHS1rrVKmu+XadU8kUAlEFaRN4XgetOzVY6kc1Rrn0WYNuj8xuG6TRYkb4iROGe
         WbZ+H8BD/IhYGrc90+at19QDkXM581GenhhEw=
Received: by 10.68.130.40 with SMTP id ob8mr15334346pbb.106.1328255523391;
        Thu, 02 Feb 2012 23:52:03 -0800 (PST)
Received: from cr0.redhat.com ([180.129.255.55])
        by mx.google.com with ESMTPS id j5sm11238601pbe.1.2012.02.02.23.51.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 23:52:02 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        WANG Cong <xiyou.wangcong@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Hillf Danton <dhillf@gmail.com>, linux-mips@linux-mips.org
Subject: [Patch] mips: do not redefine BUILD_BUG()
Date:   Fri,  3 Feb 2012 15:51:40 +0800
Message-Id: <1328255503-17575-1-git-send-email-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 1.7.7.6
X-archive-position: 32396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiyou.wangcong@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On mips, we got

include/linux/kernel.h:717:1: error: "BUILD_BUG" redefined
arch/mips/include/asm/page.h:43:1: error: this is the location of the previous definition
make[3]: *** [arch/mips/sgi-ip27/ip27-console.o] Error 1
make[2]: *** [arch/mips/sgi-ip27] Error 2
make[1]: *** [arch/mips] Error 2
make: *** [sub-make] Error 2

use generic BUILD_BUG() instead of re-defining one.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index d417909..e14121a 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -39,9 +39,7 @@
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #else /* !CONFIG_HUGETLB_PAGE */
-# ifndef BUILD_BUG
-#  define BUILD_BUG() do { extern void __build_bug(void); __build_bug(); } while (0)
-# endif
+#include <linux/kernel.h>
 #define HPAGE_SHIFT	({BUILD_BUG(); 0; })
 #define HPAGE_SIZE	({BUILD_BUG(); 0; })
 #define HPAGE_MASK	({BUILD_BUG(); 0; })
