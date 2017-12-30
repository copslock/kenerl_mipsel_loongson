Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 19:30:58 +0100 (CET)
Received: from forward103j.mail.yandex.net ([5.45.198.246]:33836 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990485AbdL3S32iYcNc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Dec 2017 19:29:28 +0100
Received: from mxback3j.mail.yandex.net (mxback3j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10c])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 38CAC34C3EE3;
        Sat, 30 Dec 2017 21:29:23 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback3j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 0RrhuuFG2d-TNM8E0Tm;
        Sat, 30 Dec 2017 21:29:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514658563;
        bh=0grInaLATVgStJlPIr6RyU0wkF4WU16AoZS/V6Jxz8Y=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=aRn+eOJhNn8UcsdkREuczMoy99Nq+bYcpLtlt2jxYHcc/mOb/6djYUQlhfbqdWu3s
         yOjWkc3jKEH6OwljzwXTOakBfzOLFSCyXN6akbjFEZfzkku5v1VwSPUja3lWPVO3bm
         X9i3/3pQIlJ2FF1E6KNHsB9qereny+RnvbbcRZsE=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 6PdmBEypOo-TKT4dft3;
        Sat, 30 Dec 2017 21:29:22 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514658562;
        bh=0grInaLATVgStJlPIr6RyU0wkF4WU16AoZS/V6Jxz8Y=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=kND1x/KWWzbgIAQA5UC7fQhaHGy73VlfuGuz9PSB4IlJijnT3lUawoqbITyqSdt2r
         /JoE2UtQAT4lzsVh3C8nPE4l4DR93hHChJHCHLUoJgW2O3t+i3/dElB7XiuGoeL3Lc
         OtIlRarqiH8hWxh8UyB7Gnk4NFmdlw0eBSXloons=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCHv2 5/8] MIPS: Loongson64: cleanup all loongson-3 files to use SPDX Identifier
Date:   Sun, 31 Dec 2017 02:28:28 +0800
Message-Id: <20171230182830.6496-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171230182830.6496-1-jiaxun.yang@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
 <20171230182830.6496-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61795
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
 arch/mips/loongson64/loongson-3/Makefile   |  1 +
 arch/mips/loongson64/loongson-3/cop2-ex.c  |  5 ++---
 arch/mips/loongson64/loongson-3/numa.c     |  7 ++-----
 arch/mips/loongson64/loongson-3/platform.c |  6 ++----
 arch/mips/loongson64/loongson-3/smp.c      | 12 ++----------
 5 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/Makefile b/arch/mips/loongson64/loongson-3/Makefile
index 44bc1482158b..317f9a4b3ff8 100644
--- a/arch/mips/loongson64/loongson-3/Makefile
+++ b/arch/mips/loongson64/loongson-3/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for Loongson-3 family machines
 #
diff --git a/arch/mips/loongson64/loongson-3/cop2-ex.c b/arch/mips/loongson64/loongson-3/cop2-ex.c
index 621d6af5f6eb..9dae0f539ee5 100644
--- a/arch/mips/loongson64/loongson-3/cop2-ex.c
+++ b/arch/mips/loongson64/loongson-3/cop2-ex.c
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  *
  * Copyright (C) 2014 Lemote Corporation.
  *   written by Huacai Chen <chenhc@lemote.com>
diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
index f17ef520799a..51faecd95f21 100644
--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -1,14 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Copyright (C) 2010 Loongson Inc. & Lemote Inc. &
  *                    Institute of Computing Technology
  * Author:  Xiang Gao, gaoxiang@ict.ac.cn
  *          Huacai Chen, chenhc@lemote.com
  *          Xiaofu Meng, Shuangshuang Zhang
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/mips/loongson64/loongson-3/platform.c b/arch/mips/loongson64/loongson-3/platform.c
index 25a97cc0ee33..908cfa130512 100644
--- a/arch/mips/loongson64/loongson-3/platform.c
+++ b/arch/mips/loongson64/loongson-3/platform.c
@@ -1,13 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *         Xiang Yu, xiangy@lemote.com
  *         Chen Huacai, chenhc@lemote.com
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <linux/err.h>
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 8501109bb0f0..34a86607a011 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Copyright (C) 2010, 2011, 2012, Lemote, Inc.
  * Author: Chen Huacai, chenhc@lemote.com
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 #include <linux/init.h>
-- 
2.15.1
