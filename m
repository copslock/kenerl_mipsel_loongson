Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 19:27:31 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:47524 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825732AbaABS13zJgAe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 19:27:29 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 1494D8F61;
        Thu,  2 Jan 2014 19:27:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KnczV2PtlEQB; Thu,  2 Jan 2014 19:27:25 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 33F31857F;
        Thu,  2 Jan 2014 19:27:25 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: BCM47XX: check length of serial console array
Date:   Thu,  2 Jan 2014 19:27:22 +0100
Message-Id: <1388687242-8168-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/serial.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/serial.c b/arch/mips/bcm47xx/serial.c
index b8ef965..2f5bbd6 100644
--- a/arch/mips/bcm47xx/serial.c
+++ b/arch/mips/bcm47xx/serial.c
@@ -31,7 +31,8 @@ static int __init uart8250_init_ssb(void)
 
 	memset(&uart8250_data, 0,  sizeof(uart8250_data));
 
-	for (i = 0; i < mcore->nr_serial_ports; i++) {
+	for (i = 0; i < mcore->nr_serial_ports &&
+		    i < ARRAY_SIZE(uart8250_data) - 1; i++) {
 		struct plat_serial8250_port *p = &(uart8250_data[i]);
 		struct ssb_serial_port *ssb_port = &(mcore->serial_ports[i]);
 
@@ -55,7 +56,8 @@ static int __init uart8250_init_bcma(void)
 
 	memset(&uart8250_data, 0,  sizeof(uart8250_data));
 
-	for (i = 0; i < cc->nr_serial_ports; i++) {
+	for (i = 0; i < cc->nr_serial_ports &&
+		    i < ARRAY_SIZE(uart8250_data) - 1; i++) {
 		struct plat_serial8250_port *p = &(uart8250_data[i]);
 		struct bcma_serial_port *bcma_port;
 		bcma_port = &(cc->serial_ports[i]);
-- 
1.7.10.4
