Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 21:03:01 +0200 (CEST)
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:38970 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493040AbZJNTC3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 21:02:29 +0200
Received: from localhost.localdomain (a88-114-232-190.elisa-laajakaista.fi [88.114.232.190])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 8C53A151705;
	Wed, 14 Oct 2009 22:02:25 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH 1/3] [MIPS] mipssim: remove unused code
Date:	Wed, 14 Oct 2009 22:02:17 +0300
Message-Id: <1255546939-3302-2-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com>
References: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com>
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

The function prom_init_cmdline() doesn't do anything, and nobody calls
the prom_getcmdline() function. Since these two are the only functions
in the file arch/mips/mipssim/sim_cmdline.c, the whole file can be
removed now along with the call to the no-op prom_init_cmdline()
routine.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/mipssim/sim_cmdline.c |   32 --------------------------------
 arch/mips/mipssim/sim_setup.c   |    1 -
 2 files changed, 0 insertions(+), 33 deletions(-)
 delete mode 100644 arch/mips/mipssim/sim_cmdline.c

diff --git a/arch/mips/mipssim/sim_cmdline.c b/arch/mips/mipssim/sim_cmdline.c
deleted file mode 100644
index 74240e1..0000000
--- a/arch/mips/mipssim/sim_cmdline.c
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
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
- *
- */
-#include <linux/init.h>
-#include <linux/string.h>
-#include <asm/bootinfo.h>
-
-extern char arcs_cmdline[];
-
-char * __init prom_getcmdline(void)
-{
-	return arcs_cmdline;
-}
-
-void  __init prom_init_cmdline(void)
-{
-	/* XXX: Get boot line from environment? */
-}
diff --git a/arch/mips/mipssim/sim_setup.c b/arch/mips/mipssim/sim_setup.c
index 2877675..0824f6a 100644
--- a/arch/mips/mipssim/sim_setup.c
+++ b/arch/mips/mipssim/sim_setup.c
@@ -61,7 +61,6 @@ void __init prom_init(void)
 	set_io_port_base(0xbfd00000);
 
 	pr_info("\nLINUX started...\n");
-	prom_init_cmdline();
 	prom_meminit();
 
 #ifdef CONFIG_MIPS_MT_SMP
-- 
1.6.0.4
