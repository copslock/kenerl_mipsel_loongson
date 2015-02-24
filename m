Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 03:28:45 +0100 (CET)
Received: from mail-qg0-f73.google.com ([209.85.192.73]:58853 "EHLO
        mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006984AbbBXC2mZ0blG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 03:28:42 +0100
Received: by mail-qg0-f73.google.com with SMTP id z60so4838197qgd.0
        for <linux-mips@linux-mips.org>; Mon, 23 Feb 2015 18:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SlKtPcLcaywPht4GVhLDzDQ4AEq/GE/f6NUyWSG1itE=;
        b=RPAP56/I1IXLbeInWqKkQbvYswK0T8ofPqZ6dzPfSQqDdVydle7ToVpY5SQDUbO3gA
         BUKWe7/bPL4HOFk/ukHTQwSeyzOAr0v+L6AJwJ2SPXjSY7chjpJn6Y2mxLLCuHYH7eGO
         KGlRWPcV45BZQ4TfZPQpnfv9S/JdYyKucwz+ic1A0/EB7rybHCHp2Xa04qFfXOkbc1E9
         hJ21+kPwjO/e1WIwYxHe7tyHN3BrQ9THwXrKwQ3sTQAd/rh24ivOKklwKQu//ycaC/XA
         fgMJCaZFVVZd136UBrseQAfawdLAHLHl2n7f06gEmHZCt+4Z3j5hlAjAg9V8iyps6KAk
         WOIA==
X-Gm-Message-State: ALoCoQl3HBemSiozN+npt4tdkPh9dfabFzg50D0VzgFMnOtieX2yWMWuKFoXbnXMQ/E+5JyGleTT
X-Received: by 10.236.2.35 with SMTP id 23mr14738526yhe.22.1424744917181;
        Mon, 23 Feb 2015 18:28:37 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id ba9si6348588qcb.0.2015.02.23.18.28.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2015 18:28:37 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id geaFGaQ0.1; Mon, 23 Feb 2015 18:28:37 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 8BCBD220728; Mon, 23 Feb 2015 18:28:35 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hogan <james.hogan@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: [PATCH] clocksource: mips-gic: Allow GIC clock to be specified in device-tree
Date:   Mon, 23 Feb 2015 18:28:34 -0800
Message-Id: <1424744914-1244-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

As an alternative to the "clock-frequency" property, allow the GIC
timer operating clock to be specified in the device-tree instead.
This is useful on systems which use common clock or where the GIC
is not fixed to a particular frequency and is instead, for example,
derived from the CPU clock.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
 .../devicetree/bindings/interrupt-controller/mips-gic.txt      |  5 +++++
 drivers/clocksource/mips-gic-timer.c                           | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt b/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
index 5a65478..aae4c38 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
@@ -27,8 +27,13 @@ Optional properties:
 Required properties for timer sub-node:
 - compatible : Should be "mti,gic-timer".
 - interrupts : Interrupt for the GIC local timer.
+
+Optional properties for timer sub-node:
+- clocks : GIC timer operating clock.
 - clock-frequency : Clock frequency at which the GIC timers operate.
 
+Note that one of clocks or clock-frequency must be specified.
+
 Example:
 
 	gic: interrupt-controller@1bdc0000 {
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 3bd31b1..1809f52 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
+#include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
@@ -146,11 +147,18 @@ void __init gic_clocksource_init(unsigned int frequency)
 
 static void __init gic_clocksource_of_init(struct device_node *node)
 {
+	struct clk *clk;
+
 	if (WARN_ON(!gic_present || !node->parent ||
 		    !of_device_is_compatible(node->parent, "mti,gic")))
 		return;
 
-	if (of_property_read_u32(node, "clock-frequency", &gic_frequency)) {
+	clk = of_clk_get(node, 0);
+	if (!IS_ERR(clk)) {
+		gic_frequency = clk_get_rate(clk);
+		clk_put(clk);
+	} else if (of_property_read_u32(node, "clock-frequency",
+					&gic_frequency)) {
 		pr_err("GIC frequency not specified.\n");
 		return;
 	}
-- 
2.2.0.rc0.207.ga3a616c
