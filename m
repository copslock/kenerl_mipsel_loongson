Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:50:25 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43547 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903723Ab2FEVts (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:49:48 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1Ac-000824-Om; Tue, 05 Jun 2012 16:20:06 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 35/35] MIPS: vr41xx: Cleanup files effected by firmware changes.
Date:   Tue,  5 Jun 2012 16:19:39 -0500
Message-Id: <1338931179-9611-36-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

From: "Steven J. Hill" <sjhill@mips.com>

Make headers consistent across the files and make changes based on
running the checkpatch script.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/vr41xx/common/init.c |   27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
index a2fa7f0..783b7f8 100644
--- a/arch/mips/vr41xx/common/init.c
+++ b/arch/mips/vr41xx/common/init.c
@@ -1,30 +1,15 @@
 /*
- *  init.c, Common initialization routines for NEC VR4100 series.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  Copyright (C) 2003-2009  Yoichi Yuasa <yuasa@linux-mips.org>
+ * init.c, Common initialization routines for NEC VR4100 series.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * Copyright (C) 2003-2009  Yoichi Yuasa <yuasa@linux-mips.org>
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/irq.h>
-#include <linux/string.h>
-
 #include <asm/time.h>
 #include <asm/fw/fw.h>
-#include <asm/vr41xx/irq.h>
 #include <asm/vr41xx/vr41xx.h>
 
 #define IO_MEM_RESOURCE_START	0UL
-- 
1.7.10.3
