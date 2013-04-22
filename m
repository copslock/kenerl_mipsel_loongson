Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Apr 2013 13:57:40 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41916 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823073Ab3DVL5ihz3S5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Apr 2013 13:57:38 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ICXs77meCUyv; Mon, 22 Apr 2013 13:56:44 +0200 (CEST)
Received: from shaker64.lan (dslb-088-073-012-093.pools.arcor-ip.net [88.73.12.93])
        by arrakis.dune.hu (Postfix) with ESMTPSA id DED5128013C;
        Mon, 22 Apr 2013 13:56:43 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH] MIPS: BCM63XX: add missing clocks for BCM6328 and BCM6362
Date:   Mon, 22 Apr 2013 13:57:06 +0200
Message-Id: <1366631826-14998-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Add some mosty unused, but missing clocks for BCM6328 and BCM6362.
This also fixes PCIe init on BCM6362.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/clk.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 6601214..c726a97 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -125,11 +125,18 @@ static struct clk clk_ephy = {
  */
 static void enetsw_set(struct clk *clk, int enable)
 {
-	if (!BCMCPU_IS_6368())
+	if (BCMCPU_IS_6328())
+		bcm_hwclock_set(CKCTL_6328_ROBOSW_EN, enable);
+	else if (BCMCPU_IS_6362())
+		bcm_hwclock_set(CKCTL_6362_ROBOSW_EN, enable);
+	else if (BCMCPU_IS_6368())
+		bcm_hwclock_set(CKCTL_6368_ROBOSW_EN |
+				CKCTL_6368_SWPKT_USB_EN |
+				CKCTL_6368_SWPKT_SAR_EN,
+				enable);
+	else
 		return;
-	bcm_hwclock_set(CKCTL_6368_ROBOSW_EN |
-			CKCTL_6368_SWPKT_USB_EN |
-			CKCTL_6368_SWPKT_SAR_EN, enable);
+
 	if (enable) {
 		/* reset switch core afer clock change */
 		bcm63xx_core_set_reset(BCM63XX_RESET_ENETSW, 1);
@@ -166,6 +173,8 @@ static void usbh_set(struct clk *clk, int enable)
 		bcm_hwclock_set(CKCTL_6328_USBH_EN, enable);
 	else if (BCMCPU_IS_6348())
 		bcm_hwclock_set(CKCTL_6348_USBH_EN, enable);
+	else if (BCMCPU_IS_6362())
+		bcm_hwclock_set(CKCTL_6362_USBH_EN, enable);
 	else if (BCMCPU_IS_6368())
 		bcm_hwclock_set(CKCTL_6368_USBH_EN, enable);
 }
@@ -181,6 +190,8 @@ static void usbd_set(struct clk *clk, int enable)
 {
 	if (BCMCPU_IS_6328())
 		bcm_hwclock_set(CKCTL_6328_USBD_EN, enable);
+	else if (BCMCPU_IS_6362())
+		bcm_hwclock_set(CKCTL_6362_USBD_EN, enable);
 	else if (BCMCPU_IS_6368())
 		bcm_hwclock_set(CKCTL_6368_USBD_EN, enable);
 }
@@ -244,7 +255,10 @@ static struct clk clk_xtm = {
  */
 static void ipsec_set(struct clk *clk, int enable)
 {
-	bcm_hwclock_set(CKCTL_6368_IPSEC_EN, enable);
+	if (BCMCPU_IS_6362())
+		bcm_hwclock_set(CKCTL_6362_IPSEC_EN, enable);
+	else if (BCMCPU_IS_6368())
+		bcm_hwclock_set(CKCTL_6368_IPSEC_EN, enable);
 }
 
 static struct clk clk_ipsec = {
@@ -257,7 +271,10 @@ static struct clk clk_ipsec = {
 
 static void pcie_set(struct clk *clk, int enable)
 {
-	bcm_hwclock_set(CKCTL_6328_PCIE_EN, enable);
+	if (BCMCPU_IS_6328())
+		bcm_hwclock_set(CKCTL_6328_PCIE_EN, enable);
+	else if (BCMCPU_IS_6362())
+		bcm_hwclock_set(CKCTL_6362_PCIE_EN, enable);
 }
 
 static struct clk clk_pcie = {
@@ -323,9 +340,9 @@ struct clk *clk_get(struct device *dev, const char *id)
 		return &clk_periph;
 	if (BCMCPU_IS_6358() && !strcmp(id, "pcm"))
 		return &clk_pcm;
-	if (BCMCPU_IS_6368() && !strcmp(id, "ipsec"))
+	if ((BCMCPU_IS_6362() || BCMCPU_IS_6368()) && !strcmp(id, "ipsec"))
 		return &clk_ipsec;
-	if (BCMCPU_IS_6328() && !strcmp(id, "pcie"))
+	if ((BCMCPU_IS_6328() || BCMCPU_IS_6362()) && !strcmp(id, "pcie"))
 		return &clk_pcie;
 	return ERR_PTR(-ENOENT);
 }
-- 
1.7.10.4
