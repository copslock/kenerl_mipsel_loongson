Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 14:25:24 +0100 (CET)
Received: from forward100p.mail.yandex.net ([IPv6:2a02:6b8:0:1472:2741:0:8b7:100]:44152
        "EHLO forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdLZNYWzsx26 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 14:24:22 +0100
Received: from mxback4j.mail.yandex.net (mxback4j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10d])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 8EFB5510259F;
        Tue, 26 Dec 2017 16:24:16 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback4j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id RePGTAf3kA-OFAKnFF5;
        Tue, 26 Dec 2017 16:24:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514294656;
        bh=iNGk2Haa62tCxHkOfTzDao3GopDyZIhOTJ6GWmqIKPQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=BHAtOR9b1GzZB/ze/7t0/GdZ7nR7PmSt9hHTC0Tx3LWTkmWJkvE23zSbG7TPhmIxN
         gjII4cgqPz52EZlluTiJqNDG/PPsAzVBnEz70lInwuL0KhXeVX0NofIPoE407As6G4
         IMiHqKgXuQ0OTNoLyvIz7NjgdzW4npgyZ4J/Ha0s=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Ful6zNDKwE-OAk8hdNk;
        Tue, 26 Dec 2017 16:24:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514294654;
        bh=iNGk2Haa62tCxHkOfTzDao3GopDyZIhOTJ6GWmqIKPQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=QmnqSgjAoJB8vL9dIB3D6ajTAHS1lEvMYwIXh8kOfgcpA2v/1GEZGgzry/+5kCGeE
         3Omfzb8roW116mMOv+osb33WKARlNDhtYEwLcRLvO+Cu241Mk6J/QegG70/POHWEEt
         AsQfES6Iq+ZGkPzrkSDoFKnAOJQSr2hNWqazVtJQ=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/7] MIPS: Loongson64: cleanup all fuloong-2e files to use SPDX Identifier
Date:   Tue, 26 Dec 2017 21:23:35 +0800
Message-Id: <20171226132339.7356-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61601
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
 arch/mips/loongson64/fuloong-2e/Makefile | 1 +
 arch/mips/loongson64/fuloong-2e/irq.c    | 6 ++----
 arch/mips/loongson64/fuloong-2e/reset.c  | 6 ++----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/mips/loongson64/fuloong-2e/Makefile b/arch/mips/loongson64/fuloong-2e/Makefile
index b7622720c1ad..a2c000555f47 100644
--- a/arch/mips/loongson64/fuloong-2e/Makefile
+++ b/arch/mips/loongson64/fuloong-2e/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for Lemote Fuloong2e mini-PC board.
 #
diff --git a/arch/mips/loongson64/fuloong-2e/irq.c b/arch/mips/loongson64/fuloong-2e/irq.c
index 892963f860b7..9423f0b32b6a 100644
--- a/arch/mips/loongson64/fuloong-2e/irq.c
+++ b/arch/mips/loongson64/fuloong-2e/irq.c
@@ -1,11 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
 #include <linux/interrupt.h>
 
diff --git a/arch/mips/loongson64/fuloong-2e/reset.c b/arch/mips/loongson64/fuloong-2e/reset.c
index da4d2ae2a1f8..59024dda093b 100644
--- a/arch/mips/loongson64/fuloong-2e/reset.c
+++ b/arch/mips/loongson64/fuloong-2e/reset.c
@@ -1,13 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /* Board-specific reboot/shutdown routines
  * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
  *
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <loongson.h>
-- 
2.15.1
