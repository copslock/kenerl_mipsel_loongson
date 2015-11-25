Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 11:20:44 +0100 (CET)
Received: from mxout51.expurgate.net ([91.198.224.51]:52085 "EHLO
        mxout51.expurgate.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011855AbbKYKTrJ0ovd convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2015 11:19:47 +0100
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a1XAr-000109-Rd; Wed, 25 Nov 2015 11:19:41 +0100
Received: from [195.243.126.94] (helo=ms.tdt.de)
        by relay.expurgate.net with esmtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a1XAq-00009m-VK; Wed, 25 Nov 2015 11:19:41 +0100
Received: from mschille.tdtnet.local (10.1.3.20) by TDT-MS.TDTNET.local
 (10.1.10.2) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Wed, 25 Nov 2015
 11:19:40 +0100
From:   Martin Schiller <mschiller@tdt.de>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <ralf@linux-mips.org>, <blogic@openwrt.org>, <hauke@hauke-m.de>,
        <jogo@openwrt.org>, <daniel.schwierzeck@gmail.com>,
        Martin Schiller <mschiller@tdt.de>
Subject: [PATCH v2 4/4] pinctrl/lantiq: fix up pinmux
Date:   Wed, 25 Nov 2015 11:18:59 +0100
Message-ID: <1448446739-5541-4-git-send-email-mschiller@tdt.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1448446739-5541-1-git-send-email-mschiller@tdt.de>
References: <1448446739-5541-1-git-send-email-mschiller@tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.1.3.20]
X-EsetResult: clean, is OK
X-EsetId: 37303A29F17133606D7D66
X-C2ProcessedOrg: 0a9847a8-efc2-4cb2-92f2-0898183e658d
Content-Transfer-Encoding: 8BIT
X-purgate-relay-fid: relay-9b77e0
X-purgate-sourceid: 1a1XAq-00009m-VK
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.eleven.de for details.
X-purgate-ID: 151534::1448446781-000066A1-5635C9BC/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-3cc1a3
Return-Path: <mschiller@tdt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50083
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
index a064962..f0b1b48 100644
--- a/drivers/pinctrl/pinctrl-xway.c
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -1496,10 +1496,9 @@ static struct pinctrl_desc xway_pctrl_desc = {
 	.confops	= &xway_pinconf_ops,
 };
 
-static inline int xway_mux_apply(struct pinctrl_dev *pctrldev,
+static int mux_apply(struct ltq_pinmux_info *info,
 				int pin, int mux)
 {
-	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
 	int port = PORT(pin);
 	u32 alt1_reg = GPIO_ALT1(pin);
 
@@ -1519,6 +1518,14 @@ static inline int xway_mux_apply(struct pinctrl_dev *pctrldev,
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
@@ -1563,12 +1570,28 @@ static int xway_gpio_dir_out(struct gpio_chip *chip, unsigned int pin, int val)
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
@@ -1577,6 +1600,7 @@ static struct gpio_chip xway_chip = {
 	.set = xway_gpio_set,
 	.request = gpiochip_generic_request,
 	.free = gpiochip_generic_free,
+	.to_irq = xway_gpio_to_irq,
 	.base = -1,
 };
 
-- 
2.1.4
