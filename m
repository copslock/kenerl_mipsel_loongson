Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 14:25:47 +0100 (CET)
Received: from forward105j.mail.yandex.net ([5.45.198.248]:55548 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdLZNYgE0Mph (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 14:24:36 +0100
Received: from mxback12g.mail.yandex.net (mxback12g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:91])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id 0038F1810B3;
        Tue, 26 Dec 2017 16:24:28 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback12g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id eoLllHMLzn-OLXKBAto;
        Tue, 26 Dec 2017 16:24:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514294661;
        bh=JCwNWXDafUHlVjCAs9RhexAkmG9XyBBVIcTCCo1pgLc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=oqr1CIkloLAUkFDHX6nfsKHWBgX4Pjoz5S+Np8y5cggcuOc4dzB2BGDOWKZSrcDCq
         JRdZg+9LbdD4j29xOlKhweaqr+6xwiBwINiwJ/xB9yLqlkTg4DU7RKwHX658/A62Ts
         2FFeZryawEDfcE/b8l2ZwBdbQWTrmzJBRfgDf3lc=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Ful6zNDKwE-OGkiqE0Y;
        Tue, 26 Dec 2017 16:24:19 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514294660;
        bh=JCwNWXDafUHlVjCAs9RhexAkmG9XyBBVIcTCCo1pgLc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=BzRw61s7baREUVzHnwOcLT6QlBZArXMy45A2iItfF0g97Nkz7bjUxHPs3OSUx1TBH
         Xj5E6ydx4RYcqaKKlNhC01v+PdcNdTCnfZe/jLMgv7hsYDOb84Tlxg57OPd4/+S424
         Cpniqmj4uDKqd2n+M8obZdWpR62RANwNetozZPOw=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/7] MIPS: Loongson64: cleanup all lemote-2f files to use SPDX Identifier
Date:   Tue, 26 Dec 2017 21:23:36 +0800
Message-Id: <20171226132339.7356-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61602
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

To reduce unnecessary license text.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/loongson64/lemote-2f/Makefile     | 1 +
 arch/mips/loongson64/lemote-2f/clock.c      | 5 ++---
 arch/mips/loongson64/lemote-2f/ec_kb3310b.c | 6 ++----
 arch/mips/loongson64/lemote-2f/irq.c        | 6 ++----
 arch/mips/loongson64/lemote-2f/machtype.c   | 6 ++----
 arch/mips/loongson64/lemote-2f/pm.c         | 6 ++----
 arch/mips/loongson64/lemote-2f/reset.c      | 6 ++----
 7 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/mips/loongson64/lemote-2f/Makefile b/arch/mips/loongson64/lemote-2f/Makefile
index 31c90737b98c..d81fdf50eaa4 100644
--- a/arch/mips/loongson64/lemote-2f/Makefile
+++ b/arch/mips/loongson64/lemote-2f/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for lemote loongson2f family machines
 #
diff --git a/arch/mips/loongson64/lemote-2f/clock.c b/arch/mips/loongson64/lemote-2f/clock.c
index 8281334df9c8..f8847e78a03e 100644
--- a/arch/mips/loongson64/lemote-2f/clock.c
+++ b/arch/mips/loongson64/lemote-2f/clock.c
@@ -1,10 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Copyright (C) 2006 - 2008 Lemote Inc. & Institute of Computing Technology
  * Author: Yanhua, yanh@lemote.com
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
diff --git a/arch/mips/loongson64/lemote-2f/ec_kb3310b.c b/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
index 6e416d55b42a..7b0b5727aaba 100644
--- a/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
+++ b/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
@@ -1,13 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Basic KB3310B Embedded Controller support for the YeeLoong 2F netbook
  *
  *  Copyright (C) 2008 Lemote Inc.
  *  Author: liujl <liujl@lemote.com>, 2008-04-20
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include <linux/io.h>
diff --git a/arch/mips/loongson64/lemote-2f/irq.c b/arch/mips/loongson64/lemote-2f/irq.c
index 9e33e45aa17c..6db9800bdfba 100644
--- a/arch/mips/loongson64/lemote-2f/irq.c
+++ b/arch/mips/loongson64/lemote-2f/irq.c
@@ -1,11 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Copyright (C) 2007 Lemote Inc.
  * Author: Fuxin Zhang, zhangfx@lemote.com
  *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
  */
 
 #include <linux/export.h>
diff --git a/arch/mips/loongson64/lemote-2f/machtype.c b/arch/mips/loongson64/lemote-2f/machtype.c
index b55e6eece5e0..2f0f11811d45 100644
--- a/arch/mips/loongson64/lemote-2f/machtype.c
+++ b/arch/mips/loongson64/lemote-2f/machtype.c
@@ -1,11 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 #include <asm/bootinfo.h>
 
diff --git a/arch/mips/loongson64/lemote-2f/pm.c b/arch/mips/loongson64/lemote-2f/pm.c
index 0768739155f6..f7e8318424b6 100644
--- a/arch/mips/loongson64/lemote-2f/pm.c
+++ b/arch/mips/loongson64/lemote-2f/pm.c
@@ -1,13 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  *  Lemote loongson2f family machines' specific suspend support
  *
  *  Copyright (C) 2009 Lemote Inc.
  *  Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include <linux/suspend.h>
diff --git a/arch/mips/loongson64/lemote-2f/reset.c b/arch/mips/loongson64/lemote-2f/reset.c
index 2b72b197c51d..26ff59df5c48 100644
--- a/arch/mips/loongson64/lemote-2f/reset.c
+++ b/arch/mips/loongson64/lemote-2f/reset.c
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /* Board-specific reboot/shutdown routines
  *
  * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
@@ -5,10 +7,6 @@
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <linux/io.h>
-- 
2.15.1
