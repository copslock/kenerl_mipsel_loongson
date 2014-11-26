Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 01:52:54 +0100 (CET)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36690 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011494AbaKZAviIRs1h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 01:51:38 +0100
Received: by mail-pa0-f44.google.com with SMTP id et14so1685490pad.17
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 16:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b5hJVYWeT6FXGn6W4ln3HHP0UkpaWcDoryRqMFMcnP8=;
        b=taYCtc6Fyb3jth2PBc7UgJ6rRKOPd3nFUJk5CdVdbLQXRUTgXK9VNQDEtYPJKuJeQp
         o3vtoWEYVkcwPuPA76T76N3uQwWrhOkod7T8GuFQLuAqkz9FttVNFWvnuFWbT/BMT8dX
         XIYZ0AZQpqo6KvZdQzHoS+NFbLRgGE6H/u6mrdmhSTw+i0k1alYmQOdE5K7mR5tElO/C
         Ozgfd3DVcwq4/iXDrLxbqr7Co4dG/wDs3n9REqkdoKPFszimvG+ZlJ6eFWkMMM4Dec8d
         N27V123dbnQ6r6L2JDxv0Oedaz5MicsHBQnUyHZo8z6a7EJ0W/2ns49DT7C+N1bzjXyW
         ivkg==
X-Received: by 10.66.235.200 with SMTP id uo8mr47802836pac.108.1416963092336;
        Tue, 25 Nov 2014 16:51:32 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id bj11sm2614439pdb.1.2014.11.25.16.51.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:51:31 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org,
        arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc:     grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 5/9] bus: brcmstb_gisb: Introduce wrapper functions for MMIO accesses
Date:   Tue, 25 Nov 2014 16:49:50 -0800
Message-Id: <1416962994-27095-6-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44458
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

These will be used to abstract out chip-to-chip differences.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 5da935a..8ff403d 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -54,6 +54,16 @@ struct brcmstb_gisb_arb_device {
 
 static LIST_HEAD(brcmstb_gisb_arb_device_list);
 
+static u32 gisb_read(struct brcmstb_gisb_arb_device *gdev, int reg)
+{
+	return ioread32(gdev->base + reg);
+}
+
+static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
+{
+	iowrite32(val, gdev->base + reg);
+}
+
 static ssize_t gisb_arb_get_timeout(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -63,7 +73,7 @@ static ssize_t gisb_arb_get_timeout(struct device *dev,
 	u32 timeout;
 
 	mutex_lock(&gdev->lock);
-	timeout = ioread32(gdev->base + ARB_TIMER);
+	timeout = gisb_read(gdev, ARB_TIMER);
 	mutex_unlock(&gdev->lock);
 
 	return sprintf(buf, "%d", timeout);
@@ -85,7 +95,7 @@ static ssize_t gisb_arb_set_timeout(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&gdev->lock);
-	iowrite32(val, gdev->base + ARB_TIMER);
+	gisb_write(gdev, val, ARB_TIMER);
 	mutex_unlock(&gdev->lock);
 
 	return count;
@@ -112,18 +122,18 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_gisb_arb_device *gdev,
 	const char *m_name;
 	char m_fmt[11];
 
-	cap_status = ioread32(gdev->base + ARB_ERR_CAP_STATUS);
+	cap_status = gisb_read(gdev, ARB_ERR_CAP_STATUS);
 
 	/* Invalid captured address, bail out */
 	if (!(cap_status & ARB_ERR_CAP_STATUS_VALID))
 		return 1;
 
 	/* Read the address and master */
-	arb_addr = ioread32(gdev->base + ARB_ERR_CAP_ADDR) & 0xffffffff;
+	arb_addr = gisb_read(gdev, ARB_ERR_CAP_ADDR) & 0xffffffff;
 #if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
-	arb_addr |= (u64)ioread32(gdev->base + ARB_ERR_CAP_HI_ADDR) << 32;
+	arb_addr |= (u64)gisb_read(gdev, ARB_ERR_CAP_HI_ADDR) << 32;
 #endif
-	master = ioread32(gdev->base + ARB_ERR_CAP_MASTER);
+	master = gisb_read(gdev, ARB_ERR_CAP_MASTER);
 
 	m_name = brcmstb_gisb_master_to_str(gdev, master);
 	if (!m_name) {
@@ -138,7 +148,7 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_gisb_arb_device *gdev,
 		m_name);
 
 	/* clear the GISB error */
-	iowrite32(ARB_ERR_CAP_CLEAR, gdev->base + ARB_ERR_CAP_CLR);
+	gisb_write(gdev, ARB_ERR_CAP_CLEAR, ARB_ERR_CAP_CLR);
 
 	return 0;
 }
-- 
2.1.0
