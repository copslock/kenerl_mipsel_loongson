Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:59:41 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58937 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994787AbdFSPuaobqCH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:50:30 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 05B9A1A45F2;
        Mon, 19 Jun 2017 17:50:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id D8DE71A46A7;
        Mon, 19 Jun 2017 17:50:19 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 6/8] input: goldfish: Fix multitouch event handling
Date:   Mon, 19 Jun 2017 17:50:13 +0200
Message-Id: <1497887415-13825-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Lingfeng Yang <lfy@google.com>

Register Goldfish Events device properly as a multitouch device,
and send SYN_REPORT event in appropriate cases only.

If SYN_REPORT is sent on every single multitouch event, it breaks
the multitouch. The multitouch becomes janky and having to click
2-3 times to do stuff (plus randomly activating notification bars
when not clicking). If these SYN_REPORT events are supressed,
multitouch will work fine, plus the events will have a protocol
that looks nice.

In addition, Goldfish Events device needs to be registerd as a
multitouch device by issuing input_mt_init_slots. Otherwise,
input_handle_abs_event in drivers/input/input.c will silently drop
all ABS_MT_SLOT events, casusing touches with more than one finger
not to work properly.

Signed-off-by: Lingfeng Yang <lfy@google.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 drivers/input/keyboard/goldfish_events.c | 33 +++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
index f6e643b..6e0b8bb 100644
--- a/drivers/input/keyboard/goldfish_events.c
+++ b/drivers/input/keyboard/goldfish_events.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/types.h>
 #include <linux/input.h>
+#include <linux/input/mt.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -24,6 +25,8 @@
 #include <linux/io.h>
 #include <linux/acpi.h>
 
+#define GOLDFISH_MAX_FINGERS 5
+
 enum {
 	REG_READ        = 0x00,
 	REG_SET_PAGE    = 0x00,
@@ -52,7 +55,22 @@ static irqreturn_t events_interrupt(int irq, void *dev_id)
 	value = __raw_readl(edev->addr + REG_READ);
 
 	input_event(edev->input, type, code, value);
-	input_sync(edev->input);
+
+	/*
+	 * Send an extra (EV_SYN, SYN_REPORT, 0x0) event if a key
+	 * was pressed. Some keyboard device drivers may only send
+	 * the EV_KEY event and not EV_SYN.
+	 *
+	 * Note that sending an extra SYN_REPORT is not necessary
+	 * nor correct protocol with other devices such as
+	 * touchscreens, which will send their own SYN_REPORT's
+	 * when sufficient event information has been collected
+	 * (e.g., for touchscreens, when pressure and X/Y coordinates
+	 * have been received). Hence, we will only send this extra
+	 * SYN_REPORT if type == EV_KEY.
+	 */
+	if (type == EV_KEY)
+		input_sync(edev->input);
 	return IRQ_HANDLED;
 }
 
@@ -155,6 +173,19 @@ static int events_probe(struct platform_device *pdev)
 	input_dev->name = edev->name;
 	input_dev->id.bustype = BUS_HOST;
 
+	/*
+	 * Set the Goldfish Device to be multitouch.
+	 *
+	 * In the Ranchu kernel, there is multitouch-specific code
+	 * for handling ABS_MT_SLOT events (see
+	 * drivers/input/input.c:input_handle_abs_event).
+	 * If we do not issue input_mt_init_slots, the kernel will
+	 * filter out needed ABS_MT_SLOT events when we touch the
+	 * screen in more than one place, preventing multitouch with
+	 * more than one finger from working.
+	 */
+	input_mt_init_slots(input_dev, GOLDFISH_MAX_FINGERS, 0);
+
 	events_import_bits(edev, input_dev->evbit, EV_SYN, EV_MAX);
 	events_import_bits(edev, input_dev->keybit, EV_KEY, KEY_MAX);
 	events_import_bits(edev, input_dev->relbit, EV_REL, REL_MAX);
-- 
2.7.4
