Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 10:34:12 +0100 (CET)
Received: from mail-wj0-f194.google.com ([209.85.210.194]:36523 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993160AbcLIJce7cPzt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2016 10:32:34 +0100
Received: by mail-wj0-f194.google.com with SMTP id j10so1501519wjb.3
        for <linux-mips@linux-mips.org>; Fri, 09 Dec 2016 01:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xoON7nC4BH7Z2qZ9B3MqYusutlI+bulgXgq0PcoIM7c=;
        b=VApMZZA5oJ6yx6lOGR3mvQoXmthILigRB1up8r3mgHgV1+uUy8vzpuohZOdZJ8pZAV
         B2IahWa4ed3kvHifY+EhvmWMq73tPEFmr3xqdGDHuE5kp/5F82AdtzghGO4f2DQNqKaF
         pQD/3HJYWvk4ErIeFNcDBKZwliaGOnBAeUznUcUeDGkI3+88F2Wf9HhUXc4r39p6gOCG
         MXtDxpW3Q9noycdjUxVQLhK0jeNTW/Y5ecl+iIH7dVFCt5PD+9s7a0ESel4Fb+ZBfWAU
         A5IRQY/Pgj8NVbqI4xsIdFSBgZkfycZnEwl2kADv4Dl2BSbp1MXzpckyT0IUCboY4jdZ
         o3QA==
X-Gm-Message-State: AKaTC01TfUZuJFm96EnQq5+biehJENdLkkIpJ5C5qVFFzaPHK6FKT4GX+d7WOVeJZ4NO1Q==
X-Received: by 10.194.164.226 with SMTP id yt2mr78184705wjb.201.1481275949667;
        Fri, 09 Dec 2016 01:32:29 -0800 (PST)
Received: from localhost.localdomain (HSI-KBW-046-005-206-247.hsi8.kabel-badenwuerttemberg.de. [46.5.206.247])
        by smtp.gmail.com with ESMTPSA id k11sm19529619wmf.24.2016.12.09.01.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 01:32:29 -0800 (PST)
From:   Jan Glauber <jglauber@cavium.com>
To:     Wolfram Sang <wsa-dev@sang-engineering.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 4/4] i2c: octeon: thunderx: Add I2C_CLASS_HWMON
Date:   Fri,  9 Dec 2016 10:31:58 +0100
Message-Id: <20161209093158.3161-5-jglauber@cavium.com>
X-Mailer: git-send-email 2.9.0.rc0.21.g7777322
In-Reply-To: <20161209093158.3161-1-jglauber@cavium.com>
References: <20161209093158.3161-1-jglauber@cavium.com>
Return-Path: <jan.glauber@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jglauber@cavium.com
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

It was reported that ipmi_ssif fails to create the
ipmi device on some systems if the adapter class is not containing
I2C_CLASS_HWMON. Fix it by setting the class.

Reported-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-platdrv.c  | 1 +
 drivers/i2c/busses/i2c-thunderx-pcidrv.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-octeon-platdrv.c b/drivers/i2c/busses/i2c-octeon-platdrv.c
index 917524c..809b868 100644
--- a/drivers/i2c/busses/i2c-octeon-platdrv.c
+++ b/drivers/i2c/busses/i2c-octeon-platdrv.c
@@ -239,6 +239,7 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 	i2c->adap = octeon_i2c_ops;
 	i2c->adap.timeout = msecs_to_jiffies(2);
 	i2c->adap.retries = 5;
+	i2c->adap.class = I2C_CLASS_HWMON;
 	i2c->adap.bus_recovery_info = &octeon_i2c_recovery_info;
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = node;
diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index bba5b42..9e3365f 100644
--- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
+++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
@@ -205,6 +205,7 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 
 	i2c->adap = thunderx_i2c_ops;
 	i2c->adap.retries = 5;
+	i2c->adap.class = I2C_CLASS_HWMON;
 	i2c->adap.bus_recovery_info = &octeon_i2c_recovery_info;
 	i2c->adap.dev.parent = dev;
 	i2c->adap.dev.of_node = pdev->dev.of_node;
-- 
2.9.0.rc0.21.g7777322
