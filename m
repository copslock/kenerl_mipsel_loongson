Return-Path: <SRS0=kNgS=XF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A418C4740A
	for <linux-mips@archiver.kernel.org>; Tue, 10 Sep 2019 13:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7B5208E4
	for <linux-mips@archiver.kernel.org>; Tue, 10 Sep 2019 13:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbfIJNtB (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 10 Sep 2019 09:49:01 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:48090 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbfIJNtB (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 10 Sep 2019 09:49:01 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: MElAMnx6DZVg0Fxo1HADhYt/CKppFOarcOtVBiJiMKeqVnerD1EXIxGfHfSFctWJdco3XjLv78
 xUkwH1JjmqvCa9jwOWHft9UhE4IXIlyPDEqRDe1OmIoHKpYSIJkLv0x17aUJyITNTyMRWpbodc
 lneFK/GmovYQEw7PxtjEpC6x3k055LWthXiCT2LjFHc4mhhZjgYC9JbHpDUcCEUuK6GlcFGY4v
 IB24qVrPtZXjzjhQigi2HVgLJL1r1E4yVKmsBEmm+UvKvhVt0qxPzmjS9H6KMJaeRjzAMwOHH2
 jYg=
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="46913719"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2019 06:48:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Sep 2019 06:48:58 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 10 Sep 2019 06:48:36 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>, <nsekhar@ti.com>,
        <bgolaszewski@baylibre.com>, <monstr@monstr.eu>,
        <john@phrozen.org>, <ralf@linux-mips.org>, <paul.burton@mips.com>,
        <jhogan@kernel.org>, <lftan@altera.com>, <tglx@linutronix.de>,
        <vgupta@synopsys.com>, <marc.zyngier@arm.com>,
        <patrice.chotard@st.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <eric@anholt.net>, <wahrenst@gmx.net>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <linus.walleij@linaro.org>, <shc_work@mail.ru>, <kgene@kernel.org>,
        <krzk@kernel.org>, <ysato@users.sourceforge.jp>,
        <liviu.dudau@arm.com>, <sudeep.holla@arm.com>,
        <lorenzo.pieralisi@arm.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>, <baohua@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <baruch@tkos.co.il>,
        <u.kleine-koenig@pengutronix.de>, <guoren@kernel.org>,
        <kaloz@openwrt.org>, <khalasa@piap.pl>, <ssantosh@kernel.org>,
        <vz@mleia.com>, <slemieux.tyco@gmail.com>, <khilman@baylibre.com>,
        <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <afaerber@suse.de>,
        <manivannan.sadhasivam@linaro.org>, <narmstrong@baylibre.com>,
        <agross@kernel.org>, <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <heiko@sntech.de>, <orsonzhai@gmail.com>, <baolin.wang@linaro.org>,
        <zhang.lyra@gmail.com>, <maxime.ripard@bootlin.com>,
        <wens@csie.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux@prisktech.co.nz>,
        <john.stultz@linaro.org>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mips@vger.kernel.org>, <nios2-dev@lists.rocketboards.org>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <uclinux-h8-devel@lists.sourceforge.jp>,
        <linux-amlogic@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
        <linux-oxnas@groups.io>, <linux-arm-msm@vger.kernel.org>,
        <linux-unisoc@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 3/7] clocksource/timer_of: use BIT() macro
Date:   Tue, 10 Sep 2019 16:47:12 +0300
Message-ID: <1568123236-767-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568123236-767-1-git-send-email-claudiu.beznea@microchip.com>
References: <1568123236-767-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Use BIT() macro for timer_of flags.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/timer-of.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index ee467bb16ca3..df861ea2ec42 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -4,9 +4,9 @@
 
 #include <linux/clockchips.h>
 
-#define TIMER_OF_BASE	0x1
-#define TIMER_OF_CLOCK	0x2
-#define TIMER_OF_IRQ	0x4
+#define TIMER_OF_BASE		BIT(0)
+#define TIMER_OF_CLOCK		BIT(1)
+#define TIMER_OF_IRQ		BIT(2)
 
 struct of_timer_irq {
 	int irq;
-- 
2.7.4

