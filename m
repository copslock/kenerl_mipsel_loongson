Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 01:52:23 +0100 (CET)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:50447 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007133AbaKZAvfAWkm0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 01:51:35 +0100
Received: by mail-pd0-f171.google.com with SMTP id y13so1641004pdi.30
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 16:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KCNcQukiauWhkIbusJ5flvvjdkacO3ipDU74bXNl2V0=;
        b=IIGf/v3p+a7o5bvx6nnb6dSdTQxtNQBqvYOsb+mwt0H/RGpmJEs8qRgDgSVgaXg5I8
         j3ZdfZ/4Ppqdl1QKYPHYHQ7YH+9izSLQde4cIqwbMWDTYlx7/xIlj0HtBKmnt5lODIX/
         Fw96pvgngHseXLzHfF7W8kVEIjqHgbQQjsn0Xenjz+PvI8dbDcyJZEsXrNhz7KLLUilW
         wOCjnFPdAXTeZhGPl+61quqWGYe/pRYYO+C1x7cPT7zAefIiT7Qc+qGxHV0HN0f/ofWl
         LN/p70gXs1ARO+A/p9HBcTUnWEy7AwHExF5RND9nDngTtpwMCvcBD3tLLzTfO14WtgXX
         Bqpw==
X-Received: by 10.68.229.33 with SMTP id sn1mr48168438pbc.63.1416963088967;
        Tue, 25 Nov 2014 16:51:28 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id bj11sm2614439pdb.1.2014.11.25.16.51.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:51:28 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org,
        arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc:     grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 3/9] power/reset: brcmstb: Add support for old 65nm chips
Date:   Tue, 25 Nov 2014 16:49:48 -0800
Message-Id: <1416962994-27095-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44456
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

The register bit fields are a little different, so add an entry and a
compatible string to accommodate them.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt | 4 +++-
 drivers/power/reset/brcmstb-reboot.c                   | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
index 3c436cc..430608e 100644
--- a/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
+++ b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
@@ -79,7 +79,9 @@ reboot
 Required properties
 
     - compatible
-        The string property "brcm,brcmstb-reboot".
+        The string property "brcm,brcmstb-reboot" for 40nm/28nm chips with
+        the new SYS_CTRL interface, or "brcm,bcm7038-reboot" for 65nm
+        chips with the old SUN_TOP_CTRL interface.
 
     - syscon
         A phandle / integer array that points to the syscon node which describes
diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 4e61c3f..33af4f3 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -88,8 +88,14 @@ static const struct reset_reg_mask reset_bits_40nm = {
 	.sw_mstr_rst_mask = BIT(0),
 };
 
+static const struct reset_reg_mask reset_bits_65nm = {
+	.rst_src_en_mask = BIT(3),
+	.sw_mstr_rst_mask = BIT(31),
+};
+
 static const struct of_device_id of_match[] = {
 	{ .compatible = "brcm,brcmstb-reboot", .data = &reset_bits_40nm },
+	{ .compatible = "brcm,bcm7038-reboot", .data = &reset_bits_65nm },
 	{},
 };
 
-- 
2.1.0
