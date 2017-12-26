Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 14:27:03 +0100 (CET)
Received: from forward105j.mail.yandex.net ([5.45.198.248]:55996 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991100AbdLZNYs7Cc-l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 14:24:48 +0100
Received: from mxback11g.mail.yandex.net (mxback11g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:90])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id 882C418343A;
        Tue, 26 Dec 2017 16:24:43 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback11g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id jD7sOf8Zmk-OhZKssKq;
        Tue, 26 Dec 2017 16:24:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514294683;
        bh=c4IueRfJaEOUf5lB12bm66iNADrw4rHsYD+3bNV4FOw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=d4Qw5n6vyuh9Z51hIJsd57cWiu1CYves2gJ1dh1WcnPxJ4w97yY8UP7dhvbdoMBF3
         BiIFVfSNDMimFPwCO2t+sceUK6MBIbaOw9/gMBzsAAFa9kc8w2pb5xe9gXigE0P9EJ
         JpxraIvFtJwnCs7nJKiBiw8N09rzA/M3wa5LIzG4=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Ful6zNDKwE-Ock8LsM8;
        Tue, 26 Dec 2017 16:24:41 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514294682;
        bh=c4IueRfJaEOUf5lB12bm66iNADrw4rHsYD+3bNV4FOw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=LP2hUuK9wk1mufsoJgWXJc0PaMohWezAHWz40Iywy+kk9G1NJ8E/A9Bvr1DG+Me+Y
         334yVr372Gp3+cgc5CoMBSHpIMQKMQ4xqmXaQdl9IMMq8Nbty/3jVIp9/bZsbqlyX5
         Ern43uZIpmu6ykNzgOqpqL9RWFTSCkZBmAcvMPe4=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 7/7] MIPS: Loongson64: cleanup all include files to use SPDX Identifier
Date:   Tue, 26 Dec 2017 21:23:39 +0800
Message-Id: <20171226132339.7356-8-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61605
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
 arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h | 5 ++---
 arch/mips/include/asm/mach-loongson64/dma-coherence.h         | 6 ++----
 arch/mips/include/asm/mach-loongson64/ec_kb3310b.h            | 6 ++----
 arch/mips/include/asm/mach-loongson64/kernel-entry-init.h     | 6 ++----
 arch/mips/include/asm/mach-loongson64/loongson.h              | 6 ++----
 arch/mips/include/asm/mach-loongson64/machine.h               | 6 ++----
 arch/mips/include/asm/mach-loongson64/mc146818rtc.h           | 5 ++---
 arch/mips/include/asm/mach-loongson64/mem.h                   | 6 ++----
 arch/mips/include/asm/mach-loongson64/mmzone.h                | 6 ++----
 arch/mips/include/asm/mach-loongson64/pci.h                   | 7 ++-----
 10 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index 581915ce231c..385a75134cae 100644
--- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
@@ -1,7 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  *
  * Copyright (C) 2009 Wu Zhangjin <wuzhangjin@gmail.com>
  * Copyright (C) 2009 Philippe Vachon <philippe@cowpig.ca>
diff --git a/arch/mips/include/asm/mach-loongson64/dma-coherence.h b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
index 1602a9e9e8c2..af52c7e6f64d 100644
--- a/arch/mips/include/asm/mach-loongson64/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
@@ -1,8 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Copyright (C) 2006, 07  Ralf Baechle <ralf@linux-mips.org>
  * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
diff --git a/arch/mips/include/asm/mach-loongson64/ec_kb3310b.h b/arch/mips/include/asm/mach-loongson64/ec_kb3310b.h
index 2e8690532ea5..daf1538c415c 100644
--- a/arch/mips/include/asm/mach-loongson64/ec_kb3310b.h
+++ b/arch/mips/include/asm/mach-loongson64/ec_kb3310b.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * KB3310B Embedded Controller
  *
@@ -6,10 +8,6 @@
  *  Copyright (C) 2009 Lemote Inc.
  *  Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #ifndef _EC_KB3310B_H
diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
index 8393bc548987..c19d319828a8 100644
--- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
@@ -1,8 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Copyright (C) 2005 Embedded Alley Solutions, Inc
  * Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 2009 Jiajie Chen (chenjiajie@cse.buaa.edu.cn)
diff --git a/arch/mips/include/asm/mach-loongson64/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
index d0ae5d55413b..7102ac0edcc6 100644
--- a/arch/mips/include/asm/mach-loongson64/loongson.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson.h
@@ -1,11 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #ifndef __ASM_MACH_LOONGSON64_LOONGSON_H
diff --git a/arch/mips/include/asm/mach-loongson64/machine.h b/arch/mips/include/asm/mach-loongson64/machine.h
index c52549bb4e56..60df03d63a8b 100644
--- a/arch/mips/include/asm/mach-loongson64/machine.h
+++ b/arch/mips/include/asm/mach-loongson64/machine.h
@@ -1,11 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #ifndef __ASM_MACH_LOONGSON64_MACHINE_H
diff --git a/arch/mips/include/asm/mach-loongson64/mc146818rtc.h b/arch/mips/include/asm/mach-loongson64/mc146818rtc.h
index ebdccfee50be..873ea5a9d0d2 100644
--- a/arch/mips/include/asm/mach-loongson64/mc146818rtc.h
+++ b/arch/mips/include/asm/mach-loongson64/mc146818rtc.h
@@ -1,7 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  *
  * Copyright (C) 1998, 2001, 03, 07 by Ralf Baechle (ralf@linux-mips.org)
  *
diff --git a/arch/mips/include/asm/mach-loongson64/mem.h b/arch/mips/include/asm/mach-loongson64/mem.h
index 75c16bead536..b59bfdb36502 100644
--- a/arch/mips/include/asm/mach-loongson64/mem.h
+++ b/arch/mips/include/asm/mach-loongson64/mem.h
@@ -1,11 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #ifndef __ASM_MACH_LOONGSON64_MEM_H
diff --git a/arch/mips/include/asm/mach-loongson64/mmzone.h b/arch/mips/include/asm/mach-loongson64/mmzone.h
index c9f7e231e66b..5f1c5c1dc7b3 100644
--- a/arch/mips/include/asm/mach-loongson64/mmzone.h
+++ b/arch/mips/include/asm/mach-loongson64/mmzone.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Copyright (C) 2010 Loongson Inc. & Lemote Inc. &
  *                    Institute of Computing Technology
@@ -5,10 +7,6 @@
  *          Huacai Chen, chenhc@lemote.com
  *          Xiaofu Meng, Shuangshuang Zhang
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 #ifndef _ASM_MACH_MMZONE_H
 #define _ASM_MACH_MMZONE_H
diff --git a/arch/mips/include/asm/mach-loongson64/pci.h b/arch/mips/include/asm/mach-loongson64/pci.h
index 3401f557434a..2d4731bce3b9 100644
--- a/arch/mips/include/asm/mach-loongson64/pci.h
+++ b/arch/mips/include/asm/mach-loongson64/pci.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Copyright (c) 2008 Zhang Le <r0bertz@gentoo.org>
  * Copyright (c) 2009 Wu Zhangjin <wuzhangjin@gmail.com>
  *
- * This program is free software; you can redistribute it
- * and/or modify it under the terms of the GNU General
- * Public License as published by the Free Software
- * Foundation; either version 2 of the License, or (at your
- * option) any later version.
  */
 
 #ifndef __ASM_MACH_LOONGSON64_PCI_H_
-- 
2.15.1
