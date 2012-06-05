Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:59:08 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43598 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903764Ab2FEVwm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:52:42 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1AZ-000824-9w; Tue, 05 Jun 2012 16:20:03 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 29/35] MIPS: PowerTV: Cleanup files effected by firmware changes.
Date:   Tue,  5 Jun 2012 16:19:33 -0500
Message-Id: <1338931179-9611-30-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33547
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
 arch/mips/powertv/asic/asic_int.c |   44 ++++++++++---------------------------
 arch/mips/powertv/init.c          |   27 +++++++++--------------
 arch/mips/powertv/memory.c        |   26 +++++++++-------------
 arch/mips/powertv/powertv_setup.c |   27 +++++++++--------------
 4 files changed, 42 insertions(+), 82 deletions(-)

diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
index 8728c3b..3cd9f65 100644
--- a/arch/mips/powertv/asic/asic_int.c
+++ b/arch/mips/powertv/asic/asic_int.c
@@ -1,27 +1,20 @@
 /*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
- * Copyright (C) 2001 Ralf Baechle
- * Portions copyright (C) 2009  Cisco Systems, Inc.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
+ * Routines for generic manipulation of the interrupts found on the PowerTV
+ * platform. The interrupt controller is located in the South Bridge a PIIX4
+ * device with two internal 82C95 interrupt controllers.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ * Copyright (C) 2000,2001,2004,2012 MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *	    Steven J. Hill <sjhill@mips.com>
  *
- * Routines for generic manipulation of the interrupts found on the PowerTV
- * platform.
+ * Copyright (C) 2001 Ralf Baechle
  *
- * The interrupt controller is located in the South Bridge a PIIX4 device
- * with two internal 82C95 interrupt controllers.
+ * Portions copyright (C) 2009  Cisco Systems, Inc.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
@@ -68,19 +61,6 @@ static void asic_irqdispatch(void)
 	do_IRQ(irq);
 }
 
-static inline int clz(unsigned long x)
-{
-	__asm__(
-	"	.set	push					\n"
-	"	.set	mips32					\n"
-	"	clz	%0, %1					\n"
-	"	.set	pop					\n"
-	: "=r" (x)
-	: "r" (x));
-
-	return x;
-}
-
 /*
  * Version of ffs that only looks at bits 12..15.
  */
diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
index 14cdf19..d9be671 100644
--- a/arch/mips/powertv/init.c
+++ b/arch/mips/powertv/init.c
@@ -1,24 +1,17 @@
 /*
- * Copyright (C) 1999, 2000, 2004, 2005  MIPS Technologies, Inc.
- *	All rights reserved.
- *	Authors: Carsten Langgaard <carstenl@mips.com>
- *		 Maciej W. Rozycki <macro@mips.com>
- * Portions copyright (C) 2009 Cisco Systems, Inc.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
+ * PROM library initialisation code.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ * Copyright (C) 1999,2000,2004,2005,2012 MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *	    Maciej W. Rozycki <macro@mips.com>
+ *	    Steven J. Hill <sjhill@mips.com>
  *
- * PROM library initialisation code.
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
  */
 #include <linux/init.h>
 #include <linux/string.h>
diff --git a/arch/mips/powertv/memory.c b/arch/mips/powertv/memory.c
index 56f0193..be70d51 100644
--- a/arch/mips/powertv/memory.c
+++ b/arch/mips/powertv/memory.c
@@ -1,23 +1,17 @@
 /*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- * Portions copyright (C) 2009 Cisco Systems, Inc.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
  * Apparently originally from arch/mips/malta-memory.c. Modified to work
  * with the PowerTV bootloader.
+ *
+ * Copyright (C) 1999,2000,2012 MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *	    Steven J. Hill <sjhill@mips.com>
+ *
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
  */
 #include <linux/init.h>
 #include <linux/mm.h>
diff --git a/arch/mips/powertv/powertv_setup.c b/arch/mips/powertv/powertv_setup.c
index 55a3fc5..beec158 100644
--- a/arch/mips/powertv/powertv_setup.c
+++ b/arch/mips/powertv/powertv_setup.c
@@ -1,20 +1,14 @@
 /*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- * Portions copyright (C) 2009 Cisco Systems, Inc.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
+ * Copyright (C) 2000,2012 MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *	    Steven J. Hill <sjhill@mips.com>
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
  */
 #include <linux/init.h>
 #include <linux/sched.h>
@@ -197,8 +191,7 @@ static int panic_handler(struct notifier_block *notifier_block,
 		my_regs.cp0_status = read_c0_status();
 	}
 
-	pr_crit("I'm feeling a bit sleepy. hmmmmm... perhaps a nap would... "
-		"zzzz... \n");
+	pr_crit("I'm feeling a bit sleepy. Perhaps a nap would...zzzz...\n");
 
 	return NOTIFY_DONE;
 }
@@ -295,7 +288,7 @@ void platform_random_ether_addr(u8 addr[ETH_ALEN])
 	const unsigned char mac_addr_locally_managed = (1 << 1);
 
 	if (!have_rfmac) {
-		pr_warning("rfmac not available on command line; "
+		pr_warn("rfmac not available on command line; "
 			"generating random MAC address\n");
 		random_ether_addr(addr);
 	}
-- 
1.7.10.3
