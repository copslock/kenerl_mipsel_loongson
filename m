Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 10:24:07 +0100 (CET)
Received: from forward102o.mail.yandex.net ([37.140.190.182]:57032 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990414AbdLDJXkBZhVe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 10:23:40 +0100
Received: from mxback5j.mail.yandex.net (mxback5j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10e])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id 3C78B5A04199;
        Mon,  4 Dec 2017 12:23:34 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback5j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id X17oPFyXWU-NX9Cqtt2;
        Mon, 04 Dec 2017 12:23:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512379414;
        bh=4Q9PY5Q8LNU0DAYxUo4688wPxQDLk8vDwGzo5tOt3uI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=MImKjqX2wvRQ4+prh0XN6T5fp+mRo6C2nBkglDHiajR5cEYAHygcFKcVtjRardWdz
         GTFryKUgtxiE811pMDS8kA6xw/LpJPetRhpZdilV2Ysq0zAM83RjtLcpSI6OuFFPsP
         OCnABGRbWIEvbpKfmjc6hxE7egiCo7T0mWR7JC44=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 99BorI3ZLs-NUP8Bdnm;
        Mon, 04 Dec 2017 12:23:32 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512379412;
        bh=4Q9PY5Q8LNU0DAYxUo4688wPxQDLk8vDwGzo5tOt3uI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=hR1V10Ul66lO6Tso2/XfsKSW84VT6zEW7r0UVmGFaRzonTb6952+RsLYl/27xP6vt
         nHNhlRYi8CkktPfx4bZP3MoJ49x9l0gXKTxZS1ECd8eqRqDxDM9km2/tbn6slYZhWm
         xCpAJwj3Z7zaXQmmsgyfk6CzS0JZp3tX351P+hqw=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH RESEND v3 1/4] MIPS: Lonngson64: Copy kernel command line from arcs_cmdline
Date:   Mon,  4 Dec 2017 17:23:09 +0800
Message-Id: <20171204092312.11256-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171204092312.11256-1-jiaxun.yang@flygoat.com>
References: <20171204092312.11256-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61283
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
