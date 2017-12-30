Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 19:29:22 +0100 (CET)
Received: from forward103p.mail.yandex.net ([77.88.28.106]:36935 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbdL3S2xU0jJc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Dec 2017 19:28:53 +0100
Received: from mxback9j.mail.yandex.net (mxback9j.mail.yandex.net [IPv6:2a02:6b8:0:1619::112])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 7E6B8218289C;
        Sat, 30 Dec 2017 21:28:47 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback9j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id FSxwEBmNK5-SlDGSPxS;
        Sat, 30 Dec 2017 21:28:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514658527;
        bh=Btn2bMrrJid8nf7yYo3W9vR5/PDdvrE1dRAh4cRXC6M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=Cg3A9l0N/jvuuEntkMKHINzoTxyeQgsiyVuuWwFSqar8HsXtT63EQMdRtPlYruH4h
         /QXRNVSANbmSd4N6LQjJeh+nKVl5qUQ+a4bNqVw3DV+Dn4MS5s5NGqby/H10KadkSJ
         suLjYlYP7PP6EOfus+mX5Jr2umpw8eATqYTJj+Qc=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 6PdmBEypOo-SiT4GU6K;
        Sat, 30 Dec 2017 21:28:45 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514658526;
        bh=Btn2bMrrJid8nf7yYo3W9vR5/PDdvrE1dRAh4cRXC6M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=Gjk1+F/FQHtGuWc+3lcnwOqdV42ePSlVO1muh8cqv17vLV2sR2wA3vIUtnZdTduuN
         N98Q64MDFua9SvovvjNSjd7cTqKV/7pmvqV6ZL5P43pv0OTz1TwRsqwUAL/2b81huq
         ZTYi+7ly1BHx/UMayH32ms+2LhP05uHjFmCn1YBA=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCHv2 1/8] MIPS: Loongson64: cleanup all cs5536 files to use SPDX Identifier
Date:   Sun, 31 Dec 2017 02:28:24 +0800
Message-Id: <20171230182830.6496-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171230182830.6496-1-jiaxun.yang@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
 <20171230182830.6496-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61791
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
 arch/mips/loongson64/common/cs5536/Makefile       | 1 +
 arch/mips/loongson64/common/cs5536/cs5536_acc.c   | 6 ++----
 arch/mips/loongson64/common/cs5536/cs5536_ehci.c  | 6 ++----
 arch/mips/loongson64/common/cs5536/cs5536_ide.c   | 6 ++----
 arch/mips/loongson64/common/cs5536/cs5536_isa.c   | 6 ++----
 arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c | 6 ++----
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c  | 6 ++----
 arch/mips/loongson64/common/cs5536/cs5536_pci.c   | 7 ++-----
 8 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/arch/mips/loongson64/common/cs5536/Makefile b/arch/mips/loongson64/common/cs5536/Makefile
index f12e64007347..b0c805a0dcc6 100644
--- a/arch/mips/loongson64/common/cs5536/Makefile
+++ b/arch/mips/loongson64/common/cs5536/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for CS5536 support.
 #
diff --git a/arch/mips/loongson64/common/cs5536/cs5536_acc.c b/arch/mips/loongson64/common/cs5536/cs5536_acc.c
index ab4d6cc57384..ba0474bb4a3d 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_acc.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_acc.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * the ACC Virtual Support Module of AMD CS5536
  *
@@ -7,10 +9,6 @@
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <cs5536/cs5536.h>
diff --git a/arch/mips/loongson64/common/cs5536/cs5536_ehci.c b/arch/mips/loongson64/common/cs5536/cs5536_ehci.c
index ec2e360267a8..c7a6ef09a978 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_ehci.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_ehci.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * the EHCI Virtual Support Module of AMD CS5536
  *
@@ -7,10 +9,6 @@
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <cs5536/cs5536.h>
diff --git a/arch/mips/loongson64/common/cs5536/cs5536_ide.c b/arch/mips/loongson64/common/cs5536/cs5536_ide.c
index a73414d9ee51..b88c7a20619e 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_ide.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_ide.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * the IDE Virtual Support Module of AMD CS5536
  *
@@ -7,10 +9,6 @@
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <cs5536/cs5536.h>
diff --git a/arch/mips/loongson64/common/cs5536/cs5536_isa.c b/arch/mips/loongson64/common/cs5536/cs5536_isa.c
index 924be39e7733..c358c0755eff 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_isa.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_isa.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * the ISA Virtual Support Module of AMD CS5536
  *
@@ -7,10 +9,6 @@
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <linux/pci.h>
diff --git a/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c b/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
index a6adcc4f8960..0acb7e3fa660 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * CS5536 General timer functions
  *
@@ -9,10 +11,6 @@
  *
  * Reference: AMD Geode(TM) CS5536 Companion Device Data Book
  *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
  */
 
 #include <linux/io.h>
diff --git a/arch/mips/loongson64/common/cs5536/cs5536_ohci.c b/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
index f7c905e50dc4..e82393273be7 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * the OHCI Virtual Support Module of AMD CS5536
  *
@@ -7,10 +9,6 @@
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <cs5536/cs5536.h>
diff --git a/arch/mips/loongson64/common/cs5536/cs5536_pci.c b/arch/mips/loongson64/common/cs5536/cs5536_pci.c
index b739723205f8..39d9ec9ebac4 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_pci.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_pci.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * read/write operation to the PCI config space of CS5536
  *
@@ -7,11 +9,6 @@
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
  *	the Virtual Support Module(VSM) for virtulizing the PCI
  *	configure space are defined in cs5536_modulename.c respectively,
  *
-- 
2.15.1
