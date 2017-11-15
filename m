Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Nov 2017 04:13:07 +0100 (CET)
Received: from forward101j.mail.yandex.net ([IPv6:2a02:6b8:0:801:2::101]:48746
        "EHLO forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbdKODM7vICFf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Nov 2017 04:12:59 +0100
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1d])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id B76781242958;
        Wed, 15 Nov 2017 06:12:50 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback3o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id CSPtKkE6QG-Col4pfAN;
        Wed, 15 Nov 2017 06:12:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1510715570;
        bh=Djv1V5f/ckDgNRjLc2jFVyAExdqbYlB3knOkiblymCM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=SbA0cVMb9gJTdZCcfwGLo9IGvnvI/u7iRM0qGuw/tm1aBzZcVfUR+O7YW3+Qr+RSJ
         EJ0mr+WkuzJsVj+I+VQ2/fMBD74cR6E+QyhDOk4u8TPEihmcKNKgGFRjypGHEbN/PZ
         ZQ15akP9cugyPtOgRiiAsypu+tuZRcNIOw3NH8ms=
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id sPMPJaqN4J-Ckc4S2WO;
        Wed, 15 Nov 2017 06:12:49 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1510715569;
        bh=Djv1V5f/ckDgNRjLc2jFVyAExdqbYlB3knOkiblymCM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=QaDbuN8R0+22MxPuu8ryPJ9XTRYO+lKi9y8UVRGkHFHzGijwJb4MbPxhZiKzaOB/Q
         OnkUJuo44cU8hfib7LX1WnFciM1GmFBY1ed/zibt2oXROL2DuBAh/70M5Z+hKMzIln
         5b7VDtYbPW+nfdiehrD2vt9LJM12uHh1hhjotwwI=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 1/4] MIPS: Lonngson64: Copy kernel command line from arcs_cmdline
Date:   Wed, 15 Nov 2017 11:11:52 +0800
Message-Id: <20171115031155.643-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20171112063617.26546-1-jiaxun.yang@flygoat.com>
References: <20171112063617.26546-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60949
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
to fix that issue.

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
