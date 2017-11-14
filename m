Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 02:27:43 +0100 (CET)
Received: from forward104o.mail.yandex.net ([IPv6:2a02:6b8:0:1a2d::607]:38665
        "EHLO forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990431AbdKNB1gU6GMW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 02:27:36 +0100
Received: from mxback5g.mail.yandex.net (mxback5g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:166])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id DF2B1701B73;
        Tue, 14 Nov 2017 04:27:25 +0300 (MSK)
Received: from smtp4j.mail.yandex.net (smtp4j.mail.yandex.net [2a02:6b8:0:1619::15:6])
        by mxback5g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id GYgZpyeWrS-RPseti9N;
        Tue, 14 Nov 2017 04:27:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1510622845;
        bh=RHohLWrIj431ruRKQuaOKafDRUi8dbu8FT4pvjo8kUc=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=gQ4M9jwy8186tSywwytL6Is1MyR63GyqvmCvz2FhUTz1YBka0AwgO4pnbxvR5KehT
         9rgX+wLGZ6avbg7u4dhoIKSvmFdgBMuA3coCwibRi9Rfb/DQbs5S5KOGp+c9F3E9MZ
         +GJt2AwPS92IbCOgnr0rtg6ISPt496eT/aXE3VnE=
Received: by smtp4j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 7l823DlZ0a-RDhC4fGh;
        Tue, 14 Nov 2017 04:27:17 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1510622844;
        bh=RHohLWrIj431ruRKQuaOKafDRUi8dbu8FT4pvjo8kUc=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=MEhy7LoMyz1H4lb+i9L73X622RRnfSPH55uEj3LFz9PeZMxNmwTDUAhlfyU7+wZGY
         2GUBW66JzdqiPadoO+5jxZQ5ftjQg/unTDR/zVRqddCZGibOj2CmmTwVpBQhR7Ms5D
         R4GV7QAjDYVstUzm31MTRCa0hBRm3Q9hRJgPROYY=
Authentication-Results: smtp4j.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 1/4] MIPS: Lonngson64: Copy kernel command line from arcs_cmdline
Date:   Tue, 14 Nov 2017 09:26:46 +0800
Message-Id: <20171114012649.29625-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.14.1
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60887
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
2.14.1
