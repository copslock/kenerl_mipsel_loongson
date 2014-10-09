Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 11:35:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4992 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010923AbaJIJepv6T91 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 11:34:45 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4765979E8CEE8
        for <linux-mips@linux-mips.org>; Thu,  9 Oct 2014 10:34:37 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 9 Oct
 2014 10:34:39 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Oct 2014 10:34:38 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.56) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Oct 2014 10:34:38 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/3] MIPS: sead3: Build the I2C related devices if CONFIG_I2C is enabled
Date:   Thu, 9 Oct 2014 10:34:20 +0100
Message-ID: <1412847261-7930-3-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 43117
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

There is no point building the drivers for the i2c related devices if
CONFIG_I2C is not enabled.

This also fixes a randconfig problem:

arch/mips/mti-sead3/sead3-pic32-i2c-drv.c: In function 'i2c_platform_probe':
arch/mips/mti-sead3/sead3-pic32-i2c-drv.c:345:2: error: implicit declaration of
function 'i2c_add_numbered_adapter' [-Werror=implicit-function-declaration]
  ret = i2c_add_numbered_adapter(&priv->adap);
    ^
arch/mips/mti-sead3/sead3-pic32-i2c-drv.c: In function
'i2c_platform_remove':
arch/mips/mti-sead3/sead3-pic32-i2c-drv.c:361:2: error: implicit declaration
of function 'i2c_del_adapter' [-Werror=implicit-function-declaration]
i2c_del_adapter(&priv->adap);

Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mti-sead3/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index 071786fa234b..a632b9cfe526 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -13,11 +13,11 @@ obj-y				:= sead3-lcd.o sead3-display.o sead3-init.o \
 				   sead3-platform.o sead3-reset.o \
 				   sead3-setup.o sead3-time.o
 
-obj-y				+= sead3-i2c-dev.o sead3-i2c.o \
-				   sead3-pic32-i2c-drv.o sead3-pic32-bus.o \
-				   leds-sead3.o sead3-leds.o
+obj-y				+= leds-sead3.o sead3-leds.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
+obj-$(CONFIG_I2C)		+= sead3-i2c.o sead3-i2c-dev.o \
+				   sead3-pic32-bus.o lsead3-pic32-i2c-drv.o
 obj-$(CONFIG_USB_EHCI_HCD)	+= sead3-ehci.o
 obj-$(CONFIG_OF)		+= sead3.dtb.o
 
-- 
2.1.2
