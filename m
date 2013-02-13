Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Feb 2013 22:41:55 +0100 (CET)
Received: from mail-ee0-f42.google.com ([74.125.83.42]:44877 "EHLO
        mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827630Ab3BMVlk2TfNC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Feb 2013 22:41:40 +0100
Received: by mail-ee0-f42.google.com with SMTP id b47so916501eek.29
        for <linux-mips@linux-mips.org>; Wed, 13 Feb 2013 13:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=oewUzHaKjVOZA3iVWdw78z1AzhMIuDJ1W7s5lz/FSgE=;
        b=ldbhLuaiZnPEw9yZ2/ZGWy2NhHDO3QOOcPdXpYfwxCKMVYWXUbnt/7jmYLB+luYiEU
         XOLHdH9jNOb26Ed4LGbnrBlubptHHUjvQd3822FSDL7GJCCY9UF4MTVgeKCAj1rzuj0E
         8i8gGLQ7tW/zUlPrckO715ys/RNYxD44FeRzJHKCL3FEmHkNdjJDA/a45EG2PxTzXUSt
         g4Txja3Mkno7JcrUWnLd+pGR3Yf5j0eTosNdA0iMlXus+AtPj6gEGUhdqfBrmW88TfLg
         1puFpQBsVnH3wg39FugShKipWtpjwRwHaxDsO6fnDDky3h1eweDCcDTOULvxQVnj/ZG8
         1V9Q==
X-Received: by 10.14.175.129 with SMTP id z1mr9670228eel.7.1360791694970;
        Wed, 13 Feb 2013 13:41:34 -0800 (PST)
Received: from localhost.localdomain ([77.70.100.51])
        by mx.google.com with ESMTPS id r4sm30921681eeo.12.2013.02.13.13.41.32
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 13:41:34 -0800 (PST)
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
Subject: [PATCH 3/5] usb: chipidea: Don't access OTG related registers
Date:   Wed, 13 Feb 2013 23:38:56 +0200
Message-Id: <1360791538-6332-4-git-send-email-svetoslav@neykov.name>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
X-Gm-Message-State: ALoCoQmTryZrVJcxwX2Wjl6qxRnT1yhwFWVv0odeh3LMaFPDSfdj+C/d6UtXJ/q908XpuA03j4+f
X-archive-position: 35743
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

According to the datasheet the chipidea controller in AR933x doesn't expose OTG and TEST registers.
If no OTG support is detected don't call functions which access those registers.

Signed-off-by: Svetoslav Neykov <svetoslav@neykov.name>
---
 drivers/usb/chipidea/udc.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 78ac5e5..9fda4d8 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1395,7 +1395,10 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
 		if (is_active) {
 			pm_runtime_get_sync(&_gadget->dev);
 			hw_device_reset(ci, USBMODE_CM_DC);
-			hw_enable_vbus_intr(ci);
+
+			if (ci->is_otg)
+				hw_enable_vbus_intr(ci);
+
 			hw_device_state(ci, ci->ep0out->qh.dma);
 		} else {
 			hw_device_state(ci, 0);
@@ -1572,7 +1575,8 @@ static int ci13xxx_start(struct usb_gadget *gadget,
 		if (ci->vbus_active) {
 			if (ci->platdata->flags & CI13XXX_REGS_SHARED) {
 				hw_device_reset(ci, USBMODE_CM_DC);
-				hw_enable_vbus_intr(ci);
+				if (ci->is_otg)
+					hw_enable_vbus_intr(ci);
 			}
 		} else {
 			pm_runtime_put_sync(&ci->gadget.dev);
@@ -1680,11 +1684,13 @@ static irqreturn_t udc_irq(struct ci13xxx *ci)
 		retval = IRQ_NONE;
 	}
 
-	intr = hw_read(ci, OP_OTGSC, ~0);
-	hw_write(ci, OP_OTGSC, ~0, intr);
+	if (ci->is_otg) {
+		intr = hw_read(ci, OP_OTGSC, ~0);
+		hw_write(ci, OP_OTGSC, ~0, intr);
 
-	if (intr & (OTGSC_AVVIE & OTGSC_AVVIS))
-		queue_work(ci->wq, &ci->vbus_work);
+		if (intr & (OTGSC_AVVIE & OTGSC_AVVIS))
+			queue_work(ci->wq, &ci->vbus_work);
+	}
 
 	spin_unlock(&ci->lock);
 
@@ -1761,7 +1767,8 @@ static int udc_start(struct ci13xxx *ci)
 		retval = hw_device_reset(ci, USBMODE_CM_DC);
 		if (retval)
 			goto put_transceiver;
-		hw_enable_vbus_intr(ci);
+		if (ci->is_otg)
+			hw_enable_vbus_intr(ci);
 	}
 
 	retval = device_register(&ci->gadget.dev);
@@ -1824,7 +1831,8 @@ static void udc_stop(struct ci13xxx *ci)
 	if (ci == NULL)
 		return;
 
-	hw_disable_vbus_intr(ci);
+	if (ci->is_otg)
+		hw_disable_vbus_intr(ci);
 	cancel_work_sync(&ci->vbus_work);
 
 	usb_del_gadget_udc(&ci->gadget);
-- 
1.7.9.5
