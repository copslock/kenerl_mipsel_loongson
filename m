Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 10:27:11 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:45520 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20032629AbZC2J1C (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 29 Mar 2009 10:27:02 +0100
Received: (qmail 22290 invoked from network); 29 Mar 2009 11:26:14 +0200
Received: from flagship.roarinelk.net (HELO localhost.localdomain) (192.168.0.197)
  by 192.168.0.1 with SMTP; 29 Mar 2009 11:26:14 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 2/3] Alchemy: add RTC device to devboards
Date:	Sun, 29 Mar 2009 11:27:01 +0200
Message-Id: <1238318822-4772-3-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1238318822-4772-2-git-send-email-mano@roarinelk.homelinux.net>
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net>
 <1238318822-4772-2-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Add a platform_device for on-chip RTC (32kHz counter0) on all devboards

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
Tested on the DB1200 only;  according to their schematics, all other
devboards do have a 32.768kHz crystal too and this patch should work.

 arch/mips/alchemy/devboards/db1x00/platform.c |    6 ++++++
 arch/mips/alchemy/devboards/pb1000/platform.c |    6 ++++++
 arch/mips/alchemy/devboards/pb1100/platform.c |    6 ++++++
 arch/mips/alchemy/devboards/pb1200/platform.c |    6 ++++++
 arch/mips/alchemy/devboards/pb1500/platform.c |    6 ++++++
 arch/mips/alchemy/devboards/pb1550/platform.c |    6 ++++++
 6 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index 49d6e5c..a6fb6bd 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -137,6 +137,11 @@ static struct platform_device pbdb_smbus_device = {
 };
 #endif
 
+static struct platform_device au1xxx_rtc_device = {
+	.name		= "rtc-au1xxx",
+	.id		= -1,
+};
+
 static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&au1xx0_uart_device,
 	&au1xxx_usb_ohci_device,
@@ -147,6 +152,7 @@ static struct platform_device *au1xxx_platform_devices[] __initdata = {
 #ifdef SMBUS_PSC_BASE
 	&pbdb_smbus_device,
 #endif
+	&au1xxx_rtc_device,
 };
 
 static int __init au1xxx_platform_init(void)
diff --git a/arch/mips/alchemy/devboards/pb1000/platform.c b/arch/mips/alchemy/devboards/pb1000/platform.c
index 0661a49..9f42f4c 100644
--- a/arch/mips/alchemy/devboards/pb1000/platform.c
+++ b/arch/mips/alchemy/devboards/pb1000/platform.c
@@ -68,10 +68,16 @@ static struct platform_device pb1000_pcmcia_device = {
 	.id 		= 0,
 };
 
+static struct platform_device au1xxx_rtc_device = {
+	.name 		= "rtc-au1xxx",
+	.id 		= -1,
+};
+
 static struct platform_device *pb1000_devices[] = {
 	&pb1000_uart_device,
 	&au1xxx_usb_ohci_device,
 	&pb1000_pcmcia_device,
+	&au1xxx_rtc_device,
 };
 
 static int __init pb1000_platform_init(void)
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
index 276db5a..42759f9 100644
--- a/arch/mips/alchemy/devboards/pb1100/platform.c
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -93,11 +93,17 @@ static struct platform_device au1100_lcd_device = {
 	.resource       = au1100_lcd_resources,
 };
 
+static struct platform_device au1xxx_rtc_device = {
+	.name 		= "rtc-au1xxx",
+	.id 		= -1,
+};
+
 static struct platform_device *pb1100_devices[] = {
 	&pb1100_uart_device,
 	&au1xxx_usb_ohci_device,
 	&pb1100_pcmcia_device,
 	&au1100_lcd_device,
+	&au1xxx_rtc_device,
 };
 
 static int __init pb1100_platform_init(void)
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index ff446a5..f32391e 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -326,6 +326,11 @@ static struct platform_device pb1200_smbus_device = {
 	.resource	= pb1200_smbus_resources,
 };
 
+static struct platform_device au1xxx_rtc_device = {
+	.name 		= "rtc-au1xxx",
+	.id 		= -1,
+};
+
 static struct platform_device *board_platform_devices[] __initdata = {
 	&au1200_uart_device,
 	&ide_device,
@@ -336,6 +341,7 @@ static struct platform_device *board_platform_devices[] __initdata = {
 	&au1xxx_usb_otg_device,
 	&au1200_lcd_device,
 	&pb1200_smbus_device,
+	&au1xxx_rtc_device,
 };
 
 static int __init board_register_devices(void)
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
index 5c68d68..affb3e1 100644
--- a/arch/mips/alchemy/devboards/pb1500/platform.c
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -66,10 +66,16 @@ static struct platform_device pb1500_pcmcia_device = {
 	.id 		= 0,
 };
 
+static struct platform_device au1xxx_rtc_device = {
+	.name 		= "rtc-au1xxx",
+	.id 		= -1,
+};
+
 static struct platform_device *pb1500_devices[] = {
 	&pb1500_uart_device,
 	&au1xxx_usb_ohci_device,
 	&pb1500_pcmcia_device,
+	&au1xxx_rtc_device,
 };
 
 static int __init pb1500_platform_init(void)
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
index f653193..717ff02 100644
--- a/arch/mips/alchemy/devboards/pb1550/platform.c
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c
@@ -83,11 +83,17 @@ static struct platform_device pb1550_smbus_device = {
 	.resource	= pb1550_smbus_resources,
 };
 
+static struct platform_device au1xxx_rtc_device = {
+	.name 		= "rtc-au1xxx",
+	.id 		= -1,
+};
+
 static struct platform_device *pb1550_devices[] = {
 	&pb1550_uart_device,
 	&au1xxx_usb_ohci_device,
 	&pb1550_pcmcia_device,
 	&pb1550_smbus_device,
+	&au1xxx_rtc_device,
 };
 
 static int __init pb1550_platform_init(void)
-- 
1.6.2
