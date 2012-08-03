Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2012 09:07:59 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:34067 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903520Ab2HCHGw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2012 09:06:52 +0200
Received: by mail-yx0-f177.google.com with SMTP id r9so506866yen.36
        for <multiple recipients>; Fri, 03 Aug 2012 00:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zBxqS9UTO2pY3wBL+2LNV8r+h/uq5FJB335krZzgALg=;
        b=tbqs0S2siLN/Zb9P3U4AftjJE7zyxjv2KUC3+2cl+Ggjzbco2gv2+x5yBN5uf5MQxZ
         Npx4BI7efE3x7Ab2uErVJksWuoNWChXvUMeTlIPonj5hN39gA4Ak+3C9kMH9Xmv4IYeP
         NPAfvgz9J43w29aABuV9UlCXTD6XRgS5btVJ8acQOMtp8s6VTCS09FuhSDyjaJyJxP10
         UvLY3IBYWuEiMg6nJjU/AGBLC6BbA6HnW/Y/U7KLApWCywMrzOZBqN3qaosDhwo8h3Dj
         yPOLLVWe+3cca09100+ey+6VkRdECrESmy9KEAhxLVTqkv+LxvG62E0qmafmkuGc3r+3
         owAQ==
Received: by 10.50.157.196 with SMTP id wo4mr8922371igb.22.1343977611350;
        Fri, 03 Aug 2012 00:06:51 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id z3sm20852677igc.7.2012.08.03.00.06.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 00:06:50 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V4 03/16] MIPS: Loongson 3: Add Lemote-3A machtypes definition.
Date:   Fri,  3 Aug 2012 15:05:58 +0800
Message-Id: <1343977571-2292-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
References: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Add four Loongson-3 based machine types:
MACH_LEMOTE_A1004/MACH_LEMOTE_A1201 are laptops;
MACH_LEMOTE_A1101 is mini-itx;
MACH_LEMOTE_A1205 is all-in-one machine.

The most significant differrent between A1004/A1201 and A1101/A1205 is
the laptops have EC but others don't.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/include/asm/bootinfo.h              |   24 +++++++++++++++---------
 arch/mips/include/asm/mach-loongson/machine.h |    6 ++++++
 arch/mips/loongson/common/machtype.c          |   20 ++++++++++++--------
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 7a51d87..118f525 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -61,15 +61,21 @@
 /*
  * Valid machtype for Loongson family
  */
-#define MACH_LOONGSON_UNKNOWN  0
-#define MACH_LEMOTE_FL2E       1
-#define MACH_LEMOTE_FL2F       2
-#define MACH_LEMOTE_ML2F7      3
-#define MACH_LEMOTE_YL2F89     4
-#define MACH_DEXXON_GDIUM2F10  5
-#define MACH_LEMOTE_NAS        6
-#define MACH_LEMOTE_LL2F       7
-#define MACH_LOONGSON_END      8
+enum loongson_machine_type {
+	MACH_LOONGSON_UNKNOWN,
+	MACH_LEMOTE_FL2E,
+	MACH_LEMOTE_FL2F,
+	MACH_LEMOTE_ML2F7,
+	MACH_LEMOTE_YL2F89,
+	MACH_DEXXON_GDIUM2F10,
+	MACH_LEMOTE_NAS,
+	MACH_LEMOTE_LL2F,
+	MACH_LEMOTE_A1004,
+	MACH_LEMOTE_A1101,
+	MACH_LEMOTE_A1201,
+	MACH_LEMOTE_A1205,
+	MACH_LOONGSON_END
+};
 
 /*
  * Valid machtype for group INGENIC
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index 4321338..481c5d9 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -24,4 +24,10 @@
 
 #endif
 
+#ifdef CONFIG_LEMOTE_MACH3A
+
+#define LOONGSON_MACHTYPE MACH_LEMOTE_A1004
+
+#endif /* CONFIG_LEMOTE_MACH3A */
+
 #endif /* __ASM_MACH_LOONGSON_MACHINE_H */
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 2efd5d9..e13e13d 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -19,15 +19,19 @@
 #define MACHTYPE_LEN 50
 
 static const char *system_types[] = {
-	[MACH_LOONGSON_UNKNOWN]         "unknown loongson machine",
-	[MACH_LEMOTE_FL2E]              "lemote-fuloong-2e-box",
-	[MACH_LEMOTE_FL2F]              "lemote-fuloong-2f-box",
-	[MACH_LEMOTE_ML2F7]             "lemote-mengloong-2f-7inches",
-	[MACH_LEMOTE_YL2F89]            "lemote-yeeloong-2f-8.9inches",
-	[MACH_DEXXON_GDIUM2F10]         "dexxon-gdium-2f",
+	[MACH_LOONGSON_UNKNOWN]		"unknown loongson machine",
+	[MACH_LEMOTE_FL2E]		"lemote-fuloong-2e-box",
+	[MACH_LEMOTE_FL2F]		"lemote-fuloong-2f-box",
+	[MACH_LEMOTE_ML2F7]		"lemote-mengloong-2f-7inches",
+	[MACH_LEMOTE_YL2F89]		"lemote-yeeloong-2f-8.9inches",
+	[MACH_DEXXON_GDIUM2F10]		"dexxon-gdium-2f",
 	[MACH_LEMOTE_NAS]		"lemote-nas-2f",
-	[MACH_LEMOTE_LL2F]              "lemote-lynloong-2f",
-	[MACH_LOONGSON_END]             NULL,
+	[MACH_LEMOTE_LL2F]		"lemote-lynloong-2f",
+	[MACH_LEMOTE_A1004]		"lemote-3a-notebook-a1004",
+	[MACH_LEMOTE_A1101]		"lemote-3a-itx-a1101",
+	[MACH_LEMOTE_A1201]		"lemote-2gq-notebook-a1201",
+	[MACH_LEMOTE_A1205]		"lemote-2gq-aio-a1205",
+	[MACH_LOONGSON_END]		NULL,
 };
 
 const char *get_system_type(void)
-- 
1.7.7.3
