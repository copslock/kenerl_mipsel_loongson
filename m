Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 11:38:00 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56330 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835001Ab3DMJhlD0grj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 11:37:41 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/3] tty: of_serial: allow rt288x-uart to load from OF
Date:   Sat, 13 Apr 2013 11:33:36 +0200
Message-Id: <1365845618-16040-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
References: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

In order to make serial_8250 loadable via OF on Ralink WiSoC we need to default
the iotype to UPIO_RT.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/of_serial.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index b025d54..42f8550 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -98,7 +98,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->regshift = prop;
 
 	port->irq = irq_of_parse_and_map(np, 0);
-	port->iotype = UPIO_MEM;
+	if (of_device_is_compatible(np, "ralink,rt2880-uart"))
+		port->iotype = UPIO_AU;
+	else
+		port->iotype = UPIO_MEM;
 	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
 		switch (prop) {
 		case 1:
-- 
1.7.10.4
