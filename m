Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 07:24:17 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:53262 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901172Ab2FWFXp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jun 2012 07:23:45 +0200
Received: (qmail 25601 invoked from network); 23 Jun 2012 05:23:42 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 23 Jun 2012 05:23:42 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Fri, 22 Jun 2012 22:23:42 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     <ffainelli@freebox.fr>, <mbizon@freebox.fr>,
        <jonas.gorski@gmail.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 1/7] MIPS: BCM63XX: Expose the USBH/USBD clocks on
 BCM6328/BCM6368
Date:   Fri, 22 Jun 2012 22:14:51 -0700
Message-Id: <0d275370a7def10f11d86b127ba502e5@localhost>
In-Reply-To: <0f67eabbb0d5c59add27e42a08b94944@localhost>
References: <0f67eabbb0d5c59add27e42a08b94944@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 33790
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/bcm63xx/clk.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 1db48ad..dff79ab 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -160,7 +160,9 @@ static struct clk clk_pcm = {
  */
 static void usbh_set(struct clk *clk, int enable)
 {
-	if (BCMCPU_IS_6348())
+	if (BCMCPU_IS_6328())
+		bcm_hwclock_set(CKCTL_6328_USBH_EN, enable);
+	else if (BCMCPU_IS_6348())
 		bcm_hwclock_set(CKCTL_6348_USBH_EN, enable);
 	else if (BCMCPU_IS_6368())
 		bcm_hwclock_set(CKCTL_6368_USBH_EN, enable);
@@ -171,6 +173,21 @@ static struct clk clk_usbh = {
 };
 
 /*
+ * USB device clock
+ */
+static void usbd_set(struct clk *clk, int enable)
+{
+	if (BCMCPU_IS_6328())
+		bcm_hwclock_set(CKCTL_6328_USBD_EN, enable);
+	else if (BCMCPU_IS_6368())
+		bcm_hwclock_set(CKCTL_6368_USBD_EN, enable);
+}
+
+static struct clk clk_usbd = {
+	.set	= usbd_set,
+};
+
+/*
  * SPI clock
  */
 static void spi_set(struct clk *clk, int enable)
@@ -284,6 +301,8 @@ struct clk *clk_get(struct device *dev, const char *id)
 		return &clk_ephy;
 	if (!strcmp(id, "usbh"))
 		return &clk_usbh;
+	if (!strcmp(id, "usbd"))
+		return &clk_usbd;
 	if (!strcmp(id, "spi"))
 		return &clk_spi;
 	if (!strcmp(id, "xtm"))
-- 
1.7.11.1
