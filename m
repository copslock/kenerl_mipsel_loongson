Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2015 05:54:20 +0100 (CET)
Received: from mxout51.expurgate.net ([194.37.255.51]:57534 "EHLO
        mxout51.expurgate.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012153AbbKTExcb9Rcp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Nov 2015 05:53:32 +0100
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1ZzdhP-0001ID-8z; Fri, 20 Nov 2015 05:53:27 +0100
Received: from [195.243.126.94] (helo=ms.tdt.de)
        by relay.expurgate.net with esmtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1ZzdhO-0004Vx-E7; Fri, 20 Nov 2015 05:53:26 +0100
Received: from mschille.tdtnet.local (10.1.3.20) by TDT-MS.TDTNET.local
 (10.1.10.2) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Fri, 20 Nov 2015
 05:53:25 +0100
From:   Martin Schiller <mschiller@tdt.de>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <ralf@linux-mips.org>, <blogic@openwrt.org>, <hauke@hauke-m.de>,
        <jogo@openwrt.org>, Martin Schiller <mschiller@tdt.de>
Subject: [PATCH 4/4] pinctrl/lantiq: fix up pinmux
Date:   Fri, 20 Nov 2015 05:52:31 +0100
Message-ID: <1447995151-3857-4-git-send-email-mschiller@tdt.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1447995151-3857-1-git-send-email-mschiller@tdt.de>
References: <1447995151-3857-1-git-send-email-mschiller@tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.1.3.20]
X-EsetResult: clean, is OK
X-EsetId: 37303A29F17133606D7564
X-C2ProcessedOrg: 0a9847a8-efc2-4cb2-92f2-0898183e658d
Content-Transfer-Encoding: 8BIT
X-purgate-relay-fid: relay-230693
X-purgate-sourceid: 1ZzdhO-0004Vx-E7
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.eleven.de for details.
X-purgate-ID: 151534::1447995207-000033D1-FDAECC9D/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-1fca43
Return-Path: <mschiller@tdt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mschiller@tdt.de
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

From: John Crispin <blogic@openwrt.org>

This patch is included in the openwrt patchset for several years now and needs
to go upstream as well. It includes the following changes:
1. Fix up inline function call to xway_mux_apply
2. Fix GPIO Setup of GPIO Port3
3. Implement gpio_chip.to_irq

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Martin Schiller <mschiller@tdt.de>
---
 drivers/pinctrl/pinctrl-xway.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
index 234d3f4..11ec71c 100644
--- a/drivers/pinctrl/pinctrl-xway.c
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -1507,10 +1507,9 @@ static struct pinctrl_desc xway_pctrl_desc = {
 	.confops	= &xway_pinconf_ops,
 };
 
-static inline int xway_mux_apply(struct pinctrl_dev *pctrldev,
+static int mux_apply(struct ltq_pinmux_info *info,
 				int pin, int mux)
 {
-	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
 	int port = PORT(pin);
 	u32 alt1_reg = GPIO_ALT1(pin);
 
@@ -1530,6 +1529,14 @@ static inline int xway_mux_apply(struct pinctrl_dev *pctrldev,
 	return 0;
 }
 
+static inline int xway_mux_apply(struct pinctrl_dev *pctrldev,
+				int pin, int mux)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+
+	return mux_apply(info, pin, mux);
+}
+
 static const struct ltq_cfg_param xway_cfg_params[] = {
 	{"lantiq,pull",		LTQ_PINCONF_PARAM_PULL},
 	{"lantiq,open-drain",	LTQ_PINCONF_PARAM_OPEN_DRAIN},
@@ -1574,12 +1581,28 @@ static int xway_gpio_dir_out(struct gpio_chip *chip, unsigned int pin, int val)
 {
 	struct ltq_pinmux_info *info = dev_get_drvdata(chip->dev);
 
+	if (PORT(pin) == PORT3)
+		gpio_setbit(info->membase[0], GPIO3_OD, PORT_PIN(pin));
+	else
+		gpio_setbit(info->membase[0], GPIO_OD(pin), PORT_PIN(pin));
 	gpio_setbit(info->membase[0], GPIO_DIR(pin), PORT_PIN(pin));
 	xway_gpio_set(chip, pin, val);
 
 	return 0;
 }
 
+static int xway_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct ltq_pinmux_info *info = dev_get_drvdata(chip->dev);
+	int i;
+
+	for (i = 0; i < info->num_exin; i++)
+		if (info->exin[i] == offset)
+			return ltq_eiu_get_irq(i);
+
+	return -1;
+}
+
 static struct gpio_chip xway_chip = {
 	.label = "gpio-xway",
 	.direction_input = xway_gpio_dir_in,
@@ -1588,6 +1611,7 @@ static struct gpio_chip xway_chip = {
 	.set = xway_gpio_set,
 	.request = gpiochip_generic_request,
 	.free = gpiochip_generic_free,
+	.to_irq = xway_gpio_to_irq,
 	.base = -1,
 };
 
-- 
2.1.4
