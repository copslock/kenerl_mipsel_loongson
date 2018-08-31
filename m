Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 17:13:07 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:49037 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994601AbeHaPMCbTKMK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Aug 2018 17:12:02 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AA98D22A39; Fri, 31 Aug 2018 17:11:57 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9DAFF22A3E;
        Fri, 31 Aug 2018 17:11:29 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 7/7] MIPS: dts: mscc: enable i2c on ocelot_pcb123
Date:   Fri, 31 Aug 2018 17:11:14 +0200
Message-Id: <20180831151114.25739-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
References: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Enable the i2c controller on ocelot PCB123. While there are no i2c devices
on the board itself, it can be used to control the SFP transceivers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
index 2266027759f9..ef852f382da8 100644
--- a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
@@ -36,6 +36,12 @@
 	};
 };
 
+&i2c {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	status = "okay";
+};
+
 &mdio0 {
 	status = "okay";
 };
-- 
2.19.0.rc1
