Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Nov 2017 07:37:07 +0100 (CET)
Received: from forward101p.mail.yandex.net ([77.88.28.101]:53342 "EHLO
        forward101p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdKLGg5tPnrX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Nov 2017 07:36:57 +0100
Received: from mxback8j.mail.yandex.net (mxback8j.mail.yandex.net [IPv6:2a02:6b8:0:1619::111])
        by forward101p.mail.yandex.net (Yandex) with ESMTP id E60AF6A8213C;
        Sun, 12 Nov 2017 09:36:51 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback8j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id pcjraMbhqt-apo8SaHp;
        Sun, 12 Nov 2017 09:36:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1510468611;
        bh=u2a71OzCFWDKUMsYaCqUnWzZxTqvAA+o7X+WvHy2bRs=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=EYC0Spw4jHM56bdaNq1XP5I2NP6RxjSrBbJYJpH5Bk42x77R1cRG3MBzx4KnNgSye
         NWbm2CDhWlcu7HWmVm5Z/s1RDQMRnyNqYlcCHizR2pHKmyb5S0yLRuMl+4gQyyVOXo
         Pz2NVaCUI7J8raQ2gP8r+ZrVjRdOQOxyWHYNzgc8=
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 0pMwdlaAMA-amZWoixv;
        Sun, 12 Nov 2017 09:36:50 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1510468610;
        bh=u2a71OzCFWDKUMsYaCqUnWzZxTqvAA+o7X+WvHy2bRs=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=YNsqavzEQUEaQKcwOX8baGsPXDL+jjQe57O1Toxa4sUT49VgOiRCDXFrhnDD/T8e2
         3pKgssH35lGFl4N1bHKUeMFiBSbhBMI5QD95CWiizxq2PasG9HSJj3NOUcqBUgRj5B
         3vhaQ1OC7+tYD/gmrjLpkLb3e/oTFbe4aGgcUm9w=
Authentication-Results: smtp1p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   jiaxun.yang@flygoat.com
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/4] MIPS: Lonngson64: Copy kernel command line from arcs_cmdline Since lemte-2f/marchtype.c need to get cmdline from loongson.h this patch simply copy kernel command line from arcs_cmdline to fix that issue
Date:   Sun, 12 Nov 2017 14:36:14 +0800
Message-Id: <20171112063617.26546-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.14.1
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60838
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

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
