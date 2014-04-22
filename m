Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 22:47:33 +0200 (CEST)
Received: from smtp-out-121.synserver.de ([212.40.185.121]:1154 "EHLO
        smtp-out-072.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6834673AbaDVUqvK7Ts9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 22:46:51 +0200
Received: (qmail 18572 invoked by uid 0); 22 Apr 2014 20:46:45 -0000
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
Subject: [PATCH 3/6] ASoC: qi_lb60: Set .dai_fmt instead of calling snd_soc_set_dai_fmt()
Date:   Tue, 22 Apr 2014 22:46:33 +0200
Message-Id: <1398199596-23649-3-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1398199596-23649-1-git-send-email-lars@metafoo.de>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39893
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

Rather than calling snd_soc_set_dai_fmt(), just set the dai_fmt field in the
dai_link struct. Both have the same effect, but the later is a bit shorter and
also allows us to remove the now unused init callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/qi_lb60.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index 8dd3568..72ce103 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -46,26 +46,6 @@ static const struct snd_soc_dapm_route qi_lb60_routes[] = {
 	{"Speaker", NULL, "ROUT"},
 };
 
-#define QI_LB60_DAIFMT (SND_SOC_DAIFMT_I2S | \
-			SND_SOC_DAIFMT_NB_NF | \
-			SND_SOC_DAIFMT_CBM_CFM)
-
-static int qi_lb60_codec_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
-
-	ret = snd_soc_dai_set_fmt(cpu_dai, QI_LB60_DAIFMT);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set cpu dai format: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static struct snd_soc_dai_link qi_lb60_dai = {
 	.name = "jz4740",
 	.stream_name = "jz4740",
@@ -73,7 +53,8 @@ static struct snd_soc_dai_link qi_lb60_dai = {
 	.platform_name = "jz4740-i2s",
 	.codec_dai_name = "jz4740-hifi",
 	.codec_name = "jz4740-codec",
-	.init = qi_lb60_codec_init,
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBM_CFM,
 };
 
 static struct snd_soc_card qi_lb60 = {
-- 
1.8.0
