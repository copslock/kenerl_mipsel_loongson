Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jul 2011 13:26:26 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54298 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491056Ab1G1L0W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jul 2011 13:26:22 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p6SBQI7C029179;
        Thu, 28 Jul 2011 12:26:18 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p6SBQGQo029176;
        Thu, 28 Jul 2011 12:26:16 +0100
Date:   Thu, 28 Jul 2011 12:26:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Liam Girdwood <lrg@ti.com>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH] SOUND: Fix txx9aclc.c build
Message-ID: <20110728112616.GA27918@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20651

552d1ef6b5a98d7b95959d5b139071e3c90cebf1 [ASoC: core - Optimise and refactor
pcm_new() to pass only rtd] breaks compilation of txx9aclc.c:

  CC [M]  sound/soc/txx9/txx9aclc.o
/home/ralf/src/linux/linux-mips/sound/soc/txx9/txx9aclc.c: In function 'txx9aclc_pcm_new':
/home/ralf/src/linux/linux-mips/sound/soc/txx9/txx9aclc.c:318:3: error: 'card' undeclared (first use in this function)
/home/ralf/src/linux/linux-mips/sound/soc/txx9/txx9aclc.c:318:3: note: each undeclared identifier is reported only once for each function it appears in
make[5]: *** [sound/soc/txx9/txx9aclc.o] Error 1

Fixed by providing a definition for card.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 sound/soc/txx9/txx9aclc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 34aa972..3de99af 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -290,6 +290,7 @@ static void txx9aclc_pcm_free_dma_buffers(struct snd_pcm *pcm)
 
 static int txx9aclc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_card *card = rtd->card->snd_card;
 	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	struct platform_device *pdev = to_platform_device(dai->platform->dev);
