Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 11:43:00 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:33383 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491757Ab1HLJkB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2011 11:40:01 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so2860485fxd.36
        for <multiple recipients>; Fri, 12 Aug 2011 02:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5XE/NAwdDYXkOjrK+WNDCDO3QaZBvIBZ/QkOt9GE110=;
        b=MXYmite6YBU3t7ltGEl4zUBQYRcuc59S68wzwPJCavynit+dWWX9L5/Q44YPPW/vxE
         e6ySrOYh7rMX+KOn/SOZWZQfK/vWppqiKHFUAQP45Izg63A174AZ3ZjlDhOmLJovwMsd
         R3Ja9wqLvZZ1/QBLQlnKgtIcp2ZbN/kP3xW+s=
Received: by 10.223.52.66 with SMTP id h2mr988208fag.92.1313142001133;
        Fri, 12 Aug 2011 02:40:01 -0700 (PDT)
Received: from localhost.localdomain (178-191-11-228.adsl.highway.telekom.at [178.191.11.228])
        by mx.google.com with ESMTPS id s14sm467338fah.29.2011.08.12.02.39.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 02:40:00 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 6/8] MIPS: Alchemy: kill au1xxx.h header
Date:   Fri, 12 Aug 2011 11:39:43 +0200
Message-Id: <1313141985-5830-7-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
References: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9267

No longer required

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/platform.c           |    2 +-
 arch/mips/alchemy/devboards/db1x00/platform.c |    2 +-
 arch/mips/alchemy/devboards/pb1200/platform.c |    3 +-
 arch/mips/include/asm/mach-au1x00/au1xxx.h    |   43 -------------------------
 drivers/i2c/busses/i2c-au1550.c               |    2 +-
 drivers/ide/au1xxx-ide.c                      |    2 +-
 drivers/mtd/nand/au1550nd.c                   |    6 +++-
 7 files changed, 11 insertions(+), 49 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-au1x00/au1xxx.h

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 7eca306..657ae27 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -18,7 +18,7 @@
 #include <linux/serial_8250.h>
 #include <linux/slab.h>
 
-#include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-au1x00/au1xxx_eth.h>
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index ef8017f..70bcfb5 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -21,7 +21,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 
-#include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
 #include "../platform.h"
 
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index 7de4f88..d7915b0 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -24,10 +24,11 @@
 #include <linux/platform_device.h>
 #include <linux/smc91x.h>
 
-#include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-db1x00/bcsr.h>
+#include <asm/mach-pb1x00/pb1200.h>
 
 #include "../platform.h"
 
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx.h b/arch/mips/include/asm/mach-au1x00/au1xxx.h
deleted file mode 100644
index 1b36550..0000000
--- a/arch/mips/include/asm/mach-au1x00/au1xxx.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef _AU1XXX_H_
-#define _AU1XXX_H_
-
-#include <asm/mach-au1x00/au1000.h>
-
-#if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || \
-    defined(CONFIG_MIPS_DB1500) || defined(CONFIG_MIPS_DB1550)
-#include <asm/mach-db1x00/db1x00.h>
-
-#elif defined(CONFIG_MIPS_PB1550)
-#include <asm/mach-pb1x00/pb1550.h>
-
-#elif defined(CONFIG_MIPS_PB1200)
-#include <asm/mach-pb1x00/pb1200.h>
-
-#elif defined(CONFIG_MIPS_DB1200)
-#include <asm/mach-db1x00/db1200.h>
-
-#endif
-
-#endif /* _AU1XXX_H_ */
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 532828b..a714534 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -36,7 +36,7 @@
 #include <linux/i2c.h>
 #include <linux/slab.h>
 
-#include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
 struct i2c_au1550_data {
diff --git a/drivers/ide/au1xxx-ide.c b/drivers/ide/au1xxx-ide.c
index c778373..259786c 100644
--- a/drivers/ide/au1xxx-ide.c
+++ b/drivers/ide/au1xxx-ide.c
@@ -36,7 +36,7 @@
 #include <linux/ide.h>
 #include <linux/scatterlist.h>
 
-#include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1xxx_ide.h>
 
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index e7767ee..fa5736b 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -19,7 +19,11 @@
 #include <linux/mtd/partitions.h>
 #include <asm/io.h>
 
-#include <asm/mach-au1x00/au1xxx.h>
+#ifdef CONFIG_MIPS_PB1550
+#include <asm/mach-pb1x00/pb1550.h>
+#elif defined(CONFIG_MIPS_DB1550)
+#include <asm/mach-db1x00/db1x00.h>
+#endif
 #include <asm/mach-db1x00/bcsr.h>
 
 /*
-- 
1.7.6
