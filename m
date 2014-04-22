Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 22:47:12 +0200 (CEST)
Received: from smtp-out-121.synserver.de ([212.40.185.121]:1110 "EHLO
        smtp-out-072.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6834671AbaDVUqt38Ihm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 22:46:49 +0200
Received: (qmail 18515 invoked by uid 0); 22 Apr 2014 20:46:44 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 18380
Received: from ppp-188-174-45-35.dynamic.mnet-online.de (HELO lars-adi-laptop.fritz.box) [188.174.45.35]
  by 217.119.54.96 with SMTP; 22 Apr 2014 20:46:44 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/6] ASoC: qi_lb60: Set fully_routed flag
Date:   Tue, 22 Apr 2014 22:46:32 +0200
Message-Id: <1398199596-23649-2-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1398199596-23649-1-git-send-email-lars@metafoo.de>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39892
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

The routes for this sound card are fully specified, so set the fully_routed
flag. This allows us to remove the manual snd_soc_dapm_nc_pin() calls.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/qi_lb60.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index 82b5f37..8dd3568 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -57,9 +57,6 @@ static int qi_lb60_codec_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
-	snd_soc_dapm_nc_pin(dapm, "LIN");
-	snd_soc_dapm_nc_pin(dapm, "RIN");
-
 	ret = snd_soc_dai_set_fmt(cpu_dai, QI_LB60_DAIFMT);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cpu dai format: %d\n", ret);
@@ -89,6 +86,7 @@ static struct snd_soc_card qi_lb60 = {
 	.num_dapm_widgets = ARRAY_SIZE(qi_lb60_widgets),
 	.dapm_routes = qi_lb60_routes,
 	.num_dapm_routes = ARRAY_SIZE(qi_lb60_routes),
+	.fully_routed = true,
 };
 
 static const struct gpio qi_lb60_gpios[] = {
-- 
1.8.0
