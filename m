Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 22:48:14 +0200 (CEST)
Received: from smtp-out-121.synserver.de ([212.40.185.121]:1082 "EHLO
        smtp-out-072.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6834677AbaDVUqv6MZLt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 22:46:51 +0200
Received: (qmail 18611 invoked by uid 0); 22 Apr 2014 20:46:45 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 18380
Received: from ppp-188-174-45-35.dynamic.mnet-online.de (HELO lars-adi-laptop.fritz.box) [188.174.45.35]
  by 217.119.54.96 with SMTP; 22 Apr 2014 20:46:45 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] ASoC: qi_lb60: Use devm_snd_soc_register_card()
Date:   Tue, 22 Apr 2014 22:46:34 +0200
Message-Id: <1398199596-23649-4-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1398199596-23649-1-git-send-email-lars@metafoo.de>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

Makes the code a bit shorter and will also allow us to remove the drivers
remove() callback eventually.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/qi_lb60.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index 72ce103..be0a437 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -86,7 +86,7 @@ static int qi_lb60_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
@@ -97,9 +97,6 @@ static int qi_lb60_probe(struct platform_device *pdev)
 
 static int qi_lb60_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
 	gpio_free_array(qi_lb60_gpios, ARRAY_SIZE(qi_lb60_gpios));
 	return 0;
 }
-- 
1.8.0
