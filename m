Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 11:35:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39298 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010924AbaJIJeqiQoFB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 11:34:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1E21BCE5D2BE3
        for <linux-mips@linux-mips.org>; Thu,  9 Oct 2014 10:34:38 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Oct 2014 10:34:40 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.56) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Oct 2014 10:34:39 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 3/3] MIPS: sead3: Only build the led driver if LEDS_CLASS is enabled
Date:   Thu, 9 Oct 2014 10:34:21 +0100
Message-ID: <1412847261-7930-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <1412847261-7930-1-git-send-email-markos.chandras@imgtec.com>
References: <1412847261-7930-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.56]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Fixes the following randconfig problem

leds-sead3.c:(.text+0x7dc): undefined reference to `led_classdev_unregister'
leds-sead3.c:(.text+0x7e8): undefined reference to `led_classdev_unregister'

Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mti-sead3/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index a632b9cfe526..10093fc9ebc9 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -13,11 +13,10 @@ obj-y				:= sead3-lcd.o sead3-display.o sead3-init.o \
 				   sead3-platform.o sead3-reset.o \
 				   sead3-setup.o sead3-time.o
 
-obj-y				+= leds-sead3.o sead3-leds.o
-
 obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
 obj-$(CONFIG_I2C)		+= sead3-i2c.o sead3-i2c-dev.o \
 				   sead3-pic32-bus.o lsead3-pic32-i2c-drv.o
+obj-$(LEDS_CLASS)		+= leds-sead3.o sead3-leds.o
 obj-$(CONFIG_USB_EHCI_HCD)	+= sead3-ehci.o
 obj-$(CONFIG_OF)		+= sead3.dtb.o
 
-- 
2.1.2
