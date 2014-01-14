Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 15:26:18 +0100 (CET)
Received: from mail-ee0-f50.google.com ([74.125.83.50]:46311 "EHLO
        mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826363AbaANO0MntIp2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jan 2014 15:26:12 +0100
Received: by mail-ee0-f50.google.com with SMTP id d17so251146eek.37
        for <multiple recipients>; Tue, 14 Jan 2014 06:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=0OvY79EatubSKsKVbF5sQ5Vxk5iOgsfzGOrbgdf02oU=;
        b=MZhybmzVpXOzz2f1N0LUkF9CRzRabzVHshe8zdz/M3pqHBMiqJn7HrLqmYeKcDKOvW
         qiWH0JexnLD0Z8+GJ6KKhSCsDFYrYxtzc9Y0DG5y6NetrXunWKPwhDXjH/29HwIfUIxp
         x5VkKwWFwoSFRPZ04Bb4hchDWTjgNOqJfVVzqXhtiwnIPbdMnhrBXHvUnlYISySVh7Fd
         qC82I+2ZNg3uiqf4AlNsJG5PtNhfU1PVGTtMHf0yEMhQTRDURuhbBCrVHlOliQVIC7MI
         P9Rkp2vTMKpJZJqbLrTwNklxnvkMV+tGH48v8/HlA86hqyuZcs57dxcjJLoqjJrXg+pX
         FsOQ==
X-Received: by 10.14.99.129 with SMTP id x1mr2460866eef.89.1389709567436;
        Tue, 14 Jan 2014 06:26:07 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id o13sm2036787eex.19.2014.01.14.06.26.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2014 06:26:06 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] bcma: gpio: use #if instead of "if" for IS_BUILTIN
Date:   Tue, 14 Jan 2014 15:26:03 +0100
Message-Id: <1389709563-1075-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

Standard "if" was evaluating to if (0) which still required conditional
code to be correct. It is not, as bcma_gpio_to_irq is not defined.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 drivers/bcma/driver_gpio.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index 69c82e2..25f9887 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -215,8 +215,9 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
 	chip->set		= bcma_gpio_set_value;
 	chip->direction_input	= bcma_gpio_direction_input;
 	chip->direction_output	= bcma_gpio_direction_output;
-	if (IS_BUILTIN(CONFIG_BCMA_HOST_SOC))
-		chip->to_irq		= bcma_gpio_to_irq;
+#if IS_BUILTIN(CONFIG_BCMA_HOST_SOC)
+	chip->to_irq		= bcma_gpio_to_irq;
+#endif
 	chip->ngpio		= 16;
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
-- 
1.7.10.4
