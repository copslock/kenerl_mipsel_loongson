Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Dec 2017 07:51:05 +0100 (CET)
Received: from forward102j.mail.yandex.net ([5.45.198.243]:43549 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990436AbdLIGugp2w7O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Dec 2017 07:50:36 +0100
Received: from mxback4g.mail.yandex.net (mxback4g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:165])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 1BBF55601AAA;
        Sat,  9 Dec 2017 09:50:28 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback4g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id WpIfZwRu89-oRjuXtLv;
        Sat, 09 Dec 2017 09:50:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512802228;
        bh=4Q9PY5Q8LNU0DAYxUo4688wPxQDLk8vDwGzo5tOt3uI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=q2zQM5DJgwnbnqryNGKZuFs4JbRHOJPKmpqXlFpNKKpoez0PudiVuxQF+4OLKYWWG
         GUwWtY1KJAHkJp4WBwK2AzqCFVxkNjmfs83aWbeXdnevIG3gtMV7T8ZZzdD/UTyawX
         bR2/fTbW52wAppBLKWYIEahuQYIByZiuOSjNyT3U=
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id jBC3v0GG1J-oNpafUwN;
        Sat, 09 Dec 2017 09:50:25 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512802226;
        bh=4Q9PY5Q8LNU0DAYxUo4688wPxQDLk8vDwGzo5tOt3uI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=KikD36586n+C6DqsN5J1BQGwCsCcRiBnxgicoYq3cuh3iIsnUIcdEOLjp6ltuSUln
         BtxWl7rpd2weGmATCvjyjqA58Us5vmoW0ZhMlyfuFPQacQkNM9ZmH4p/efkvacNf8J
         fxhw+ApphKBaxaboiMjmi33kl47MiSA+1v/tOn4M=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v4 1/5] MIPS: Lonngson64: Copy kernel command line from arcs_cmdline
Date:   Sat,  9 Dec 2017 14:49:49 +0800
Message-Id: <20171209064953.8984-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171209064953.8984-1-jiaxun.yang@flygoat.com>
References: <20171209064953.8984-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61385
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
index c68c0cc879c6..1edf3a484e6a 100644
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
2.15.0
