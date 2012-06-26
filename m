Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:45:45 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:54960 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903760Ab2FZEmN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:42:13 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbL-0002zj-Hn; Mon, 25 Jun 2012 23:42:07 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 08/33] MIPS: Cobalt: Cleanup files effected by firmware changes.
Date:   Mon, 25 Jun 2012 23:41:23 -0500
Message-Id: <1340685708-14408-9-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33816
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
 arch/mips/cobalt/setup.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index 3fdd449..d7ecf18 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -1,13 +1,12 @@
 /*
- * Setup pointers to hardware dependent routines.
- *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * Setup pointers to hardware dependent routines.
+ *
  * Copyright (C) 1996, 1997, 2004, 05 by Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 2001, 2002, 2003 by Liam Davies (ldavies@agile.tv)
- *
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -27,14 +26,14 @@ extern void cobalt_machine_halt(void);
 const char *get_system_type(void)
 {
 	switch (cobalt_board_id) {
-		case COBALT_BRD_ID_QUBE1:
-			return "Cobalt Qube";
-		case COBALT_BRD_ID_RAQ1:
-			return "Cobalt RaQ";
-		case COBALT_BRD_ID_QUBE2:
-			return "Cobalt Qube2";
-		case COBALT_BRD_ID_RAQ2:
-			return "Cobalt RaQ2";
+	case COBALT_BRD_ID_QUBE1:
+		return "Cobalt Qube";
+	case COBALT_BRD_ID_RAQ1:
+		return "Cobalt RaQ";
+	case COBALT_BRD_ID_QUBE2:
+		return "Cobalt Qube2";
+	case COBALT_BRD_ID_RAQ2:
+		return "Cobalt RaQ2";
 	}
 	return "MIPS Cobalt";
 }
@@ -86,7 +85,8 @@ void __init plat_mem_setup(void)
 
 	/* These resources have been reserved by VIA SuperI/O chip. */
 	for (i = 0; i < ARRAY_SIZE(cobalt_reserved_resources); i++)
-		request_resource(&ioport_resource, cobalt_reserved_resources + i);
+		request_resource(&ioport_resource,
+				cobalt_reserved_resources + i);
 }
 
 /*
-- 
1.7.10.3
