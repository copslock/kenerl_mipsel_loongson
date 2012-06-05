Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:58:18 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43595 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903737Ab2FEVw3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:52:29 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1AW-000824-ES; Tue, 05 Jun 2012 16:20:00 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 23/35] MIPS: Netlogic: Cleanup files effected by firmware changes.
Date:   Tue,  5 Jun 2012 16:19:27 -0500
Message-Id: <1338931179-9611-24-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33545
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
 arch/mips/netlogic/xlr/setup.c |   35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 113a402..324c071 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -1,37 +1,12 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
  * reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the NetLogic
- * license below:
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
- * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
- * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-
 #include <linux/kernel.h>
 #include <linux/serial_8250.h>
 #include <linux/pm.h>
-- 
1.7.10.3
