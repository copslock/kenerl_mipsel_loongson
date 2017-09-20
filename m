Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 13:19:04 +0200 (CEST)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:36530
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993967AbdITLQYkT4TX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 13:16:24 +0200
Received: by mail-wm0-x244.google.com with SMTP id r136so2119757wmf.3;
        Wed, 20 Sep 2017 04:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PMaxpNmYe07DmlqFixN6iuB9Mcv3FxUJUtqqkedrCeg=;
        b=RqHu/z7ZZXibkAwk/YywRGb6hZp5BNQgaaCVowa5WKFThavLJ8YQ1lmXDkYI+PkGrZ
         0g4TG0vhhZ+aA2IuGy3e2WZd4n3SHSUqGPw3SRNSCGMMnSB4cY3w+QfoTk2ph5lHxCUF
         PGgN3TPL5sGpvSzx2X/8g3ESPuPgEzSSiqPo8MaReDlaOGZE1zSZXQr3Xel2LVHuRCV1
         hhTzgwfvAL96epcUIho2uGQPlY98G3+KwBCbGVmXH0bIkCkmZkuEOFgwR1BduR9A5D6Y
         4ZdP6TD6w6M9glxGGT4IGpxLCd2WF2isqVOib4qk4J1XMT22sazGD2dEB/xiaIaNdOK4
         DnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PMaxpNmYe07DmlqFixN6iuB9Mcv3FxUJUtqqkedrCeg=;
        b=AeFaeCYVTZffw2ltoisvxx5k00UgyYKNpv1LVlBuLM1b71bdZTo4EGWmirkLwFRo/X
         JIsXevFCt+QIZ0BbrEEQsbMWntMCqD8hbkPi1HPVHIopCh3qpdmKBXO8fSA8tWR4u4GZ
         zIi1X+ShGeMoxYMLs/CanPWJYkJSQf4/4FEVL7pw9iQERw7y+dEqTHJ2UVYK41JMsSPT
         othNncAoYAFoRPKy/eUo1irICdDRO+6lLdiUdKRCAbvIzCbtszRCTgsj6q0I6jbsEufb
         lQWNU6CEAmkh0B8mbuO/HmRVtVB49vze1r8Oo2kRK3CaDlBPsnBMAVkoYlAn8v3Eys79
         IgCQ==
X-Gm-Message-State: AHPjjUgQozzbGEZwaIQMl9GYrBTH3qSK89UkOO73aqqTVczifB8Fn7QF
        WX8iLQzp+qZH7VOPUrQvlzb/1w==
X-Google-Smtp-Source: AOwi7QCQDSmFaFffN+nsjEQPtXwauJugYnX08mbezMs8tj/EHBbAxMgL/JOpC2oJz9V55XYbe5k1FA==
X-Received: by 10.80.189.204 with SMTP id z12mr4212227edh.2.1505906179187;
        Wed, 20 Sep 2017 04:16:19 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id s12sm884513edd.25.2017.09.20.04.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 04:16:18 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH V2 8/8] MIPS: BCM63XX: split out swpkt_sar/usb clocks
Date:   Wed, 20 Sep 2017 13:14:08 +0200
Message-Id: <20170920111408.29711-9-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170920111408.29711-1-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Make the secondary switch clocks their own clocks. This allows proper
enable reference counting between SAR/XTM and the main switch clocks,
and controlling them individually from drivers.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c | 61 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 2018425fe97e..164115944a7f 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -122,21 +122,56 @@ static struct clk clk_ephy = {
 };
 
 /*
+ * Ethernet switch SAR clock
+ */
+static void swpkt_sar_set(struct clk *clk, int enable)
+{
+	if (BCMCPU_IS_6368())
+		bcm_hwclock_set(CKCTL_6368_SWPKT_SAR_EN, enable);
+	else
+		return;
+}
+
+static struct clk clk_swpkt_sar = {
+	.set	= swpkt_sar_set,
+};
+
+/*
+ * Ethernet switch USB clock
+ */
+static void swpkt_usb_set(struct clk *clk, int enable)
+{
+	if (BCMCPU_IS_6368())
+		bcm_hwclock_set(CKCTL_6368_SWPKT_USB_EN, enable);
+	else
+		return;
+}
+
+static struct clk clk_swpkt_usb = {
+	.set	= swpkt_usb_set,
+};
+
+/*
  * Ethernet switch clock
  */
 static void enetsw_set(struct clk *clk, int enable)
 {
-	if (BCMCPU_IS_6328())
+	if (BCMCPU_IS_6328()) {
 		bcm_hwclock_set(CKCTL_6328_ROBOSW_EN, enable);
-	else if (BCMCPU_IS_6362())
+	} else if (BCMCPU_IS_6362()) {
 		bcm_hwclock_set(CKCTL_6362_ROBOSW_EN, enable);
-	else if (BCMCPU_IS_6368())
-		bcm_hwclock_set(CKCTL_6368_ROBOSW_EN |
-				CKCTL_6368_SWPKT_USB_EN |
-				CKCTL_6368_SWPKT_SAR_EN,
-				enable);
-	else
+	} else if (BCMCPU_IS_6368()) {
+		if (enable) {
+			clk_enable_unlocked(&clk_swpkt_sar);
+			clk_enable_unlocked(&clk_swpkt_usb);
+		} else {
+			clk_disable_unlocked(&clk_swpkt_usb);
+			clk_disable_unlocked(&clk_swpkt_sar);
+		}
+		bcm_hwclock_set(CKCTL_6368_ROBOSW_EN, enable);
+	} else {
 		return;
+	}
 
 	if (enable) {
 		/* reset switch core afer clock change */
@@ -261,8 +296,12 @@ static void xtm_set(struct clk *clk, int enable)
 	if (!BCMCPU_IS_6368())
 		return;
 
-	bcm_hwclock_set(CKCTL_6368_SAR_EN |
-			CKCTL_6368_SWPKT_SAR_EN, enable);
+	if (enable)
+		clk_enable_unlocked(&clk_swpkt_sar);
+	else
+		clk_disable_unlocked(&clk_swpkt_sar);
+
+	bcm_hwclock_set(CKCTL_6368_SAR_EN, enable);
 
 	if (enable) {
 		/* reset sar core afer clock change */
@@ -451,6 +490,8 @@ static struct clk_lookup bcm6358_clks[] = {
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
 	CLKDEV_INIT(NULL, "pcm", &clk_pcm),
+	CLKDEV_INIT(NULL, "swpkt_sar", &clk_swpkt_sar),
+	CLKDEV_INIT(NULL, "swpkt_usb", &clk_swpkt_usb),
 	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet0),
 	CLKDEV_INIT("bcm63xx_enet.1", "enet", &clk_enet1),
 };
-- 
2.13.2
