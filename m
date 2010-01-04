Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 10:17:45 +0100 (CET)
Received: from mail-yw0-f182.google.com ([209.85.211.182]:60952 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493167Ab0ADJRa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2010 10:17:30 +0100
Received: by ywh12 with SMTP id 12so15942361ywh.21
        for <multiple recipients>; Mon, 04 Jan 2010 01:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=NdxxoCGiXy8NAIyTCaMqSPt0YOmU89Q7iPwtSBH1NaU=;
        b=InWL0ano7UhIGXjN+pEvEFD8ZHJ8WQI7zcmXb7NpWOLD1qv8JCqns94Bl+gsMqN9a9
         UrCviFS0RwqtDtHAG4MnOXUIhEnA1D1M1bhX4teDGdyAW+VIXIH6E3QpQeHPfZbW29Ju
         Ps/65hK8dVh38cwFUm61WvqFy6vzlS1VEHh3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GG/mIKKqCEK+WAn1JDotOW/DVnM3LH42PHFPVnJrv8YKDjm5wtvYVuDqQQB2Hle/F0
         UKLTYYfUpS6QkcOGWGgchmba0tXmWrLTqJ4rfdujYGfnRg/gStzpxLTV154Wzw+Y/IP3
         dQV6rWOJ4CivNIn3Rwvi1whOqaTEq7xhDaPYI=
Received: by 10.150.104.11 with SMTP id b11mr2562011ybc.235.1262596643451;
        Mon, 04 Jan 2010 01:17:23 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm6122077ywh.16.2010.01.04.01.17.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 01:17:21 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
        zhangfx@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 01/10] Loongson: Lemote-2F: Get the machine type from PMON_VER
Date:   Mon,  4 Jan 2010 17:16:43 +0800
Message-Id: <f4aeb125cb030f10d34966febfe9715874d52ab2.1262596493.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
In-Reply-To: <cover.1262586650.git.wuzhangjin@gmail.com>
References: <cover.1262586650.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262596493.git.wuzhangjin@gmail.com>
X-archive-position: 25499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2260

From: Wu Zhangjin <wuzhangjin@gmail.com>

Lemote have used the PMON_VER strings to indicate the loongson-2f
machine series:

 	PMON_VER=LM8089		Lemote 8.9'' netbook
 	         LM8101		Lemote 10.1'' netbook
 	(The above two netbooks have the same kernel support)
	         LM6XXX		Lemote FuLoong(2F) box series
	         LM9XXX		Lemote LynLoong PC series

Before the machtype is supported by the PMON, we can get the machine
type from the PMON_VER for these machines, this will help the users a
lot.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/machtype.c    |   10 +++++-
 arch/mips/loongson/lemote-2f/Makefile   |    1 +
 arch/mips/loongson/lemote-2f/machtype.c |   45 +++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/machtype.c

diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 0ed52b3..3799098 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzj@lemote.com
  *
  * Copyright (c) 2009 Zhang Le <r0bertz@gentoo.org>
@@ -35,6 +35,10 @@ const char *get_system_type(void)
 	return system_types[mips_machtype];
 }
 
+void __weak __init mach_prom_init_machtype(void)
+{
+}
+
 void __init prom_init_machtype(void)
 {
 	char *p, str[MACHTYPE_LEN];
@@ -43,8 +47,10 @@ void __init prom_init_machtype(void)
 	mips_machtype = LOONGSON_MACHTYPE;
 
 	p = strstr(arcs_cmdline, "machtype=");
-	if (!p)
+	if (!p) {
+		mach_prom_init_machtype();
 		return;
+	}
 	p += strlen("machtype=");
 	strncpy(str, p, MACHTYPE_LEN);
 	p = strstr(str, " ");
diff --git a/arch/mips/loongson/lemote-2f/Makefile b/arch/mips/loongson/lemote-2f/Makefile
index 4d84b27..01f71b1 100644
--- a/arch/mips/loongson/lemote-2f/Makefile
+++ b/arch/mips/loongson/lemote-2f/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-y += irq.o reset.o ec_kb3310b.o
+obj-y += machtype.o irq.o reset.o ec_kb3310b.o
 
 #
 # Suspend Support
diff --git a/arch/mips/loongson/lemote-2f/machtype.c b/arch/mips/loongson/lemote-2f/machtype.c
new file mode 100644
index 0000000..610f431
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/machtype.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <asm/bootinfo.h>
+
+#include <loongson.h>
+
+void __init mach_prom_init_machtype(void)
+{
+	/* We share the same kernel image file among Lemote 2F family
+	 * of machines, and provide the machtype= kernel command line
+	 * to users to indicate their machine, this command line will
+	 * be passed by the latest PMON automatically. and fortunately,
+	 * up to now, we can get the machine type from the PMON_VER=
+	 * commandline directly except the NAS machine, In the old
+	 * machines, this will help the users a lot.
+	 *
+	 * If no "machtype=" passed, get machine type from "PMON_VER=".
+	 * 	PMON_VER=LM8089		Lemote 8.9'' netbook
+	 * 	         LM8101		Lemote 10.1'' netbook
+	 * 	(The above two netbooks have the same kernel support)
+	 *	         LM6XXX		Lemote FuLoong(2F) box series
+	 *	         LM9XXX		Lemote LynLoong PC series
+	 */
+	if (strstr(arcs_cmdline, "PMON_VER=LM")) {
+		if (strstr(arcs_cmdline, "PMON_VER=LM8"))
+			mips_machtype = MACH_LEMOTE_YL2F89;
+		else if (strstr(arcs_cmdline, "PMON_VER=LM6"))
+			mips_machtype = MACH_LEMOTE_FL2F;
+		else if (strstr(arcs_cmdline, "PMON_VER=LM9"))
+			mips_machtype = MACH_LEMOTE_LL2F;
+		else
+			mips_machtype = MACH_LEMOTE_NAS;
+
+		strcat(arcs_cmdline, " machtype=");
+		strcat(arcs_cmdline, get_system_type());
+		strcat(arcs_cmdline, " ");
+	}
+}
-- 
1.6.5.6
