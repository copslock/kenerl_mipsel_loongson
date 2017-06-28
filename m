Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 17:53:40 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:55609 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993980AbdF1Pw7J1rT8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 17:52:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id A9C871A47EA;
        Wed, 28 Jun 2017 17:52:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 8DBC41A47C5;
        Wed, 28 Jun 2017 17:52:53 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>
Subject: [PATCH v2 07/10] video: goldfishfb: Add support for device tree bindings
Date:   Wed, 28 Jun 2017 17:47:00 +0200
Message-Id: <1498664922-28493-8-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58867
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Add ability to the Goldfish FB driver to be recognized by OS via DT.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 drivers/video/fbdev/goldfishfb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index 7f6c9e6..3b70044 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -304,12 +304,18 @@ static int goldfish_fb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id goldfish_fb_of_match[] = {
+	{ .compatible = "google,goldfish-fb", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, goldfish_fb_of_match);
 
 static struct platform_driver goldfish_fb_driver = {
 	.probe		= goldfish_fb_probe,
 	.remove		= goldfish_fb_remove,
 	.driver = {
-		.name = "goldfish_fb"
+		.name = "goldfish_fb",
+		.of_match_table = goldfish_fb_of_match,
 	}
 };
 
-- 
2.7.4
