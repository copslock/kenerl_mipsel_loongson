Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2012 00:06:45 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:41916 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6828030Ab2KSW6uUhQ29 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2012 23:58:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 7BF078F64;
        Mon, 19 Nov 2012 23:58:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y0+dQUbriBLQ; Mon, 19 Nov 2012 23:58:42 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id E1A6B8F65;
        Mon, 19 Nov 2012 23:58:10 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        florian@openwrt.org, zajec5@gmail.com, m@bues.ch,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] ssb: add ssb_chipco_gpio_pull{up,down}
Date:   Mon, 19 Nov 2012 23:57:54 +0100
Message-Id: <1353365877-11131-6-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1353365877-11131-1-git-send-email-hauke@hauke-m.de>
References: <1353365877-11131-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add functions to access the GPIO registers for pullup and pulldown.
These are needed for handling gpio registration.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/ssb/driver_chipcommon.c           |   16 ++++++++++++++++
 include/linux/ssb/ssb_driver_chipcommon.h |    2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/ssb/driver_chipcommon.c b/drivers/ssb/driver_chipcommon.c
index e9d2ca1..4df4926 100644
--- a/drivers/ssb/driver_chipcommon.c
+++ b/drivers/ssb/driver_chipcommon.c
@@ -442,6 +442,22 @@ u32 ssb_chipco_gpio_polarity(struct ssb_chipcommon *cc, u32 mask, u32 value)
 	return chipco_write32_masked(cc, SSB_CHIPCO_GPIOPOL, mask, value);
 }
 
+u32 ssb_chipco_gpio_pullup(struct ssb_chipcommon *cc, u32 mask, u32 value)
+{
+	if (cc->dev->id.revision < 20)
+		return 0xffffffff;
+
+	return chipco_write32_masked(cc, SSB_CHIPCO_GPIOPULLUP, mask, value);
+}
+
+u32 ssb_chipco_gpio_pulldown(struct ssb_chipcommon *cc, u32 mask, u32 value)
+{
+	if (cc->dev->id.revision < 20)
+		return 0xffffffff;
+
+	return chipco_write32_masked(cc, SSB_CHIPCO_GPIOPULLDOWN, mask, value);
+}
+
 #ifdef CONFIG_SSB_SERIAL
 int ssb_chipco_serial_init(struct ssb_chipcommon *cc,
 			   struct ssb_serial_port *ports)
diff --git a/include/linux/ssb/ssb_driver_chipcommon.h b/include/linux/ssb/ssb_driver_chipcommon.h
index c2b02a5..c8d07c9 100644
--- a/include/linux/ssb/ssb_driver_chipcommon.h
+++ b/include/linux/ssb/ssb_driver_chipcommon.h
@@ -644,6 +644,8 @@ u32 ssb_chipco_gpio_outen(struct ssb_chipcommon *cc, u32 mask, u32 value);
 u32 ssb_chipco_gpio_control(struct ssb_chipcommon *cc, u32 mask, u32 value);
 u32 ssb_chipco_gpio_intmask(struct ssb_chipcommon *cc, u32 mask, u32 value);
 u32 ssb_chipco_gpio_polarity(struct ssb_chipcommon *cc, u32 mask, u32 value);
+u32 ssb_chipco_gpio_pullup(struct ssb_chipcommon *cc, u32 mask, u32 value);
+u32 ssb_chipco_gpio_pulldown(struct ssb_chipcommon *cc, u32 mask, u32 value);
 
 #ifdef CONFIG_SSB_SERIAL
 extern int ssb_chipco_serial_init(struct ssb_chipcommon *cc,
-- 
1.7.10.4
