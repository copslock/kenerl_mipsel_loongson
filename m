Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 20:01:05 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027485AbbEKRz40kOee (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:56 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 41D8EBB3;
        Mon, 11 May 2015 17:55:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Schichan <nschichan@freebox.fr>,
        linux-mips@linux-mips.org, Alexandre Courbot <acourbot@nvidia.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 07/72] MIPS: BCM63xx: Move bcm63xx_gpio_init() to bcm63xx_register_devices().
Date:   Mon, 11 May 2015 10:54:13 -0700
Message-Id: <20150511175437.329697816@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Nicolas Schichan <nschichan@freebox.fr>

Commit 2ec459f2a77b808c1e5a3616c88b613d3f720c8d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/bcm63xx/prom.c  |    4 ----
 arch/mips/bcm63xx/setup.c |    4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

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
 
