Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:49:34 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:48628 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825700Ab2JWRsCIykr5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:48:02 +0200
Received: by mail-lb0-f177.google.com with SMTP id gi11so520790lbb.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7fNihtDmco4Xy1RL3kDnFzVzPN5vC7OZompxmgn2v4I=;
        b=lP7tJKWX7qDIG4C8UFw74OvQqelpaLgJ1mvoISr8zTdpc8znS1R9RVbLhG0Hl+x+c1
         DJSOIK2Ejrxq1qwCloXvxTrdqqTYHSpEXZI4/aG5L+qwIi2uyFlVDUWxQwBEJXg7L/mZ
         x2mup8PpVRb1tiC7RxnXQcRMLUAfAqG6f1ngow2nWV1UQoUHXeVNSkqwOEzZF6Z1ef6Z
         z4QadsqUUXwtsQNelaBJYQSMqR0ZVWv7VXPcP2f5qkln+yt0BWT26YYf3y+Z/0cGZPoX
         6MBCaksOg5XCKZR4VzKX2FbB1DgP+Xym12bWGxHlLwYGgVqF5pEl1EdTV0/nU8zxIpaF
         9kcw==
Received: by 10.152.133.140 with SMTP id pc12mr11952209lab.53.1351014481582;
        Tue, 23 Oct 2012 10:48:01 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.48.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:48:00 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 07/13] MIPS: JZ4750D: Add setup code
Date:   Tue, 23 Oct 2012 21:43:55 +0400
Message-Id: <1351014241-3207-8-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Add get_system_type for JZ4750D SoCs. Fix memory size to 64M.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/jz4750d/setup.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 arch/mips/jz4750d/setup.c

diff --git a/arch/mips/jz4750d/setup.c b/arch/mips/jz4750d/setup.c
new file mode 100644
index 0000000..e36ed0a
--- /dev/null
+++ b/arch/mips/jz4750d/setup.c
@@ -0,0 +1,35 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D setup code
+ *
+ *  based on JZ4740 setup code
+ *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  Copyright (C) 2011, Maarten ter Huurne <maarten@treewalker.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+
+#include <asm/bootinfo.h>
+
+#include "reset.h"
+
+void __init plat_mem_setup(void)
+{
+	jz4750d_reset_init();
+
+	/* FIXME: the detection of the memory size is skipped */
+	add_memory_region(0, 0x04000000 /* 64 M */, BOOT_MEM_RAM);
+}
+
+const char *get_system_type(void)
+{
+	return "JZ4750D";
+}
-- 
1.7.10.4
