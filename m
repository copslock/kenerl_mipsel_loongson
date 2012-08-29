Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2012 00:34:56 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:3107 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903257Ab2H2Weu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Aug 2012 00:34:50 +0200
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 29 Aug 2012 15:33:37 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 29 Aug 2012 15:34:31 -0700
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id C84CC9F9F8; Wed, 29
 Aug 2012 15:34:30 -0700 (PDT)
From:   "Jim Quinlan" <jim2101024@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     "Jim Quinlan" <jim2101024@gmail.com>
Subject: [PATCH V2 1/2] asm-offsets.c: adding #define to break circular
 dependency
Date:   Wed, 29 Aug 2012 18:34:06 -0400
Message-ID: <1346279647-27955-1-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
X-WSS-ID: 7C20474B3MK25991850-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

irqflags.h depends on asm-offsets.h, but asm-offsets.h depends
on irqflags.h when generating asm-offsets.h.  Adding a definition
to the top of asm-offsets.c allows us to break this circle.  There
is a similar define in bounds.c

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/kernel/asm-offsets.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 6b30fb2..035f167 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -8,6 +8,7 @@
  * Kevin Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000 MIPS Technologies, Inc.
  */
+#define __GENERATING_OFFSETS_S
 #include <linux/compat.h>
 #include <linux/types.h>
 #include <linux/sched.h>
-- 
1.7.6
