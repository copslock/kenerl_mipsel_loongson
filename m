Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 19:29:44 +0100 (CET)
Received: from forward105p.mail.yandex.net ([77.88.28.108]:56243 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990412AbdL3S3U30kYc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Dec 2017 19:29:20 +0100
Received: from mxback5o.mail.yandex.net (mxback5o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1f])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 533D74082EE5;
        Sat, 30 Dec 2017 21:29:14 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback5o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id jPx0zSJOlk-SoVuM79r;
        Sat, 30 Dec 2017 21:28:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514658531;
        bh=uVPPgfMEYJNksNDjeesRwgZj3qcPmCaQjVz2w5g2vFQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=aVQwN0ORUfT235UzDBArm8KmamF34cXk6zONRyqsD4Msxdj6byi9nEgz/sv0WDDFs
         VDtccX7KvrjfmY61A2EWpjZ2xmIG3TcvO8zLRHUoCTbVuWioYxXhnGXYEpGSe5DvZH
         ovAQUt8Q6sIA3Mz6gmykmFu6UCXx4CANMb1dSugY=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 6PdmBEypOo-SlTScrL6;
        Sat, 30 Dec 2017 21:28:49 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514658529;
        bh=uVPPgfMEYJNksNDjeesRwgZj3qcPmCaQjVz2w5g2vFQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=NPOSvRnO4wiDMP88EZIWCANUackhBy9D6h8KyqLtDVUfppE+HgNdVAKPwDtIfhTzk
         LdNb/Inp7Ios71sNRZ08Rx9UbmfNJi9WRtyEe3fCZDf3q6+33VJdWlp+DTQectea77
         X1gH6pC/F66+qgtfcJA5bzrD/xPFIvVVZ3nXu5sU=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCHv2 2/8]  MIPS: Loongson64: cleanup all loongson common files to use SPDX Identifier
Date:   Sun, 31 Dec 2017 02:28:25 +0800
Message-Id: <20171230182830.6496-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171230182830.6496-1-jiaxun.yang@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
 <20171230182830.6496-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61792
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
 arch/mips/loongson64/common/bonito-irq.c   | 6 ++----
 arch/mips/loongson64/common/cmdline.c      | 7 ++-----
 arch/mips/loongson64/common/early_printk.c | 6 ++----
 arch/mips/loongson64/common/env.c          | 6 ++----
 arch/mips/loongson64/common/init.c         | 6 ++----
 arch/mips/loongson64/common/irq.c          | 6 ++----
 arch/mips/loongson64/common/machtype.c     | 6 ++----
 arch/mips/loongson64/common/mem.c          | 8 ++------
 arch/mips/loongson64/common/pci.c          | 6 ++----
 arch/mips/loongson64/common/platform.c     | 6 ++----
 arch/mips/loongson64/common/pm.c           | 6 ++----
 arch/mips/loongson64/common/reset.c        | 7 ++-----
 arch/mips/loongson64/common/rtc.c          | 8 +++-----
 arch/mips/loongson64/common/serial.c       | 5 ++---
 arch/mips/loongson64/common/setup.c        | 6 ++----
 arch/mips/loongson64/common/time.c         | 6 ++----
 arch/mips/loongson64/common/uart_base.c    | 6 ++----
 17 files changed, 35 insertions(+), 72 deletions(-)

diff --git a/arch/mips/loongson64/common/bonito-irq.c b/arch/mips/loongson64/common/bonito-irq.c
index 4e116d23bab3..eb9ef61363e0 100644
--- a/arch/mips/loongson64/common/bonito-irq.c
+++ b/arch/mips/loongson64/common/bonito-irq.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Copyright 2001 MontaVista Software Inc.
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
@@ -6,10 +8,6 @@
  * Copyright (C) 2007 Lemote Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
  */
 #include <linux/interrupt.h>
 #include <linux/compiler.h>
diff --git a/arch/mips/loongson64/common/cmdline.c b/arch/mips/loongson64/common/cmdline.c
index 01fbed137028..791588474d80 100644
--- a/arch/mips/loongson64/common/cmdline.c
+++ b/arch/mips/loongson64/common/cmdline.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Based on Ocelot Linux port, which is
  * Copyright 2001 MontaVista Software Inc.
@@ -11,11 +13,6 @@
  *
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
- *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 #include <asm/bootinfo.h>
 
diff --git a/arch/mips/loongson64/common/early_printk.c b/arch/mips/loongson64/common/early_printk.c
index 6ca632e529dc..6786ebdc55b9 100644
--- a/arch/mips/loongson64/common/early_printk.c
+++ b/arch/mips/loongson64/common/early_printk.c
@@ -1,13 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*  early printk support
  *
  *  Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
  *  Copyright (c) 2009 Lemote Inc.
  *  Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
  */
 #include <linux/serial_reg.h>
 
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index 1e8a955ae5a8..bd98494f45aa 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Based on Ocelot Linux port, which is
  * Copyright 2001 MontaVista Software Inc.
@@ -12,10 +14,6 @@
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 #include <linux/export.h>
 #include <asm/bootinfo.h>
diff --git a/arch/mips/loongson64/common/init.c b/arch/mips/loongson64/common/init.c
index 6ef17120722f..9166e7bac7d2 100644
--- a/arch/mips/loongson64/common/init.c
+++ b/arch/mips/loongson64/common/init.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
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
 
 #include <linux/bootmem.h>
diff --git a/arch/mips/loongson64/common/irq.c b/arch/mips/loongson64/common/irq.c
index d36d969a4a87..24e5ec2c0c5e 100644
--- a/arch/mips/loongson64/common/irq.c
+++ b/arch/mips/loongson64/common/irq.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Copyright (C) 2007 Lemote Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
  */
 #include <linux/delay.h>
 #include <linux/interrupt.h>
diff --git a/arch/mips/loongson64/common/machtype.c b/arch/mips/loongson64/common/machtype.c
index f2807bc662a3..d138130c561c 100644
--- a/arch/mips/loongson64/common/machtype.c
+++ b/arch/mips/loongson64/common/machtype.c
@@ -1,13 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * Copyright (c) 2009 Zhang Le <r0bertz@gentoo.org>
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 #include <linux/errno.h>
 #include <asm/bootinfo.h>
diff --git a/arch/mips/loongson64/common/mem.c b/arch/mips/loongson64/common/mem.c
index b01d52473da8..1d022e7bc555 100644
--- a/arch/mips/loongson64/common/mem.c
+++ b/arch/mips/loongson64/common/mem.c
@@ -1,9 +1,5 @@
-/*
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0
+
 #include <linux/fs.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
diff --git a/arch/mips/loongson64/common/pci.c b/arch/mips/loongson64/common/pci.c
index 4e2575643781..7bd3171a7f22 100644
--- a/arch/mips/loongson64/common/pci.c
+++ b/arch/mips/loongson64/common/pci.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
  */
 #include <linux/pci.h>
 
diff --git a/arch/mips/loongson64/common/platform.c b/arch/mips/loongson64/common/platform.c
index 0ed38321a9a2..aca41a4a9d4d 100644
--- a/arch/mips/loongson64/common/platform.c
+++ b/arch/mips/loongson64/common/platform.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
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
 
 #include <linux/err.h>
diff --git a/arch/mips/loongson64/common/pm.c b/arch/mips/loongson64/common/pm.c
index a6b67ccfc811..d2caa12b1105 100644
--- a/arch/mips/loongson64/common/pm.c
+++ b/arch/mips/loongson64/common/pm.c
@@ -1,13 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * loongson-specific suspend support
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
 #include <linux/interrupt.h>
diff --git a/arch/mips/loongson64/common/reset.c b/arch/mips/loongson64/common/reset.c
index a60715e11306..e7b996f5c33a 100644
--- a/arch/mips/loongson64/common/reset.c
+++ b/arch/mips/loongson64/common/reset.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
  * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  * Copyright (C) 2009 Lemote, Inc.
diff --git a/arch/mips/loongson64/common/rtc.c b/arch/mips/loongson64/common/rtc.c
index b5709af09f7f..d231c6ef3cbf 100644
--- a/arch/mips/loongson64/common/rtc.c
+++ b/arch/mips/loongson64/common/rtc.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
- *  Lemote Fuloong platform support
+ *  mc146818 rtc support for lemote-2f platform
  *
  *  Copyright(c) 2010 Arnaud Patard <apatard@mandriva.com>
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
  */
 
 #include <linux/init.h>
diff --git a/arch/mips/loongson64/common/serial.c b/arch/mips/loongson64/common/serial.c
index ffefc1cb2612..a82b23bd42aa 100644
--- a/arch/mips/loongson64/common/serial.c
+++ b/arch/mips/loongson64/common/serial.c
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  *
  * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
  *
diff --git a/arch/mips/loongson64/common/setup.c b/arch/mips/loongson64/common/setup.c
index 332387678f3e..d62bb04c000b 100644
--- a/arch/mips/loongson64/common/setup.c
+++ b/arch/mips/loongson64/common/setup.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Copyright (C) 2007 Lemote Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
  */
 #include <linux/export.h>
 #include <linux/init.h>
diff --git a/arch/mips/loongson64/common/time.c b/arch/mips/loongson64/common/time.c
index e1a5382ad47e..6cedaacd488f 100644
--- a/arch/mips/loongson64/common/time.c
+++ b/arch/mips/loongson64/common/time.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
@@ -5,10 +7,6 @@
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
  */
 #include <asm/mc146818-time.h>
 #include <asm/time.h>
diff --git a/arch/mips/loongson64/common/uart_base.c b/arch/mips/loongson64/common/uart_base.c
index d27c41b237a0..ec371665f341 100644
--- a/arch/mips/loongson64/common/uart_base.c
+++ b/arch/mips/loongson64/common/uart_base.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
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
 
 #include <linux/export.h>
-- 
2.15.1
