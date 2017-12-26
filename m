Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 14:26:12 +0100 (CET)
Received: from forward106o.mail.yandex.net ([IPv6:2a02:6b8:0:1a2d::609]:39538
        "EHLO forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990718AbdLZNYjYKInd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 14:24:39 +0100
Received: from mxback2g.mail.yandex.net (mxback2g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:163])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id CBFC8781720;
        Tue, 26 Dec 2017 16:24:32 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback2g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id EEZDh1O7rc-OWNC16TG;
        Tue, 26 Dec 2017 16:24:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514294672;
        bh=cfShhEPjYM+77IZqPkmWdtICEvpgM6fGc31ChtaoROM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=SJFL5uk7rQbcnvbPGGpYQWf45fK1Z2cIsJNVvOGe9zQM0+TCJKAumpnu5ol2hTmTu
         pksh1a/6IKZrqzSoPS0hD/sJoGk+xadJVJ5H1XfY5gX4fT0EukYrVb+fc5clMfBaAv
         D+bqYOgUKuor//nX5sP11hvFznCt6lWuF04PiQag=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Ful6zNDKwE-OSki3Wao;
        Tue, 26 Dec 2017 16:24:31 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514294671;
        bh=cfShhEPjYM+77IZqPkmWdtICEvpgM6fGc31ChtaoROM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=eTYEmaCQzu/wZQumNO8J0V7P9m99Ii1Eu+zQsvCtGq/YYC7Zk64gqgod/3u3ZredM
         Hegt2nQYcS57rfa3gauq9PyRUtxc/j2ecLdPZh/C1c2FrLFmq/G3TE3AocapqQgrR6
         qyHqXTDsjp5d1Sr3noCFRQFd9jWXWyt7cApGXC5Q=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 5/7] MIPS: Loongson64: cleanup all loongson-3 files to use SPDX Identifier
Date:   Tue, 26 Dec 2017 21:23:37 +0800
Message-Id: <20171226132339.7356-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61603
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
+/* SPDX-License-Identifier: GPL-2.0 */
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
+/* SPDX-License-Identifier: GPL-2.0 */
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
+/* SPDX-License-Identifier: GPL-2.0 */
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
+/* SPDX-License-Identifier: GPL-2.0 */
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
