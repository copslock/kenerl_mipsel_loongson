Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Feb 2013 20:21:44 +0100 (CET)
Received: from mail-da0-f41.google.com ([209.85.210.41]:41019 "EHLO
        mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825898Ab3BATVnYbwdN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Feb 2013 20:21:43 +0100
Received: by mail-da0-f41.google.com with SMTP id e20so1848892dak.0
        for <multiple recipients>; Fri, 01 Feb 2013 11:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=bGn/qD+qLnzakEI+QTY6ilHV3tpN+rYIpG1n8sL6jo0=;
        b=MqxHxq5OGAHGX1fg93OcvC07e/M7S0RDa1dLynMXgR0rNnceXxuuCZjpWnG7SG/dvd
         IZQo7+whxZObhLaE5E/MN1bh++28JdMHGIENgpt8XyqRwYro4Juu+JPRCZoizop4f96Y
         ds3QcBpkEGwduT3NlQsvC2EbgM973rDd5L2JdCo0KoSdhcA7HdnTs2NNqV4y5nvNiq95
         5gRdSPXC/M2Q3XH3j/lg35Sr1EdvAdoB9GLHci4ooc/9GjOyKnR2TbVHszxteQxRixod
         7l6EkcpDqqFdD9M7YTptNN+Ubf/PBAbpFnRsSISdbMz5n8WIA8bFdJjwqBqj7IgRzPvj
         Webg==
X-Received: by 10.68.213.233 with SMTP id nv9mr35071708pbc.155.1359746496378;
        Fri, 01 Feb 2013 11:21:36 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id x6sm10002052paw.0.2013.02.01.11.21.35
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 11:21:35 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r11JLY14017939;
        Fri, 1 Feb 2013 11:21:34 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r11JLXsm017938;
        Fri, 1 Feb 2013 11:21:33 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Don't export kernel internal details in uapi/asm/break.h
Date:   Fri,  1 Feb 2013 11:21:32 -0800
Message-Id: <1359746492-17905-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
X-archive-position: 35677
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

Only the codes used by userspace should be exported.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/uapi/asm/break.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/uapi/asm/break.h b/arch/mips/include/uapi/asm/break.h
index 6f61d08..652431f 100644
--- a/arch/mips/include/uapi/asm/break.h
+++ b/arch/mips/include/uapi/asm/break.h
@@ -20,10 +20,14 @@
 #define BRK_OVERFLOW	6	/* Overflow check */
 #define BRK_DIVZERO	7	/* Divide by zero check */
 #define BRK_RANGE	8	/* Range error check */
+
+#ifdef __KERNEL__
+/* Break codes used internally to the kernel. */
 #define BRK_BUG		12	/* Used by BUG() */
 #define BRK_MEMU	514	/* Used by FPU emulator */
 #define BRK_KPROBE_BP	515	/* Kprobe break */
 #define BRK_KPROBE_SSTEPBP 516	/* Kprobe single step software implementation */
 #define BRK_MULOVF	1023	/* Multiply overflow */
+#endif /* __KERNEL__ */
 
 #endif /* __ASM_BREAK_H */
-- 
1.7.11.7
