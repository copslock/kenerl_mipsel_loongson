Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2018 07:34:45 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:39837
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990505AbeHWFelGF0US (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Aug 2018 07:34:41 +0200
Received: by mail-pf1-x443.google.com with SMTP id j8-v6so2107549pff.6;
        Wed, 22 Aug 2018 22:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=05TSRE2yBjvCMW0T4O6HTeA7+lvWdTOVPdV38ofe3v8=;
        b=aje7gWlR0dSp8NTJ+IM67Dajsgv7skYspKcmTNVSDcQr7+acDHwHNlY7RrSGIMJO+5
         akf3QFiwieHLtunU0l2FXi86ZFSO/bzcQ34YAYsL2XdExkS9yfrZuW/PPGzphHxSrSMH
         pRLFAUJk/YLO8jE46hVx2+DbKr5rtheQnXv7m3RXQjatLvLEc6b+UnLS3XCT1Wfm4IGz
         7XdB62XMYQZ3skxpfyhNwmaLAbagUC0FUQsZMhDNDwvhmtGNjN0Aoj712QB8Ol3Y+UJv
         eJEHqfd9+LspYGQogNWNSQZwMgp43dSce3wa/o2H50J7jiBk0kb4Z+heboRcJbGcXv5q
         3e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=05TSRE2yBjvCMW0T4O6HTeA7+lvWdTOVPdV38ofe3v8=;
        b=bIB0YGBP0XHm8cLjkhMarqIeBqjAcqUh48ic0n/CDPwrtRaNw8j+N9KRUEP/zLSyAX
         uCo5OrREGc1a2ZDc0NOCKYiQZVMoZZnKuk7fWuaaOLjEBeVcfIfDBJzspNs7U+yJgrpq
         MN0IPLI+vk23ywXr4B/MeLpGyyGWGITV94E1HPdhAILn/w/ecpocBf3uD+8y7KkKdZWU
         sS/FUJDZppy/0iUB8ejuUzDLRPMZA9exvusIkoaGew54zpuZypZnY/npXu1UWBrR8tsM
         K4YS7DxkgE1ZzCW9xavrx411ohQU0PcUytEPKNo6sbXHW40NTcAP5xaWEbp8FxSb06A+
         wyjw==
X-Gm-Message-State: AOUpUlF17PlTvZlKkIKOzXDhsf8P/rHqW2BM4VYsfBHWjI4dJrqgZtL3
        TXcoCxt48Ugje/t2w253ySNzMHDQJr1QjhYL
X-Google-Smtp-Source: AA+uWPzxNzRArdLAKuWYB96i4ehDj6H6B7SGw0A89ehxmR1wSvQ/F/Gs8sU1tqiiMI0+NCp6UkLkfw==
X-Received: by 2002:a62:429c:: with SMTP id h28-v6mr36127005pfd.51.1535002474232;
        Wed, 22 Aug 2018 22:34:34 -0700 (PDT)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id k23-v6sm3606944pgl.42.2018.08.22.22.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 22:34:33 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Loongon64: DMA functions cleanup
Date:   Thu, 23 Aug 2018 13:33:10 +0800
Message-Id: <1535002390-21966-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Split the common dma.c which shared by Loongson-2E and Loongson-2F,
since the code in 'common' directory is assumed be shared by all 64bit
Loongson platforms (but Loongson-3 doesn't use it now). By the way,
Loongson-2E and Loongson-2F have already dropped 32bit kernel support,
so CONFIG_64BIT isn't needed.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/common/Makefile     |  1 -
 arch/mips/loongson64/common/dma.c        | 18 ------------------
 arch/mips/loongson64/fuloong-2e/Makefile |  2 +-
 arch/mips/loongson64/fuloong-2e/dma.c    | 12 ++++++++++++
 arch/mips/loongson64/lemote-2f/Makefile  |  2 +-
 arch/mips/loongson64/lemote-2f/dma.c     | 14 ++++++++++++++
 6 files changed, 28 insertions(+), 21 deletions(-)
 delete mode 100644 arch/mips/loongson64/common/dma.c
 create mode 100644 arch/mips/loongson64/fuloong-2e/dma.c
 create mode 100644 arch/mips/loongson64/lemote-2f/dma.c

diff --git a/arch/mips/loongson64/common/Makefile b/arch/mips/loongson64/common/Makefile
index 57ee030..684624f 100644
--- a/arch/mips/loongson64/common/Makefile
+++ b/arch/mips/loongson64/common/Makefile
@@ -6,7 +6,6 @@
 obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
     bonito-irq.o mem.o machtype.o platform.o serial.o
 obj-$(CONFIG_PCI) += pci.o
-obj-$(CONFIG_CPU_LOONGSON2) += dma.o
 
 #
 # Serial port support
diff --git a/arch/mips/loongson64/common/dma.c b/arch/mips/loongson64/common/dma.c
deleted file mode 100644
index 48f0412..0000000
--- a/arch/mips/loongson64/common/dma.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/dma-direct.h>
-
-dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
-{
-	return paddr | 0x80000000;
-}
-
-phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
-{
-#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
-	if (dma_addr > 0x8fffffff)
-		return dma_addr;
-	return dma_addr & 0x0fffffff;
-#else
-	return dma_addr & 0x7fffffff;
-#endif
-}
diff --git a/arch/mips/loongson64/fuloong-2e/Makefile b/arch/mips/loongson64/fuloong-2e/Makefile
index b762272..0a9a472 100644
--- a/arch/mips/loongson64/fuloong-2e/Makefile
+++ b/arch/mips/loongson64/fuloong-2e/Makefile
@@ -2,4 +2,4 @@
 # Makefile for Lemote Fuloong2e mini-PC board.
 #
 
-obj-y += irq.o reset.o
+obj-y += irq.o reset.o dma.o
diff --git a/arch/mips/loongson64/fuloong-2e/dma.c b/arch/mips/loongson64/fuloong-2e/dma.c
new file mode 100644
index 0000000..e122292
--- /dev/null
+++ b/arch/mips/loongson64/fuloong-2e/dma.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-direct.h>
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return paddr | 0x80000000;
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr & 0x7fffffff;
+}
diff --git a/arch/mips/loongson64/lemote-2f/Makefile b/arch/mips/loongson64/lemote-2f/Makefile
index 08b8abc..b5792c3 100644
--- a/arch/mips/loongson64/lemote-2f/Makefile
+++ b/arch/mips/loongson64/lemote-2f/Makefile
@@ -2,7 +2,7 @@
 # Makefile for lemote loongson2f family machines
 #
 
-obj-y += clock.o machtype.o irq.o reset.o ec_kb3310b.o
+obj-y += clock.o machtype.o irq.o reset.o dma.o ec_kb3310b.o
 
 #
 # Suspend Support
diff --git a/arch/mips/loongson64/lemote-2f/dma.c b/arch/mips/loongson64/lemote-2f/dma.c
new file mode 100644
index 0000000..abf0e39
--- /dev/null
+++ b/arch/mips/loongson64/lemote-2f/dma.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-direct.h>
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return paddr | 0x80000000;
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+	if (dma_addr > 0x8fffffff)
+		return dma_addr;
+	return dma_addr & 0x0fffffff;
+}
-- 
2.7.0
