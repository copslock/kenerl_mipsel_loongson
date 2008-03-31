Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 00:12:30 +0200 (CEST)
Received: from smtp02.mtu.ru ([62.5.255.49]:2522 "EHLO smtp02.mtu.ru")
	by lappi.linux-mips.net with ESMTP id S1100136AbYCaWId (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 00:08:33 +0200
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 1086243437;
	Tue,  1 Apr 2008 02:05:55 +0400 (MSD)
Received: from localhost.localdomain (ppp85-140-79-111.pppoe.mtu-net.ru [85.140.79.111])
	by smtp02.mtu.ru (Postfix) with ESMTP id E094441C2E;
	Tue,  1 Apr 2008 02:03:37 +0400 (MSD)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] [MIPS] make standard_io_resources[] static
Date:	Tue,  1 Apr 2008 02:03:24 +0400
Message-Id: <1207001005-2633-6-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

The array standard_io_resources[] needs not to be exposed in the kernel
global namespace. This patch makes it static.

Successfully build-tested using default configs for Malta, Atlas
and SEAD boards.

Runtime test successfully performed by booting the Malta 4Kc board
up to the shell prompt.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index 2cd8f57..a06e4b5 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -1,7 +1,7 @@
 /*
  * Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- * Copyright (C) Dmitri Vorobiev
+ * Copyright (C) 2008 Dmitri Vorobiev
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -36,7 +36,7 @@
 #include <linux/console.h>
 #endif
 
-struct resource standard_io_resources[] = {
+static struct resource standard_io_resources[] = {
 	{
 		.name = "dma1",
 		.start = 0x00,
-- 
1.5.3
