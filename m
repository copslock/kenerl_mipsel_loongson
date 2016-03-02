Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 09:16:23 +0100 (CET)
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33772 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007383AbcCBIQVHuGA7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 09:16:21 +0100
Received: by mail-wm0-f48.google.com with SMTP id l68so68629364wml.0;
        Wed, 02 Mar 2016 00:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vvTfqP1D4BGcOZ0E6JIOtU2u2iTUpO5dUzstbbDHvb8=;
        b=0gmCRQhAV6OW6zCpGiKc5ZVdh+ctw+ZN/44ntCIyi+uLAd+yzgwX2CPjA7diwVzh1A
         3IEQtXeyVNQ2xspC2hKJgq2JBDug6Xsv96S5b/yS3Osy/G7FXE0XI6WfToUBlbkXD+0A
         2kCNVcGTBzRwG36Ma2157dX14o9V3QPafNekPbJBErTwvB7geNQjQ3qbUOTUDjOILwJD
         w36VStN7xI5QTBp5psodvtAFVM6gx32OKmUcO8iZVBuHKwurZr5s/tDPKnAoFQxDy/wW
         gXwbPWOHnGyzrzq3/iK03vzI8Eys3JNsRvlPUmmHdeVBdH5qTGcWnRjwx6X7kdM/S4n4
         mHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vvTfqP1D4BGcOZ0E6JIOtU2u2iTUpO5dUzstbbDHvb8=;
        b=GlqVxWY6jBq36iCQXf7HlO2RisRPiruEBOdX0WDtV/EMVoXZ4nc/0xLAhVXEV0vuJY
         cTKwL9nYAfFDwchiPW6BD4eC0HPXjMNcJpIvaaSLIPO6BECYmzuu++kj10Ou4UVt0KUt
         IqvPmdcmvKXKoLt00m16OKNuG0CtT0tfkJy8stLCgU6jznGWr0bW1px9gacULzVcCP+k
         3LqFkm5IS0JdU/HrmisFf0B8Q+syGx32OBSdUeRxSS1w0GYPcKppWUSiNyuXRzAW+Iom
         pddyV0ntRBYzLSRjsmonSI+VWY0uNTkTsW4E1XTSg6ttG2zaP09JxSwuRpbAqWgQSfuS
         Cg5Q==
X-Gm-Message-State: AD7BkJJFeWRv1hWruZV+xcZ/y0GbzJKM/RHWpe8UGwiRjqkGMncbUWcgamvMPqdPMBNFeA==
X-Received: by 10.28.0.86 with SMTP id 83mr3336526wma.63.1456906575296;
        Wed, 02 Mar 2016 00:16:15 -0800 (PST)
Received: from dargo.Speedport_W_724V_Typ_A_05011603_00_009 (p200300874C0F583536E6D7FFFE14BFA6.dip0.t-ipconnect.de. [2003:87:4c0f:5835:36e6:d7ff:fe14:bfa6])
        by smtp.gmail.com with ESMTPSA id z127sm2917013wme.5.2016.03.02.00.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Mar 2016 00:16:14 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     linux-pcmcia@lists.infradead.org
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, arnd@arndb.de,
        linus.walleij@linaro.org, Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] pcmcia: db1xxx_ss: fix last irq_to_gpio user
Date:   Wed,  2 Mar 2016 09:16:12 +0100
Message-Id: <1456906572-101795-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.7.2
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

remove the usage of removed irq_to_gpio() function.  On pre-DB1200
boards, pass the actual carddetect GPIO number instead of the IRQ,
because we need the gpio to actually test card status (inserted or
not) and can get the irq number with gpio_to_irq() instead.

Tested on DB1300 and DB1500, this patch fixes PCMCIA on the DB1500,
which used irq_to_gpio().

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1000.c | 18 ++++++++----------
 arch/mips/alchemy/devboards/db1550.c |  4 ++--
 drivers/pcmcia/db1xxx_ss.c           | 11 +++++++++--
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index bdeed9d..433c4b9 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -503,15 +503,15 @@ int __init db1000_dev_setup(void)
 	if (board == BCSR_WHOAMI_DB1500) {
 		c0 = AU1500_GPIO2_INT;
 		c1 = AU1500_GPIO5_INT;
-		d0 = AU1500_GPIO0_INT;
-		d1 = AU1500_GPIO3_INT;
+		d0 = 0;	/* GPIO number, NOT irq! */
+		d1 = 3; /* GPIO number, NOT irq! */
 		s0 = AU1500_GPIO1_INT;
 		s1 = AU1500_GPIO4_INT;
 	} else if (board == BCSR_WHOAMI_DB1100) {
 		c0 = AU1100_GPIO2_INT;
 		c1 = AU1100_GPIO5_INT;
-		d0 = AU1100_GPIO0_INT;
-		d1 = AU1100_GPIO3_INT;
+		d0 = 0; /* GPIO number, NOT irq! */
+		d1 = 3; /* GPIO number, NOT irq! */
 		s0 = AU1100_GPIO1_INT;
 		s1 = AU1100_GPIO4_INT;
 
@@ -545,15 +545,15 @@ int __init db1000_dev_setup(void)
 	} else if (board == BCSR_WHOAMI_DB1000) {
 		c0 = AU1000_GPIO2_INT;
 		c1 = AU1000_GPIO5_INT;
-		d0 = AU1000_GPIO0_INT;
-		d1 = AU1000_GPIO3_INT;
+		d0 = 0; /* GPIO number, NOT irq! */
+		d1 = 3; /* GPIO number, NOT irq! */
 		s0 = AU1000_GPIO1_INT;
 		s1 = AU1000_GPIO4_INT;
 		platform_add_devices(db1000_devs, ARRAY_SIZE(db1000_devs));
 	} else if ((board == BCSR_WHOAMI_PB1500) ||
 		   (board == BCSR_WHOAMI_PB1500R2)) {
 		c0 = AU1500_GPIO203_INT;
-		d0 = AU1500_GPIO201_INT;
+		d0 = 1; /* GPIO number, NOT irq! */
 		s0 = AU1500_GPIO202_INT;
 		twosocks = 0;
 		flashsize = 64;
@@ -566,7 +566,7 @@ int __init db1000_dev_setup(void)
 		 */
 	} else if (board == BCSR_WHOAMI_PB1100) {
 		c0 = AU1100_GPIO11_INT;
-		d0 = AU1100_GPIO9_INT;
+		d0 = 9; /* GPIO number, NOT irq! */
 		s0 = AU1100_GPIO10_INT;
 		twosocks = 0;
 		flashsize = 64;
@@ -583,7 +583,6 @@ int __init db1000_dev_setup(void)
 	} else
 		return 0; /* unknown board, no further dev setup to do */
 
-	irq_set_irq_type(d0, IRQ_TYPE_EDGE_BOTH);
 	irq_set_irq_type(c0, IRQ_TYPE_LEVEL_LOW);
 	irq_set_irq_type(s0, IRQ_TYPE_LEVEL_LOW);
 
@@ -597,7 +596,6 @@ int __init db1000_dev_setup(void)
 		c0, d0, /*s0*/0, 0, 0);
 
 	if (twosocks) {
-		irq_set_irq_type(d1, IRQ_TYPE_EDGE_BOTH);
 		irq_set_irq_type(c1, IRQ_TYPE_LEVEL_LOW);
 		irq_set_irq_type(s1, IRQ_TYPE_LEVEL_LOW);
 
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index b518f02..1c01d6e 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -514,7 +514,7 @@ static void __init db1550_devices(void)
 		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
 		AU1000_PCMCIA_IO_PHYS_ADDR,
 		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		AU1550_GPIO3_INT, AU1550_GPIO0_INT,
+		AU1550_GPIO3_INT, 0,
 		/*AU1550_GPIO21_INT*/0, 0, 0);
 
 	db1x_register_pcmcia_socket(
@@ -524,7 +524,7 @@ static void __init db1550_devices(void)
 		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
 		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
 		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
-		AU1550_GPIO5_INT, AU1550_GPIO1_INT,
+		AU1550_GPIO5_INT, 1,
 		/*AU1550_GPIO22_INT*/0, 0, 1);
 
 	platform_device_register(&db1550_nand_dev);
diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index 4c2fa05..944674e 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -56,6 +56,7 @@ struct db1x_pcmcia_sock {
 	int	stschg_irq;	/* card-status-change irq */
 	int	card_irq;	/* card irq */
 	int	eject_irq;	/* db1200/pb1200 have these */
+	int	insert_gpio;	/* db1000 carddetect gpio */
 
 #define BOARD_TYPE_DEFAULT	0	/* most boards */
 #define BOARD_TYPE_DB1200	1	/* IRQs aren't gpios */
@@ -83,7 +84,7 @@ static int db1200_card_inserted(struct db1x_pcmcia_sock *sock)
 /* carddetect gpio: low-active */
 static int db1000_card_inserted(struct db1x_pcmcia_sock *sock)
 {
-	return !gpio_get_value(irq_to_gpio(sock->insert_irq));
+	return !gpio_get_value(sock->insert_gpio);
 }
 
 static int db1x_card_inserted(struct db1x_pcmcia_sock *sock)
@@ -457,9 +458,15 @@ static int db1x_pcmcia_socket_probe(struct platform_device *pdev)
 	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "card");
 	sock->card_irq = r ? r->start : 0;
 
-	/* insert: irq which triggers on card insertion/ejection */
+	/* insert: irq which triggers on card insertion/ejection
+	 * BIG FAT NOTE: on DB1000/1100/1500/1550 we pass a GPIO here!
+	 */
 	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "insert");
 	sock->insert_irq = r ? r->start : -1;
+	if (sock->board_type == BOARD_TYPE_DEFAULT) {
+		sock->insert_gpio = r ? r->start : -1;
+		sock->insert_irq = r ? gpio_to_irq(r->start) : -1;
+	}
 
 	/* stschg: irq which trigger on card status change (optional) */
 	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "stschg");
-- 
2.7.2
