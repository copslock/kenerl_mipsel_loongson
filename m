Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 08:53:43 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:52239 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903562Ab2FSGx2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 08:53:28 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq13so9838055pbb.36
        for <multiple recipients>; Mon, 18 Jun 2012 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gsUCGJvPERNDH611pU7fsyDvDWcQzhYO3mk1/uKPz5c=;
        b=rkEp3qlr+fyasdeqjOQGoFY57UbOBvu0RI/Zh/1z1pKdP7bX2FYpJjbtUpWCmRhF3t
         VRfOzJ9q+/PEmTCYRDaAH150qBvH/SMfVwXVDw+dVyvfl/DYkJOKpl6BZXQQxisxUV4p
         hY807OJu1/1Kq6Ual56VyV7+76MmtZ4jxYAgG2QRKm6RnV0J8EWoqALIFP/ADgTWPAj9
         Jai6BBDw0G8hJ3/2ZFP1PlIQnmLcqC55TfznxSfmgmGqaY3LR6afMZJedrs9y+zaBq9c
         ELz0d3pEoqiYkBGRBHpa49w4EUML6LPEYgO66z99fA4f6vyIH16HThiO3XIJDfsAXnE+
         /RBA==
Received: by 10.68.226.73 with SMTP id rq9mr59581110pbc.145.1340088807089;
        Mon, 18 Jun 2012 23:53:27 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id gk3sm20156319pbc.1.2012.06.18.23.53.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2012 23:53:26 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V2 03/16] MIPS: Loongson 3: Add Lemote-3A machtypes definition.
Date:   Tue, 19 Jun 2012 14:50:11 +0800
Message-Id: <1340088624-25550-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33693
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

Add three Loongson 3 based machine types:
MACH_LEMOTE_A1004 is laptop;
MACH_LEMOTE_A1101 is mini-itx;
MACH_LEMOTE_A1205 is all-in-one machine.

The most significant differrent between A1004 and A1101/A1205 is
the laptop has EC but others don't.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/include/asm/bootinfo.h              |   23 ++++++++++++++---------
 arch/mips/include/asm/mach-loongson/machine.h |    6 ++++++
 arch/mips/loongson/common/machtype.c          |    5 ++++-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 7a51d87..d5da63e 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -61,15 +61,20 @@
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
index 2efd5d9..e377b44 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -25,8 +25,11 @@ static const char *system_types[] = {
 	[MACH_LEMOTE_ML2F7]             "lemote-mengloong-2f-7inches",
 	[MACH_LEMOTE_YL2F89]            "lemote-yeeloong-2f-8.9inches",
 	[MACH_DEXXON_GDIUM2F10]         "dexxon-gdium-2f",
-	[MACH_LEMOTE_NAS]		"lemote-nas-2f",
+	[MACH_LEMOTE_NAS]               "lemote-nas-2f",
 	[MACH_LEMOTE_LL2F]              "lemote-lynloong-2f",
+	[MACH_LEMOTE_A1004]             "lemote-3a-notebook-a1004",
+	[MACH_LEMOTE_A1101]             "lemote-3a-itx-a1101",
+	[MACH_LEMOTE_A1205]             "lemote-2gq-aio-a1205",
 	[MACH_LOONGSON_END]             NULL,
 };
 
-- 
1.7.7.3
