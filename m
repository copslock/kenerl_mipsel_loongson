Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 01:53:44 +0100 (CET)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40640 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013677AbaKZAvnfR0H0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 01:51:43 +0100
Received: by mail-pd0-f176.google.com with SMTP id y10so1639913pdj.21
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 16:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m2TEBeOghQKhk7UbwLJwKnTNpGlD3jbcMl0uak4KBxI=;
        b=WWD3AcMk+R3MULAvJrnV+AB5qa9cVAyfUU0YwPF+J/ZL25RIwgfi2b2Y5M/Jes7x34
         cb9vswDhrU51AX5dh3UuKtb3bOMeGBaDRF414UtEq0sZjxsIx5vxI75A7TrttzcbiG9/
         +6tduZxvvSTOFnfNEMSVyQBQQ5jSGGPgYJKDYM34AtEqfcgzXv0G0Hwu8tbP+OksrAdU
         YyX5xSXHee6x7takgst5CEawqa6hxoMomuB/lGXxgWOGZ/YG1IuLEbQi+erDjp8eyJWX
         5VFm7/2PEWZCyvyAH14hMqbtUXhkzxia1rIoPvwJDid7//qXTeD2bOUvNsOW7jf65OGU
         b49Q==
X-Received: by 10.70.96.68 with SMTP id dq4mr48676811pdb.61.1416963097798;
        Tue, 25 Nov 2014 16:51:37 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id bj11sm2614439pdb.1.2014.11.25.16.51.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:51:37 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org,
        arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc:     grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 8/9] bus: brcmstb_gisb: Honor the "big-endian" and "native-endian" DT properties
Date:   Tue, 25 Nov 2014 16:49:53 -0800
Message-Id: <1416962994-27095-9-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44461
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

On chips strapped for BE, we'll need to use ioread32be/iowrite32be instead of
ioread32/iowrite32.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 172908d..969b992 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -90,6 +90,7 @@ static const int gisb_offsets_bcm7445[] = {
 struct brcmstb_gisb_arb_device {
 	void __iomem	*base;
 	const int	*gisb_offsets;
+	bool		big_endian;
 	struct mutex	lock;
 	struct list_head next;
 	u32 valid_mask;
@@ -106,7 +107,10 @@ static u32 gisb_read(struct brcmstb_gisb_arb_device *gdev, int reg)
 	if (offset == -1)
 		return 1;
 
-	return ioread32(gdev->base + offset);
+	if (gdev->big_endian)
+		return ioread32be(gdev->base + offset);
+	else
+		return ioread32(gdev->base + offset);
 }
 
 static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
@@ -115,7 +119,11 @@ static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
 
 	if (offset == -1)
 		return;
-	iowrite32(val, gdev->base + reg);
+
+	if (gdev->big_endian)
+		iowrite32be(val, gdev->base + reg);
+	else
+		iowrite32(val, gdev->base + reg);
 }
 
 static ssize_t gisb_arb_get_timeout(struct device *dev,
@@ -300,6 +308,7 @@ static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	gdev->gisb_offsets = of_id->data;
+	gdev->big_endian = of_device_is_big_endian(dn);
 
 	err = devm_request_irq(&pdev->dev, timeout_irq,
 				brcmstb_gisb_timeout_handler, 0, pdev->name,
-- 
2.1.0
