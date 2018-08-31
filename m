Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 17:12:47 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:49018 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994614AbeHaPMANpwpK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Aug 2018 17:12:00 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6E5D02072D; Fri, 31 Aug 2018 17:11:55 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9958722A3A;
        Fri, 31 Aug 2018 17:11:28 +0200 (CEST)
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
Subject: [PATCH v5 4/7] dt-bindings: i2c: designware: document MSCC Ocelot bindings
Date:   Fri, 31 Aug 2018 17:11:11 +0200
Message-Id: <20180831151114.25739-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
References: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65818
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

Document bindings for the Microsemi Ocelot integration of the Designware
I2C controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/i2c/i2c-designware.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index fbb0a6d8b964..3e4bcc2fb6f7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -3,6 +3,7 @@
 Required properties :
 
  - compatible : should be "snps,designware-i2c"
+                or "mscc,ocelot-i2c" with "snps,designware-i2c" for fallback
  - reg : Offset and length of the register set for the device
  - interrupts : <IRQ> where IRQ is the interrupt number.
 
@@ -11,8 +12,12 @@ Recommended properties :
  - clock-frequency : desired I2C bus clock frequency in Hz.
 
 Optional properties :
+ - reg : for "mscc,ocelot-i2c", a second register set to configure the SDA hold
+   time, named ICPU_CFG:TWI_DELAY in the datasheet.
+
  - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
-   This option is only supported in hardware blocks version 1.11a or newer.
+   This option is only supported in hardware blocks version 1.11a or newer and
+   on Microsemi SoCs ("mscc,ocelot-i2c" compatible).
 
  - i2c-scl-falling-time-ns : should contain the SCL falling time in nanoseconds.
    This value which is by default 300ns is used to compute the tLOW period.
-- 
2.19.0.rc1
