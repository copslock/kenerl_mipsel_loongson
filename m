Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Feb 2013 22:41:36 +0100 (CET)
Received: from mail-ea0-f170.google.com ([209.85.215.170]:47207 "EHLO
        mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827628Ab3BMVlfJOohr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Feb 2013 22:41:35 +0100
Received: by mail-ea0-f170.google.com with SMTP id a11so644292eaa.15
        for <linux-mips@linux-mips.org>; Wed, 13 Feb 2013 13:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=Pknm0aZkCVZhEqJsUMCwq6O5DE+Xz6wQPjN+mPAvKd0=;
        b=ih1bMroGldHWt3s7Cu35/wZJvq1pcvXHAMGlWuJZoFL4KYisiW0BE2jcapVqV/yoV7
         wZ4j/qGrEGYw/HbSksF3dDCeJDMBb+GN+olZRFOf9EQWPs4A5BG22pZvcI7uuUF0u4aN
         cvtCrPJ6xlzcGqqLHkbTWUJofkBMz8A6vC4mM3Y5nTb1PKjF010Vhc8nh3ymIODHteEB
         2ye+waYLRGIECBcYvAWZReiDwXSZzF+JrnCx/vbhquqjcDanOGpBh25/OtIKJ7OW4Vz2
         C8GwCHv8Tu1/RM90krw/Ff4PNonyGJyUhW2caLh3ToPUm5iOmWc1PjkeXLfzmev1Uzhx
         AogA==
X-Received: by 10.14.207.200 with SMTP id n48mr8993630eeo.4.1360791689503;
        Wed, 13 Feb 2013 13:41:29 -0800 (PST)
Received: from localhost.localdomain ([77.70.100.51])
        by mx.google.com with ESMTPS id r4sm30921681eeo.12.2013.02.13.13.41.27
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 13:41:28 -0800 (PST)
From:   Svetoslav Neykov <svetoslav@neykov.name>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Svetoslav Neykov <svetoslav@neykov.name>
Subject: [PATCH 2/5] usb: chipidea: flags to force usb mode (host/device)
Date:   Wed, 13 Feb 2013 23:38:55 +0200
Message-Id: <1360791538-6332-3-git-send-email-svetoslav@neykov.name>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
X-Gm-Message-State: ALoCoQk/yweb5DjzecT2RKvcApN1ulpOHNEMXvIO3/soDEMGGsgftOX3piwMjE1vrQvYKaiHKurm
X-archive-position: 35742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svetoslav@neykov.name
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

The chipidea controller in the AR933x SOC supports both host and device modes but not OTG.
Which USB mode is used depends on a pin state (GIPO13) during boot - HIGH for host, LOW for device mode.
Currently if both host and device modes are available, the code assumes OTG support. Add flags to allow
the platform code for force a specific mode based on the pin state.

Signed-off-by: Svetoslav Neykov <svetoslav@neykov.name>
---
 drivers/usb/chipidea/core.c  |   22 +++++++++++++++++-----
 include/linux/usb/chipidea.h |    2 ++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 3cefb4c..85c72e5 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -398,6 +398,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	struct resource	*res;
 	void __iomem	*base;
 	int		ret;
+	bool force_host_mode;
+	bool force_device_mode;
 
 	if (!dev->platform_data) {
 		dev_err(dev, "platform data missing\n");
@@ -459,21 +461,31 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	if (ret)
 		dev_info(dev, "doesn't support gadget\n");
 
-	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
+	force_host_mode = ci->platdata->flags & CI13XXX_FORCE_HOST_MODE;
+	force_device_mode = ci->platdata->flags & CI13XXX_FORCE_DEVICE_MODE;
+	if ((!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) ||
+			(force_host_mode && !ci->roles[CI_ROLE_HOST]) ||
+			(force_device_mode && !ci->roles[CI_ROLE_GADGET])) {
 		dev_err(dev, "no supported roles\n");
 		ret = -ENODEV;
 		goto rm_wq;
 	}
 
-	if (ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]) {
+	if (!force_host_mode && !force_device_mode &&
+			ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]) {
 		ci->is_otg = true;
 		/* ID pin needs 1ms debouce time, we delay 2ms for safe */
 		mdelay(2);
 		ci->role = ci_otg_role(ci);
 	} else {
-		ci->role = ci->roles[CI_ROLE_HOST]
-			? CI_ROLE_HOST
-			: CI_ROLE_GADGET;
+		if (force_host_mode)
+			ci->role = CI_ROLE_HOST;
+		else if (force_device_mode)
+			ci->role = CI_ROLE_GADGET;
+		else
+			ci->role = ci->roles[CI_ROLE_HOST]
+				? CI_ROLE_HOST
+				: CI_ROLE_GADGET;
 	}
 
 	ret = ci_role_start(ci, ci->role);
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 544825d..e6f44d2 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -19,6 +19,8 @@ struct ci13xxx_platform_data {
 #define CI13XXX_REQUIRE_TRANSCEIVER	BIT(1)
 #define CI13XXX_PULLUP_ON_VBUS		BIT(2)
 #define CI13XXX_DISABLE_STREAMING	BIT(3)
+#define CI13XXX_FORCE_HOST_MODE		BIT(5)
+#define CI13XXX_FORCE_DEVICE_MODE	BIT(6)
 
 #define CI13XXX_CONTROLLER_RESET_EVENT		0
 #define CI13XXX_CONTROLLER_STOPPED_EVENT	1
-- 
1.7.9.5
