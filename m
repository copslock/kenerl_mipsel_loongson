Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2012 15:17:00 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:42088 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870525Ab2JHNOuLaGFi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Oct 2012 15:14:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id EC8D5AA0615;
        Mon,  8 Oct 2012 15:14:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b+u++SlZ7ZhH; Mon,  8 Oct 2012 15:14:49 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 98B04AA0600;
        Mon,  8 Oct 2012 15:14:49 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Sarah Sharp <sarah.a.sharp@linux.intel.com>,
        Felipe Balbi <balbi@ti.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/32 v2] USB: move common alchemy USB routines to arch/mips/alchemy/common.c
Date:   Mon,  8 Oct 2012 15:11:40 +0200
Message-Id: <1349701906-16481-27-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349701906-16481-1-git-send-email-florian@openwrt.org>
References: <1349701906-16481-1-git-send-email-florian@openwrt.org>
X-archive-position: 34656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

A previous patch converted the Alchemy platform to use the OHCI and EHCI
platform drivers. As a result, all the common logic to handle USB present in
drivers/usb/host/alchemy-common.c has no reason to remain here, so we move it
to arch/mips/alchemy/common/usb.c which is a more appropriate place. This
change was suggested by Manuel Lauss.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes in v2:
- rebased against greg's latest usb-next

 arch/mips/alchemy/common/Makefile                  |    2 +-
 .../mips/alchemy/common/usb.c                      |    0
 drivers/usb/host/Makefile                          |    1 -
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename drivers/usb/host/alchemy-common.c => arch/mips/alchemy/common/usb.c (100%)

diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index 407ebc0..cb83d8d 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -6,7 +6,7 @@
 #
 
 obj-y += prom.o time.o clocks.o platform.o power.o setup.o \
-	sleeper.o dma.o dbdma.o vss.o irq.o
+	sleeper.o dma.o dbdma.o vss.o irq.o usb.o
 
 # optional gpiolib support
 ifeq ($(CONFIG_ALCHEMY_GPIO_INDIRECT),)
diff --git a/drivers/usb/host/alchemy-common.c b/arch/mips/alchemy/common/usb.c
similarity index 100%
rename from drivers/usb/host/alchemy-common.c
rename to arch/mips/alchemy/common/usb.c
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 9e0a89c..332ed89 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -40,6 +40,5 @@ obj-$(CONFIG_USB_HWA_HCD)	+= hwa-hc.o
 obj-$(CONFIG_USB_IMX21_HCD)	+= imx21-hcd.o
 obj-$(CONFIG_USB_FSL_MPH_DR_OF)	+= fsl-mph-dr-of.o
 obj-$(CONFIG_USB_OCTEON2_COMMON) += octeon2-common.o
-obj-$(CONFIG_MIPS_ALCHEMY)	+= alchemy-common.o
 obj-$(CONFIG_USB_HCD_BCMA)	+= bcma-hcd.o
 obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
-- 
1.7.9.5
