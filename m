Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 01:52:38 +0100 (CET)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:64472 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007134AbaKZAvgQvZZ3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 01:51:36 +0100
Received: by mail-pd0-f174.google.com with SMTP id w10so1635797pde.19
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 16:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jRDul6hhREHqSU6wsVs/AgfeMQ6MjERPSlMIvezKfw4=;
        b=I03iXi1rxXLM0IXGc/NPhrW7lUrYCKcDAyvfnWyocGEMV+c3Bi2pIBtYT8qmX5Ycac
         6uuJXzKWIKSTOHuVXgTnenDuUJpu0ZbBGr20dVaWwGNmVJylXrJIxKvPwccnoPV6BMid
         aPDYFIGzGmgiDiCRRphP/M2axqyiaf2sC55jM4dQpBzuugTYYATTjdBri7gdVvzibXY5
         hg64BSJTK5NOGDYuw+4cdARISyT/wOnnVWeRUDS01lzf3/E+bNz0s6hRmXNn4Dks/OY5
         KaFTf82JKdl8MKnQwzx7mNc+1EgDLJtB1tC8BrgsUryNjbIKo0xX/wupqu1pRdOx5xaS
         KjSQ==
X-Received: by 10.68.211.135 with SMTP id nc7mr48615138pbc.44.1416963090629;
        Tue, 25 Nov 2014 16:51:30 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id bj11sm2614439pdb.1.2014.11.25.16.51.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:51:30 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org,
        arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc:     grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 4/9] bus: brcmstb_gisb: Make the driver buildable on MIPS
Date:   Tue, 25 Nov 2014 16:49:49 -0800
Message-Id: <1416962994-27095-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

BCM7xxx ARM and MIPS platforms share a similar hardware block for
reporting GISB errors, so they both benefit from the use of this driver.
Conditionally compile the ARM-specific bus error handler so that the
GISB error IRQ handler works on other architectures.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/bus/Kconfig        | 2 +-
 drivers/bus/brcmstb_gisb.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 603eb1b..b99729e 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -6,7 +6,7 @@ menu "Bus devices"
 
 config BRCMSTB_GISB_ARB
 	bool "Broadcom STB GISB bus arbiter"
-	depends on ARM
+	depends on ARM || MIPS
 	help
 	  Driver for the Broadcom Set Top Box System-on-a-chip internal bus
 	  arbiter. This driver provides timeout and target abort error handling
diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index f2cd6a2d..5da935a 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -24,8 +24,10 @@
 #include <linux/of.h>
 #include <linux/bitops.h>
 
+#ifdef CONFIG_ARM
 #include <asm/bug.h>
 #include <asm/signal.h>
+#endif
 
 #define ARB_TIMER			0x008
 #define ARB_ERR_CAP_CLR			0x7e4
@@ -141,6 +143,7 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_gisb_arb_device *gdev,
 	return 0;
 }
 
+#ifdef CONFIG_ARM
 static int brcmstb_bus_error_handler(unsigned long addr, unsigned int fsr,
 				     struct pt_regs *regs)
 {
@@ -165,6 +168,7 @@ void __init brcmstb_hook_fault_code(void)
 	hook_fault_code(22, brcmstb_bus_error_handler, SIGBUS, 0,
 			"imprecise external abort");
 }
+#endif
 
 static irqreturn_t brcmstb_gisb_timeout_handler(int irq, void *dev_id)
 {
-- 
2.1.0
