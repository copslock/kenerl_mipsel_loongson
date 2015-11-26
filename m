Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2015 11:02:41 +0100 (CET)
Received: from mxout51.expurgate.net ([194.37.255.51]:59331 "EHLO
        mxout51.expurgate.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012734AbbKZKB5Of7hI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2015 11:01:57 +0100
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a1tN9-0003Kb-Vu; Thu, 26 Nov 2015 11:01:52 +0100
Received: from [195.243.126.94] (helo=ms.tdt.de)
        by relay.expurgate.net with esmtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a1tN9-0002go-25; Thu, 26 Nov 2015 11:01:51 +0100
Received: from mschille.tdtnet.local (10.1.3.20) by TDT-MS.TDTNET.local
 (10.1.10.2) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Thu, 26 Nov 2015
 11:01:49 +0100
From:   Martin Schiller <mschiller@tdt.de>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <ralf@linux-mips.org>, <blogic@openwrt.org>, <hauke@hauke-m.de>,
        <jogo@openwrt.org>, <daniel.schwierzeck@gmail.com>,
        Martin Schiller <mschiller@tdt.de>
Subject: [PATCH v3 5/5] pinctrl/lantiq: Implement gpio_chip.to_irq
Date:   Thu, 26 Nov 2015 11:00:10 +0100
Message-ID: <1448532010-30930-5-git-send-email-mschiller@tdt.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1448532010-30930-1-git-send-email-mschiller@tdt.de>
References: <1448532010-30930-1-git-send-email-mschiller@tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.1.3.20]
X-EsetResult: clean, is OK
X-EsetId: 37303A29F17133606C7561
X-C2ProcessedOrg: 0a9847a8-efc2-4cb2-92f2-0898183e658d
Content-Transfer-Encoding: 8BIT
X-purgate-relay-fid: relay-5443cb
X-purgate-sourceid: 1a1tN9-0002go-25
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.eleven.de for details.
X-purgate-ID: 151534::1448532111-00006013-CC150195/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-938205
Return-Path: <mschiller@tdt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50139
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

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Martin Schiller <mschiller@tdt.de>
---
Changes in v3:
- Moved this change into a separate patch

Changes in v2: 
None

 drivers/pinctrl/pinctrl-xway.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
index b78baaa..8ae99a8 100644
--- a/drivers/pinctrl/pinctrl-xway.c
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -1573,6 +1573,18 @@ static int xway_gpio_dir_out(struct gpio_chip *chip, unsigned int pin, int val)
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
@@ -1581,6 +1593,7 @@ static struct gpio_chip xway_chip = {
 	.set = xway_gpio_set,
 	.request = gpiochip_generic_request,
 	.free = gpiochip_generic_free,
+	.to_irq = xway_gpio_to_irq,
 	.base = -1,
 };
 
-- 
2.1.4
