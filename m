Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 14:48:50 +0200 (CEST)
Received: from mail-da0-f52.google.com ([209.85.210.52]:53697 "EHLO
        mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834987Ab3DOMrqjPDY5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 14:47:46 +0200
Received: by mail-da0-f52.google.com with SMTP id f10so2061040dak.39
        for <multiple recipients>; Mon, 15 Apr 2013 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Dj9JrJAz3yR/NeUF9qmQxtJMeK7GVwDVSsv5taSrR+s=;
        b=KBi3Gx1eYbsIPqs48esUuKg0JZgn5ncVkhz6PmRyYPLpXNujz/tZHQSyBCPBeBvnSD
         oWswuYYu3JLHwVs6DNv1I2KmW+mR6gJcUUQ+EUiF262uuApUOJvjFjYheYY85ydlJlYk
         pz5q68UmuYPfWyKbS3dBj0EwolpyavLnYeCCDWoqEvJLoT5/1M2UsqQL2nPnm5pSpb4/
         3SDzSHJ7FjUJ4QvD5JbZy4KwuDVFzy2EP/B2HGaJQ6Vyg5WwaKiLaXSwBcLr6Yp9fhmo
         BHo3QdfBCVzCFQOotbLj83YxUlsn0+YhBSfau3zLIuGK+yUhwhBP/g3xy6LwvXkow45K
         5UpQ==
X-Received: by 10.68.1.138 with SMTP id 10mr29294816pbm.136.1366030059932;
        Mon, 15 Apr 2013 05:47:39 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id xz4sm20242580pbb.18.2013.04.15.05.47.35
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 05:47:38 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V10 04/13] MIPS: Loongson 3: Add Lemote-3A machtypes definition
Date:   Mon, 15 Apr 2013 20:46:59 +0800
Message-Id: <1366030028-5084-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36185
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
 arch/mips/loongson/common/machtype.c          |    4 ++++
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index b71dd5b..f94bc97 100644
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
-#define MACH_LEMOTE_NAS	       6
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
index 3810d5c..1b1f592 100644
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
index 4becd4f..1a47979 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -27,6 +27,10 @@ static const char *system_types[] = {
 	[MACH_DEXXON_GDIUM2F10]		"dexxon-gdium-2f",
 	[MACH_LEMOTE_NAS]		"lemote-nas-2f",
 	[MACH_LEMOTE_LL2F]		"lemote-lynloong-2f",
+	[MACH_LEMOTE_A1004]		"lemote-3a-notebook-a1004",
+	[MACH_LEMOTE_A1101]		"lemote-3a-itx-a1101",
+	[MACH_LEMOTE_A1201]		"lemote-2gq-notebook-a1201",
+	[MACH_LEMOTE_A1205]		"lemote-2gq-aio-a1205",
 	[MACH_LOONGSON_END]		NULL,
 };
 
-- 
1.7.7.3
