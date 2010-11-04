Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2010 23:26:38 +0100 (CET)
Received: from smtp-out-083.synserver.de ([212.40.180.83]:1030 "HELO
        smtp-out-081.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S1491881Ab0KDW0f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Nov 2010 23:26:35 +0100
Received: (qmail 11315 invoked by uid 0); 4 Nov 2010 22:26:27 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 10773
Received: from c128026.adsl.hansenet.de (HELO localhost.localdomain) [213.39.128.26]
  by 217.119.54.81 with SMTP; 4 Nov 2010 22:26:26 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Lars-Peter Clausen <lars@metafoo.de>,
        stable@kernel.org
Subject: [PATCH] MIPS: jz4740: qi_lb60: Fix gpio for the 6th row of the keyboard matrix
Date:   Thu,  4 Nov 2010 23:25:56 +0100
Message-Id: <1288909557-20088-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

This patch fixes the gpio number for the 6th row of the keyboard matrix.

(And fixes a typo in my name...)

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: stable@kernel.org
---
 arch/mips/jz4740/board-qi_lb60.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)A
---
This patch should go into 2.6.36.x stable

diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 3221846..05297ef 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -5,7 +5,7 @@
  *
  * Copyright (c) 2009 Qi Hardware inc.,
  * Author: Xiangfu Liu <xiangfu@qi-hardware.com>
- * Copyright 2010, Lars-Petrer Clausen <lars@metafoo.de>
+ * Copyright 2010, Lars-Peter Clausen <lars@metafoo.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 or later
@@ -236,7 +236,7 @@ static const unsigned int qi_lb60_keypad_rows[] = {
 	QI_LB60_GPIO_KEYIN(3),
 	QI_LB60_GPIO_KEYIN(4),
 	QI_LB60_GPIO_KEYIN(5),
-	QI_LB60_GPIO_KEYIN(7),
+	QI_LB60_GPIO_KEYIN(6),
 	QI_LB60_GPIO_KEYIN8,
 };
 
-- 
1.5.6.5
