Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Dec 2017 15:58:49 +0100 (CET)
Received: from forward100p.mail.yandex.net ([77.88.28.100]:52798 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990765AbdLPO6QoVw9S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Dec 2017 15:58:16 +0100
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1d])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id B550651042E3;
        Sat, 16 Dec 2017 17:58:10 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback3o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id K2C5p5h3tq-wAbSgqvQ;
        Sat, 16 Dec 2017 17:58:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1513436290;
        bh=t+bUxsDTW18ugUtp8HpRNPyeI6rs5TqwcstO11/SXIk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=bOpWI/aRKLSec4Gu5G33PmK3NtoQ6O6bEl8BYJ2Gmom91VaVT5T9YuC/ybMu1zsqA
         5u2umi5YpqguTFG07ouRRNBzZzNhl4CBXWLoOQqeYUxbce0Y4070BWv1WiYz01WH95
         m+h5vJVxLEDMciAlDYwbzVUgNKfBfFTskKb82aio=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 6waszUSHIG-w6saqAiC;
        Sat, 16 Dec 2017 17:58:08 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1513436289;
        bh=t+bUxsDTW18ugUtp8HpRNPyeI6rs5TqwcstO11/SXIk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=hA7BjJQXLmluXIZ1GEQJS0fydyczT1jaI25YfF0dx0Wg2GBTRHfKoNnRYw0lMxuFc
         +QjX2nrhi8ijazgXjUE6I+P6whjEj4QLbs9Em24MOah5Ag/rO+NF0E+dWTNgYcXIgf
         3xLFBHViT5nxL9pWY/ZYsJu9ovUkhaTnGDuFKhY4=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Huacai Chan <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v5 1/5] MIPS: Lonngson64: Copy kernel command line from arcs_cmdline
Date:   Sat, 16 Dec 2017 22:57:47 +0800
Message-Id: <20171216145751.3486-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171216145751.3486-1-jiaxun.yang@flygoat.com>
References: <20171216145751.3486-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

Since lemote-2f/marchtype.c need to get cmdline from loongson.h
this patch simply copy kernel command line from arcs_cmdline
to fix that issue

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mach-loongson64/loongson.h | 6 ++++++
 arch/mips/loongson64/common/cmdline.c            | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/mips/include/asm/mach-loongson64/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
index d0ae5d55413b..39876e28b8b2 100644
--- a/arch/mips/include/asm/mach-loongson64/loongson.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson.h
@@ -45,6 +45,12 @@ static inline void prom_init_uart_base(void)
 #endif
 }
 
+/*
+ * Copy kernel command line from arcs_cmdline
+ */
+#include <asm/setup.h>
+extern char loongson_cmdline[COMMAND_LINE_SIZE];
+
 /* irq operation functions */
 extern void bonito_irqdispatch(void);
 extern void __init bonito_irq_init(void);
diff --git a/arch/mips/loongson64/common/cmdline.c b/arch/mips/loongson64/common/cmdline.c
index 01fbed137028..49e172184e15 100644
--- a/arch/mips/loongson64/common/cmdline.c
+++ b/arch/mips/loongson64/common/cmdline.c
@@ -21,6 +21,11 @@
 
 #include <loongson.h>
 
+/* the kernel command line copied from arcs_cmdline */
+#include <linux/export.h>
+char loongson_cmdline[COMMAND_LINE_SIZE];
+EXPORT_SYMBOL(loongson_cmdline);
+
 void __init prom_init_cmdline(void)
 {
 	int prom_argc;
@@ -45,4 +50,6 @@ void __init prom_init_cmdline(void)
 	}
 
 	prom_init_machtype();
+	/* copy arcs_cmdline into loongson_cmdline */
+	strncpy(loongson_cmdline, arcs_cmdline, COMMAND_LINE_SIZE);
 }
-- 
2.15.1
