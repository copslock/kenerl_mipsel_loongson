Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 01:53:27 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:51288 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012838AbaKZAvlEZhSk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 01:51:41 +0100
Received: by mail-pa0-f43.google.com with SMTP id kx10so1702194pab.2
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 16:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YpY7FyABO/Mb6iMIKnUApx68REEOU4WkYYfdEjxS9J4=;
        b=B8INjS18nlwBwi/zyKMM7J+7cRZCP9xyF+6F5U7n2Xohi4k8huMfc6e/kmxuI3s+LS
         I8NZN5b29SCYAM1W1XH6Eww60gQzFe2E21Z9vy4enHxHkZJXOGgipDB45yp50Z/eaxGT
         y0/6mJAK9XxLPCad05iP8t8pnh5RqukHm8ZdrulsvoH5oJEFp2qAgFq6DUrI0ynqwBLB
         PMGUka7+C10xawzCNJDBKSwyilib4H8HLoy2yhHMfLA+rvh6eEvNJvv3NR4IP+DYtsGu
         Pzhj60fC4DysK7WMKTqY0z816+kZx0lLq2He26vb/B3pCnZO/zP0zUUkboYIlPOKuylr
         3LdQ==
X-Received: by 10.69.19.203 with SMTP id gw11mr49106768pbd.22.1416963094274;
        Tue, 25 Nov 2014 16:51:34 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id bj11sm2614439pdb.1.2014.11.25.16.51.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:51:33 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org,
        arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc:     grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 6/9] bus: brcmstb_gisb: Look up register offsets in a table
Date:   Tue, 25 Nov 2014 16:49:51 -0800
Message-Id: <1416962994-27095-7-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44460
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

There are at least 4 incompatible variations of this hardware block,
so let's use the ARB_* constants as a table index instead of hardcoding
specific register offsets.  Also, allow for the possibility of adding
old devices that are missing some of the registers.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 8ff403d..ef1e423 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -29,23 +29,37 @@
 #include <asm/signal.h>
 #endif
 
-#define ARB_TIMER			0x008
-#define ARB_ERR_CAP_CLR			0x7e4
 #define  ARB_ERR_CAP_CLEAR		(1 << 0)
-#define ARB_ERR_CAP_HI_ADDR		0x7e8
-#define ARB_ERR_CAP_ADDR		0x7ec
-#define ARB_ERR_CAP_DATA		0x7f0
-#define ARB_ERR_CAP_STATUS		0x7f4
 #define  ARB_ERR_CAP_STATUS_TIMEOUT	(1 << 12)
 #define  ARB_ERR_CAP_STATUS_TEA		(1 << 11)
 #define  ARB_ERR_CAP_STATUS_BS_SHIFT	(1 << 2)
 #define  ARB_ERR_CAP_STATUS_BS_MASK	0x3c
 #define  ARB_ERR_CAP_STATUS_WRITE	(1 << 1)
 #define  ARB_ERR_CAP_STATUS_VALID	(1 << 0)
-#define ARB_ERR_CAP_MASTER		0x7f8
+
+enum {
+	ARB_TIMER,
+	ARB_ERR_CAP_CLR,
+	ARB_ERR_CAP_HI_ADDR,
+	ARB_ERR_CAP_ADDR,
+	ARB_ERR_CAP_DATA,
+	ARB_ERR_CAP_STATUS,
+	ARB_ERR_CAP_MASTER,
+};
+
+static const int gisb_offsets_bcm7445[] = {
+	[ARB_TIMER]		= 0x008,
+	[ARB_ERR_CAP_CLR]	= 0x7e4,
+	[ARB_ERR_CAP_HI_ADDR]	= 0x7e8,
+	[ARB_ERR_CAP_ADDR]	= 0x7ec,
+	[ARB_ERR_CAP_DATA]	= 0x7f0,
+	[ARB_ERR_CAP_STATUS]	= 0x7f4,
+	[ARB_ERR_CAP_MASTER]	= 0x7f8,
+};
 
 struct brcmstb_gisb_arb_device {
 	void __iomem	*base;
+	const int	*gisb_offsets;
 	struct mutex	lock;
 	struct list_head next;
 	u32 valid_mask;
@@ -56,11 +70,21 @@ static LIST_HEAD(brcmstb_gisb_arb_device_list);
 
 static u32 gisb_read(struct brcmstb_gisb_arb_device *gdev, int reg)
 {
-	return ioread32(gdev->base + reg);
+	int offset = gdev->gisb_offsets[reg];
+
+	/* return 1 if the hardware doesn't have ARB_ERR_CAP_MASTER */
+	if (offset == -1)
+		return 1;
+
+	return ioread32(gdev->base + offset);
 }
 
 static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
 {
+	int offset = gdev->gisb_offsets[reg];
+
+	if (offset == -1)
+		return;
 	iowrite32(val, gdev->base + reg);
 }
 
@@ -230,6 +254,8 @@ static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	if (IS_ERR(gdev->base))
 		return PTR_ERR(gdev->base);
 
+	gdev->gisb_offsets = gisb_offsets_bcm7445;
+
 	err = devm_request_irq(&pdev->dev, timeout_irq,
 				brcmstb_gisb_timeout_handler, 0, pdev->name,
 				gdev);
-- 
2.1.0
