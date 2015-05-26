Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 20:44:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39019 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007284AbbEZSoxcGV8t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2015 20:44:53 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EAF694E341B3D;
        Tue, 26 May 2015 19:44:46 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 26 May
 2015 19:42:44 +0100
Received: from laptop.hh.imgtec.org (10.100.200.175) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 26 May
 2015 19:42:43 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        <Govindraj.Raja@imgtec.com>, <Damien.Horsley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v2 1/7] clocksource: mips-gic: Enable the clock before using it
Date:   Tue, 26 May 2015 15:39:02 -0300
Message-ID: <1432665548-16024-2-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1432665548-16024-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432665548-16024-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.175]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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

For the clock to be used (e.g. get its rate through clk_get_rate)
it should be prepared and enabled first.

Also, while the clock is enabled the driver must hold a reference to it,
so let's remove the call to clk_put.

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/clocksource/mips-gic-timer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index b81ed1a..913585d 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -158,8 +158,13 @@ static void __init gic_clocksource_of_init(struct device_node *node)
 
 	clk = of_clk_get(node, 0);
 	if (!IS_ERR(clk)) {
+		if (clk_prepare_enable(clk) < 0) {
+			pr_err("GIC failed to enable clock\n");
+			clk_put(clk);
+			return;
+		}
+
 		gic_frequency = clk_get_rate(clk);
-		clk_put(clk);
 	} else if (of_property_read_u32(node, "clock-frequency",
 					&gic_frequency)) {
 		pr_err("GIC frequency not specified.\n");
-- 
2.3.3
