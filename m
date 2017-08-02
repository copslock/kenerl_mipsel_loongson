Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 11:37:23 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:37773
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993418AbdHBJfThn4py (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Aug 2017 11:35:19 +0200
Received: by mail-wr0-x241.google.com with SMTP id 12so3223080wrb.4;
        Wed, 02 Aug 2017 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yjcqmE7k0lcmIGKiuErmJhgnSb8CGNC2SrAwO4blsw4=;
        b=U08XNWYJK3vK5PbwiRznOdiADYiJ5vn0AHdkoQxV7VtkGdRJT8dn+alnfbpG0ztEzo
         GDUcFm5layOkce9YQUAdO1SDQaPLSFC6dYZj6Kemoramf+pZqKFNLPZXHNl+sLktIq65
         NkeV+mAbQN1DYXsJV6rutPQxdIWS8vzZ7AOQwRSrMRCD5brEvsWPcR04dSnyDp1CkxYq
         yzt5ygAB8ZFnduDpxD4ZXobTg4GNQpK3jjH51641pLqC6ULnmZ3dYGDCCy5sFjwuDnT7
         wiILeORAEPE3elnRJXL+ZzxH5EDJVLoaJcSjXvVGDgdXYydLafL7JL6/9dj1jXMr7GK+
         ZsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yjcqmE7k0lcmIGKiuErmJhgnSb8CGNC2SrAwO4blsw4=;
        b=jedAQKHPFU0XGTf8AQfr+7q7ebwvRtDmNp9drL3+L8fXG75vOJHMCNr26awy85et0n
         2dbjgoG5fPMy3OVXWwn89yqWmaumI3M5ShA7MBVY7Zl7iNpC49BNilxGyB3ve789CrgZ
         4Qpw39W4EQhuFFQrKaFAkGPYT5b6sriK9rxmO7EHxghsGaMdjvEHQAO946VSt/ZhrT9E
         GPipEukvkBRT7ywG7fsL5A6iL3YpejCVEY222xaWmHpPYXl0oWFjFgJ+OOIhMKGyu7PK
         /pxli56LyykrE4pp7lIdNZavZ8K0w4X9c/BRl/CYPFcCabHqhNONvwBwcJ4qJXJhc3BT
         zKCA==
X-Gm-Message-State: AIVw112ILShlzrKlWtXkP+/XPfDrdPVC4H5LY4kD1zX1mKayAGSacp6l
        ePyVRSuYmBZ8hvupi2A=
X-Received: by 10.223.131.130 with SMTP id 2mr19727337wre.51.1501666514225;
        Wed, 02 Aug 2017 02:35:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 91sm32058876wrg.83.2017.08.02.02.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2017 02:35:13 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 5/8] MIPS: BCM63XX: provide enet clocks as "enet" to the ethernet devices
Date:   Wed,  2 Aug 2017 11:34:26 +0200
Message-Id: <20170802093429.12572-6-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59321
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

Add lookups to provide the appropriate enetX clocks as just "enet" to
the ethernet devices.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 0b898e5e4c5b..8a089a92e029 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -370,6 +370,8 @@ static struct clk_lookup bcm3368_clks[] = {
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
 	CLKDEV_INIT(NULL, "pcm", &clk_pcm),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet0),
+	CLKDEV_INIT("bcm63xx_enet.1", "enet", &clk_enet1),
 };
 
 static struct clk_lookup bcm6328_clks[] = {
@@ -396,6 +398,7 @@ static struct clk_lookup bcm6338_clks[] = {
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet_misc),
 };
 
 static struct clk_lookup bcm6345_clks[] = {
@@ -409,6 +412,7 @@ static struct clk_lookup bcm6345_clks[] = {
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet_misc),
 };
 
 static struct clk_lookup bcm6348_clks[] = {
@@ -422,6 +426,8 @@ static struct clk_lookup bcm6348_clks[] = {
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet_misc),
+	CLKDEV_INIT("bcm63xx_enet.1", "enet", &clk_enet_misc),
 };
 
 static struct clk_lookup bcm6358_clks[] = {
@@ -437,6 +443,8 @@ static struct clk_lookup bcm6358_clks[] = {
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
 	CLKDEV_INIT(NULL, "pcm", &clk_pcm),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet0),
+	CLKDEV_INIT("bcm63xx_enet.1", "enet", &clk_enet1),
 };
 
 static struct clk_lookup bcm6362_clks[] = {
-- 
2.13.2
