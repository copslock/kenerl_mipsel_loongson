Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jan 2013 14:17:38 +0100 (CET)
Received: from mail-da0-f46.google.com ([209.85.210.46]:37108 "EHLO
        mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816859Ab3A3NRgu22Lx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jan 2013 14:17:36 +0100
Received: by mail-da0-f46.google.com with SMTP id p5so768239dak.19
        for <multiple recipients>; Wed, 30 Jan 2013 05:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=rXpRHthSL8WeMazlyT81I7fgRTqMc7/57ShLmvHBjdU=;
        b=cGTJmh9fdgeFn2eYHSo2z0CA7Md0b5Nc88pdeRveRYCW5czN8uEsWRGrjAcGf7dq7Y
         SlI8sUPSbRNjU8MrdAFsqqOCZ3jmRmrmJTi9rLj3KtuGmNh0926QYWj5AUwfkY9P/oPV
         m5qoJAuZA6+Qz8R6O1nN7gUALErJK8lS+L165VasUv7r7HSavu72fDLpvc5akpVcQ8Q5
         4SzVcZWW3kB67RMGa2wpNr/zVlI6lW4mHQVktkd2vZugsd9wBhEF0kc0YmDKIvJ2QGdz
         x5PBJqykDRZMbNCxAClKlOJ9sYib23KKIjzycFyjHL+vknLLEIU4xkJH0Ox5rVgelTxZ
         wUBw==
X-Received: by 10.68.220.161 with SMTP id px1mr9691162pbc.167.1359527437459;
        Tue, 29 Jan 2013 22:30:37 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id gj1sm612282pbc.11.2013.01.29.22.29.21
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 22:30:36 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V9 04/13] MIPS: Loongson 3: Add Lemote-3A machtypes definition
Date:   Wed, 30 Jan 2013 14:24:57 +0800
Message-Id: <1359527106-22879-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1359527106-22879-1-git-send-email-chenhc@lemote.com>
References: <1359527106-22879-1-git-send-email-chenhc@lemote.com>
X-archive-position: 35634
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
index 4321338..89f6b9a5 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -24,4 +24,10 @@
 
 #endif
 
+#ifdef CONFIG_LEMOTE_MACH3A
+
+#define LOONGSON_MACHTYPE MACH_LEMOTE_A1101
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
