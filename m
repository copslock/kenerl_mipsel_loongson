Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 16:34:16 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:40100 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011542AbbEPOePS0pza (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 16:34:15 +0200
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4GEY6ib006947
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 16 May 2015 14:34:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEY4aG021810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 16 May 2015 14:34:04 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEY4An012167;
        Sat, 16 May 2015 14:34:04 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.239.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 May 2015 07:34:04 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Nicolas Schichan <nschichan@freebox.fr>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: BCM63xx: Move bcm63xx_gpio_init() to bcm63xx_register_devices().
Date:   Sat, 16 May 2015 10:33:10 -0400
Message-Id: <1431786833-25487-2-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
References: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Nicolas Schichan <nschichan@freebox.fr>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 2ec459f2a77b808c1e5a3616c88b613d3f720c8d ]

When called from prom init code, bcm63xx_gpio_init() will fail as it
will call gpiochip_add() which relies on a working kmalloc() to alloc
the gpio_desc array and kmalloc is not useable yet at prom init time.

Move bcm63xx_gpio_init() to bcm63xx_register_devices() (an
arch_initcall) where kmalloc works.

Fixes: 14e85c0e69d5 ("gpio: remove gpio_descs global array")

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: Alexandre Courbot <acourbot@nvidia.com>
Patchwork: https://patchwork.linux-mips.org/patch/9530/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/bcm63xx/prom.c  | 4 ----
 arch/mips/bcm63xx/setup.c | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index e1f27d6..7019e29 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -17,7 +17,6 @@
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
-#include <bcm63xx_gpio.h>
 
 void __init prom_init(void)
 {
@@ -53,9 +52,6 @@ void __init prom_init(void)
 	reg &= ~mask;
 	bcm_perf_writel(reg, PERF_CKCTL_REG);
 
-	/* register gpiochip */
-	bcm63xx_gpio_init();
-
 	/* do low level board init */
 	board_prom_init();
 
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 6660c7d..240fb4f 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -20,6 +20,7 @@
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
+#include <bcm63xx_gpio.h>
 
 void bcm63xx_machine_halt(void)
 {
@@ -160,6 +161,9 @@ void __init plat_mem_setup(void)
 
 int __init bcm63xx_register_devices(void)
 {
+	/* register gpiochip */
+	bcm63xx_gpio_init();
+
 	return board_register_devices();
 }
 
-- 
2.1.0
