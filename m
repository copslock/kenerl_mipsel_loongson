Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Aug 2012 13:12:50 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:36862 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903552Ab2HELMU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Aug 2012 13:12:20 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id E9D2887B9;
        Sun,  5 Aug 2012 13:12:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LmUY0Hqz0oAW; Sun,  5 Aug 2012 13:12:14 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 5455D8880;
        Sun,  5 Aug 2012 13:12:14 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>, Michael Buesch <m@bues.ch>
Subject: [PATCH 1/3] ssb: add function to return number of gpio lines
Date:   Sun,  5 Aug 2012 13:12:01 +0200
Message-Id: <1344165123-4640-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344165123-4640-1-git-send-email-hauke@hauke-m.de>
References: <1344165123-4640-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 34063
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

CC: Michael Buesch <m@bues.ch>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/ssb/embedded.c           |   12 ++++++++++++
 include/linux/ssb/ssb_embedded.h |    4 ++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/ssb/embedded.c b/drivers/ssb/embedded.c
index 9ef124f..078007c 100644
--- a/drivers/ssb/embedded.c
+++ b/drivers/ssb/embedded.c
@@ -136,6 +136,18 @@ u32 ssb_gpio_polarity(struct ssb_bus *bus, u32 mask, u32 value)
 }
 EXPORT_SYMBOL(ssb_gpio_polarity);
 
+int ssb_gpio_count(struct ssb_bus *bus)
+{
+	if (ssb_chipco_available(&bus->chipco))
+		return SSB_GPIO_CHIPCO_LINES;
+	else if (ssb_extif_available(&bus->extif))
+		return SSB_GPIO_EXTIF_LINES;
+	else
+		SSB_WARN_ON(1);
+	return 0;
+}
+EXPORT_SYMBOL(ssb_gpio_count);
+
 #ifdef CONFIG_SSB_DRIVER_GIGE
 static int gige_pci_init_callback(struct ssb_bus *bus, unsigned long data)
 {
diff --git a/include/linux/ssb/ssb_embedded.h b/include/linux/ssb/ssb_embedded.h
index 8d8dedf..f1618d2 100644
--- a/include/linux/ssb/ssb_embedded.h
+++ b/include/linux/ssb/ssb_embedded.h
@@ -7,6 +7,9 @@
 
 extern int ssb_watchdog_timer_set(struct ssb_bus *bus, u32 ticks);
 
+#define SSB_GPIO_EXTIF_LINES	5
+#define SSB_GPIO_CHIPCO_LINES	16
+
 /* Generic GPIO API */
 u32 ssb_gpio_in(struct ssb_bus *bus, u32 mask);
 u32 ssb_gpio_out(struct ssb_bus *bus, u32 mask, u32 value);
@@ -14,5 +17,6 @@ u32 ssb_gpio_outen(struct ssb_bus *bus, u32 mask, u32 value);
 u32 ssb_gpio_control(struct ssb_bus *bus, u32 mask, u32 value);
 u32 ssb_gpio_intmask(struct ssb_bus *bus, u32 mask, u32 value);
 u32 ssb_gpio_polarity(struct ssb_bus *bus, u32 mask, u32 value);
+int ssb_gpio_count(struct ssb_bus *bus);
 
 #endif /* LINUX_SSB_EMBEDDED_H_ */
-- 
1.7.9.5
